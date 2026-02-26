return {
  {
    "aserowy/tmux.nvim",
    opts = {
      navigation = {
        enable_default_keybindings = false,
      },
      resize = {
        enable_default_keybindings = false,
      },
      swap = {
        enable_default_keybindings = false,
      },
    },
  },
  {
    "christopher-francisco/tmux-status.nvim",
    lazy = false,
    opts = {
      window = {
        separator = "  ",
        icon_zoom = "",
        icon_mark = "󰃀",
        icon_bell = "󰂞",
        icon_mute = "󰂛",
        icon_activity = "󰖲",
        text = "name",
      },
      session = {
        icon = "",
      },
      datetime = {
        icon = "󰃭",
        format = "%a %d %b %H:%M",
      },
      colors = {
        window_active = { fg = "#0d0d0d", bg = "#d4d4d4" },
        window_inactive = { fg = "#737373", bg = "#151515" },
        window_inactive_recent = { fg = "#a3a3a3", bg = "#151515" },
        session = { fg = "#0d0d0d", bg = "#a3a3a3" },
        datetime = { fg = "#0d0d0d", bg = "#8a8a8a" },
        battery = { fg = "#0d0d0d", bg = "#737373" },
      },
    },
  },
}
