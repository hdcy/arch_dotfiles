# arch_dotfiles

Arch Linux 桌面环境配置文件，通过软链管理。

## 桌面环境

- **系统**: Arch Linux
- **桌面**: KDE Plasma 6 (Wayland)
- **Shell**: Zsh + Oh My Zsh
- **终端**: Kitty
- **编辑器**: Neovim (lazy.nvim)
- **文件管理器**: Dolphin / Yazi

## 目录结构

```
├── zsh/                ← Zsh 配置
│   ├── .zshrc          ← Oh My Zsh 主配置
│   └── oh-my-zsh/      ← OMZ 自定义插件
│       └── custom/plugins/
│           ├── zsh-autosuggestions
│           ├── zsh-completions
│           └── zsh-syntax-highlighting
├── kitty/              ← Kitty 终端配置
│   └── kitty.conf
├── nvim/               ← Neovim 配置
│   ├── init.lua        ← 入口，引导 lazy.nvim
│   └── lua/
│       ├── options.lua ← 编辑器基础设置
│       ├── keymaps.lua ← 快捷键
│       ├── autocmds.lua← 自动命令
│       └── plugins/    ← 插件声明
│           ├── ui.lua  ← 主题 + 文件树
│           └── git.lua ← gitsigns
├── fastfetch/          ← Fastfetch 系统信息
│   └── config.jsonc
├── yazi/               ← Yazi 文件管理器
├── waybar/             ← Waybar 状态栏
└── caelestia/          ← Caelestia 配置（暂存）
```

## 软链部署

```bash
git clone git@github.com:hdcy/arch_dotfiles.git ~/workspace/git_clone/arch_dotfiles

# Zsh
ln -sf ~/workspace/git_clone/arch_dotfiles/zsh/.zshrc ~/.zshrc
ln -sf ~/workspace/git_clone/arch_dotfiles/zsh/oh-my-zsh ~/.config/oh-my-zsh

# 终端 / 编辑器
ln -sf ~/workspace/git_clone/arch_dotfiles/kitty     ~/.config/kitty
ln -sf ~/workspace/git_clone/arch_dotfiles/nvim      ~/.config/nvim

# 其他
ln -sf ~/workspace/git_clone/arch_dotfiles/fastfetch ~/.config/fastfetch
ln -sf ~/workspace/git_clone/arch_dotfiles/yazi      ~/.config/yazi
```

## 注意事项

- nvim 配置使用 lazy.nvim 管理插件，首次启动自动安装
- oh-my-zsh 通过 pacman 安装至 `/usr/share/oh-my-zsh`，自定义插件在 dotfiles 中
- Kitty 连接 Wayland 原生渲染，需 `--enable-features=UseOzonePlatform` 参数（已在 desktop 文件中设置）
