-- ~/.config/hypr/local.lua
--
-- Your personal Hyprland configuration.
--
-- Parrot's main configuration is in /etc/xdg/hypr/hyprland.lua. Hyprland loads
-- that file first and then loads this file at the end, so everything here can
-- override or extend the Parrot defaults without editing a package-owned file.
--
-- How to use this file
-- --------------------
-- 1. Find the example closest to what you want to do.
-- 2. Remove the leading "-- " from every line of that example.
-- 3. Replace the example values with your own.
-- 4. Save the file. Hyprland reloads it automatically.
-- 5. Run "hyprctl configerrors" if something does not work.
--
-- Keep examples commented out until you need them. Do not uncomment several
-- examples that define the same keybinding or the same setting: use one.
--
-- hl.config() values are applied in order, so a later value wins. hl.bind()
-- and hl.on() add registrations; use hl.unbind() before replacing an existing
-- keybinding.
--
-- The Hyprland Lua API uses:
--   hl.config(...)        change settings
--   hl.bind(...)          add a keybinding
--   hl.unbind(...)        remove an existing keybinding
--   hl.monitor(...)       configure a display
--   hl.window_rule(...)   configure windows
--   hl.workspace_rule(...) configure workspaces
--   hl.device(...)        configure an input device
--   hl.gesture(...)       configure a touchpad gesture
--   hl.env(...)           set an environment variable
--   hl.on(...)            run code when a Hyprland event happens
--   hl.exec_cmd(...)      run a shell command
--
-- Full documentation: https://wiki.hypr.land/configuring/
-- Check display names with: hyprctl monitors
-- Check input devices with: hyprctl devices


-- ============================================================================
-- 1. DISPLAYS AND MONITORS
-- ============================================================================

-- Set the scale of the laptop display. Replace eDP-1 with your output name.
-- hl.monitor({
--     output = "eDP-1",
--     mode = "preferred",
--     position = "auto",
--     scale = "1.25",
-- })

-- Place two displays side by side, with the external display on the right.
-- hl.monitor({
--     output = "eDP-1",
--     mode = "preferred",
--     position = "0x0",
--     scale = "1",
-- })
-- hl.monitor({
--     output = "HDMI-A-1",
--     mode = "2560x1440@144",
--     position = "1920x0",
--     scale = "1",
-- })

-- Disable an output without unplugging it.
-- hl.monitor({ output = "HDMI-A-1", disabled = true })

-- Rotate a display. Values are 0, 1, 2 or 3 (normal, 90, 180, 270 degrees).
-- hl.monitor({ output = "eDP-1", transform = 1 })


-- ============================================================================
-- 2. KEYBOARD, MOUSE AND TOUCHPAD
-- ============================================================================

-- Change the keyboard layout and make Caps Lock an Escape key.
-- hl.config({
--     input = {
--         kb_layout = "it",
--         kb_options = "caps:escape",
--     },
-- })

-- Change keyboard repeat speed.
-- hl.config({
--     input = {
--         repeat_rate = 40,
--         repeat_delay = 400,
--     },
-- })

-- Disable touchpad natural scrolling.
-- hl.config({
--     input = {
--         touchpad = {
--             natural_scroll = false,
--         },
--     },
-- })

-- Per-device settings. Run "hyprctl devices" to find the device name.
-- hl.device({
--     name = "your-touchpad-name",
--     sensitivity = 0.2,
--     tap_to_click = true,
--     natural_scroll = true,
-- })


-- ============================================================================
-- 3. LAUNCH APPLICATIONS WITH KEYBINDINGS
-- ============================================================================
--
-- The Parrot defaults already bind:
--   SUPER + T          kitty
--   SUPER + E          thunar
--   SUPER + B          firefox-esr
--   SUPER + D          cyberpunk-apps
--   SUPER + I          cyberpunk-control
--   SUPER + SHIFT + E  cyberpunk-power
--   SUPER + L          cyberpunk-lock
--
-- Add a new keybinding. The command is run through the shell.
-- hl.bind("SUPER + Return", hl.dsp.exec_cmd("kitty"))
-- hl.bind("SUPER + C", hl.dsp.exec_cmd("code"))
-- hl.bind("SUPER + M", hl.dsp.exec_cmd("thunderbird"))
-- hl.bind("SUPER + SHIFT + F", hl.dsp.exec_cmd("firefox-esr --private-window"))

-- Launch a command with arguments.
-- hl.bind("SUPER + SHIFT + T", hl.dsp.exec_cmd("kitty --directory ~/Downloads"))

-- Launch your own script. Use an absolute path for reliability.
-- hl.bind("SUPER + F12", hl.dsp.exec_cmd("/home/USER/bin/my-script"))

-- Replace an existing Parrot binding. First remove the old binding, then add
-- the new one. Both lines are needed.
-- hl.unbind("SUPER + T")
-- hl.bind("SUPER + T", hl.dsp.exec_cmd("alacritty"))

-- Run a small Lua function instead of a single command.
-- hl.bind("SUPER + SHIFT + W", function()
--     hl.exec_cmd("notify-send 'Hello' 'This is my custom shortcut'")
-- end)

-- A repeating binding, for example for volume or brightness.
-- hl.bind("SUPER + SHIFT + Up", hl.dsp.exec_cmd("brightnessctl set +5%"), {
--     repeating = true,
-- })

-- A binding that also works while the lockscreen is active.
-- hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), {
--     locked = true,
-- })

-- Print-screen shortcuts used by Parrot. You can replace the command with
-- your own screenshot tool if you prefer.
-- hl.bind("Print", hl.dsp.exec_cmd("cyberpunk-screenshot area"))
-- hl.bind("SHIFT + Print", hl.dsp.exec_cmd("cyberpunk-screenshot full"))


-- ============================================================================
-- 4. WINDOW MANAGEMENT KEYBINDINGS
-- ============================================================================

-- Close the active window.
-- hl.bind("SUPER + Q", hl.dsp.window.close())

-- Toggle fullscreen.
-- hl.bind("SUPER + F", hl.dsp.window.fullscreen({
--     action = "toggle",
--     mode = "fullscreen",
-- }))

-- Toggle floating mode.
-- hl.bind("SUPER + V", hl.dsp.window.float({ action = "toggle" }))

-- Toggle pseudo-tiling (dwindle layout).
-- hl.bind("SUPER + P", hl.dsp.window.pseudo())

-- Toggle the split direction (dwindle layout).
-- hl.bind("SUPER + J", hl.dsp.layout("togglesplit"))

-- Focus a window in a direction.
-- hl.bind("SUPER + left", hl.dsp.focus({ direction = "left" }))

-- Move the active window in a direction.
-- hl.bind("SUPER + SHIFT + left", hl.dsp.window.move({ direction = "left" }))

-- Resize a window with repeated keypresses.
-- hl.bind("SUPER + CTRL + right", hl.dsp.window.resize({
--     x = 30,
--     y = 0,
--     relative = true,
-- }), { repeating = true })

-- Drag and resize with the mouse while holding Super.
-- hl.bind("SUPER + mouse:272", hl.dsp.window.drag(), { mouse = true })
-- hl.bind("SUPER + mouse:273", hl.dsp.window.resize(), { mouse = true })


-- ============================================================================
-- 5. WORKSPACES
-- ============================================================================

-- Switch to workspace 1, 2, 3 or 4.
-- hl.bind("SUPER + 1", hl.dsp.focus({ workspace = 1 }))
-- hl.bind("SUPER + 2", hl.dsp.focus({ workspace = 2 }))

-- Move the active window to a workspace.
-- hl.bind("SUPER + SHIFT + 1", hl.dsp.window.move({ workspace = 1 }))

-- Move through workspaces with the mouse wheel.
-- hl.bind("SUPER + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
-- hl.bind("SUPER + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- A scratchpad workflow: Super+0 shows it, Super+Shift+0 moves a window there.
-- hl.bind("SUPER + 0", hl.dsp.focus({ workspace = "special:scratch" }))
-- hl.bind("SUPER + SHIFT + 0", hl.dsp.window.move({ workspace = "special:scratch" }))

-- Make a workspace persistent.
-- hl.workspace_rule({ workspace = "5", persistent = true })

-- Assign a workspace to a monitor.
-- hl.workspace_rule({
--     workspace = "1",
--     monitor = "eDP-1",
--     default = true,
-- })

-- Remove gaps on a workspace.
-- hl.workspace_rule({
--     workspace = "6",
--     gaps_in = 0,
--     gaps_out = 0,
-- })


-- ============================================================================
-- 6. WINDOW RULES
-- ============================================================================
--
-- Use "hyprctl clients" to inspect a window's class, title and initial class.
-- Regexes are supported.

-- Float and center a settings window.
-- hl.window_rule({
--     name = "my-float-settings",
--     match = { class = "^(my-settings-app)$" },
--     float = true,
--     center = true,
-- })

-- Open a browser on workspace 2.
-- hl.window_rule({
--     name = "my-browser-workspace",
--     match = { class = "^(firefox|firefox-esr)$" },
--     workspace = "2",
-- })

-- Open a floating window with a fixed size.
-- hl.window_rule({
--     name = "my-fixed-window",
--     match = { class = "^(my-tool)$" },
--     float = true,
--     size = { 900, 600 },
--     center = true,
-- })

-- Make a window slightly transparent.
-- hl.window_rule({
--     name = "my-transparent-terminal",
--     match = { class = "^Alacritty$" },
--     opacity = "0.92 0.88",
-- })

-- Prevent a video player from blurring.
-- hl.window_rule({
--     name = "my-no-blur-video",
--     match = { class = "^(mpv|celluloid)$" },
--     no_blur = true,
-- })

-- Prevent a window from taking focus when it opens.
-- hl.window_rule({
--     name = "my-no-focus",
--     match = { class = "^(my-notification-app)$" },
--     no_focus = true,
-- })

-- Keep a window visible on all workspaces.
-- hl.window_rule({
--     name = "my-pinned-window",
--     match = { class = "^(my-pinned-app)$" },
--     pin = true,
-- })


-- ============================================================================
-- 7. APPEARANCE, GAPS, BORDERS AND ANIMATIONS
-- ============================================================================

-- Change gaps, border width and active border colors.
-- hl.config({
--     general = {
--         gaps_in = 4,
--         gaps_out = 8,
--         border_size = 2,
--         col = {
--             active_border = { colors = { "rgba(39d5cfff)" }, angle = 45 },
--             inactive_border = "rgba(303d50ff)",
--         },
--     },
-- })

-- Change window rounding and opacity.
-- hl.config({
--     decoration = {
--         rounding = 6,
--         active_opacity = 1.0,
--         inactive_opacity = 0.94,
--     },
-- })

-- Disable blur.
-- hl.config({
--     decoration = {
--         blur = { enabled = false },
--     },
-- })

-- Disable all animations. You can also turn off a single leaf below.
-- hl.config({ animations = { enabled = false } })

-- Add a custom animation curve and use it for windows.
-- hl.curve("myCurve", {
--     type = "bezier",
--     points = { { 0.2, 0 }, { 0, 1 } },
-- })
-- hl.animation({
--     leaf = "windows",
--     enabled = true,
--     speed = 5,
--     bezier = "myCurve",
-- })

-- Change the dwindle layout.
-- hl.config({
--     dwindle = {
--         preserve_split = true,
--     },
-- })

-- Change the master layout.
-- hl.config({
--     master = {
--         new_status = "master",
--     },
-- })


-- ============================================================================
-- 8. ENVIRONMENT VARIABLES
-- ============================================================================

-- Set a cursor theme and size.
-- hl.env("XCURSOR_THEME", "Adwaita")
-- hl.env("XCURSOR_SIZE", "24")

-- Tell Qt and Firefox applications to use Wayland.
-- hl.env("QT_QPA_PLATFORM", "wayland")
-- hl.env("MOZ_ENABLE_WAYLAND", "1")

-- Add a directory to PATH for applications launched by Hyprland.
-- hl.env("PATH", os.getenv("HOME") .. "/.local/bin:" .. (os.getenv("PATH") or ""))


-- ============================================================================
-- 9. AUTOSTART APPLICATIONS
-- ============================================================================
--
-- Parrot already starts Hyprpaper, Waybar, Hypridle and the desktop helpers.
-- Do not start those a second time here.

-- Start an application after Hyprland has created its sockets.
-- hl.on("hyprland.start", function()
--     hl.exec_cmd("/usr/bin/keepassxc")
-- end)

-- Start two applications.
-- hl.on("hyprland.start", function()
--     hl.exec_cmd("/usr/bin/nm-applet")
--     hl.exec_cmd("/usr/bin/blueman-applet")
-- end)


-- ============================================================================
-- 10. TRACKPAD GESTURES
-- ============================================================================

-- Three-finger horizontal swipe to switch workspaces.
-- hl.gesture({
--     fingers = 3,
--     direction = "horizontal",
--     action = "workspace",
-- })

-- Three-finger vertical swipe to move the active window.
-- hl.gesture({
--     fingers = 3,
--     direction = "vertical",
--     action = "move",
-- })

-- Four-finger swipe to scroll through windows.
-- hl.gesture({
--     fingers = 4,
--     direction = "vertical",
--     action = "scroll_move",
-- })


-- ============================================================================
-- 11. ADVANCED OPTIONS
-- ============================================================================

-- Require explicit permissions for privileged Hyprland operations.
-- hl.config({
--     ecosystem = {
--         enforce_permissions = true,
--     },
-- })

-- Allow screen sharing from the usual Parrot tools.
-- hl.permission("/usr/(bin|local/bin)/grim", "screencopy", "allow")
-- hl.permission("/usr/(lib|libexec|lib64)/xdg-desktop-portal-hyprland", "screencopy", "allow")

-- Load a Hyprland plugin. Replace the path with the plugin's .so file.
-- hl.plugin.load("/usr/lib/hyprland/plugins/example.so")


-- ============================================================================
-- 12. APPLY SETTINGS AT STARTUP
-- ============================================================================

-- hl.exec_cmd() at file scope runs while the configuration is being loaded.
-- Prefer hl.on("hyprland.start", ...) when a command needs the compositor.
--
-- hl.exec_cmd("/usr/bin/notify-send 'Hyprland' 'Configuration loaded'")

-- End of personal configuration.
