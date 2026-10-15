# Keymap Reference

Route table for `lua/config/keybind/`. All files return spec arrays applied by `config/keybind/init.lua` (`vim.keymap.set`; supports `mode`, `cond`, `buffer`, `nowait`, `desc`, nesting).

Per-directory references with full key tables:

- [`general/README.md`](lua/config/keybind/general/README.md) — buffers, tabs, windows, terminal, UI toggles
- [`langs/README.md`](lua/config/keybind/langs/README.md) — LSP, diagnostics, code actions
- [`editing/README.md`](lua/config/keybind/editing/README.md) — pickers, explorer, search & replace, git, misc editing

## Route table

| File | Keys | Scope |
| --- | --- | --- |
| `general/misc.lua` | `jj`, `<leader>w`, `<leader>z` | esc / save / quit |
| `general/buffer.lua` | `<leader>e*`, `[b` `]b`, `H` `L`, `<leader>b*` | buffers |
| `general/tab.lua` | `[<tab>` `]<tab>`, `<leader><tab>d` | tabs |
| `general/window.lua` | `<C-hjkl>`, `<A-hjkl>`, `<leader>HJKL`, `<leader>V` `v` `-` `\|` `q` | window focus / resize / swap / split |
| `general/terminal.lua` | `<C-q>` (t) | terminal mode |
| `general/ui.lua` | `<leader>u*` | redraw, diagnostics virtual lines, colorscheme |
| `langs/lsp.lua` | `gd` `gi` `gr` `gy` `gD` `gai` `gao` | goto / calls (reference only) |
| `langs/code-action.lua` | `<leader>c*` | code actions, rename |
| `langs/complete.lua` | `<Tab>` `<C-k>` `<C-j>` `<C-y>` | completion (reference only) |
| `langs/diagnostic.lua` | `[e` `]e` `[w` `]w`, `gk`, `gQ` `gL` | diagnostics / quickfix / loclist |
| `editing/explorer.lua` | `<C-e>` | neo-tree (n/x/i/t) |
| `editing/picker/find.lua` | `<leader><space>`, `<leader>/`, `<leader>:`, `<leader>,`, `<leader>f*` | files, grep, history, buffers |
| `editing/picker/search.lua` | `<leader>s*` | grep/diagnostics/marks/jumps/… (fzf-lua) |
| `editing/picker/git.lua` | `<leader>gb` `gl` `gs` `gS` `gd` `gf` | branches, log, status, stash |
| `editing/picker/lsp.lua` | `gd` `gD` `gr` `gi` `gt` `gai` `gao` | LSP pickers (fzf-lua) |
| `editing/pairs.lua` | `gsa` `gsd` `gsf` `gsF` `gsh` `gsr` `gsn` | mini.surround (reference only) |
| `editing/replace.lua` | `<leader>ss` | grug-far |
| `editing/words.lua` | `]]` `[[` | next/prev word reference |
| `editing/codemap.lua` | `<leader>cm*` | codewindow minimap (if installed) |
| `editing/git.lua` | `<leader>gg`, `<leader>g*`, `<leader>gh*`, `[h` `]h`, `<leader>h*` | neogit, octo, gitsigns hunks |
| `editing/database.lua` | buffer-local `<leader>d*` (SQL buffers) | sqls execute / switch |

## Defined in plugin configs (not `config/keybind`)

| Keys | Where | Purpose |
| --- | --- | --- |
| `K` `gK` `<F2>` `<leader>rn` `<leader>cr` `<leader>C` `<leader>cc` | `config/langs/lsp/shared.lua` | LSP hover / signature / rename / code action (on_attach) |
| `<Tab>`/`<C-y>`/`<C-k>`/`<C-j>`/… | `config/langs/complete.lua` | blink.cmp select/accept/snippets |
| `zR` `zM` | native | open/close all folds |

## Plugin defaults (not configured anywhere)

| Keys | Plugin | Purpose |
| --- | --- | --- |
| `<C-t>` `<C-v>` `<C-x>` | fzf-lua (in picker) | open selection in tab / vsplit / split |
| `<C-q>` | fzf-lua (in picker) | send selection to quickfix |
| `<M-Esc>` | fzf-lua (in picker) | hide, resume later |
| `<F1>`–`<F6>` | fzf-lua (in picker) | help, fullscreen, preview wrap/toggle/rotate |
| `alt-a` | fzf-lua (in picker) | toggle select-all |
| `<C-u>` `<C-f>` / `<C-b>` | fzf-lua (in picker) | clear query / half-page scroll |
| `a` `d` `r` `c` `m` `y` `x` `P` `?` … | neo-tree (in window) | file ops, preview, help |
