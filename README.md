# Neovim Config

Personal Neovim configuration: managed with the built-in `vim.pack`, Lua-only. See [KEYMAP.md](KEYMAP.md) for the keymap reference.

## Editor Core

| Feature | Implementation |
| --- | --- |
| Options / globals / autocmds | native |
| Keymaps | native (`vim.keymap.set`) |
| Folding | treesitter folds + indent fallback |
| Big files | degraded mode (no folds / conceal / diagnostics) |
| Images | `vim.ui.img` |
| Terminal integration | kitty / Windows Terminal |
| Per-project config | native (`exrc`, `.nvim.lua`) |

## UI

| Feature | Plugin |
| --- | --- |
| Theme | everforest |
| Statusline | custom |
| File explorer | neo-tree.nvim |
| Picker | fzf-lua |
| Messages / cmdline | native (`cmdheight=0`) |
| Notifications | custom (floating, above statusline) |
| Minimap | codewindow.nvim |

## Language Tooling

| Feature | Plugin |
| --- | --- |
| Completion | blink.cmp |
| LSP | nvim-lspconfig + mason.nvim |
| Lint | nvim-lint |
| Format | conform.nvim |
| Treesitter | nvim-treesitter |
| Java | nvim-jdtls |
| Go | vim-go |
| Helm | helm-ls.nvim |
| SQL | sqls.nvim |
| Schemas | schemastore.nvim + `.vscode/settings.json` (`json.schemas`, `files.associations`) |
| `.vscode/tasks.json` runner | native (`:Task`, `<leader>rt`) |
| MAA pipeline | maa-pipeline.nvim |
| Mybatis | nvim-mybatis |

### LSP servers

| Language | Server |
| --- | --- |
| Go | gopls |
| Java | jdtls |
| JS / TS | vtsls, ts_ls |
| Vue | vue_ls |
| Python | ty |
| Lua | lua_ls |
| Bash | bashls |
| SQL | sqls |
| JSON | jsonls |
| YAML | yamlls |
| XML | lemminx |
| Protobuf | buf_ls |
| PowerShell | powershell_es |
| Typos | typos_lsp |

### Linters

| Language | Linter |
| --- | --- |
| C / C++ | cpplint |
| CSS / SCSS | stylelint |
| Docker | hadolint |
| Go | golangcilint |
| HTML | htmlhint |
| JS / TS (+ JSX) | eslint_d |
| JSON | jsonlint |
| Python | ruff |

### Formatters (on save)

| Language | Formatter |
| --- | --- |
| C / C++ | clang-format |
| CSS / SCSS / HTML | prettier |
| Go | goimports, gofumpt |
| Java | google-java-format |
| JSON | jq |
| Lua | stylua |
| Markdown | prettier |
| Nginx | nginxfmt |
| Protobuf | buf |
| Python | ruff |
| TOML | taplo |
| TypeScript | prettier |
| Typst | typstyle |
| Vue | prettier |

## Git

| Feature | Plugin |
| --- | --- |
| Status / commit | neogit |
| Diff / file history | diffview.nvim |
| Hunks (signs, stage/reset hunk or line, blame) | gitsigns.nvim |
| GitHub (issues, PRs, discussions) | octo.nvim |

## Editing

| Feature | Plugin |
| --- | --- |
| Autopairs | nvim-autopairs |
| Search & replace | grug-far.nvim |
| Surround | mini.surround |
| Markdown rendering | render-markdown.nvim |
