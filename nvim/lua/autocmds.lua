require "nvchad.autocmds"

-- Clear all buffers on startup
vim.api.nvim_create_autocmd("VimEnter", {
	callback = function()
		vim.schedule(function()
			-- Get all buffers
			local bufs = vim.api.nvim_list_bufs()
			local current_buf = vim.api.nvim_get_current_buf()

			-- Delete all buffers except current
			for _, buf in ipairs(bufs) do
				if buf ~= current_buf and vim.api.nvim_buf_is_valid(buf) then
					pcall(vim.api.nvim_buf_delete, buf, { force = true })
				end
			end

			-- Force redraw to clean up UI
			vim.cmd("redraw!")
		end)
	end,
})

-- Autocmds for relative number behavior
vim.cmd [[
    autocmd InsertEnter * :set norelativenumber
]]

vim.cmd [[
    autocmd InsertLeave * :set relativenumber
]]

-- Auto-remove trailing whitespace on save
vim.cmd [[
    autocmd BufWritePre * :%s/\s\+$//e
]]

-- restore cursor to file position in previous editing session
vim.api.nvim_create_autocmd("BufReadPost", {
	callback = function(args)
		local mark = vim.api.nvim_buf_get_mark(args.buf, '"')
		local line_count = vim.api.nvim_buf_line_count(args.buf)
		if mark[1] > 0 and mark[1] <= line_count then
			vim.api.nvim_win_set_cursor(0, mark)
			-- defer centering slightly so it's applied after render
			vim.schedule(function()
				vim.cmd("normal! zz")
			end)
		end
	end,
})

-- open help in vertical split
vim.api.nvim_create_autocmd("FileType", {
	pattern = "help",
	command = "wincmd L",
})

-- auto resize splits when the terminal's window is resized
vim.api.nvim_create_autocmd("VimResized", {
	command = "wincmd =",
})

-- no auto continue comments on new line
vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("no_auto_comment", {}),
	callback = function()
		vim.opt_local.formatoptions:remove({ "c", "r", "o" })
	end,
})

-- syntax highlighting for dotenv files
vim.api.nvim_create_autocmd("BufRead", {
	group = vim.api.nvim_create_augroup("dotenv_ft", { clear = true }),
	pattern = { ".env", ".env.*" },
	callback = function()
		vim.bo.filetype = "dosini"
	end,
})

-- ide like highlight when stopping cursor
vim.api.nvim_create_autocmd("CursorMoved", {
	group = vim.api.nvim_create_augroup("LspReferenceHighlight", { clear = true }),
	desc = "Highlight references under cursor",
	callback = function()
		-- Only run if the cursor is not in insert mode
		if vim.fn.mode() ~= "i" then
			local clients = vim.lsp.get_clients({ bufnr = 0 })
			local supports_highlight = false
			for _, client in ipairs(clients) do
				if client.server_capabilities.documentHighlightProvider then
					supports_highlight = true
					break -- Found a supporting client, no need to check others
				end
			end

			-- 3. Proceed only if an LSP is active AND supports the feature
			if supports_highlight then
				vim.lsp.buf.clear_references()
				vim.lsp.buf.document_highlight()
			end
		end
	end,
})

-- ide like highlight when stopping cursor
vim.api.nvim_create_autocmd("CursorMovedI", {
	group = "LspReferenceHighlight",
	desc = "Clear highlights when entering insert mode",
	callback = function()
		vim.lsp.buf.clear_references()
	end,
})
--
-- ---@type table<number, {token:lsp.ProgressToken, msg:string, done:boolean}[]>
-- local progress = vim.defaulttable()
-- vim.api.nvim_create_autocmd("LspProgress", {
--   ---@param ev {data: {client_id: integer, params: lsp.ProgressParams}}
--   callback = function(ev)
--     local client = vim.lsp.get_client_by_id(ev.data.client_id)
--     local value = ev.data.params.value --[[@as {percentage?: number, title?: string, message?: string, kind: "begin" | "report" | "end"}]]
--     if not client or type(value) ~= "table" then
--       return
--     end
--     local p = progress[client.id]
--
--     for i = 1, #p + 1 do
--       if i == #p + 1 or p[i].token == ev.data.params.token then
--         p[i] = {
--           token = ev.data.params.token,
--           msg = ("[%3d%%] %s%s"):format(
--             value.kind == "end" and 100 or value.percentage or 100,
--             value.title or "",
--             value.message and (" **%s**"):format(value.message) or ""
--           ),
--           done = value.kind == "end",
--         }
--         break
--       end
--     end
--
--     local msg = {} ---@type string[]
--     progress[client.id] = vim.tbl_filter(function(v)
--       return table.insert(msg, v.msg) or not v.done
--     end, p)
--
--     local spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
--     vim.notify(table.concat(msg, "\n"), "info", {
--       id = "lsp_progress",
--       title = client.name,
--       opts = function(notif)
--         notif.icon = #progress[client.id] == 0 and " "
--           or spinner[math.floor(vim.uv.hrtime() / (1e6 * 80)) % #spinner + 1]
--       end,
--     })
--   end,
-- })

-- Auto-refresh tabufline when grapple tags change
vim.api.nvim_create_autocmd("User", {
	pattern = "GrappleUpdate",
	callback = function()
		vim.cmd("redrawtabline")
	end,
})

-- Auto-refresh tabufline when switching buffers (for non-Grapple file display)
vim.api.nvim_create_autocmd("BufEnter", {
	callback = function(ev)
		local bufnr = ev.buf
		-- Skip temporary/invalid/unlisted buffers (like LSP temp buffers)
		if not vim.api.nvim_buf_is_valid(bufnr) or not vim.bo[bufnr].buflisted then
			return
		end
		vim.cmd("redrawtabline")
	end,
})

-- Auto-refresh tabufline when buffer is modified (for * indicator)
vim.api.nvim_create_autocmd({ "BufModifiedSet", "TextChanged", "TextChangedI" }, {
	callback = function(ev)
		local bufnr = ev.buf
		-- Skip temporary/invalid/unlisted buffers
		if not vim.api.nvim_buf_is_valid(bufnr) or not vim.bo[bufnr].buflisted then
			return
		end
		vim.cmd("redrawtabline")
	end,
})

-- Force buffer redraw when entering windows (fixes rendering after closing splits)
vim.api.nvim_create_autocmd({ "WinEnter", "BufWinEnter" }, {
	callback = function()
		vim.cmd("redraw")
	end,
})

-- Force full redraw after window operations (closing splits, etc)
vim.api.nvim_create_autocmd("WinClosed", {
	callback = function()
		vim.schedule(function()
			vim.cmd("redraw!")
		end)
	end,
})
