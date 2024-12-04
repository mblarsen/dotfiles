local M = {}

require "custom.plugins.mini.basics"
require "custom.plugins.mini.diff"
require "custom.plugins.mini.files"

require("mini.ai").setup()
require("mini.git").setup()
require("mini.surround").setup()
require("mini.operators").setup()

return M
