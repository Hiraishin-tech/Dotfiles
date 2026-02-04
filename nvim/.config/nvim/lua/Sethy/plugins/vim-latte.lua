return {
    'Janiczek/vim-latte',
    ft = {'latte', "latte.php.html"}, -- ft = filetype (pro kontrolu v jednotlivych souborech muzu zadat ':set filetype?')
    -- config = function()
    -- vim.api.nvim_create_autocmd("FileType", {
    --     pattern = "latte",
    --     callback = function()
    --         vim.bo.commentstring = "{* %s *}"
    --     end,
    -- })
    -- end
}
