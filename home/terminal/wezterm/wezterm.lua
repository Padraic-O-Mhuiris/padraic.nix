local wezterm = require "wezterm"

-- This should be better contextualised
package.path = package.path ..
                   ";/home/padraic/code/nix/padraic.nix/home/terminal/wezterm/modules/?.lua"

local workspace = require("workspace")

--- https://github.com/wez/wezterm/pull/5576

local config = wezterm.config_builder()

config.font = wezterm.font_with_fallback({"Berkeley Mono"})
config.font_size = 14
config.freetype_load_flags = "NO_HINTING"
config.freetype_load_target = "Normal"
config.front_end = "WebGpu"
config.max_fps = 144
config.line_height = 1.1

config.enable_tab_bar = true
config.use_fancy_tab_bar = true
config.hide_tab_bar_if_only_one_tab = false
config.tab_bar_at_bottom = false

config.color_scheme = "Catppuccin Mocha (Gogh)"

config.window_frame = {
    font = wezterm.font_with_fallback({"Berkeley Mono"}),
    font_size = 12.0
}

config.window_padding = {left = 30, right = 30, top = 20, bottom = 10}
-- config.window_close_confirmation = "NeverPrompt"

config.leader = {key = "a", mods = "CTRL", timeout_milliseconds = 1000}
config.launch_menu = {}

-- workspace_switcher.apply_to_config(config)
config.default_workspace = "~"

config.keys = {
    {
        key = '|',
        mods = 'LEADER|SHIFT',
        action = wezterm.action.SplitHorizontal {domain = 'CurrentPaneDomain'}
    }, {
        key = '-',
        mods = 'LEADER|SHIFT',
        action = wezterm.action.SplitVertical {domain = 'CurrentPaneDomain'}
    }, {
        key = 'h',
        mods = 'CTRL',
        action = wezterm.action.ShowTabNavigator
        -- action = wezterm.action_callback(
        --     function(window, pane)
        --         window:perform_action(wezterm.action.SplitPane {
        --             direction = 'Right',
        --             size = {Percent = 30}
        --         }, pane)
        --     end)
    }

    -- , {
    --     key = "s",
    --     mods = "ALT",
    --     action = workspace_switcher.switch_workspace()
    --     -- action = workspace_switcher.switch_workspace({
    --     --     extra_args = " | rg -Fxf ~/.projects"
    --     -- })
    -- }
}

workspace.apply_to_config(config)

return config
