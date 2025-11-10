return {
  "nvim-mini/mini.sessions",
  version = false,
lazy= false,
  config = function()
    local sessions = require('mini.sessions')

    -- Cross-platform session directory
    local session_dir
    if vim.fn.has('win32') == 1 or vim.fn.has('win64') == 1 then
      -- Windows
      session_dir = vim.fn.expand('$LOCALAPPDATA/nvim-sessions')
    else
      -- macOS and Linux
      session_dir = vim.fn.expand('~/.local/share/nvim-sessions')
    end

    -- Create directory if it doesn't exist
    vim.fn.mkdir(session_dir, 'p')

    sessions.setup({
      -- Whether to read default session if Neovim opened without file arguments
      autoread = false,

      -- Whether to write currently read session before leaving it
      autowrite = true,

      -- Directory where global sessions are stored
      directory = session_dir,

      -- File for local session (use '' to disable)
      file = 'Session.vim',

      -- Whether to force possibly harmful actions
      force = { read = false, write = true, delete = false },

      -- Hook functions for actions
      hooks = {
        -- Before successful action
        pre = { read = nil, write = nil, delete = nil },
        -- After successful action
        post = { read = nil, write = nil, delete = nil },
      },

      -- Whether to print session path after action
      verbose = { read = false, write = true, delete = true },
    })

    -- Helper function to get session list for dashboard
    _G.get_session_list = function()
      local session_files = vim.fn.glob(session_dir .. '/*', false, true)
      local sessions_list = {}

      for _, file in ipairs(session_files) do
        local name = vim.fn.fnamemodify(file, ':t:r')
        local mtime = vim.fn.getftime(file)
        table.insert(sessions_list, {
          name = name,
          file = file,
          mtime = mtime,
        })
      end

      -- Sort by modification time (newest first)
      table.sort(sessions_list, function(a, b)
        return a.mtime > b.mtime
      end)

      -- Limit to 10 sessions
      local limited_sessions = {}
      for i = 1, math.min(25, #sessions_list) do
        table.insert(limited_sessions, sessions_list[i])
      end

      return limited_sessions
    end

    -- Helper function to save session with input
    _G.save_session_with_input = function()
      Snacks.input({
        prompt = 'Session name: ',
        value = '',
      }, function(name)
        if name and name ~= '' then
          sessions.write(name)
        end
      end)
    end

    -- Helper function to delete session with picker
    _G.delete_session_with_picker = function()
      local session_list = _G.get_session_list()
      if #session_list == 0 then
        vim.notify('No sessions found', vim.log.levels.INFO)
        return
      end

      -- Extract session names for selection
      local session_names = {}
      for _, session in ipairs(session_list) do
        table.insert(session_names, session.name)
      end

      vim.ui.select(session_names, {
        prompt = '(CRITICAL) Delete Session: ',
        format_item = function(item)
          return ' ' .. item
        end,
      }, function(choice)
        if choice then
          sessions.delete(choice, { force = true })
        end
      end)
    end

    -- Helper function to handle unsaved buffers
    local function handle_unsaved_buffers(callback)
      local unsaved_buffers = {}
      for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        if vim.api.nvim_buf_is_loaded(buf)
           and vim.bo[buf].modified
           and vim.bo[buf].buflisted then
          local name = vim.api.nvim_buf_get_name(buf)
          if name ~= '' then
            table.insert(unsaved_buffers, { buf = buf, name = name })
          end
        end
      end

      if #unsaved_buffers == 0 then
        callback()
        return
      end

      -- Process each unsaved buffer
      local function process_buffer(index)
        if index > #unsaved_buffers then
          -- Clear LSP references before switching
          vim.lsp.buf.clear_references()
          -- Stop all LSP clients to prevent errors on deleted buffers
          vim.lsp.stop_client(vim.lsp.get_clients())
          callback()
          return
        end

        local buf_info = unsaved_buffers[index]
        local filename = vim.fn.fnamemodify(buf_info.name, ':t')

        vim.ui.select({ 'Save', 'Discard', 'Cancel' }, {
          prompt = string.format('Buffer "%s" has unsaved changes: ', filename),
        }, function(choice)
          if choice == 'Save' then
            vim.api.nvim_buf_call(buf_info.buf, function()
              vim.cmd('write')
            end)
            process_buffer(index + 1)
          elseif choice == 'Discard' then
            vim.api.nvim_set_option_value('modified', false, { buf = buf_info.buf })
            process_buffer(index + 1)
          else
            -- Cancel - stop the session switch
            vim.notify('Session switch cancelled', vim.log.levels.INFO)
          end
        end)
      end

      process_buffer(1)
    end

    -- Helper function to load session with picker
    _G.load_session_with_picker = function()
      local session_list = _G.get_session_list()
      if #session_list == 0 then
        vim.notify('No sessions found', vim.log.levels.INFO)
        return
      end

      -- Extract session names for selection
      local session_names = {}
      for _, session in ipairs(session_list) do
        table.insert(session_names, session.name)
      end

      vim.ui.select(session_names, {
        prompt = 'Load Session: ',
        format_item = function(item)
          return ' ' .. item
        end,
      }, function(choice)
        if choice then
          handle_unsaved_buffers(function()
            sessions.read(choice)
          end)
        end
      end)
    end
  end,
}
