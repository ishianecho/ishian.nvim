# Neovim Config

Personal Neovim configuration: lazy.nvim-managed, Lua-only. See [KEYMAP.md](KEYMAP.md) for the keymap reference.

## Editor Core

| Feature | Implementation |
| --- | --- |
| Options / globals / autocmds | native |
| Keymaps | native (`vim.keymap.set`) |
| Folding | treesitter folds + indent fallback |
| Big files | degraded mode (no folds / conceal / diagnostics) |
| Session | per-tab buffer persistence |
| Images | `vim.ui.img` |
| Terminal integration | kitty / Windows Terminal |

## UI

| Feature | Plugin |
| --- | --- |
| Theme | everforest |
| Bufferline | bufferline.nvim |
| Statusline | custom |
| File explorer | neo-tree.nvim |
| Picker | fzf-lua |
| Messages / cmdline | noice.nvim |
| Notifications | noice.nvim |
| Minimap | codewindow.nvim |

## Language Tooling

| Feature | Plugin |
| --- | --- |
| Completion | blink.cmp |
| LSP | nvim-lspconfig + mason.nvim |
| Lint | nvim-lint |
| Format | conform.nvim |
| Treesitter | nvim-treesitter |
| Tests | neotest (neotest-golang, neotest-java) |
| Java | nvim-jdtls |
| Go | vim-go |
| Helm | helm-ls.nvim |
| Lua dev | lazydev.nvim |
| SQL | sqls.nvim |
| Schemas | schemastore.nvim |

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
| Hunks (signs, stage, blame) | gitsigns.nvim |
| Hunk ops (apply / reset) | mini.diff |
| GitHub (issues, PRs, discussions) | octo.nvim |

## Editing

| Feature | Plugin |
| --- | --- |
| Move lines / selections | mini.move |
| Autopairs | nvim-autopairs |
| Search & replace | grug-far.nvim |
| Todo comments | todo-comments.nvim |
| Surround | mini.surround |

## Extras

| Feature | Plugin |
| --- | --- |
| Database UI / queries | vim-dadbod + dadbod-ui + dadbod-completion |
| Markdown rendering | render-markdown.nvim |
| Markdown lists | autolist.nvim + bullets.vim |
| AI (codex) | mini.codex + codex-prompt-lsp |
| MAA pipeline | maa-pipeline.nvim |
| Mybatis | nvim-mybatis |
