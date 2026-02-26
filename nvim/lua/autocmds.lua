require "nvchad.autocmds"

if vim.env.TMUX then
	local focus_group = vim.api.nvim_create_augroup("tmux_single_statusline", { clear = true })

	vim.api.nvim_create_autocmd({ "FocusLost", "VimSuspend" }, {
		group = focus_group,
		callback = function()
			vim.g._tmux_laststatus = vim.o.laststatus
			vim.o.laststatus = 0
			vim.cmd("redrawstatus")
		end,
	})

	vim.api.nvim_create_autocmd({ "FocusGained", "VimResume" }, {
		group = focus_group,
		callback = function()
			vim.o.laststatus = vim.g._tmux_laststatus or 3
			vim.cmd("redrawstatus")
		end,
	})
end

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

-- SQL-specific cmp sources (vim-dadbod-completion + buffer)
vim.api.nvim_create_autocmd("FileType", {
	pattern = "sql",
	callback = function()
		local cmp_ok, cmp = pcall(require, "cmp")
		if not cmp_ok then
			return
		end

		-- Get current sources (NvChad defaults)
		local config = cmp.get_config()
		local sources = config.sources or {}

		-- Add dadbod and buffer if not already present
		local has_dadbod = false
		local has_buffer = false

		for _, source in ipairs(sources) do
			if source.name == "vim-dadbod-completion" then
				has_dadbod = true
			end
			if source.name == "buffer" then
				has_buffer = true
			end
		end

		if not has_dadbod then
			table.insert(sources, { name = "vim-dadbod-completion" })
		end

		if not has_buffer then
			table.insert(sources, { name = "buffer" })
		end

		-- Apply the modified sources with formatting to strip ^M and sorting to deprioritize functions
		local types = require("cmp.types")
		local compare = require("cmp.config.compare")

		cmp.setup.buffer({
			sources = sources,
			sorting = {
				priority_weight = 2,
				comparators = {
					compare.offset,
					compare.exact,
					compare.score,
					-- Custom comparator to push functions to the bottom
					function(entry1, entry2)
						local kind1 = entry1:get_kind()
						local kind2 = entry2:get_kind()
						local is_func1 = kind1 == types.lsp.CompletionItemKind.Function
						local is_func2 = kind2 == types.lsp.CompletionItemKind.Function

						if is_func1 and not is_func2 then
							return false
						elseif not is_func1 and is_func2 then
							return true
						end
					end,
					compare.recently_used,
					compare.locality,
					compare.kind,
					compare.length,
					compare.order,
				},
			},
			formatting = {
				format = function(entry, vim_item)
					-- Strip carriage returns from dadbod completions
					if vim_item.abbr then
						vim_item.abbr = vim_item.abbr:gsub("\r", "")
					end
					if vim_item.menu then
						vim_item.menu = vim_item.menu:gsub("\r", "")
					end
					-- Apply NvChad's default formatting if it exists
					local nvchad_format = config.formatting and config.formatting.format
					if nvchad_format then
						vim_item = nvchad_format(entry, vim_item)
					end
					return vim_item
				end,
			},
		})
	end,
})
