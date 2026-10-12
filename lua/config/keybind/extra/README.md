# Extra Keybinds

Opt-in integrations.

## `git`

| Key | Mode | Description |
| --- | --- | --- |
| `<leader>gg` | n | Show: neogit ui |
| `<leader>gD` | n | Diff file against branch |
| `<leader>ghi` | n | List issues |
| `<leader>ghp` | n | List pull requests |
| `<leader>ghd` | n | List discussions |
| `<leader>ghn` | n | List notifications |
| `<leader>ghs` | n | Search GitHub |
| `<leader>ght` | n | Toggle use_local_fs |
| `[h` | n | Prev hunk |
| `]h` | n | Next hunk |
| `<leader>hs` | n x | Stage hunk |
| `<leader>hr` | n x | Reset hunk |
| `<leader>hS` | n | Stage buffer |
| `<leader>hR` | n | Reset buffer |
| `<leader>hu` | n | Undo stage hunk |
| `<leader>hp` | n | Preview hunk |
| `<leader>hb` | n | Blame line |
| `<leader>hB` | n | Blame buffer |
| `<leader>hd` | n | Diff this |
| `<leader>hD` | n | Diff line ~ |
| `ih` | o x | GitSigns Select Hunk |

## `mini.diff` (defaults)

Not set in config — active when the plugin is installed.

| Key | Mode | Description |
| --- | --- | --- |
| `gh` | n x | Apply hunk |
| `gH` | n x | Reset hunk |
| `gh` | o | Hunk textobject (e.g. `dgh`, `vgh`) |
| `[h` | n | Prev hunk |
| `]h` | n | Next hunk |
| `[H` | n | First hunk |
| `]H` | n | Last hunk |

## `database`

Registered by `setup()`, not a plain spec. The SQL keys are buffer-local.

| Key | Mode | Description |
| --- | --- | --- |
| `<leader>dd` | n | Toggle dadbod-ui |
| `<leader>dc` | n | Switch connection (sqls, SQL buffer) |
| `<leader>db` | n | Switch database (sqls, SQL buffer) |
| `<leader>dx` | n x | Execute query (dadbod `%DB` / `SqlsExecuteQuery`, SQL buffer) |
