local M = {}

require "custom.plugins.mini-plugins.basics"
require "custom.plugins.mini-plugins.diff"
require "custom.plugins.mini-plugins.files"

require("mini.ai").setup()
require("mini.git").setup()
require("mini.surround").setup()
require("mini.operators").setup()

return M
