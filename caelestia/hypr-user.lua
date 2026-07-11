-- ============================================================
-- hypr-user.lua — 用户覆盖配置（from arch_dotfiles）
-- ============================================================

-- === 覆盖通用设置 ===
hl.config({
    general = {
        layout = "scrolling", -- 无限平铺
    },

    scrolling = {
        column_width             = 0.7,
        fullscreen_on_one_column = true,
        direction                = "right",
        follow_focus             = true,
        wrap_focus               = false,
        wrap_swapcol             = false,
        explicit_column_widths   = "0.2, 0.333, 0.5, 0.7, 0.92, 1.0",
    },

    input = {
        numlock_by_default         = true,
        accel_profile              = "flat",
        sensitivity                = 0.5,
        follow_mouse               = 0,
        float_switch_override_focus = 0,
    },

    misc = {
        initial_workspace_tracking = false,
        layers_hog_keyboard_focus  = false,
    },

    xwayland = {
        force_zero_scaling = true,
    },
})

-- === 显示器 ===
hl.monitor({
    output   = "eDP-2",
    mode     = "2560x1600@300",
    position = "0x0",
    scale    = 1.6,
})

-- === 窗口规则 ===
hl.window_rule({
    match   = { class = ".*" },
    opacity = "0.9 0.9 0.9",
})

-- === 层规则（Waybar / Wofi 模糊） ===
-- hl.layer_rule({ match = { namespace = "^waybar$" }, blur = true })
-- hl.layer_rule({ match = { namespace = "^wofi$" }, blur = true })

-- === 启动命令 ===
hl.on("hyprland.start", function()
    hl.exec_cmd("fcitx5")
    hl.exec_cmd("echo 'Xft.dpi:154' | xrdb -merge")
    hl.exec_cmd("systemctl --user start hyprland-session.service")
    hl.exec_cmd("sh -c 'systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP && sleep 2 && systemctl --user start xdg-desktop-portal.service xdg-desktop-portal-hyprland.service'")
    hl.exec_cmd("gsettings set org.gnome.desktop.interface icon-theme 'Papirus-Dark'")
    hl.exec_cmd("gsettings set org.gnome.desktop.interface toolbar-style 'icons'")
end)

-- === 手势：四指下滑锁屏 ===
-- hl.gesture({ fingers = 4, direction = "down", action = function()
--     hl.exec_cmd("loginctl lock-session")
-- end })

-- === 动画：工作区切换用 slidevert ===
hl.animation({
    leaf    = "workspaces",
    enabled = true,
    speed   = 4,
    bezier  = "emphasizedDecel",
    style   = "slidevert",
})

-- === 滚动聚焦动画 ===
hl.animation({ leaf = "windowsMove", enabled = true, speed = 4, bezier = "standard" })

-- ============================================================
--                      快捷键
-- ============================================================

-- 工作区切换
hl.bind("SUPER + K", function() hl.dispatch(hl.dsp.focus({ workspace = "r-1" })) end)
hl.bind("SUPER + J", function() hl.dispatch(hl.dsp.focus({ workspace = "r+1" })) end)

-- 移动窗口到上下工作区
hl.bind("SUPER + SHIFT + K", function()
    local ws = hl.get_active_workspace()
    if ws then
        hl.dispatch(hl.dsp.window.move({ workspace = ws.id - 1, follow = true }))
    end
end)
hl.bind("SUPER + SHIFT + J", function()
    local ws = hl.get_active_workspace()
    if ws then
        hl.dispatch(hl.dsp.window.move({ workspace = ws.id + 1, follow = true }))
    end
end)

-- 启动器
hl.unbind("SUPER + SUPER_L")
hl.bind("SUPER + Space", hl.dsp.global("caelestia:launcher"), { release = true })

-- 仪表盘
hl.bind("SUPER + I", hl.dsp.global("caelestia:dashboard"))

-- 窗口导航（滚动方向）
hl.bind("SUPER + L", hl.dsp.layout("focus r"))
hl.bind("SUPER + H", hl.dsp.layout("focus l"))

-- 列宽调整
hl.bind("SUPER + W", hl.dsp.layout("colresize +0.05"))
hl.bind("SUPER + B", hl.dsp.layout("colresize -0.05"))
-- hl.bind("SUPER + CTRL + K", hl.dsp.layout("colresize +conf"))
-- hl.bind("SUPER + CTRL + J", hl.dsp.layout("colresize -conf"))

-- 高级操作
hl.bind("SUPER + SHIFT + L", hl.dsp.layout("swapcol r"))
hl.bind("SUPER + SHIFT + H", hl.dsp.layout("swapcol l"))
hl.bind("SUPER + Y", hl.dsp.layout("fit all"))

-- 浮动窗口切换（切入时缩小到 60% 居中）
hl.bind("SUPER + ALT + Space", function()
    local win = hl.get_active_window()
    if win then
        if win.floating then
            hl.dsp.window.float({ action = "off" })
        else
            hl.dsp.window.float({ action = "on" })
            hl.dsp.window.resize({ size = { x = 60, y = 60, relative = true } })
            hl.dsp.window.center({})
        end
    end
end)
