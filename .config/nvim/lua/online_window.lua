local M = {}

local start_symbol = ""
local end_symbol = ""

---@class DecoratedContent
---@field original string
---@field decorated string

---@param content_fn fun(): string
---@return DecoratedContent
local function get_decorated_event(content_fn)
  local content = content_fn()
  local lines = vim.split(content, "\n", { plain = true })
  local text = lines[1]
  -- local text = "🌱 " .. (lines[1] or "No event")

  local decorated_text = start_symbol .. text .. end_symbol

  return {
    decorated = decorated_text,
    plain = text,
  }
end

---create a floating buffer for the calendar event
---@param content string
---@return integer
local function create_buffer(content)
  local buf = vim.api.nvim_create_buf(false, true)
  local lines = { content }

  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)

  return buf
end

---@param content string
---@return integer
local function create_window(content)
  local height, width, buf, win, padding

  -- width needs to in columns needed to render string
  width = vim.fn.strwidth(content)
  height = 1
  padding = 0
  buf = create_buffer(content)

  win = vim.api.nvim_open_win(buf, false, {
    relative = "editor",
    anchor = "NE",
    width = width,
    height = height,
    focusable = false,
    row = padding,
    col = vim.o.columns - padding,
    style = "minimal",
    border = "none",
  })

  -- theme
  local ns = vim.api.nvim_create_namespace "notioncalendar"
  vim.api.nvim_set_hl(0, "NotionCalendarNormal", { bg = "#333c48", fg = "#ffffff" })
  vim.api.nvim_set_hl(0, "NotionCalendarOrnament", { fg = "#333c48", bg = nil })

  local buf_options = {
    buftype = "nofile",
    modifiable = false,
    filetype = "notioncalendar",
  }

  local win_options = {
    winblend = 0,
  }

  for option, value in pairs(buf_options) do
    vim.api.nvim_set_option_value(option, value, { buf = buf })
  end

  for option, value in pairs(win_options) do
    vim.api.nvim_set_option_value(option, value, { win = win })
  end

  -- extmark end_col needs to be in byte
  local end_col = #content - #end_symbol
  local ornament_regexp = "\\(" .. start_symbol .. "\\|" .. end_symbol .. "\\)"

  vim.api.nvim_buf_set_extmark(buf, ns, 0, 2, { end_row = 0, end_col = end_col, hl_group = "NotionCalendarNormal" })
  vim.fn.matchadd("NotionCalendarOrnament", ornament_regexp, 999, -1, { window = win })

  return win
end

---@class CreateOpt
---@field priority integer

---create a one line window
---@param content fun(): string
---@param opts CreateOpt
---@return table
function M.create(content, opts)
  ---@type integer?
  local window = nil

  return {
    ---get the current window id
    ---@return integer?
    get_window = function()
      return window
    end,
    ---@return nil
    close_window = function()
      if window and vim.api.nvim_win_is_valid(window) then
        vim.api.nvim_win_close(window, true)
        window = nil
      end
    end,
    ---@return nil
    toggle_window = function()
      if window and vim.api.nvim_win_is_valid(window) then
        close_window()
      else
        window = create_window(content())
      end
    end,
  }
end

return M
