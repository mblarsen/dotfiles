--- @module 'blink.cmp'
--- @class blink.cmp.Source
local source = {}

-- `opts` table comes from `sources.providers.abbr.opts`
-- You may also accept a second argument `config`, to get the full
-- `sources.providers.your_provider` table
function source.new(opts)
  -- vim.validate('your-source.opts.some_option', opts.some_option, { 'string' })
  -- vim.validate('your-source.opts.optional_option', opts.optional_option, { 'string' }, true)

  local self = setmetatable({}, { __index = source })
  self.opts = opts
  return self
end

--- Gets all defined abbreviations and returns them as a structured Lua table.
-- @return table A table of abbreviations, where each entry is a table with keys: mode, lhs, rhs.
-- @example
-- -- returns { { mode = 'i', lhs = 'eml', rhs = 'example@email.com' }, ... }
local function get_abbreviations()
  -- 1. Capture the raw string output of the `:abbr` command.
  local abbr_output = vim.fn.execute('abbr')

  -- 2. Split the output into a table of individual lines.
  local lines = vim.split(abbr_output, '\n')

  -- 3. Prepare the final table to store the structured data.
  local abbreviations = {}

  -- 4. Iterate over each line and parse it.
  for _, line in ipairs(lines) do
    -- We use a Lua pattern (regex) to extract the three columns.
    -- ^(%S)   - Captures the first non-whitespace character (the mode).
    -- %s+     - Skips one or more space characters.
    -- (%S+)   - Captures the abbreviation keyword (the left-hand side).
    -- %s+     - Skips one or more space characters.
    -- (.*)$   - Captures all remaining characters until the end of the line (the right-hand side).
    local mode, lhs, rhs = line:match('^(%S)%s+(%S+)%s+(.*)$')

    -- 5. If the line was successfully parsed, add it to our results table.
    if mode then
      table.insert(abbreviations, {
        mode = mode,
        abbr = lhs,
        expands_to = rhs,
      })
    end
  end

  return abbreviations
end
-- (Optional) Enable the source in specific contexts only
-- function source:enabled() return vim.bo.filetype == 'lua' end

-- (Optional) Non-alphanumeric characters that trigger the source
-- function source:get_trigger_characters() return { '.' } end

function source:get_completions(ctx, callback)
  -- ctx (context) contains the current keyword, cursor position, bufnr, etc.

  local abbreviations = get_abbreviations()
  -- You should never filter items based on the keyword, since blink.cmp will
  -- do this for you

  -- https://microsoft.github.io/language-server-protocol/specifications/lsp/3.17/specification/#completionItem
  --- @type lsp.CompletionItem[]
  local items = {}
  for i, abbr in ipairs(abbreviations) do
    --- @type lsp.CompletionItem
    local item = {
      -- Label of the item in the UI
      label = abbr.abbr,
      -- (Optional) Item kind, where `Function` and `Method` will receive
      -- auto brackets automatically
      kind = require('blink.cmp.types').CompletionItemKind.Text,

      -- (Optional) Text to fuzzy match against
      filterText = abbr.abbr .. "|" .. abbr.expands_to,
      -- (Optional) Text to use for sorting. You may use a layout like
      -- 'aaaa', 'aaab', 'aaac', ... to control the order of the items
      sortText = abbr.abbr,

      detail = "Expands to -> " .. abbr.expands_to,
      labelDetails = {
        description = abbr.expands_to,
      },
      -- Text to be inserted when accepting the item using ONE of:
      --
      -- (Recommended) Control the exact range of text that will be replaced
      -- textEdit = {
      --   newText = 'item ' .. i,
      --   range = {
      --     -- 0-indexed line and character, end-exclusive
      --     start = { line = 0, character = 0 },
      --     ['end'] = { line = 0, character = 0 },
      --   },
      -- },
      -- Or get blink.cmp to guess the range to replace for you. Use this only
      -- when inserting *exclusively* alphanumeric characters. Any symbols will
      -- trigger complicated guessing logic in blink.cmp that may not give the
      -- result you're expecting
      -- Note that blink.cmp will use `label` when omitting both `insertText` and `textEdit`
      insertText = abbr.abbr,
      -- May be Snippet or PlainText. Works with both `textEdit` and `insertText`
      -- https://microsoft.github.io/language-server-protocol/specifications/lsp/3.17/specification/#snippet_syntax
      insertTextFormat = vim.lsp.protocol.InsertTextFormat.PlainText,

      -- There are some other fields you may want to explore which are blink.cmp
      -- specific, such as `score_offset` (blink.cmp.CompletionItem)
    }
    table.insert(items, item)
  end

  -- The callback _MUST_ be called at least once. The first time it's called,
  -- blink.cmp will show the results in the completion menu. Subsequent calls
  -- will append the results to the menu to support streaming results.
  callback({
    items = items,
    -- Whether blink.cmp should request items when deleting characters
    -- from the keyword (i.e. "foo|" -> "fo|")
    -- Note that any non-alphanumeric characters will always request
    -- new items (excluding `-` and `_`)
    is_incomplete_backward = false,
    -- Whether blink.cmp should request items when adding characters
    -- to the keyword (i.e. "fo|" -> "foo|")
    -- Note that any non-alphanumeric characters will always request
    -- new items (excluding `-` and `_`)
    is_incomplete_forward = false,
  })

  -- (Optional) Return a function which cancels the request
  -- If you have long running requests, it's essential you support cancellation
  return function() end
end

-- (Optional) Before accepting the item or showing documentation, blink.cmp will call this function
-- so you may avoid calculating expensive fields (i.e. documentation) for only when they're actually needed
-- Note only some fields may be resolved lazily. You may check the LSP capabilities for a complete list:
-- `textDocument.completion.completionItem.resolveSupport`
-- At the time of writing: 'documentation', 'detail', 'additionalTextEdits', 'command', 'data'
function source:resolve(item, callback)
  item = vim.deepcopy(item)

  -- Shown in the documentation window (<C-space> when menu open by default)
  item.documentation = {
    kind = 'markdown',
    value = [[Accept the abbreviation by typing the abbreviation followed by a space or punctuation.]],
  }

  -- Additional edits to make to the document, such as for auto-imports
  -- item.additionalTextEdits = {
  --   {
  --     newText = 'foo',
  --     range = {
  --       start = { line = 0, character = 0 },
  --       ['end'] = { line = 0, character = 0 },
  --     },
  --   },
  -- }

  callback(item)
end

-- (Optional) Called immediately after applying the item's textEdit/insertText
-- Only useful when you want to customize how items are accepted,
-- beyond what's possible with `textEdit` and `additionalTextEdits`
function source:execute(ctx, item, callback, default_implementation)
  -- When you provide an `execute` function, your source must handle the execution
  -- of the item itself, but you may use the default implementation at any time
  default_implementation()

  -- The callback _MUST_ be called once
  callback()
end

return source
