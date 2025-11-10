-- 📎 Copy File References for Claude Code
return {
  {
    name = " Copy File Reference",
    cmd = function()
      local filepath = vim.fn.expand("%:p")
      local relative_path = vim.fn.fnamemodify(filepath, ":~:.")
      relative_path = relative_path:gsub("\\", "/")

      local reference = "@" .. relative_path
      vim.fn.setreg("+", reference)
      vim.notify("Copied: " .. reference)
    end,
    keybind = "f",
    rtxt = "f",
  },

  {
    name = " Copy with Line Range",
    cmd = function()
      local filepath = vim.fn.expand("%:p")
      local relative_path = vim.fn.fnamemodify(filepath, ":~:.")
      relative_path = relative_path:gsub("\\", "/")

      local reference
      if vim.g.menu_visual_start and vim.g.menu_visual_end then
        local start_line = vim.g.menu_visual_start
        local end_line = vim.g.menu_visual_end
        if start_line > end_line then
          start_line, end_line = end_line, start_line
        end

        if start_line == end_line then
          reference = "@" .. relative_path .. " :L" .. start_line
        else
          reference = "@" .. relative_path .. " :L" .. start_line .. "-L" .. end_line
        end
      else
        local current_line = vim.fn.line(".")
        reference = "@" .. relative_path .. " :L" .. current_line
      end

      vim.fn.setreg("+", reference)
      vim.notify("Copied: " .. reference)
    end,
    keybind = "l",
    rtxt = "l",
  },

  {
    name = "󰈙 Copy Smart Reference",
    cmd = function()
      local filepath = vim.fn.expand("%:p")
      local relative_path = vim.fn.fnamemodify(filepath, ":~:.")
      relative_path = relative_path:gsub("\\", "/")

      local reference
      if vim.g.menu_visual_start and vim.g.menu_visual_end then
        local start_line = vim.g.menu_visual_start
        local end_line = vim.g.menu_visual_end
        if start_line > end_line then
          start_line, end_line = end_line, start_line
        end

        if start_line == end_line then
          reference = "@" .. relative_path .. " :L" .. start_line
        else
          reference = "@" .. relative_path .. " :L" .. start_line .. "-L" .. end_line
        end
      else
        reference = "@" .. relative_path
      end

      vim.fn.setreg("+", reference)
      vim.notify("Copied: " .. reference)
    end,
    keybind = "r",
    rtxt = "r",
  },

  { name = "separator" },

  {
    name = "󰅴 Copy Diagnostic (Line)",
    cmd = function()
      local filepath = vim.fn.expand("%:p")
      local relative_path = vim.fn.fnamemodify(filepath, ":~:.")
      relative_path = relative_path:gsub("\\", "/")

      local current_line = vim.fn.line(".")
      local diagnostics = vim.diagnostic.get(0, { lnum = current_line - 1 })

      if #diagnostics == 0 then
        vim.notify("No diagnostics on this line", vim.log.levels.WARN)
        return
      end

      local output = "@" .. relative_path .. " :L" .. current_line .. "\n\n"
      for _, diag in ipairs(diagnostics) do
        local severity = vim.diagnostic.severity[diag.severity]
        output = output .. string.format("[%s] %s\n", severity, diag.message)
      end

      vim.fn.setreg("+", output)
      vim.notify("Copied " .. #diagnostics .. " diagnostic(s) from line " .. current_line)
    end,
    keybind = "d",
    rtxt = "d",
  },

  {
    name = "󰨸 Copy Diagnostic (Buffer)",
    cmd = function()
      local filepath = vim.fn.expand("%:p")
      local relative_path = vim.fn.fnamemodify(filepath, ":~:.")
      relative_path = relative_path:gsub("\\", "/")

      local diagnostics = vim.diagnostic.get(0)
      if #diagnostics == 0 then
        vim.notify("No diagnostics in this buffer", vim.log.levels.WARN)
        return
      end

      local output = "@" .. relative_path .. "\n\n"
      for _, diag in ipairs(diagnostics) do
        local severity = vim.diagnostic.severity[diag.severity]
        local line = diag.lnum + 1
        output = output .. string.format("Line %d [%s] %s\n", line, severity, diag.message)
      end

      vim.fn.setreg("+", output)
      vim.notify("Copied " .. #diagnostics .. " diagnostic(s) from buffer")
    end,
    keybind = "b",
    rtxt = "b",
  },
}
