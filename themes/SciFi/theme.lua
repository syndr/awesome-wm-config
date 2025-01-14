---------------------------------------------
-- Awesome theme which follows xrdb config --
--   by Yauhen Kirylau                    --
---------------------------------------------

local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local xrdb = xresources.get_current_theme()
local gfs = require("gears.filesystem")
local themes_path = gfs.get_themes_dir()

-- inherit default theme
local theme = dofile(themes_path.."default/theme.lua")
--local theme = dofile("/home/syndr@styx.ultroncore.net/.config/awesome/themes/default/theme.lua")
-- load vector assets' generators for this theme

theme.font          = "terminus 8"

--- Original colors based on xrdb
--theme.bg_normal     = xrdb.background
--theme.bg_normal     = "#111111"
--theme.bg_focus      = xrdb.foreground
--theme.bg_urgent     = xrdb.color1
--theme.bg_minimize   = xrdb.color8
--theme.bg_systray    = theme.bg_normal

theme.bg_normal     = "#000000"
theme.bg_focus      = "#00FF00"  -- Green terminal colors
--theme.bg_focus      = "#339933"  -- Greenish
--theme.bg_focus      = "#19FFFF" -- For blue tron-like colors
theme.bg_urgent     = "#FFFF00"
theme.bg_minimize   = "#444444"
theme.bg_systray    = theme.bg_normal

---Original colors based on xrdb
--theme.fg_normal     = xrdb.foreground
--theme.fg_focus      = xrdb.background
--theme.fg_urgent     = theme.bg_normal
--theme.fg_minimize   = xrdb.color7

--theme.fg_normal     = "#19FFFF" -- For tron-like colors
theme.fg_normal     = "#00FF00"
theme.fg_focus      = "#111111"
theme.fg_urgent     = "#66DD00"
theme.fg_minimize   = "#66DD00"

theme.tag_bg_focus  = "#5beb5b"
theme.tag_fg_urgent = "#000000"

theme.hotkeys_bg    = "#000000"
theme.hotkeys_fg    = "#00FF00"

theme.useless_gap   = dpi(5)
theme.border_width  = dpi(1)
theme.border_normal = "#02bf02"
theme.border_focus  = theme.fg_normal
theme.border_marked = xrdb.color3

-- There are other variable sets
-- overriding the default one when
-- defined, the sets are:
-- taglist_[bg|fg]_[focus|urgent|occupied|empty|volatile]
-- tasklist_[bg|fg]_[focus|urgent]
-- titlebar_[bg|fg]_[normal|focus]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- mouse_finder_[color|timeout|animate_timeout|radius|factor]
-- Example:
--theme.taglist_bg_focus = "#ff0000"

theme.titlebar_fg_normal = theme.fg_normal .. "88"
theme.titlebar_fg_focus = theme.fg_normal .. "ff"
theme.titlebar_bg_normal = "#00000000"
theme.titlebar_bg_focus = "#00000000"

theme.tooltip_fg = theme.fg_normal
theme.tooltip_bg = theme.bg_normal

-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_submenu_icon = themes_path.."default/submenu.png"
theme.menu_height = dpi(16)
theme.menu_width  = dpi(100)

--theme.notification_font
theme.notification_bg               = xrdb.background
--theme.notification_fg
theme.notification_border_width     = 8
theme.notification_border_color     = xrdb.color3
--theme.notification_shape
--theme.notification_opacity
--theme.notification_margin
--theme.notification_width
--theme.notification_height

-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
--theme.bg_widget = "#cc0000"

-- Recolor Layout icons:
theme = theme_assets.recolor_layout(theme, theme.fg_normal)

-- Recolor titlebar icons:
--
local function darker(color_value, darker_n)
    local result = "#"
    for s in color_value:gmatch("[a-fA-F0-9][a-fA-F0-9]") do
        local bg_numeric_value = tonumber("0x"..s) - darker_n
        if bg_numeric_value < 0 then bg_numeric_value = 0 end
        if bg_numeric_value > 255 then bg_numeric_value = 255 end
        result = result .. string.format("%2.2x", bg_numeric_value)
    end
    return result
end
theme = theme_assets.recolor_titlebar(
    theme, theme.fg_normal, "focus"
)
theme = theme_assets.recolor_titlebar(
    theme, darker(theme.fg_normal, -60), "focus", "hover"
)
theme = theme_assets.recolor_titlebar(
    theme, xrdb.color1, "focus", "press"
)
theme = theme_assets.recolor_titlebar(
    theme, darker(theme.fg_normal, 40), "normal"
)
theme = theme_assets.recolor_titlebar(
    theme, darker(theme.fg_focus, -60), "normal", "hover"
)
theme = theme_assets.recolor_titlebar(
    theme, xrdb.color1, "normal", "press"
)

-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme = nil

-- Generate Awesome icon:
theme.awesome_icon = theme_assets.awesome_icon(
    theme.menu_height, theme.bg_focus, theme.fg_focus
)

-- Generate taglist squares:
local taglist_square_size = dpi(4)
theme.taglist_squares_sel = theme_assets.taglist_squares_sel(
    taglist_square_size, xrdb.color7
)
theme.taglist_squares_unsel = theme_assets.taglist_squares_unsel(
    taglist_square_size, theme.fg_normal
)

--[[
-- Try to determine if we are running light or dark colorscheme:
local bg_numberic_value = 0;
for s in theme.bg_normal:gmatch("[a-fA-F0-9][a-fA-F0-9]") do
    bg_numberic_value = bg_numberic_value + tonumber("0x"..s);
end
local is_dark_bg = (bg_numberic_value < 383)

-- Generate wallpaper:
local wallpaper_bg = xrdb.color8
local wallpaper_fg = xrdb.color7
local wallpaper_alt_fg = xrdb.color12
if not is_dark_bg then
    wallpaper_bg, wallpaper_fg = wallpaper_fg, wallpaper_bg
end
theme.wallpaper = function(s)
    return theme_assets.wallpaper(wallpaper_bg, wallpaper_fg, wallpaper_alt_fg, s)
end
--]]

theme.wallpaper = "~/.config/awesome/wallpaper/futuristic-city-cyberpunk.jpg"

return theme

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
