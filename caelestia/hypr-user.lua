-- ============================================================
-- hypr-user.lua — 用户覆盖配置（from arch_dotfiles）
-- ============================================================

-- 双 GPU（AMD iGPU + NVIDIA dGPU）兼容：关显式同步和 modifier 协商
hl.env("AQ_MGPU_NO_EXPLICIT", "1")

-- === 覆盖通用设置 ===
hl.config({
    general = {
        layout          = "scrolling", -- 无限平铺
        gaps_workspaces = 0,          -- 工作区外边距
        gaps_in         = 10,           -- 窗口之间间距
        gaps_out        = 18,          -- 窗口到屏幕边缘
    },

    scrolling = {
        column_width             = 0.8,
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
    debug = {
        vfr= false,  -- 禁掉可变帧率，始终保持满帧
        damage_tracking = 0, -- 禁止渲染器休眠
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

-- === 不透明窗口：游戏/创作软件强制不透明 ===
hl.window_rule({ match = { tag = "opaque_app" }, opacity = "1.0 override" })
hl.window_rule({ match = { class = "Minecraft.*" }, opacity = "1.0 override", no_blur = true })

-- === 手势：四指下滑锁屏 ===
-- hl.gesture({ fingers = 4, direction = "down", action = function()
--     hl.exec_cmd("loginctl lock-session")
-- end })

-- === Apple 风格动画曲线 ===
hl.curve("smoothOut", { type = "bezier", points = { {0.25, 0.1}, {0.25, 1} } })
hl.curve("smoothIn",  { type = "bezier", points = { {0.8, 0},    {0.6, 1} } })

-- === 轻微越界回弹曲线 ===
hl.curve("bounce", { type = "spring", mass = 2, stiffness = 50, dampening = 16 })

-- === 工作区切换 ===
hl.animation({
    leaf    = "workspaces",
    enabled = true,
    speed   = 4,
    spring  = "bounce",
    style   = "slidevert",
})

-- === 窗口动画 ===
hl.animation({
    leaf    = "windows",
    enabled = true,
    speed   = 4,
    spring  = "bounce",
})
hl.animation({
    leaf    = "windowsIn",
    enabled = true,
    speed   = 4,
    spring  = "bounce",
    style   = "slide right",
})
hl.animation({
    leaf    = "windowsOut",
    enabled = true,
    speed   = 8,
    bezier  = "smoothIn",
    style   = "slide right",
})

-- === 窗口移动 ===
hl.animation({
    leaf    = "windowsMove",
    enabled = true,
    speed   = 4,
    spring  = "bounce",
})

-- === 层动画（启动器、通知等） ===
hl.animation({
    leaf    = "layersIn",
    enabled = true,
    speed   = 4,
    bezier  = "smoothOut",
    style   = "fade",
})
hl.animation({
    leaf    = "layersOut",
    enabled = true,
    speed   = 3,
    bezier  = "smoothIn",
    style   = "fade",
})


-- ============================================================
--                      快捷键
-- ============================================================

-- 辅助函数：找有窗口的最高工作区 ID
local function max_occupied()
    local max_id = 0
    for _, w in ipairs(hl.get_workspaces()) do
        if w.windows > 0 and w.id > max_id then max_id = w.id end
    end
    return max_id
end

-- 工作区切换（J 边界：最后一个有窗口的工作区 + 1）
hl.bind("SUPER + K", function()
    local ws = hl.get_active_workspace()
    if ws and ws.id > 1 then hl.dispatch(hl.dsp.focus({ workspace = "r-1" })) end
end)
hl.bind("SUPER + J", function()
    local ws = hl.get_active_workspace()
    if ws and ws.id < max_occupied() + 1 then hl.dispatch(hl.dsp.focus({ workspace = "r+1" })) end
end)

-- 移动窗口到上下工作区（J 边界同上）
hl.bind("SUPER + SHIFT + K", function()
    local ws = hl.get_active_workspace()
    if ws and ws.id > 1 then hl.dispatch(hl.dsp.window.move({ workspace = ws.id - 1, follow = true })) end
end)
hl.bind("SUPER + SHIFT + J", function()
    local ws = hl.get_active_workspace()
    if ws and ws.id < max_occupied() + 1 then hl.dispatch(hl.dsp.window.move({ workspace = ws.id + 1, follow = true })) end
end)

-- 启动器
-- hl.unbind("SUPER + SUPER_L")
-- hl.bind("SUPER + Space", hl.dsp.global("caelestia:launcher"), { release = true })

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
-- 注意：resize 的 { size = { x, y, relative } } 格式虽有类型警告但功能正常，勿改
hl.bind("SUPER + ALT + Space", function()
    local win = hl.get_active_window()
    if win then
        if win.floating then
            hl.dsp.window.float({ action = "off" })
        else
            hl.dsp.window.float({ action = "on" })
            hl.dsp.window.resize( { x = 60, y = 60, relative = true } )
            hl.dsp.window.center({})
        end
    end
end)
