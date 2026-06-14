# arch_dotfiles

Arch Linux (EndeavourOS) 桌面环境配置文件，通过软连管理。

## 桌面环境

- **合成器**: Hyprland 0.55 + caelestia dotfiles
- **Shell**: caelestia-shell (Quickshell QML)
- **显示管理器**: SDDM (KWin Wayland)
- **终端**: Kitty
- **编辑器**: Neovim (NvChad v2.5)
- **文件管理器**: Dolphin / Yazi

## 目录结构

```
├── caelestia/         ← Hyprland 用户覆盖层 (核心)
│   ├── hypr-user.conf ← Hyprland 自定义 (布局、光标、portal…)
│   ├── hypr-vars.conf ← 变量覆盖 (终端、快捷键、主题…)
│   ├── shell.json     ← caelestia Shell UI 设置
│   └── monitors/      ← 显示器配置
├── kitty/             ← Kitty 终端配置
│   ├── kitty.conf
│   └── current-theme.conf ← caelestia 配色自动同步 (脚本见 skills)
├── nvim/              ← Neovim NvChad v2.5
├── waybar/            ← Waybar 状态栏
├── mako/              ← Mako 通知守护进程
├── yazi/              ← Yazi 终端文件管理器
├── fastfetch/         ← Fastfetch 配置 (sofijacom/dotfiles-fastfetch, 随机 PNG logo)
├── zsh/               ← Zsh 配置
│   └── .zshrc         ← Oh My Zsh + fastfetch 别名
├── hypr/              ← [旧] 独立 Hyprland 配置 (已迁移到 caelestia)
└── wofi/              ← [空] Wofi 启动器 (已由 caelestia launcher 替代)
```

## 软连部署

```bash
git clone git@github.com:2621939606/arch_dotfiles.git ~/git_clone/dotfiles

# 建立软连 (~/.config/)
ln -sf ~/git_clone/dotfiles/caelestia ~/.config/caelestia
ln -sf ~/git_clone/dotfiles/kitty     ~/.config/kitty
ln -sf ~/git_clone/dotfiles/nvim      ~/.config/nvim
ln -sf ~/git_clone/dotfiles/waybar    ~/.config/waybar
ln -sf ~/git_clone/dotfiles/mako      ~/.config/mako
ln -sf ~/git_clone/dotfiles/yazi      ~/.config/yazi

# zshrc
ln -sf ~/git_clone/dotfiles/zsh/.zshrc ~/.zshrc
```

## 依赖项

| 组件 | 依赖 |
|------|------|
| caelestia | caelestia-shell, caelestia-cli, qtengine, quickshell |
| Hyprland | aquamarine, xdg-desktop-portal-hyprland |
| Neovim | NvChad, lazy.nvim |
| Kitty | caelestia-kitty-sync (动态配色) |

## 注意事项

- `caelestia/` 是用户覆盖层，不受上游 `~/git_clone/Caelestia_dtos/` git 影响
- `hypr/` 目录为历史备份，当前 Hyprland 配置由 caelestia 管理
- `kitty/current-theme.conf` 由 caelestia 配色系统自动生成，变更直接进 git
- KDE Plasma 共存时需 `~/.config/plasma-workspace/env/pre-kde.sh` 清除 `QT_QPA_PLATFORMTHEME` (防止主题污染)
- SDDM Wayland greeter 双光标残留修复: `/etc/sddm.conf` 中 `GreeterEnvironment=KWIN_FORCE_SW_CURSOR=1`
