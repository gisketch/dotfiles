return {
  "nvim-lua/plenary.nvim",
  lazy = false,
  config = function()
    -- Cross-platform project directory
    local project_dir
    if vim.fn.has("win32") == 1 or vim.fn.has("win64") == 1 then
      project_dir = vim.fn.expand("$LOCALAPPDATA/nvim-projects")
    else
      project_dir = vim.fn.expand("~/.local/share/nvim-projects")
    end

    vim.fn.mkdir(project_dir, "p")

    local projects_file = project_dir .. "/projects.json"

    -- Load projects from JSON
    local function load_projects()
      local file = io.open(projects_file, "r")
      if not file then
        return {}
      end
      local content = file:read("*all")
      file:close()
      if content == "" then
        return {}
      end
      return vim.json.decode(content) or {}
    end

    -- Save projects to JSON
    local function save_projects(projects)
      local file = io.open(projects_file, "w")
      if not file then
        vim.notify("Failed to save projects", vim.log.levels.ERROR)
        return
      end
      file:write(vim.json.encode(projects))
      file:close()
    end

    -- Helper function to get project list
    _G.get_project_list = function()
      local projects = load_projects()
      local project_list = {}

      for name, data in pairs(projects) do
        table.insert(project_list, {
          name = name,
          path = data.path,
          mtime = data.mtime or 0,
        })
      end

      -- Sort by modification time (newest first)
      table.sort(project_list, function(a, b)
        return a.mtime > b.mtime
      end)

      return project_list
    end

    -- Save current CWD as project
    _G.save_project_with_input = function()
      Snacks.input({
        prompt = "Project name: ",
        value = "",
      }, function(name)
        if name and name ~= "" then
          local projects = load_projects()
          local cwd = vim.fn.getcwd()

          projects[name] = {
            path = cwd,
            mtime = os.time(),
          }

          save_projects(projects)
          vim.notify('Saved project "' .. name .. '" → ' .. cwd, vim.log.levels.INFO)
        end
      end)
    end

    -- Delete project with picker
    _G.delete_project_with_picker = function()
      local project_list = _G.get_project_list()
      if #project_list == 0 then
        vim.notify("No projects found", vim.log.levels.INFO)
        return
      end

      local project_names = {}
      for _, project in ipairs(project_list) do
        table.insert(project_names, project.name)
      end

      vim.ui.select(project_names, {
        prompt = "(CRITICAL) Delete Project: ",
        format_item = function(item)
          return " " .. item
        end,
      }, function(choice)
        if choice then
          local projects = load_projects()
          projects[choice] = nil
          save_projects(projects)
          vim.notify('Deleted project "' .. choice .. '"', vim.log.levels.INFO)
        end
      end)
    end

    -- Load project with picker (changes tab CWD)
    _G.load_project_with_picker = function()
      local project_list = _G.get_project_list()
      if #project_list == 0 then
        vim.notify("No projects found", vim.log.levels.INFO)
        return
      end

      local project_names = {}
      for _, project in ipairs(project_list) do
        table.insert(project_names, project.name)
      end

      vim.ui.select(project_names, {
        prompt = "Load Project: ",
        format_item = function(item)
          return " " .. item
        end,
      }, function(choice)
        if choice then
          local projects = load_projects()
          local project = projects[choice]

          if project and vim.fn.isdirectory(project.path) == 1 then
            -- Update mtime
            project.mtime = os.time()
            save_projects(projects)

            -- Change tab CWD only
            vim.cmd("tcd " .. vim.fn.fnameescape(project.path))
            vim.notify('Changed tab CWD to "' .. choice .. '" → ' .. project.path, vim.log.levels.INFO)

            -- After changing CWD, check for grapple index 1 or open explorer
            vim.schedule(function()
              local grapple_ok, grapple = pcall(require, "grapple")
              if grapple_ok then
                local tags = grapple.tags()
                if tags and #tags > 0 and tags[1] then
                  -- Open grapple index 1
                  grapple.select({ index = 1 })
                  return
                end
              end

              -- No grapple index 1, open explorer
              Snacks.picker.explorer()
            end)
          else
            vim.notify("Project path no longer exists", vim.log.levels.ERROR)
          end
        end
      end)
    end
  end,
}
