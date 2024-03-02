return {
    "kylechui/nvim-surround",
    version = "*", -- can also use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
        require("nvim-surround").setup({})
    end
}
