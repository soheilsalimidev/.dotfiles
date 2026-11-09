local mod = "SUPER"
local terminal = "wezterm" -- replace with your terminal variable
local browser = "zen-beta" -- replace with your browser variable

---- LAYOUT ----
hl.bind(mod .. " + J", hl.dsp.layout("move +col"))
hl.bind(mod .. " + K", hl.dsp.layout("move -col"))

---- LAUNCHERS ----
hl.bind(mod .. " + Return", hl.dsp.exec_cmd("uwsm app -- " .. terminal))
hl.bind(mod .. " + D", hl.dsp.exec_cmd("rofi-launcher"))
hl.bind(mod .. " + B", hl.dsp.exec_cmd(browser))
hl.bind(mod .. " + E", hl.dsp.exec_cmd("emopicker9000"))
hl.bind(mod .. " + S", hl.dsp.exec_cmd("screenshootin"))
hl.bind(mod .. " + O", hl.dsp.exec_cmd("obs"))
hl.bind(mod .. " + C", hl.dsp.exec_cmd("hyprpicker -a"))
hl.bind(mod .. " + G", hl.dsp.exec_cmd("gimp"))
hl.bind(mod .. " + T", hl.dsp.exec_cmd("pypr toggle term"))
hl.bind(mod .. " + M", hl.dsp.exec_cmd("pavucontrol"))
hl.bind(mod .. " + V", hl.dsp.exec_cmd("cliphist list | rofi -dmenu | cliphist decode | wl-copy"))
hl.bind(mod .. " + SHIFT + N", hl.dsp.exec_cmd("swaync-client -rs"))
hl.bind("SHIFT + CONTROL + L", hl.dsp.exec_cmd("playerctl next"))
hl.bind("SHIFT + CONTROL + H", hl.dsp.exec_cmd("playerctl previous"))

---- WINDOW MANAGEMENT ----
hl.bind(mod .. " + Q", hl.dsp.window.close())
hl.bind(mod .. " + P", hl.dsp.window.pseudo())
hl.bind(mod .. " + F", hl.dsp.window.fullscreen())
-- hl.bind(mod .. " + SHIFT + F", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mod .. " + ALT + F", hl.dsp.exec_cmd("hyprctl dispatch workspaceopt allfloat"))
-- hl.bind(mod .. " + SHIFT + I", hl.dsp.layout("togglesplit"))

---- MOVE FOCUS ----
hl.bind(mod .. " + left", hl.dsp.focus({ direction = "l" }))
hl.bind(mod .. " + right", hl.dsp.focus({ direction = "r" }))
hl.bind(mod .. " + up", hl.dsp.focus({ direction = "u" }))
hl.bind(mod .. " + down", hl.dsp.focus({ direction = "d" }))
hl.bind(mod .. " + H", hl.dsp.focus({ direction = "l" }))
hl.bind(mod .. " + L", hl.dsp.focus({ direction = "r" }))
hl.bind(mod .. " + K", hl.dsp.focus({ direction = "u" }))

---- MOVE WINDOW ----
hl.bind(mod .. " + SHIFT + left", hl.dsp.window.move({ direction = "l" }))
hl.bind(mod .. " + SHIFT + right", hl.dsp.window.move({ direction = "r" }))
hl.bind(mod .. " + SHIFT + up", hl.dsp.window.move({ direction = "u" }))
hl.bind(mod .. " + SHIFT + down", hl.dsp.window.move({ direction = "d" }))
hl.bind(mod .. " + SHIFT + H", hl.dsp.window.move({ direction = "l" }))
hl.bind(mod .. " + SHIFT + L", hl.dsp.window.move({ direction = "r" }))
hl.bind(mod .. " + SHIFT + K", hl.dsp.window.move({ direction = "u" }))
-- hl.bind(mod .. " + SHIFT + J", hl.dsp.window.move({ direction = "d" }))

---- SWAP WINDOW ----
hl.bind(mod .. " + ALT + left", hl.dsp.window.swap({ direction = "l" }))
hl.bind(mod .. " + ALT + right", hl.dsp.window.swap({ direction = "r" }))
hl.bind(mod .. " + ALT + up", hl.dsp.window.swap({ direction = "u" }))
hl.bind(mod .. " + ALT + down", hl.dsp.window.swap({ direction = "d" }))

---- WORKSPACES 1-10 ----
for i = 1, 10 do
  local key = i % 10
  hl.bind(mod .. " + " .. key, hl.dsp.focus({ workspace = i }))
  hl.bind(mod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

---- CYCLE WORKSPACES ----
hl.bind(mod .. " + CONTROL + L", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mod .. " + CONTROL + H", hl.dsp.focus({ workspace = "e-1" }))
hl.bind(mod .. " + CONTROL + right", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mod .. " + CONTROL + left", hl.dsp.focus({ workspace = "e-1" }))
hl.bind(mod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

---- SPECIAL WORKSPACE ----
hl.bind(mod .. " + SHIFT + SPACE", hl.dsp.window.move({ workspace = "special" }))

---- ALT TAB ----
hl.bind("ALT + Tab", hl.dsp.exec_cmd("hyprctl dispatch cyclenext"))
hl.bind("ALT + Tab", hl.dsp.exec_cmd("hyprctl dispatch bringactivetotop"))

---- MEDIA / VOLUME / BRIGHTNESS ----
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), { locked = true, repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl set 5%-"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl set +5%"), { locked = true, repeating = true })

---- MONITOR MANAGEMENT ----
hl.bind("ALT + SHIFT + 1", hl.dsp.exec_cmd("cp ~/.config/hypr/monitors1.conf ~/.config/hypr/monitors.conf"))
hl.bind("ALT + SHIFT + 2", hl.dsp.exec_cmd("cp ~/.config/hypr/monitors2.conf ~/.config/hypr/monitors.conf"))
hl.bind("ALT + SHIFT + 3", hl.dsp.exec_cmd("cp ~/.config/hypr/monitors3.conf ~/.config/hypr/monitors.conf"))

---- MOUSE BINDINGS ----
hl.bind(mod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })
hl.gesture({ fingers = 3, direction = "horizontal", action = "workspace" })
-- 3-finger swipe up → focus the window above
hl.gesture({
    fingers = 3,
    direction = "up",
    action = function()
        hl.dsp.focus({ direction = "u" })
        -- If the above doesn't work, try:
        -- hl.dsp.movefocus({ direction = "u" })
    end
})

-- 3-finger swipe down → focus the window below
hl.gesture({
    fingers = 3,
    direction = "down",
    action = function()
        hl.dsp.focus({ direction = "d" })
        -- If the above doesn't work, try:
        -- hl.dsp.movefocus({ direction = "d" })
    end
})
