# gisketch.dotfiles

My personal dotfiles managed with [Rotz](https://github.com/volllly/rotz).

## Prerequisites

### All
- JetBrainsMonoNL Nerd Font Propo
- zoxide

### Windows
- Windows Terminal
    - manually copy `settings.json`
- [Ripgrep](https://github.com/BurntSushi/ripgrep) is required for grep searching with Telescope (OPTIONAL).
- GCC, Windows users must have [mingw](http://mingw-w64.org/downloads) installed and set on path.
- Make, Windows users must have [GnuWin32](https://sourceforge.net/projects/gnuwin32) installed and set on path.
- Scoop
- eza

## Quick Setup on New PC

### 1. Install Rotz

**Windows:**
```powershell
scoop bucket add volllly https://github.com/volllly/scoop-bucket
scoop install volllly/rotz
```

**macOS/Linux:**
```bash
brew install volllly/tap/rotz
```

### 2. Clone & Link

```powershell
rotz clone https://github.com/yourusername/dotfiles.git
rotz link
```

## What's Included

- **nvim** - Neovim configuration
- **herdr** - Herdr terminal/session UI configuration (runtime state excluded)
- **pi** - Pi agent settings, extension package manifest, Herdr integration, and custom skills (auth/sessions excluded)

## What This Does

- Clones your dotfiles repo
- Creates hard links from `~/.dotfiles/` to your actual config locations
- Edits sync automatically with git

## Moving to Another PC

Same 3-step process above. Your entire dev environment gets restored in minutes.
