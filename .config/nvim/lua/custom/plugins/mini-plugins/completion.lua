require("mini.completion").setup {}
require("mini.snippets").setup {}

-- require("mini.icons").setup {}
-- MiniIcons.tweak_lsp_kind()

local gr = vim.api.nvim_create_augroup("MyMiniCompletion", {})
local au = function(event, pattern, callback, desc)
  vim.api.nvim_create_autocmd(event, { group = gr, pattern = pattern, callback = callback, desc = desc })
end

au("FileType", "snacks_picker_input", function()
  vim.b.minicompletion_disable = true
end, "Disable locally")
