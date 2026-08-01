# arch_dotfiles

Arch Linux 桌面环境配置文件，通过软链管理。

## 桌面环境

- **系统**: Arch Linux (EndeavourOS)
- **合成器**: niri 26.04（scrollable-tiling，2026-07 从 Hyprland 迁移）
- **Shell**: noctalia 5.0.0-git（控制中心/剪贴板/壁纸）
- **终端**: foot 1.27（主题 OSC 热应用）
- **显示管理器**: SDDM (Wayland)
- **输入法**: fcitx5 (mozc + 拼音)
- **编辑器**: Neovim (lazy.nvim) / Kate
- **文件管理器**: Dolphin / Yazi
- **浏览器**: Zen Browser

## 目录结构

```
├── zsh/                ← Zsh 配置（.zshrc 含 API key，git 提交时排除）
├── foot/               ← Foot 终端配置 + noctalia-foot-sync 热应用脚本
├── kitty/              ← Kitty 配置（历史备用，已弃用）
├── nvim/               ← Neovim 配置
├── niri/               ← niri 合成器配置（config.kdl + noctalia.kdl）
├── caelestia/          ← Caelestia 配置（历史备用，已迁移到 noctalia）
├── noctalia/           ← noctalia 配置
├── systemd/            ← user 级 systemd unit（noctalia-foot-sync.service 等）
├── fastfetch/          ← Fastfetch 系统信息
├── yazi/               ← Yazi 文件管理器
├── waybar/             ← Waybar 配置（历史备用）
└── scripts/            ← 辅助脚本
```

## 部署方式

所有配置通过**软链**从仓库指向 `~/.config/`：

```bash
ln -s ~/workspace/git_clone/arch_dotfiles/foot ~/.config/foot
ln -s ~/workspace/git_clone/arch_dotfiles/niri ~/.config/niri
ln -s ~/workspace/git_clone/arch_dotfiles/systemd/user ~/.config/systemd/user
# ... 依此类推
```

systemd 服务启用：

```bash
systemctl --user enable --now noctalia-foot-sync.service
```

## 注意事项

- `zsh/.zshrc` 含 API key，**提交时用 `git stash push zsh/.zshrc` 排除**
- `foot/themes/noctalia`、`niri/noctalia.kdl` 由 noctalia 自动生成，可能随壁纸变化
- 历史组件（Hyprland/caelestia/kitty）保留在仓库，未来可能回归
