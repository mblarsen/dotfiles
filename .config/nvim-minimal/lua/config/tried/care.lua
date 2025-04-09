return {
    "max397574/care.nvim",
    enabled = false,
    dependencies = {
        {
            "romgrk/fzy-lua-native",
            build = "make" -- optional, uses faster native version
        }
    },
    rocks = {
      hererocks = true,
    },
    config = function()
      require("care").setup({
        ui = {
          type_icons = "mini.icons"
        },
      })
    end
}
