vim.cmd [[
  highlight StatuslineEllipsis guifg=#cc66a6
  highlight StatuslineFile guifg=#ffffff
  highlight StatuslineFileDir guifg=#777777 gui=bold
  highlight StatuslineFileModified guifg=#ff5555 gui=bold
  highlight StatuslineReadonly guifg=#e6b400 gui=bold
  highlight StatuslineFileSeparator guifg=#444444
  highlight StatuslineScrollbar guifg=#e6b400 guibg=#282a3c
  highlight StatuslineScrollbarEnd guifg=#ff5555 guibg=#282a3c
  "highlight StatuslineLSPIcons guifg=#bbbbbb
  "highlight StatuslineLSPIcons guifg=#7777dd
  highlight StatuslineLSPIcons guifg=#dddd77
  highlight StatuslineLSPText guifg=#777777
  highlight StatuslineLSPTextActive guifg=#ffffff
  highlight StatuslineLSPSeparator guifg=#444444
]]

-- Define highlight groups
local hl_dir = "%#StatuslineFileDir#"
local hl_sep = "%#StatuslineFileSeparator#"
local hl_file = "%#StatuslineFile#"
local hl_modified = "%#StatuslineFileModified#"
local hl_ellipsis = "%#StatuslineEllipsis#"
local hl_readonly = "%#StatuslineReadonly#"
local hl_scrollbar = "%#StatuslineScrollbar#"
local hl_scrollbar_ends = "%#StatuslineScrollbarEnd#"
local hl_lsp_icons = "%#StatuslineLSPIcons#"
local hl_lsp_text = "%#StatuslineLSPText#"
local hl_lsp_text_active = "%#StatuslineLSPTextActive#"
local hl_lsp_separator = "%#StatuslineLSPSeparator#"
local hl_terminate = "%*"

local M = {}

-- Configuration with default values
local config = {
  ellipsis = "…",
  filepath = {
    max_elements = 0,
    hidden = {
      "",
      "Avante",
      "AvanteInput",
      "AvanteSelectedFiles",
      "TelescopePrompt",
      "snacks_picker_list",
      "help",
      "terminal",
    },
  },
  scrollbar = {
    hidden = {
      "",
      "Avante",
      "AvanteInput",
      "AvanteSelectedFiles",
      "TelescopePrompt",
      "snacks_picker_list",
      "help",
      "terminal",
    },
  },
  lsp_context = {
    max_elements = 4,
    reverse = true,
    -- separators = { " ", " " },
    separators = { " ← ", " → " },
  },
}

-- Function to allow user configuration
function M.setup(user_config)
  config = vim.tbl_extend("force", config, user_config or {})

  vim.opt.statusline = ""

  local group = vim.api.nvim_create_augroup("StatuslineUpdate", { clear = true })

  -- Records which window is the active one
  vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter" }, {
    group = group,
    pattern = "*",
    callback = function()
      vim.g.statusline_winid = vim.api.nvim_get_current_win()
    end,
  })

  -- Renders the statusline
  vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter", "FileType" }, {
    group = group,
    pattern = "*",
    callback = function()
      local current_winid = vim.fn.win_getid()
      vim.opt_local.statusline = string.format("%%!v:lua.require'config.statusline'.render(%d)", current_winid)
    end,
  })

  -- Set globals
  vim.g.statusline_filepath = true
  vim.g.statusline_lsp_context = true

  -- Set up keymaps
  vim.keymap.set("n", "gtsf", function()
    vim.g.statusline_filepath = not vim.g.statusline_filepath
    M.render()
  end, { desc = "Toggle filepath in statusline" })
  vim.keymap.set("n", "gtsF", function()
    vim.g.statusline_filepath = true
    vim.g.statusline_lsp_context = false
    M.render()
  end, { desc = "Set only filepath in statusline" })
  vim.keymap.set("n", "gtsl", function()
    vim.g.statusline_lsp_context = not vim.g.statusline_lsp_context
    M.render()
  end, { desc = "Toggle lsp context in statusline" })
  vim.keymap.set("n", "gtsL", function()
    vim.g.statusline_filepath = false
    vim.g.statusline_lsp_context = true
    M.render()
  end, { desc = "Set only lsp context in statusline" })
end

function M.render(winid)
  winid = winid or 0
  local bufnr = vim.api.nvim_win_get_buf(winid)
  if bufnr == -1 then
    return ""
  end

  local function active_only(value)
    local active = vim.api.nvim_get_current_win() == vim.g.statusline_winid
    return active and value or ""
  end

  local filepath = M.get_filepath(bufnr, winid)
  -- local filepath = active_only(M.get_filepath(bufnr, winid))
  local scrollbar = active_only(M.get_scrollbar(bufnr, winid))
  local readonly = active_only(M.get_readonly(bufnr))
  local lsp_context = active_only(M.get_lsp_context(bufnr))

  local left = table.concat {
    readonly ~= "" and " " or "",
    readonly,
    " ",
    filepath,
  }
  local center = table.concat {
    " ",
  }
  local right = table.concat {
    lsp_context,
    " ",
    scrollbar,
    " ",
  }

  return table.concat({
    left,
    "%=",
    center,
    "%=",
    right,
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

local function truncate_elements(components, max_elements, ellipsis_element, truncate_near)
  truncate_near = truncate_near or "middle"

  local total = #components

  -- Handle trivial cases: Cannot truncate if 3 or fewer components
  if total <= 3 then
    return components
  end

  -- If truncation might happen, we need at least 3 slots:
  local effective_max = math.max(max_elements, 3)

  -- Check if truncation is actually needed based on the effective max
  if total <= effective_max then
    return components
  end

  -- Always include first element
  local first_element = components[1]

  local truncated = {}
  table.insert(truncated, first_element)

  if truncate_near == "middle" then
    -- Calculate how many *extra* components we can show besides the mandatory 3
    -- We have effective_max slots. 3 are for mandatory components.
    local num_extra_to_show = effective_max - 3
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
    table.insert(truncated, ellipsis_element)

    -- Add second to last and last element
    table.insert(truncated, components[total - 1])
    table.insert(truncated, components[total])
  elseif truncate_near == "start" then
    local num_extra_to_show = effective_max - 2

    if total > effective_max then
      table.insert(truncated, ellipsis_element)
    end

    for i = total - num_extra_to_show, total do
      if i > 1 then
        table.insert(truncated, components[i])
      end
    end
  end

  return truncated
end

local function get_dynamic_max_elements(winid)
  local window_width = vim.api.nvim_win_get_width(winid)
  local elm = config.filepath.max_elements

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
  -- local filetype = vim.filetype.match { buf = bufnr } or ""
  local filetype = vim.api.nvim_buf_get_option(bufnr, "filetype") or ""
  for _, hidden_ft in ipairs(hidden_config) do
    if filetype == hidden_ft then
      return false
    end
  end
  return true
end

function M.get_filepath(bufnr, winid)
  if not can_show(bufnr, config.filepath.hidden) or vim.g.statusline_filepath == false then
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
  local current_max = math.max(config.filepath.max_elements, dynamic_max)

  if #components > current_max then
    components = truncate_elements(components, current_max, config.ellipsis, "middle")
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
    return hl_scrollbar .. string.rep("─", 2) .. hl_terminate
  end

  local cur_line = vim.api.nvim_win_get_cursor(winid)[1]
  local i = math.floor((cur_line - 1) / lines * #sbar_chars) + 1
  local sbar = string.rep(sbar_chars[i], 2)

  local hl = hl_scrollbar
  if i == 1 or i == #sbar_chars then
    hl = hl_scrollbar_ends
  end

  return hl .. sbar .. hl_terminate
end

function M.get_readonly(bufnr, winid)
  local readonly = vim.api.nvim_get_option_value("readonly", { buf = bufnr, win = winid })
  local icon = ""
  return readonly and table.concat { hl_readonly, icon, hl_terminate } or ""
end

function M.get_lsp_context(bufnr)
  local ok, navic = pcall(require, "nvim-navic")
  if not ok then
    return ""
  end
  local data = navic.get_data(bufnr)
  if not data or #data == 0 or vim.g.statusline_lsp_context == false then
    return ""
  end

  local ignore = { "Variable", "Package" }
  local filtered_data = {}
  for _, item in ipairs(data) do
    if not vim.tbl_contains(ignore, item.type) then
      table.insert(filtered_data, item)
    end
  end

  filtered_data = truncate_elements(
    filtered_data,
    config.lsp_context.max_elements,
    { name = config.ellipsis, type = "$truncated", icon = "" },
    "start"
  )

  if config.lsp_context.reverse then
    filtered_data = vim.fn.reverse(filtered_data)
  end

  local parts = {}
  for i, item in ipairs(filtered_data) do
    local icon = hl_lsp_icons .. item.icon .. hl_terminate
    local hl = (i == (config.lsp_context.reverse and 1 or #filtered_data)) and hl_lsp_text_active or hl_lsp_text
    if item.type == "$truncated" then
      hl = hl_ellipsis
    end
    table.insert(parts, icon .. hl .. item.name .. hl_terminate)
    if i < #filtered_data then
      local separator = config.lsp_context.reverse and config.lsp_context.separators[1]
        or config.lsp_context.separators[2]
      table.insert(parts, hl_lsp_separator .. separator .. hl_terminate)
    end
  end

  return table.concat(parts)
end

return M
