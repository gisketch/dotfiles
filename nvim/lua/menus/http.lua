-- HTTP/REST request menu (kulala)
return {
  {
    name = "󰣺 Send Request",
    cmd = function()
      require("kulala").run()
    end,
    rtxt = "s",
  },
  {
    name = "󰣺 Send All Requests",
    cmd = function()
      require("kulala").run_all()
    end,
    rtxt = "a",
  },
  {
    name = "󰑐 Replay Last Request",
    cmd = function()
      require("kulala").replay()
    end,
    rtxt = "r",
  },
}
