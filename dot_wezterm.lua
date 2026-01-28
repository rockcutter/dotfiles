local wezterm = require("wezterm")
local config = wezterm.config_builder()

-- Windowsの場合のみデフォルトシェルを設定
if wezterm.target_triple == "x86_64-pc-windows-msvc" then
  config.default_prog = { "ubuntu2204.exe" }
end

config.use_fancy_tab_bar = false
config.enable_tab_bar = false
config.window_decorations = "RESIZE"
config.use_ime = true
-- config.window_background_opacity = 0.95
config.window_background_opacity = 0.7

border_color = "#c6f"

config.window_frame = {
  border_left_width = "2px",
  border_right_width = "2px",
  border_bottom_height = "2px",
  border_top_height = "2px",
  border_left_color = border_color,
  border_right_color = border_color,
  border_bottom_color = border_color,
  border_top_color = border_color,
}

config.window_padding = {
  left = 0,
  right = 0,
  top = 0,
  bottom = 0,
}

-- フォント設定
-- config.font = wezterm.font("CaskaydiaCove Nerd Font", { weight = "Regular" })
config.font = wezterm.font("UDEV Gothic 35NF", { weight = "Regular" })
config.font_size = 12.0

config.window_close_confirmation = "NeverPrompt"

if wezterm.target_triple ~= "aarch64-apple-darwin" then
  config.keys = {
    {
      key = "v",
      mods = "CTRL",
      action = wezterm.action.PasteFrom("Clipboard"),
    },
  }
end

config.color_scheme = "Tinacious Design (Dark)"
-- config.color_scheme = "Tinacious Design (Light)"

-- 文字色白に対し、カーソルが白で変換中みづらかったので黒に変更
config.colors = {
  compose_cursor = "#0d0d2b",
}

return config
