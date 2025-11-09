# gisketch.dotfiles

My personal dotfiles managed with [Rotz](https://github.com/volllly/rotz).

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

## What This Does

- Clones your dotfiles repo
- Creates hard links from `~/.dotfiles/` to your actual config locations
- Edits sync automatically with git

## Moving to Another PC

Same 3-step process above. Your entire dev environment gets restored in minutes.
