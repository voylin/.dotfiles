return {
	"voylin/godot_color_theme",
	name = "godot_color_theme",
	priority = 1000,
	config = function()
		require("godot_theme").setup({
			is_modern = false,
			base_color = "#363d4a",
			accent_color = "#70bafa",
			contrast = 0.2,
		})
	end,
}
