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
| `[B` | n | Move buffer left |
| `]B` | n | Move buffer right |
| `H` | n | Goto: prev buffer |
| `L` | n | Goto: next buffer |
| `<leader>bH` | n | Delete left buffers |
| `<leader>bL` | n | Delete right buffers |
| `<leader>bo` | n | Delete other buffers |
| `<leader>bp` | n | Toggle: buffer pin |
| `<leader>bP` | n | Delete unpinned buffers |
| `<leader>bs` | n | Select buffer |

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
| `<leader><tab>r` | n | Rename |

## `terminal`

| Key | Mode | Description |
| --- | --- | --- |
| `<C-q>` | t | Quit terminal mode |

## `ui`

| Key | Mode | Description |
| --- | --- | --- |
| `<leader>ur` | n | Redraw, Noh, Diff update |
| `<leader>ud` | n | Toggle diagnostic (virtual lines) |
| `<leader>uc` | n | Switch colorscheme (light / dark) |
| `<leader>uC` | n | Colorschemes |
| `<leader>u<tab>` | n | Toggle tabline mode (buffers / tabs) |

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
| `<leader>H` | n | Window swap left |
| `<leader>J` | n | Window swap down |
| `<leader>K` | n | Window swap up |
| `<leader>L` | n | Window swap right |
