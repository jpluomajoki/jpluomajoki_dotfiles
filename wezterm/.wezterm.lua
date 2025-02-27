-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()
local act = wezterm.action
-- This is where you actually apply your config choices
local opacity_default = 0.9
local opacity_current = opacity_default
local WEZTERM_MOD = "CTRL|SHIFT"

config = {
	-- *** APPEARANCE ***--
	--enable_wayland = false,
	color_scheme = "GruvboxDark",
	font = wezterm.font("FiraCode Nerd Font Med"),
	tab_max_width = 14,
	window_background_opacity = opacity_default,
	hide_mouse_cursor_when_typing = true,
	hide_tab_bar_if_only_one_tab = false,
	adjust_window_size_when_changing_font_size = false,
	window_padding = { left = 0, right = 0, top = 0, bottom = 0 },
	window_frame = {},
	colors = {
		tab_bar = {
			inactive_tab_edge = "#333333",
		},
		split = "#D79921",
	},
	show_close_tab_button_in_tabs = false,
	inactive_pane_hsb = {
		saturation = 1,
		brightness = 0.7,
	},
	-- *** KEYMAP *** --
	keys = {
		-- Vertical split
		{
			key = "i",
			mods = WEZTERM_MOD,
			action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
		},
		-- Horizontal split
		{
			key = "_",
			mods = WEZTERM_MOD,
			action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
		},
		{
			key = "_",
			mods = "CTRL|SHIFT|ALT",
			action = wezterm.action.DecreaseFontSize,
		},
		-- Close pane
		{
			key = "w",
			mods = WEZTERM_MOD,
			action = wezterm.action.CloseCurrentPane({ confirm = true }),
		},
		{
			key = "q",
			mods = WEZTERM_MOD,
			action = wezterm.action.CloseCurrentTab({ confirm = true }),
		},
		-- change tabs with lazyvim-like bindings
		{
			key = "h",
			mods = WEZTERM_MOD,
			action = wezterm.action.ActivateTabRelative(-1),
		},
		{
			key = "l",
			mods = WEZTERM_MOD,
			action = wezterm.action.ActivateTabRelative(1),
		},
		{
			key = "l",
			mods = WEZTERM_MOD .. "|ALT",
			action = wezterm.action.ShowDebugOverlay,
		},
		-- Resize mode
		{
			key = "r",
			mods = WEZTERM_MOD,
			action = act.ActivateKeyTable({
				name = "resize_pane",
				one_shot = false,
				replace_current = true,
			}),
		},
		-- Opacity change mode
		{
			key = "o",
			mods = WEZTERM_MOD,
			action = act.ActivateKeyTable({
				name = "window_opacity",
				one_shot = true,
				replace_current = true,
			}),
		},
	},
	key_tables = {
		resize_pane = {
			{ key = "LeftArrow", action = act.AdjustPaneSize({ "Left", 1 }) },
			{ key = "RightArrow", action = act.AdjustPaneSize({ "Right", 1 }) },
			{ key = "UpArrow", action = act.AdjustPaneSize({ "Up", 1 }) },
			{ key = "DownArrow", action = act.AdjustPaneSize({ "Down", 1 }) },
			-- Cancel the mode by pressing escape
			{ key = "Escape", action = "PopKeyTable" },
		},
		window_opacity = {
			{ key = "UpArrow", action = act.EmitEvent("opacity-up") },
			{ key = "DownArrow", action = act.EmitEvent("opacity-down") },
			{ key = "d", action = act.EmitEvent("opacity-default") },
			{ key = "k", mods = WEZTERM_MOD, action = act.EmitEvent("opacity-up") },
			{ key = "j", mods = WEZTERM_MOD, action = act.EmitEvent("opacity-down") },
			{ key = "d", action = act.EmitEvent("opacity-default") },
			{ key = "1", action = act.EmitEvent("opacity-full") },
		},
	},
	mouse_bindings = {
		-- Scrolling up while holding CTRL increases the font size
		{
			event = { Down = { streak = 1, button = { WheelUp = 1 } } },
			mods = "CTRL",
			action = act.IncreaseFontSize,
		},

		-- Scrolling down while holding CTRL decreases the font size
		{
			event = { Down = { streak = 1, button = { WheelDown = 1 } } },
			mods = "CTRL",
			action = act.DecreaseFontSize,
		},
	},
}

-- Opacity controls
local function set_opacity(window, opacity)
	local overrides = window:get_config_overrides() or {}
	if opacity >= 1 then
		opacity = 1
	end
	if opacity <= 0 then
		opacity = 0
	end
	opacity_current = opacity
	overrides.window_background_opacity = opacity
	window:set_config_overrides(overrides)
end

wezterm.on("opacity-up", function(window)
	set_opacity(window, opacity_current + 0.1)
end)

wezterm.on("opacity-down", function(window)
	set_opacity(window, opacity_current - 0.1)
end)

wezterm.on("opacity-default", function(window)
	set_opacity(window, opacity_default)
end)

wezterm.on("opacity-full", function(window)
	set_opacity(window, 1)
end)

-- This function returns the suggested title for a tab.
-- It prefers the title that was set via `tab:set_title()`
-- or `wezterm cli set-tab-title`, but falls back to the
-- title of the active pane in that tab.
function Tab_title(tab_info)
	local title = tab_info.tab_title
	-- if the tab title is explicitly set, take that
	if title and #title > 0 then
		return title
	end
	-- Otherwise, use the title from the active pane
	-- in that tab
	return tab_info.active_pane.title
end

wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
	local background = "#333333"
	local foreground = "#A89984"

	if tab.is_active then
		background = "#242424"
    foreground = "#D79921"
		--elseif hover then
		--	background = "#333333"
	end

	local title = Tab_title(tab)
	local spacer = "  "
	if string.len(title) > 10 then
		spacer = ""
	end

	return {
		{ Background = { Color = background } },
		{ Foreground = { Color = foreground } },
		{ Text = spacer .. wezterm.truncate_right(title, max_width - (string.len(spacer) * 2)) .. spacer },
	}
end)

wezterm.on("update-status", function(window, pane)
	local name = window:active_key_table()

	if name then
		name = "Key table: " .. name
	end

	window:set_right_status(wezterm.format({
		{ Text = name or "" },
	}))
end)

wezterm.on("augment-command-palette", function(window, pane)
	return {
		{
			brief = "Rename tab",
			icon = "md_rename_box",

			action = act.PromptInputLine({
				description = "Enter new name for tab",
				initial_value = "",
				action = wezterm.action_callback(function(window, pane, line)
					if line then
						window:active_tab():set_title(line)
					end
				end),
			}),
		},
	}
end)

-- and finally, return the configuration to wezterm
return config
