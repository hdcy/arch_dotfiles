local scheme = require("scheme.current")

return {
    -- Apps
    terminal                   = "kitty",
    browser                    = "zen-browser",
    editor                     = "kate",
    fileExplorer               = "dolphin",

    -- Touchpad
    touchpadDisableTyping      = true,
    touchpadScrollFactor       = 0.3,
    gestureFingers             = 3,
    workspaceSwipeFingers      = 4,
    gestureFingersMore         = 9,

    -- Blur
    blurEnabled                = true,
    blurSpecialWs              = false,
    blurPopups                 = true,
    blurInputMethods           = true,
    blurSize                   = 12,
    blurPasses                 = 3,
    blurXray                   = false,

    -- Shadow
    shadowEnabled              = true,
    shadowRange                = 20,
    shadowRenderPower          = 3,
    shadowColour               = "rgba(" .. scheme.surface .. "d4)",

    -- Gaps
    workspaceGaps              = 20,
    windowGapsIn               = 5,
    windowGapsOut              = 10,
    singleWindowGapsOut        = 20,

    -- Window styling
    windowOpacity              = 0.95,
    windowRounding             = 15,
    windowBorderSize           = 1,
    activeWindowBorderColour   = "rgba(" .. scheme.primary .. "e6)",
    inactiveWindowBorderColour = "rgba(" .. scheme.onSurfaceVariant .. "11)",

    -- Misc
    volumeStep                 = 10,
    cursorTheme                = "Qogir",
    cursorSize                 = 24,

    -- Keybinds: Workspaces
    kbMoveWinToWs              = "SUPER + SHIFT",
    kbMoveWinToWsGroup         = "CTRL + SUPER + ALT",
    kbGoToWs                   = "SUPER",
    kbGoToWsGroup              = "CTRL + SUPER",
    kbNextWs                   = "CTRL + SUPER + Right",
    kbPrevWs                   = "CTRL + SUPER + Left",
    kbToggleSpecialWs          = "SUPER + S",

    -- Keybinds: Window groups
    kbWindowGroupCycleNext     = "ALT + TAB",
    kbWindowGroupCyclePrev     = "SHIFT + ALT + TAB",
    kbUngroup                  = "SUPER + U",
    kbToggleGroup              = "SUPER + Comma",

    -- Keybinds: Window actions
    kbMoveWindow               = "SUPER + Z",
    kbResizeWindow             = "SUPER + X",
    kbWindowPip                = "SUPER + ALT + backslash",
    kbPinWindow                = "SUPER + P",
    kbWindowFullscreen         = "SUPER + F",
    kbWindowBorderedFullscreen = "SUPER + ALT + F",
    kbToggleWindowFloating     = "SUPER + ALT + Space",
    kbCloseWindow              = "SUPER + C",

    -- Keybinds: Special workspaces
    kbSystemMonitorWs          = "CTRL + ALT + Space",
    kbMusicWs                  = "SUPER + M",
    kbCommunicationWs          = "SUPER + D",
    kbTodoWs                   = "SUPER + R",

    -- Keybinds: Apps
    kbTerminal                 = "SUPER + Q",
    kbBrowser                  = "SUPER + ALT + W",
    kbEditor                   = "SUPER + T",
    kbFileExplorer             = "SUPER + E",

    -- Keybinds: Misc
    kbSession                  = "CTRL + ALT + Delete",
    kbShowSidebar              = "SUPER + N",
    kbClearNotifs              = "CTRL + ALT + C",
    kbShowPanels               = "SUPER + ALT + H",
    kbLock                     = "SUPER + ALT + L",
    kbRestoreLock              = "SUPER + CTRL + L",
}
