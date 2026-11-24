-- Parrot Cyberpunk — teal / midnight, using Hyprland's native Lua API.
-- Super is the Windows/Command key. Super+F1 opens the offline guide.
-- Personal overrides live in $XDG_CONFIG_HOME/hypr/local.lua and load last.
-- This is the shared distribution default, loaded from /etc/xdg when present.
-- Packaged builds can also load the same file directly from /usr/share/hypr.

hl.monitor({ output = "", mode = "preferred", position = "auto", scale = "auto" })

-- Run once after the compositor creates its sockets, not on every config reload.
hl.on("hyprland.start", function()
    hl.exec_cmd("/usr/lib/cyberpunk/session-ready")
end)

hl.config({
    input = {
        kb_layout = os.getenv("CYBERPUNK_KB_LAYOUT") or "us",
        kb_variant = os.getenv("CYBERPUNK_KB_VARIANT") or "",
        kb_options = os.getenv("CYBERPUNK_KB_OPTIONS") or "",
        follow_mouse = 0,
        sensitivity = 0,
        touchpad = {
            natural_scroll = true,
            -- Lua field names use underscores; the hyprlang name is tap-to-click.
            tap_to_click = true,
            disable_while_typing = true,
        },
    },
    general = {
        gaps_in = 5,
        gaps_out = 10,
        border_size = 2,
        col = {
            active_border = { colors = { "rgba(39d5cfff)", "rgba(769cfaff)" }, angle = 45 },
            inactive_border = "rgba(303d50ff)",
        },
        resize_on_border = true,
        layout = "dwindle",
    },
    decoration = {
        rounding = 10,
        active_opacity = 1.0,
        inactive_opacity = 1.0,
        shadow = {
            enabled = true,
            range = 12,
            render_power = 3,
            color = "rgba(00000055)",
        },
        blur = { enabled = true, size = 4, passes = 2 },
    },
    animations = { enabled = true },
    dwindle = {
        preserve_split = true,
        -- Super+left-drag drops tiled windows at the pointer position.
        precise_mouse_move = true,
    },
    misc = {
        disable_hyprland_logo = true,
        disable_splash_rendering = true,
        force_default_wallpaper = 0,
    },
})

hl.curve("cyberpunk", { type = "bezier", points = { { 0.16, 1 }, { 0.3, 1 } } })
for _, leaf in ipairs({ "windows", "fade", "workspaces" }) do
    hl.animation({ leaf = leaf, enabled = true, speed = 3, bezier = "cyberpunk" })
end
hl.animation({ leaf = "border", enabled = true, speed = 4, bezier = "default" })

-- Keep four workspaces available to the panel, including when they are empty.
-- Waybar uses ext-workspace-v1, not the removed Hyprlang dispatch syntax.
for workspace = 1, 4 do
    hl.workspace_rule({ workspace = tostring(workspace), persistent = true })
end

-- Dialogs and settings should not open as awkward half-screen tiles.
hl.window_rule({
    name = "cyberpunk-settings",
    match = { class = "^(org.pulseaudio.pavucontrol|Pavucontrol|nm-connection-editor|blueman-manager|wdisplays)$" },
    float = true,
    center = true,
})
hl.window_rule({
    name = "cyberpunk-file-dialogs",
    match = { class = "^(org.freedesktop.impl.portal.desktop.gtk|xdg-desktop-portal-gtk)$" },
    float = true,
    center = true,
})
hl.window_rule({
    name = "cyberpunk-authentication",
    match = { class = "^(org.kde.)?polkit-kde-authentication-agent-1$" },
    float = true,
    center = true,
})

-- External commands run asynchronously; never block the compositor's Lua loop.
local function launch(keys, command, flags)
    hl.bind(keys, hl.dsp.exec_cmd(command), flags or {})
end

launch("SUPER + T", "kitty")
launch("ALT + T", "kitty")
launch("SUPER + space", "fuzzel")
launch("SUPER + D", "cyberpunk-apps")
launch("SUPER + E", "/usr/bin/thunar")
launch("SUPER + B", "/usr/bin/firefox-esr")
launch("SUPER + I", "cyberpunk-control")
launch("SUPER + F1", "cyberpunk-welcome")
launch("SUPER + L", "cyberpunk-lock")
launch("SUPER + SHIFT + E", "cyberpunk-power")
launch("CTRL + ALT + Delete", "cyberpunk-power")
launch("Print", "cyberpunk-screenshot area")
launch("SHIFT + Print", "cyberpunk-screenshot full")

hl.bind("SUPER + Q", hl.dsp.window.close())
hl.bind("ALT + F4", hl.dsp.window.close())
hl.bind("SUPER + F", hl.dsp.window.fullscreen({ action = "toggle", mode = "fullscreen" }))
hl.bind("SUPER + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind("SUPER + P", hl.dsp.window.pseudo())
hl.bind("SUPER + J", hl.dsp.layout("togglesplit"))
hl.bind("ALT + Tab", hl.dsp.window.cycle_next())
hl.bind("ALT + SHIFT + Tab", hl.dsp.window.cycle_next({ next = false }))

for _, direction in ipairs({ "left", "right", "up", "down" }) do
    hl.bind("SUPER + " .. direction, hl.dsp.focus({ direction = direction }))
    hl.bind("SUPER + SHIFT + " .. direction, hl.dsp.window.move({ direction = direction }))
end
hl.bind("SUPER + CTRL + left", hl.dsp.window.resize({ x = -30, y = 0, relative = true }), { repeating = true })
hl.bind("SUPER + CTRL + right", hl.dsp.window.resize({ x = 30, y = 0, relative = true }), { repeating = true })
hl.bind("SUPER + CTRL + up", hl.dsp.window.resize({ x = 0, y = -30, relative = true }), { repeating = true })
hl.bind("SUPER + CTRL + down", hl.dsp.window.resize({ x = 0, y = 30, relative = true }), { repeating = true })

-- Four virtual desktops in one horizontal line: 1 — 2 — 3 — 4.
-- Ctrl+Alt+Left/Right changes desktop; adding Shift moves the active window
-- and follows it. At either end, the binding intentionally does nothing.
local horizontal_workspace = {
    left = { [2] = 1, [3] = 2, [4] = 3 },
    right = { [1] = 2, [2] = 3, [3] = 4 },
}
local function use_adjacent_workspace(direction, move_window)
    local active = hl.get_active_workspace()
    local target = active and active.id and horizontal_workspace[direction][active.id]
    if not target then return end
    if move_window then
        hl.dispatch(hl.dsp.window.move({ workspace = target, follow = true }))
    else
        hl.dispatch(hl.dsp.focus({ workspace = target }))
    end
end
local function bind_workspace_direction(direction)
    hl.bind("CTRL + ALT + " .. direction, function()
        use_adjacent_workspace(direction, false)
    end)
    hl.bind("CTRL + ALT + SHIFT + " .. direction, function()
        use_adjacent_workspace(direction, true)
    end)
end
bind_workspace_direction("left")
bind_workspace_direction("right")
hl.bind("SUPER + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind("SUPER + mouse_up", hl.dsp.focus({ workspace = "e-1" }))
hl.bind("SUPER + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind("SUPER + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Host PipeWire/WirePlumber and brightness controls, never sudo.
local repeat_locked = { locked = true, repeating = true }
local locked = { locked = true }
launch("XF86AudioRaiseVolume", "/usr/bin/wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ 5%+", repeat_locked)
launch("XF86AudioLowerVolume", "/usr/bin/wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-", repeat_locked)
launch("XF86AudioMute", "/usr/bin/wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle", locked)
launch("XF86AudioMicMute", "/usr/bin/wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle", locked)
launch("XF86MonBrightnessUp", "/usr/bin/brightnessctl set +5%", repeat_locked)
launch("XF86MonBrightnessDown", "/usr/bin/brightnessctl set 5%-", repeat_locked)
launch("XF86AudioPlay", "/usr/bin/playerctl play-pause", locked)
launch("XF86AudioPause", "/usr/bin/playerctl play-pause", locked)
launch("XF86AudioNext", "/usr/bin/playerctl next", locked)
launch("XF86AudioPrev", "/usr/bin/playerctl previous", locked)

-- Absolute user path: the personal file is the customization point, and
-- keeping it last prevents its errors from discarding the core setup.
local config_home = os.getenv("XDG_CONFIG_HOME")
if not config_home or config_home == "" or config_home:sub(1, 1) ~= "/" then
    local home = os.getenv("HOME")
    config_home = home and home:sub(1, 1) == "/" and (home .. "/.config") or nil
end

if config_home then
    local local_module = config_home .. "/hypr/local"
    -- Linux ENOENT is 2. Absence is optional; permission and I/O errors are not.
    local local_file, open_error, open_errno = io.open(local_module .. ".lua", "r")
    if local_file then
        local_file:close()
        require(local_module)
    elseif open_errno ~= 2 then
        error(open_error, 0)
    end
end
