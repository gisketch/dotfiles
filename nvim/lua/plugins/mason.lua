return {
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup({
                registries = {
                    "github:mason-org/mason-registry",
                    "github:Crashdummyy/mason-registry",
                },
                ensure_installed = {
                    "roslyn",
                    -- "rzls"
                },
                ui = {
                    icons = {
                        package_installed = "✓",
                        package_pending = "➜",
                        package_uninstalled = "✗"
                    }
                }
            })
        end,
    },
    -- Mason LSP config for automatic server installation
    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = { "williamboman/mason.nvim" },
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "ts_ls",       -- TypeScript/JavaScript
                    "html",        -- HTML
                    "cssls",       -- CSS
                    "jsonls",      -- JSON
                    "lua_ls",      -- Lua
                    "pyright",     -- Python
                    "tailwindcss", -- Tailwind CSS (useful for React)
                },
                automatic_installation = true,
            })

            -- Enable LSP configurations after Mason installs servers
            vim.api.nvim_create_autocmd("User", {
                pattern = "MasonLspInstallComplete",
                callback = function()
                    -- Enable all configured LSP servers
                    local servers = { "ts_ls", "html", "cssls", "jsonls", "lua_ls", "pyright", "tailwindcss" }
                    for _, server in ipairs(servers) do
                        vim.lsp.enable(server)
                    end
                end,
            })

            -- Also enable immediately if servers are already installed
            vim.schedule(function()
                local servers = { "ts_ls", "html", "cssls", "jsonls", "lua_ls", "pyright", "tailwindcss" }
                for _, server in ipairs(servers) do
                    vim.lsp.enable(server)
                end
            end)
        end,
    },
    }
