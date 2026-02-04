return {
	"stevearc/oil.nvim",
    -- enabled = false,
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		require("oil").setup({
            default_file_explorer = true, -- start up nvim with oil instead of netrw (:Ex doesn't work anymore)
			columns = { },
			keymaps = {
				["<C-h>"] = false,
                -- ["<C-c>"] = false, -- prevent from closing Oil as <C-c> is esc key
				["<M-h>"] = "actions.select_split", -- Alt + h open file in horizontal split
                ["q"] = "actions.close",
                -- shift + l/h like for the mini plugin
                ["L"] = "actions.select",
                ["H"] = {"actions.parent", mode="n"}
			},
            delete_to_trash = true, -- files and directories deleted will go to trash bin
			view_options = {
				show_hidden = true, -- showing also hidden files
			},
            skip_confirm_for_simple_edits = true,
		})

        -- Keymaps for oil
		-- opens parent dir over current active window
		vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
		-- open parent dir in float window
		vim.keymap.set("n", "<leader>-", require("oil").toggle_float)

        -- Color highlights in oil explorer
        vim.api.nvim_create_autocmd("FileType", {
            pattern = "oil", -- Adjust if Oil uses a specific file type identifier
            callback = function()
                vim.opt_local.cursorline = true
            end,
        })
	end,

}
