AGENTS - repository agent guidelines

Build / Lint / Test
- Run a quick syntax check: `luac -p init.lua` (or `luac -p lua/**/*.lua`)
- Lint Lua files with `luacheck .` (install luacheck globally)
- Run a single test (if tests exist): `busted path/to/spec.lua` (use `busted -o dot path/to/spec.lua` for verbose)

Code Style Guidelines
- File encoding: UTF-8, Unix line endings preferred
- Formatting: follow standard Lua style (2-4 spaces). This repo uses 4-space indents.
- Imports: use `require("module.path")` with relative package paths matching `lua/` layout
- Naming: modules and files use `snake_case`; Lua variables/functions use `snake_case`; Lua modules return tables
- Types: annotate expected types in comments where helpful; prefer clear table shapes over ad-hoc globals
- Error handling: prefer `pcall` for guarded calls and propagate errors upward; avoid swallowing errors silently
- Side effects: keep `init.lua` minimal; put plugin configs under `lua/plugins/` and user settings under `lua/config/`
- Tests: place tests alongside code in `spec/` or `tests/` when present; use `busted` for unit tests
- Commits: small, focused, and include the "why" in the message

Cursor & Copilot Rules
- No repo-level Cursor rules found in `.cursor/` or `.cursorrules`.
- No Copilot instructions found in `.github/copilot-instructions.md`.

When editing
- Update `AGENTS.md` if you add new tools, test runners or linters.
- Remember to run `luacheck` and `luac -p` before opening PRs.

Contact: repo owner for questions about conventions.