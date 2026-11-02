-- Hyprland Lua 配置文件
-- 由 hyprland.conf 迁移而来（Hyprland 0.55+ 使用 Lua 配置）
-- 参考: https://wiki.hypr.land/Configuring/Start/

local terminal    = "kitty"
local fileManager = "thunar"
local mainMod     = "SUPER" -- Windows 键作为主修饰键

-----------------
--- MONITORS ----
-----------------

-- 多屏幕自动检测，扩展模式
hl.monitor({
    output   = "",
    mode     = "preferred",
    position = "auto",
    scale    = "auto",
})

--------------------
---- AUTOSTART ----
--------------------

hl.on("hyprland.start", function()
    hl.exec_cmd("hyprpaper")
    hl.exec_cmd("udiskie")
    hl.exec_cmd("xrdb ~/.Xresources")
    -- Sparkle：本机 Hyprland 不会激活 graphical-session.target，
    -- XDG autostart（~/.config/autostart）不会执行，因此在此处显式启动。
    -- 先清理残留实例，避免二次启动触发 second-instance 强制弹窗。
    hl.exec_cmd("sudo pkill -x sparkle; sudo pkill -x mihomo; sleep 2; /opt/sparkle/sparkle")
    hl.exec_cmd("nm-applet")
    hl.exec_cmd("waybar")
    hl.exec_cmd("fcitx5 --replace -d")
    hl.exec_cmd("gnome-keyring-daemon --start")
    -- Screen Share
    hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
    hl.exec_cmd("systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
    hl.exec_cmd("sleep 1; killall -e xdg-desktop-portal-hyprland 2>/dev/null; killall xdg-desktop-portal 2>/dev/null; /usr/lib/xdg-desktop-portal-hyprland & sleep 2; /usr/lib/xdg-desktop-portal &")
end)

hl.on("hyprland.shutdown", function()
    hl.exec_cmd("sudo pkill -x sparkle; sudo pkill -x mihomo")
end)

------------------------
---- ENV VARIABLES ----
------------------------

-- toolkit-specific scale
hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")
hl.env("http_proxy", "http://localhost:7890")
hl.env("https_proxy", "http://localhost:7890")
hl.env("no_proxy", "localhost,127.0.0.1,::1")
hl.env("NO_PROXY", "localhost,127.0.0.1,::1")
hl.env("GLFW_IM_MODULE", "fcitx5")
hl.env("GTK_IM_MODULE", "fcitx")
hl.env("QT_IM_MODULE", "fcitx")
hl.env("LC_CTYPE", "zh_CN.UTF-8")
hl.env("XMODIFIERS", "@im=fcitx")
hl.env("GTK_THEME", "Adwaita:dark")
hl.env("GTK2_RC_FILES", "/usr/share/themes/Adwaita-dark/gtk-2.0/gtkrc")
hl.env("QT_STYLE_OVERRIDE", "Adwaita-Dark")
-- 注意: hl.env 不展开 $VAR，必须用 os.getenv 拼接，否则会破坏 PATH
hl.env("PATH", (os.getenv("HOME") or "~") .. "/.local/bin:" .. (os.getenv("PATH") or ""))
hl.env("WORKON_HOME", (os.getenv("HOME") or "~") .. "/.virtualenv")

------------------
---- GENERAL -----
------------------

hl.config({
    general = {
        gaps_in  = 5,
        gaps_out = 10,

        border_size = 2,

        col = {
            active_border   = { colors = { "rgba(33ccffee)", "rgba(0087aaee)" }, angle = 90 },
            inactive_border = { colors = { "rgba(5f7aa0ee)", "rgba(6272a4ee)" }, angle = 90 },
        },

        resize_on_border = false,

        -- 开启前请先阅读 https://wiki.hypr.land/Configuring/Advanced-and-Cool/Tearing/
        allow_tearing = false,

        layout = "dwindle",
    },
})

----------------------
---- DECORATION ------
----------------------

hl.config({
    decoration = {
        rounding       = 10,
        rounding_power = 2,

        active_opacity   = 1.0,
        inactive_opacity = 0.8,

        shadow = {
            enabled      = true,
            range        = 4,
            render_power = 3,
            color        = "rgba(1a1a1aee)",
        },

        blur = {
            enabled   = true,
            size      = 3,
            passes    = 1,
            vibrancy  = 0.1696,
        },
    },
})

----------------------
---- ANIMATIONS ------
----------------------

hl.config({
    animations = {
        enabled = true,
    },
})

hl.curve("easeOutQuint",   { type = "bezier", points = { {0.23, 1},    {0.32, 1}    } })
hl.curve("easeInOutCubic", { type = "bezier", points = { {0.65, 0.05}, {0.36, 1}    } })
hl.curve("linear",         { type = "bezier", points = { {0, 0},       {1, 1}       } })
hl.curve("almostLinear",   { type = "bezier", points = { {0.5, 0.5},   {0.75, 1}    } })
hl.curve("quick",          { type = "bezier", points = { {0.15, 0},    {0.1, 1}     } })

hl.animation({ leaf = "global",        enabled = true,  speed = 10,   bezier = "default" })
hl.animation({ leaf = "border",        enabled = true,  speed = 5.39, bezier = "easeOutQuint" })
hl.animation({ leaf = "windows",       enabled = true,  speed = 4.79, bezier = "easeOutQuint" })
hl.animation({ leaf = "windowsIn",     enabled = true,  speed = 4.1,  bezier = "easeOutQuint", style = "popin 87%" })
hl.animation({ leaf = "windowsOut",    enabled = true,  speed = 1.49, bezier = "linear",       style = "popin 87%" })
hl.animation({ leaf = "fadeIn",        enabled = true,  speed = 1.73, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut",       enabled = true,  speed = 1.46, bezier = "almostLinear" })
hl.animation({ leaf = "fade",          enabled = true,  speed = 3.03, bezier = "quick" })
hl.animation({ leaf = "layers",        enabled = true,  speed = 3.81, bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn",      enabled = true,  speed = 4,    bezier = "easeOutQuint", style = "fade" })
hl.animation({ leaf = "layersOut",     enabled = true,  speed = 1.5,  bezier = "linear",       style = "fade" })
hl.animation({ leaf = "fadeLayersIn",  enabled = true,  speed = 1.79, bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut", enabled = true,  speed = 1.39, bezier = "almostLinear" })
hl.animation({ leaf = "workspaces",    enabled = true,  speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesIn",  enabled = true,  speed = 1.21, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesOut", enabled = true,  speed = 1.94, bezier = "almostLinear", style = "fade" })

---------------
---- LAYOUT ---
---------------

hl.config({
    dwindle = {
        preserve_split = true, -- You probably want this
    },
})

hl.config({
    master = {
        new_status = "master",
    },
})

-------------
---- MISC ---
-------------

hl.config({
    misc = {
        force_default_wallpaper = 0,
        disable_hyprland_logo   = true,
        vrr                     = 0,
    },
})

hl.config({
    xwayland = {
        force_zero_scaling = true,
    },
})

------------------
----- INPUT ------
------------------

hl.config({
    input = {
        kb_layout = "us",
        kb_variant = "",
        kb_model   = "",
        kb_options = "",
        kb_rules   = "",

        follow_mouse = 0,

        sensitivity = 0, -- -1.0 - 1.0, 0 means no modification.

        touchpad = {
            natural_scroll = false,
        },
    },
})

hl.config({
    gestures = {
        workspace_swipe_forever = false,
    },
})

hl.device({
    name        = "epic-mouse-v1",
    sensitivity = -0.5,
})

hl.config({
    cursor = {
        no_warps = true,
    },
})

----------------
---- BINDS -----
----------------

-- 退出 Hyprland（SUPER+SHIFT+M）
hl.bind(mainMod .. " + SHIFT + M", hl.dsp.exit())
-- 启动 emacs client
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd("emacsclient -c -a \"\""))
-- 浏览器
hl.bind(mainMod .. " + D", hl.dsp.exec_cmd("chromium --password-store=gnome-libsecret"))
-- 终端
hl.bind(mainMod .. " + T", hl.dsp.exec_cmd(terminal))
-- 文件管理器
hl.bind(mainMod .. " + F", hl.dsp.exec_cmd(fileManager))
-- 启动器（tofi）：lua 判断逻辑，最终命令经 bash 执行
function launch_tofi(app)
    app = app:gsub("%s+$", ""):gsub("^%s+", "")
    if app == "" then return end
    local args = ""
    if app == "/usr/bin/google-chrome-stable" then
        args = " --password-store=gnome-libsecret --no-proxy-server"
    end
    if app == "obs" then
        hl.exec_cmd("sudo modprobe v4l2loopback exclusive_caps=1 card_label='OBS Virtual Camera'")
    end
    hl.exec_cmd(app .. args)
end
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd([[
app=$(tofi-drun)
[ -n "$app" ] && hyprctl eval "launch_tofi('$app')"
]]))
-- 关闭活动窗口
hl.bind(mainMod .. " + C", hl.dsp.window.close())
-- 切换浮动
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
-- 伪平铺 (dwindle)
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())

-- 用 mainMod + 方向键移动焦点
hl.bind(mainMod .. " + left",  hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up",    hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down",  hl.dsp.focus({ direction = "down" }))

-- 用 mainMod + [0-9] 切换工作区
for i = 1, 10 do
    local key = i % 10 -- 10 映射到按键 0
    hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
end

-- 用 mainMod + SHIFT + [0-9] 将活动窗口移动到工作区
for i = 1, 10 do
    local key = i % 10
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- 特殊工作区 (scratchpad)
hl.bind(mainMod .. " + S",         hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- 用 mainMod + 滚轮在现有工作区间滚动
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

-- 用 mainMod + 鼠标左/右键拖动窗口 / 调整大小
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- 将当前工作区移到另一台显示器
hl.bind(mainMod .. " + J", hl.dsp.workspace.move({ monitor = "+1" }))
hl.bind(mainMod .. " + K", hl.dsp.workspace.move({ monitor = "-1" }))

-- 笔记本多媒体键：音量与屏幕亮度
hl.bind("XF86AudioRaiseVolume",  hl.dsp.exec_cmd("~/.config/hypr/scripts/volume.sh up"),     { repeating = true, locked = true })
hl.bind("XF86AudioLowerVolume",  hl.dsp.exec_cmd("~/.config/hypr/scripts/volume.sh down"),   { repeating = true, locked = true })
hl.bind("XF86AudioMute",         hl.dsp.exec_cmd("~/.config/hypr/scripts/volume.sh mute"),   { repeating = true, locked = true })
hl.bind("XF86AudioMicMute",      hl.dsp.exec_cmd("~/.config/hypr/scripts/volume.sh mic-mute"), { repeating = true, locked = true })
hl.bind("XF86MonBrightnessUp",   hl.dsp.exec_cmd("~/.config/hypr/scripts/brightness.sh up"),   { repeating = true, locked = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("~/.config/hypr/scripts/brightness.sh down"), { repeating = true, locked = true })

-- 需要 playerctl
hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),       { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),   { locked = true })

----------------------------
---- WINDOW RULES ----------
----------------------------

-- 移除浮动窗口边框
hl.window_rule({
    name  = "移除浮动窗口边框",
    match = {
        float = true,
        class = "com.alibabainc.dingtalk|wechat|tblive",
    },
    border_size = 0,
    no_shadow   = true,
    no_blur     = true,
})

-- vim: filetype=lua
