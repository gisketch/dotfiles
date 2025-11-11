return {
  {
    name = " Save Project",
    cmd = function()
      _G.save_project_with_input()
    end,
    rtxt = "s",
  },
  {
    name = " Delete Project",
    cmd = function()
      _G.delete_project_with_picker()
    end,
    rtxt = "d",
  },
}
