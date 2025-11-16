require("nvchad.configs.lspconfig").defaults()

-- Configure Roslyn LSP with custom command
vim.lsp.config.roslyn = {
  cmd = {
    "dotnet",
    vim.fn.expand("~/lsp/dotnet/content/LanguageServer/win-x64/Microsoft.CodeAnalysis.LanguageServer.dll"),
    "--logLevel",
    "Information",
    "--extensionLogDirectory",
    vim.fs.joinpath(vim.uv.os_tmpdir(), "roslyn_ls/logs"),
    "--stdio",
  },
  root_markers = { "*.csproj", "*.sln" },
}

local servers = { "html", "cssls", "lua_ls", "pyright", "roslyn", "tailwindcss", "ts_ls"}
vim.lsp.enable(servers)

-- read :h vim.lsp.config for changing options of lsp servers
