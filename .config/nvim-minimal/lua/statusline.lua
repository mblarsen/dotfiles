vim.cmd [[
  highlight StatuslineEllipsis guifg=#cc66a6
  highlight StatuslineFile guifg=#ffffff
  highlight StatuslineFileDir guifg=#777777 gui=bold
  highlight StatuslineFileModified guifg=#ff5555 gui=bold
  highlight StatuslineReadonly guifg=#e6b400 gui=bold
  highlight StatuslineSeparator guifg=#444444
  highlight StatuslineScrollbar guifg=#e6b400 guibg=#282a3c
  highlight StatuslineScrollbarEnd guifg=#ff5555 guibg=#282a3c
]]

-- Define highlight groups
local hl_dir = "%#StatuslineFileDir#"
local hl_sep = "%#StatuslineSeparator#"
local hl_file = "%#StatuslineFile#"
local hl_modified = "%#StatuslineFileModified#"
local hl_ellipsis = "%#StatuslineEllipsis#"
local hl_readonly = "%#StatuslineReadonly#"
local hl_status = "%#StatuslineScrollbar#"
local hl_status_end = "%#StatuslineScrollbarEnd#"
local hl_terminate = "%*"

local M = {}

-- Configuration with default values
local config = {
  ellipsis = "…",
  -- Default maximum path elements, 0 = dynamic
  max_path_elements = 0,
  filepath = {
    hidden = { "", "TelescopePrompt", "snacks_picker_list", "help", "terminal" },
  },
  scrollbar = {
    hidden = { "", "TelescopePrompt", "snacks_picker_list", "help", "terminal" },
  },
}

-- Function to allow user configuration
function M.setup(user_config)
  config = vim.tbl_extend("force", config, user_config or {})

  vim.opt.statusline = ""
  vim.api.nvim_create_augroup("StatuslineUpdate", { clear = true })
  vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter", "FileType" }, {
    group = "StatuslineUpdate",
    pattern = "*",
    callback = function()
      local current_winid = vim.fn.win_getid()
      vim.opt_local.statusline = string.format("%%!v:lua.require'statusline'.render(%d)", current_winid)
    end,
  })
end

function M.render(winid)
  winid = winid or 0
  local bufnr = vim.api.nvim_win_get_buf(winid)
  if bufnr == -1 then
    return ""
  end

  local filepath = M.get_filepath(bufnr, winid)
  local scrollbar = M.get_scrollbar(bufnr, winid)
  local readonly = M.get_readonly(bufnr)
  return table.concat({
    readonly ~= "" and " " or "",
    readonly,
    " ",
    filepath,
    "%=",
    " ",
    scrollbar,
    " ",
  }, "")
end

local function find_root()
  local root_markers = {
    ".git",
    "package.json",
    "pyproject.toml",
    "Cargo.toml",
    "go.mod",
    "gleam.toml",
  }

  local found_paths = vim.fs.find(root_markers, {
    upward = true,
    type = "directory",
    stop = vim.loop.os_homedir(),
  })

  local marker_path = found_paths and found_paths[1] or nil

  if marker_path then
    local root_dir = vim.fs.dirname(marker_path)

    return root_dir
  else
    return vim.loop.os_homedir()
  end
end

local function get_relative_path(file_path, root_path)
  if vim.startswith(file_path, root_path) then
    local relative = vim.fn.fnamemodify(file_path, ":.")
    return relative
  else
    return vim.fn.fnamemodify(file_path, ":~")
  end
end

local function split_path(path)
  local components = {}
  for part in string.gmatch(path, "[^/\\]+") do
    table.insert(components, part)
  end
  return components
end

local function truncate_path(components, max_elements)
  local total = #components

  -- Handle trivial cases: Cannot truncate if 3 or fewer components
  if total <= 3 then
    return components
  end

  -- If truncation might happen, we need at least 4 slots:
  local effective_max = math.max(max_elements, 3)

  -- Check if truncation is actually needed based on the effective max
  if total <= effective_max then
    return components
  end

  -- Truncation IS needed (total > effective_max, and effective_max >= 4)

  -- Always include these 3 components
  local first_dir = components[1]
  local second_last_dir = components[total - 1]
  local file = components[total]

  -- Calculate how many *extra* components we can show besides the mandatory 3
  -- We have effective_max slots. 3 are for mandatory components.
  local num_extra_to_show = effective_max - 3

  local truncated = {}
  table.insert(truncated, first_dir)

  -- Add extra components from the beginning of the middle section
  -- The middle section starts at index 2 in the original 'components'
  for i = 1, num_extra_to_show do
    local component_index = 1 + i -- Index in original components (starts after first_dir)
    -- Ensure we don't grab the second_last_dir itself as an "extra"
    if component_index < (total - 1) then
      table.insert(truncated, components[component_index])
    else
      -- We've run out of unique middle components before filling all extra slots
      break
    end
  end

  -- Add the ellipsis
  table.insert(truncated, config.ellipsis)

  -- Add the mandatory second-last and last components
  table.insert(truncated, second_last_dir)
  table.insert(truncated, file)

  return truncated
end

local function get_dynamic_max_elements(winid)
  local window_width = vim.api.nvim_win_get_width(winid)
  local elm = config.max_path_elements

  if window_width < 100 then
    elm = 3
  elseif window_width < 140 then
    elm = 4
  else
    elm = 5
  end

  return elm
end

local function can_show(bufnr, hidden_config)
  -- Return an empty string to hide the scrollbar for hidden filetypes
  local filetype = vim.filetype.match { buf = bufnr } or ""
  for _, hidden_ft in ipairs(hidden_config) do
    if filetype == hidden_ft then
      return false
    end
  end
  return true
end

function M.get_filepath(bufnr, winid)
  if not can_show(bufnr, config.filepath.hidden) then
    return ""
  end

  local root = find_root()
  local file_path = vim.api.nvim_buf_get_name(bufnr)
  if file_path == "" then
    return ""
  end

  local relative_path = get_relative_path(file_path, root)
  -- Remove any leading path separators or dots
  relative_path = relative_path:gsub("^./", ""):gsub("^\\", "")

  local components = split_path(relative_path)
  if #components == 0 then
    return ""
  end

  -- Dynamic adjustment based on window width
  local dynamic_max = get_dynamic_max_elements(winid)
  local current_max = math.max(config.max_path_elements, dynamic_max)

  if #components > current_max then
    components = truncate_path(components, current_max)
  end

  local total = #components

  local parts = {}
  for i, comp in ipairs(components) do
    if i > 1 then
      -- Insert separator before each component except the first
      table.insert(parts, hl_sep .. "/")
    end

    if comp == config.ellipsis then
      -- Insert ellipsis with its highlight
      table.insert(parts, hl_ellipsis .. config.ellipsis)
    elseif i < total then
      -- Intermediate directories
      table.insert(parts, hl_dir .. comp)
    else
      -- Last component is the file
      local mod = vim.bo.modified
      if mod then
        table.insert(parts, hl_modified .. comp)
      else
        table.insert(parts, hl_file .. comp)
      end
    end
  end

  -- Reset highlight at the end
  table.insert(parts, hl_terminate)

  return table.concat(parts)
end

function M.get_scrollbar(bufnr, winid)
  if not can_show(bufnr, config.scrollbar.hidden) then
    return ""
  end

  local sbar_chars = {
    "▔",
    "🮂",
    "🬂",
    "🮃",
    "▀",
    "▄",
    "▃",
    "🬭",
    "▂",
    "▁",
  }

  local lines = vim.api.nvim_buf_line_count(bufnr)
  local window_height = vim.api.nvim_win_get_height(winid)

  if lines <= window_height then
    return hl_status .. string.rep(" ", 2) .. hl_terminate
  end

  local cur_line = vim.api.nvim_win_get_cursor(winid)[1]
  local i = math.floor((cur_line - 1) / lines * #sbar_chars) + 1
  local sbar = string.rep(sbar_chars[i], 2)

  local hl = hl_status
  if i == 1 or i == #sbar_chars then
    hl = hl_status_end
  end

  return hl .. sbar .. hl_terminate
end

function M.get_readonly(bufnr, winid)
  local readonly = vim.api.nvim_get_option_value("readonly", { buf = bufnr, win = winid })
  local icon = ""
  return readonly and table.concat { hl_readonly, icon, hl_terminate } or ""
end

return M
