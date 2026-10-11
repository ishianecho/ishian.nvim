local M = {}

local CELL_WIDTH = 10
local CELL_HEIGHT = 20

local images = {}

local function hide(win)
  local entry = images[win]
  if not entry then
    return
  end
  images[win] = nil
  vim.ui.img.del(entry.id)
end

local function prune()
  for win in pairs(images) do
    if not vim.api.nvim_win_is_valid(win) then
      hide(win)
    end
  end
end

local function show(win)
  local buf = vim.api.nvim_win_get_buf(win)
  local name = vim.api.nvim_buf_get_name(buf)
  local path = name:match("%d+//(.+)$")
  path = path and "/" .. path or name
  if path == "" then
    return
  end
  local data
  if path:match("%.png$") then
    local ok, blob = pcall(vim.fn.readblob, path)
    data = ok and blob or nil
  else
    local tmp = vim.fn.tempname() .. ".png"
    vim.fn.system({ "magick", path, tmp })
    if vim.v.shell_error == 0 then
      data = vim.fn.readblob(tmp)
      os.remove(tmp)
    end
  end
  if not data or #data == 0 then
    return
  end

  hide(win)

  local is_file = vim.bo[buf].buftype == ""
  local pos = vim.fn.win_screenpos(win)
  local opts = { row = pos[1], col = pos[2] }
  if not is_file then
    opts.row = opts.row + 1
    opts.col = opts.col + 1
  end

  local width, height = 0, 0
  if #data >= 24 and data:sub(1, 8) == "\137PNG\r\n\26\n" then
    local b = { data:byte(17, 24) }
    width = b[1] * 0x1000000 + b[2] * 0x10000 + b[3] * 0x100 + b[4]
    height = b[5] * 0x1000000 + b[6] * 0x10000 + b[7] * 0x100 + b[8]
  end
  if width > 0 and height > 0 then
    local avail_w = vim.api.nvim_win_get_width(win)
    local avail_h = vim.api.nvim_win_get_height(win)
    local scale = math.min(avail_w * CELL_WIDTH / width, avail_h * CELL_HEIGHT / height, 1)
    opts.width = math.max(math.floor(width * scale / CELL_WIDTH + 0.5), 1)
    opts.height = math.max(math.floor(height * scale / CELL_HEIGHT + 0.5), 1)
  end

  vim.bo[buf].modifiable = true
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, {})
  vim.bo[buf].modified = false
  vim.bo[buf].modifiable = false
  if is_file then
    vim.bo[buf].readonly = true
    vim.wo[win].number = false
    vim.wo[win].relativenumber = false
    vim.wo[win].signcolumn = "no"
    vim.wo[win].foldcolumn = "0"
  end

  images[win] = { id = vim.ui.img.set(data, opts), bias = not is_file }
end

function M.setup()
  if not vim.env.KITTY_WINDOW_ID then
    return
  end

  local autocmd = _G.UserUtils.autocmd

  vim.filetype.add({
    extension = {
      bmp = "image.bmp",
      gif = "image.gif",
      ico = "image.ico",
      jpeg = "image.jpeg",
      jpg = "image.jpg",
      png = "image.png",
      tif = "image.tif",
      tiff = "image.tiff",
      webp = "image.webp",
    },
  })

  autocmd("BufWinEnter", {
    callback = function(args)
      prune()
      local win = vim.api.nvim_get_current_win()
      hide(win)
      if vim.bo[args.buf].filetype:match("^image%.") then
        show(win)
      end
    end,
  })

  autocmd("WinEnter", {
    callback = prune,
  })

  autocmd("Syntax", {
    pattern = "image.*",
    callback = function(args)
      local win = vim.fn.bufwinid(args.buf)
      if win ~= -1 then
        show(win)
      end
    end,
  })

  autocmd({ "WinResized", "VimResized" }, {
    callback = function(args)
      local wins = args.event == "WinResized" and vim.v.event.windows or vim.tbl_keys(images)
      for _, win in ipairs(wins) do
        if images[win] then
          show(win)
        end
      end
    end,
  })

  autocmd("WinClosed", {
    callback = function(args)
      hide(tonumber(args.match))
    end,
  })
end

return M
