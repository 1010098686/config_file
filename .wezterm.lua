local wezterm = require 'wezterm';

local launch_menu = {}

if wezterm.target_triple == "x86_64-pc-windows-msvc" then
  table.insert(launch_menu, {
    label = "PowerShell",
    args = {"powershell"},
  })
  table.insert(launch_menu, {
    label = "pwsh",
    args = {"pwsh"}
  })
  default_prog = "pwsh"

  -- Enumerate any WSL distributions that are installed and add those to the menu
  local success, wsl_list, wsl_err = wezterm.run_child_process({"wsl.exe", "-l"})
  -- `wsl.exe -l` has a bug where it always outputs utf16:
  -- https://github.com/microsoft/WSL/issues/4607
  -- So we get to convert it
  wsl_list = wezterm.utf16_to_utf8(wsl_list)

  for idx, line in ipairs(wezterm.split_by_newlines(wsl_list)) do
    -- Skip the first line of output; it's just a header
    if idx > 1 then
      -- Remove the "(Default)" marker from the default line to arrive
      -- at the distribution name on its own
      local distro = line:gsub(" %(Default%)", "")
      local distro = distro:gsub(" %(默认%)", "")

      -- Add an entry that will spawn into the distro with the default shell
      table.insert(launch_menu, {
        label = distro .. " (WSL default shell)",
        args = {"wsl.exe", "--distribution", distro},
      })
    end
  end
else
  table.insert(launch_menu, {
    label = "zsh",
    args = { "zsh" }
  })
  default_prog = "zsh"
end

local config = {
  automatically_reload_config = true,
  window_close_confirmation = "NeverPrompt",
  window_decorations = "RESIZE",
  initial_cols = 150,
  initial_rows = 35,
  launch_menu = launch_menu,
  default_prog = {default_prog},
  font = wezterm.font("FiraCode Nerd Font Mono", {weight="Regular", stretch="Normal", style="Normal"}),
  harfbuzz_features = {'liga=1'},
  font_size=14,
  keys={
    {key="DownArrow", mods="SHIFT|ALT", action=wezterm.action.SplitVertical{domain="CurrentPaneDomain"}},
    {key="RightArrow", mods="SHIFT|ALT", action=wezterm.action.SplitHorizontal{domain="CurrentPaneDomain"}},
    {key="e", mods="ALT", action=wezterm.action.QuitApplication}
  },
  color_scheme = 'Catppuccin Macchiato',
  background = {
    -- {
    --   source={
    --     File="C:\\Users\\f00613555\\Pictures\\wallpapers\\wallhaven-7pze9v.png"
    --   },
    --   hsb={
    --     hue=1.0,
    --     saturation=1.02,
    --     brightness=0.1
    --   },
    --   width="100%",
    --   height="100%"
    -- },
    {
      source={
        Color="#282c35"
      },
      width="100%",
      height="100%",
      opacity=0.85
    }
  },
  window_padding={
    left=3,
    right=3,
    top=0,
    bottom=0
  }
}

-- local bar = wezterm.plugin.require("https://github.com/adriankarlen/bar.wezterm")
-- bar.apply_to_config(config)

return config
