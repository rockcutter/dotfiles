local wezterm = require("wezterm")
local config = wezterm.config_builder()

-- Windowsの場合のみデフォルトシェルを設定
if wezterm.target_triple == "x86_64-pc-windows-msvc" then
  config.default_prog = { "ubuntu2204.exe" }
end

config.use_fancy_tab_bar = false
config.window_decorations = "RESIZE"
config.use_ime = true
-- config.window_background_opacity = 0.95
config.window_background_opacity = 0.7

-- フォント設定
-- config.font = wezterm.font("CaskaydiaCove Nerd Font", { weight = "Regular" })
config.font = wezterm.font("UDEV Gothic 35NF", { weight = "Regular" })
config.font_size = 12.0

config.window_close_confirmation = "NeverPrompt"

config.keys = {
	{
		key = 'v',
		mods = 'CTRL',
		action = wezterm.action.PasteFrom 'Clipboard',
	}
}

-- 色設定
config.colors = {
  -- 基本色
  foreground = "#CBCBF0",
  background = "#1D1D26",
  
  -- カーソル
  cursor_bg = "#CBCBF0",
  cursor_fg = "#1D1D26",
  
  -- 選択範囲
  selection_bg = "#FF3399",
  selection_fg = "#CBCBF0",
  
  -- ANSI カラー
  ansi = {
    "#1D1D26", -- black
    "#FF3399", -- red
    "#00D364", -- green
    "#FFCC66", -- yellow
    "#00CBFF", -- blue
    "#CC66FF", -- magenta
    "#00CECA", -- cyan
    "#CBCBF0", -- white
  },
  
  -- Bright ANSI カラー
  brights = {
    "#636667", -- bright black
    "#FF2F92", -- bright red
    "#00D364", -- bright green
    "#FFD479", -- bright yellow
    "#00CBFF", -- bright blue
    "#D783FF", -- bright magenta
    "#00D5D4", -- bright cyan
    "#D5D6F3", -- bright white
  },
}

return config
