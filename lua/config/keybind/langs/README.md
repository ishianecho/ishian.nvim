# Language Keybinds

LSP, diagnostics, and code actions.

## `code-action`

| Key | Mode | Description |
| --- | --- | --- |
| `<leader>co` | n | Organize imports |
| `<leader>ct` | n | Rewrite structure |
| `<leader>cf` | n | Rewrite structure |

## `diagnostic`

| Key | Mode | Description |
| --- | --- | --- |
| `gk` | n | Show: diagnostic (float) |
| `[e` | n | Goto: prev error |
| `]e` | n | Goto: next error |
| `[w` | n | Goto: prev warning |
| `]w` | n | Goto: next warning |
| `gQ` | n | Show: qflist |
| `gL` | n | Show: loclist |

## `lsp` (reference only)

The spec entries have no rhs — the actual LSP binds are set in `config/langs/lsp/shared.lua` (`on_attach`).

| Key | Mode | Description |
| --- | --- | --- |
| `K` | n | Hover |
| `gK` | n | Signature help |
| `<F2>` | n | Rename |
| `<leader>rn` | n | Rename |
| `<leader>cr` | n | Rename |
| `<leader>C` | n | Code action |
| `<leader>cc` | n | Code action |

## `complete` (reference only)

Completion keys come from blink.cmp options in `config/langs/complete.lua`.

| Key | Mode | Description |
| --- | --- | --- |
| `<C-y>` | i c | Toggle completion panel |
| `<C-k>` | i c | Prev item |
| `<C-j>` | i c | Next item |
| `<Tab>` | i c | Confirm |
| `<C-n>` | i c | Fallback (native next) |
| `<C-p>` | i c | Fallback (native prev) |
