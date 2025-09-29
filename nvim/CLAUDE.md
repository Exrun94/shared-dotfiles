# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Commands
- Format: `stylua <file>` - Format Lua files using StyleLua
- Lint: No specific linting command (LazyVim handles this internally)
- Test: No specific test commands for this Neovim config

## Code Style Guidelines
- **Formatting**: Use 2 spaces for indentation in Lua files (as per stylua.toml)
- **Line length**: Max 120 columns in Lua files
- **Plugin definitions**: Return a table with plugin config
- **Imports**: Use `require()` for modules, prefer local imports
- **Types**: No strict typing (Lua), use docstrings for clarity when needed
- **Error handling**: Use `vim.notify()` for user-facing errors
- **Naming**: Use snake_case for variables/functions, follow LazyVim conventions
- **Plugin Config**: Keep plugin configs in separate files in lua/plugins/
- **Comments**: Minimal but descriptive, usually only for complex logic
- **Functions**: Prefer local functions unless they need to be exposed
- **LazyVim Integration**: Follow LazyVim plugin spec format for all plugins