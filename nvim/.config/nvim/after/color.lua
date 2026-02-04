local function set_toggleterm_hl()
    vim.api.nvim_set_hl(0, "ToggleTerm", { bg = "#111111" })
end

set_toggleterm_hl()

vim.api.nvim_create_autocmd("ColorScheme", {
    callback = set_toggleterm_hl,
})
