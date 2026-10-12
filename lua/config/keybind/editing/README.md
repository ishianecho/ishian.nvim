# Editing Keybinds

Pickers, explorer, search & replace, and misc editing tools.

## `codemap`

| Key | Mode | Description |
| --- | --- | --- |
| `<leader>cmo` | n | Open minimap |
| `<leader>cmf` | n | Toggle: minimap focus |
| `<leader>cmc` | n | Close minimap |
| `<leader>cmm` | n | Toggle: minimap |

## `explorer`

| Key | Mode | Description |
| --- | --- | --- |
| `<C-e>` | n x i t | Toggle: file explorer |

### neo-tree defaults (in window)

Not set in config.

| Key | Mode | Description |
| --- | --- | --- |
| `a` | n | Add (file / directory) |
| `d` | n | Delete |
| `r` | n | Rename |
| `m` | n | Move |
| `c` | n | Copy |
| `P` | n | Paste |
| `y` | n | Copy name to clipboard |
| `x` | n | Cut to clipboard |
| `<` | n | Prev source |
| `>` | n | Next source |
| `?` | n | Help |

## `notify`

| Key | Mode | Description |
| --- | --- | --- |
| `<leader>n` | n | Notification History |
| `<leader>fn` | n | Notification History |

## `replace`

| Key | Mode | Description |
| --- | --- | --- |
| `<leader>ss` | n x | Search and Replace |

## `todo-comments`

| Key | Mode | Description |
| --- | --- | --- |
| `]t` | n | Next Todo Comment |
| `[t` | n | Previous Todo Comment |
| `<leader>ft` | n | Todo |
| `<leader>fT` | n | Todo/Fix/Fixme |

## `words`

| Key | Mode | Description |
| --- | --- | --- |
| `]]` | n t | Next Reference |
| `[[` | n t | Prev Reference |

## `workspace`

| Key | Mode | Description |
| --- | --- | --- |
| `<leader>fs` | n | Session |
| `<leader>Sd` | n | Delete |
| `<leader>SD` | n | DeletePicker |
| `<leader>Sr` | n | Restore |
| `<leader>Ss` | n | Save |

## `picker/find`

| Key | Mode | Description |
| --- | --- | --- |
| `<leader><space>` | n | Find Files |
| `<leader>,` | n | Buffers |
| `<leader>/` | n | Grep |
| `<leader>:` | n | Command History |
| `<leader>fb` | n | Buffers |
| `<leader>fc` | n | Find Config File |
| `<leader>ff` | n | Find Files |
| `<leader>fg` | n | Find Git Files |
| `<leader>fr` | n | Recent |

## `picker/git`

| Key | Mode | Description |
| --- | --- | --- |
| `<leader>gb` | n | Git Branches |
| `<leader>gl` | n | Git Log |
| `<leader>gs` | n | Git Status |
| `<leader>gS` | n | Git Stash |
| `<leader>gd` | n | Git Diff |
| `<leader>gf` | n | Git Log File |

## `picker/lsp`

| Key | Mode | Description |
| --- | --- | --- |
| `gd` | n | Goto: definition |
| `gD` | n | Goto: declaration |
| `gr` | n | Goto: references |
| `gi` | n | Goto: implementation |
| `gt` | n | Goto: type definition |
| `gai` | n | Show: incoming calls |
| `gao` | n | Show: outgoing calls |

## `picker/search`

| Key | Mode | Description |
| --- | --- | --- |
| `<leader>sb` | n | Buffer Lines |
| `<leader>sg` | n | Grep |
| `<leader>sw` | n | Word under cursor |
| `<leader>sw` | x | Visual selection |
| `<leader>s"` | n | Registers |
| `<leader>s/` | n | Search History |
| `<leader>sa` | n | Autocmds |
| `<leader>sc` | n | Command History |
| `<leader>sC` | n | Commands |
| `<leader>sd` | n | Diagnostics |
| `<leader>sD` | n | Buffer Diagnostics |
| `<leader>sh` | n | Help Pages |
| `<leader>sH` | n | Highlights |
| `<leader>sj` | n | Jumps |
| `<leader>sk` | n | Keymaps |
| `<leader>sl` | n | Location List |
| `<leader>sm` | n | Marks |
| `<leader>sM` | n | Man Pages |
| `<leader>sq` | n | Quickfix List |
| `<leader>sR` | n | Resume |
| `<leader>su` | n | Undo History |

## fzf-lua defaults (in picker)

Not set in config — available inside every fzf-lua picker.

| Key | Mode | Description |
| --- | --- | --- |
| `<C-t>` | n | Open selection in tab |
| `<C-v>` | n | Open selection in vsplit |
| `<C-x>` | n | Open selection in split |
| `<C-q>` | n | Send selection to quickfix |
| `<M-Esc>` | n | Hide (resume later) |
| `<F1>` | n | Help |
| `<F2>` | n | Fullscreen |
| `<F3>` | n | Toggle preview wrap |
| `<F4>` | n | Toggle preview |
| `<F5>` | n | Rotate preview |
| `<F6>` | n | Toggle hidden |
| `alt-a` | n | Toggle select-all |
| `<C-u>` | n | Clear query |
| `<C-f>` | n | Half-page scroll down |
| `<C-b>` | n | Half-page scroll up |

## `pairs` (reference only)

mini.surround binds, active when the plugin is installed.

| Key | Mode | Description |
| --- | --- | --- |
| `gsa` | n x | Add surrounding |
| `gsd` | n x | Delete surrounding |
| `gsf` | n x | Find right surrounding |
| `gsF` | n x | Find left surrounding |
| `gsh` | n x | Highlight surrounding |
| `gsr` | n x | Replace surrounding |
| `gsn` | n | Update `mini.surround` search radius |
