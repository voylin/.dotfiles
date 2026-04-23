vim.api.nvim_create_user_command("Teledot", function()
	local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":t")
	local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
	local text = filename .. "\n" .. table.concat(lines, "\n")

	local uv = vim.loop
	local udp = uv.new_udp()
	udp:bind("0.0.0.0", 0)
	udp:set_broadcast(true)

	local timeout = uv.new_timer()
	timeout:start(2000, 0, vim.schedule_wrap(function()
		if not udp:is_closing() then
			udp:close()
			vim.notify("TeleDot: App not found on network (is it open and on the same Wi-Fi?)", vim.log.levels.ERROR)
		end
	end))

	udp:recv_start(function(err, data, addr, flags)
		if data == "TELEDOT_ACK" then
			if not udp:is_closing() then
				udp:recv_stop()
				udp:close()
				timeout:stop()
				timeout:close()
			end

			local client = uv.new_tcp()
			client:connect(addr.ip, 4242, function(tcp_err)
				if tcp_err then
					vim.schedule(function() vim.notify("TeleDot TCP error: " .. tcp_err, vim.log.levels.ERROR) end)
					return
				end
				client:write(text, function(write_err)
					if write_err then
						vim.schedule(function() vim.notify("TeleDot write error: " .. write_err, vim.log.levels.ERROR) end)
					end
					client:shutdown()
					client:close()
					vim.schedule(function() vim.notify("TeleDot: Script sent successfully!") end)
				end)
			end)
		end
	end)

	udp:send("TELEDOT_DISCOVER", "255.255.255.255", 4243, function(err)
		if err then
			vim.schedule(function() vim.notify("TeleDot UDP error: " .. err, vim.log.levels.ERROR) end)
		end
	end)
end, {})
