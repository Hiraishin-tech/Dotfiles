return {
    "nvimdev/lspsaga.nvim",
    dependencies = {
        "nvim-tree/nvim-web-devicons", -- optional
        "nvim-treesitter/nvim-treesitter" -- optional
    },
    config = function()
        require("lspsaga").setup({})
    end
}
