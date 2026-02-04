return {
    "chentoast/marks.nvim",
    event = "VeryLazy",
    config = function ()
        require("marks").setup({
            default_mappings = true, -- whether to map keybinds or not. default true
        })

        vim.keymap.set("n", "<leader>ml", "<cmd>MarksListAll<CR>", { desc = "List all marks" })
        vim.keymap.set("n", "<leader>mt", "<cmd>Telescope marks<CR>", { desc = "Marks (Telescope)" })
    end
}
