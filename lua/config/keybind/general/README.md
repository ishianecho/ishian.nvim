# General Keybinds

Buffers, tabs, windows, terminal, and UI toggles.

## `buffer`

| Key | Mode | Description |
| --- | --- | --- |
| `<leader>ee` | n | New buffer (input filename) |
| `<leader>en` | n | New file |
| `[b` | n | Goto: prev buffer |
| `]b` | n | Goto: next buffer |
| `<leader>bl` | n | Goto: last buffer |
| `<leader>bd` | n | Delete curr buffer |
| `<leader>bC` | n | Copy curr buffer absolute path |
| `<leader>bc` | n | Copy curr buffer relative path |
| `H` | n | Goto: prev buffer |
| `L` | n | Goto: next buffer |

## `misc`

| Key | Mode | Description |
| --- | --- | --- |
| `jj` | i | Return to normal mode |
| `jj` | c | Return to normal mode |
| `<leader>w` | n | Save file |
| `<leader>z` | n | Quit neovim |

## `tab`

| Key | Mode | Description |
| --- | --- | --- |
| `<leader><tab><tab>` | n | NewTab (input filename) |
| `[<tab>` | n | Previous tab |
| `]<tab>` | n | Next tab |
| `<leader><tab>d` | n | Delete tab |

## `terminal`

| Key | Mode | Description |
| --- | --- | --- |
| `<C-q>` | t | Quit terminal mode |
| `<leader>rt` | n | Run a task from `.vscode/tasks.json` (also `:Task [label]`) |

## `ui`

| Key | Mode | Description |
| --- | --- | --- |
| `<leader>ur` | n | Redraw, Noh, Diff update |
| `<leader>ud` | n | Toggle diagnostic (virtual lines) |
| `<leader>uc` | n | Switch colorscheme (light / dark) |
| `<leader>uC` | n | Colorschemes |

## `window`

| Key | Mode | Description |
| --- | --- | --- |
| `<leader>V` | n | Horizontal Split (input filename) |
| `<leader>v` | n | Vertical Split (input filename) |
| `<leader>-` | n | Horizontal Split |
| `<leader>|` | n | Vertical Split |
| `<leader>q` | n | Delete window |
| `<C-h>` | n | Focus on the left page |
| `<C-j>` | n | Focus on the page below |
| `<C-k>` | n | Focus on the page above |
| `<C-l>` | n | Focus on the right page |
| `<A-h>` | n | Window resize left |
| `<A-j>` | n | Window resize down |
| `<A-k>` | n | Window resize up |
| `<A-l>` | n | Window resize right |
| `<C-S-h>` | n | Window swap left |
| `<C-S-j>` | n | Window swap down |
| `<C-S-k>` | n | Window swap up |
| `<C-S-l>` | n | Window swap right |
