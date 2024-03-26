local bindings = require "bindings"
local select = require "select"
local aesthetics = require "aesthetics"
local wezterm = require "wezterm"

wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
   local pane_title = tab.active_pane.title
   local user_title = tab.active_pane.user_vars.panetitle

   if user_title ~= nil and #user_title > 0 then
      pane_title = user_title
   end

   return {
      { Text = " " .. pane_title .. " " },
   }
end)

-- see https://wezfurlong.org/wezterm/config/lua/wezterm/target_triple.html for values
local is_windows = wezterm.target_triple == "x86_64-pc-windows-msvc"
local wsl_domains = wezterm.default_wsl_domains()

for _, dom in ipairs(wsl_domains) do
   dom.default_cwd = "~"
end

return {
   ----------- WSL stuff -----------
   wsl_domains = wsl_domains,
   default_domain = is_windows and "WSL:Ubuntu-22.04" or nil,
   default_prog = is_windows and { "wsl.exe" } or nil,
   ----------- Aesthetics ----------
   color_scheme = aesthetics.color_scheme,
   window_background_opacity = aesthetics.window_background_opacity,
   hide_tab_bar_if_only_one_tab = aesthetics.hide_tab_bar_if_only_one_tab,
   font_size = aesthetics.font_size,
   window_decorations = aesthetics.window_decorations,
   ----------- Bindings ----------
   -- keys = bindings.keys,
   -- key_tables = bindings.key_tables,
   mouse_bindings = bindings.mouse,
   ----------- Selection ----------
   quick_select_patterns = select.quick_select_patterns,
   hyperlink_rules = select.hyperlink_rules,
   ----------- Misc ----------
   -- prevents terminal hanging when exiting with ctrl-d
   exit_behavior = "Close",
   -- get rid of the stupid bell when tab complete fails
   audible_bell = "Disabled",
}
