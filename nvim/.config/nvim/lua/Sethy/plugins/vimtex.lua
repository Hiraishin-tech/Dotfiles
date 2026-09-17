return {
    "lervag/vimtex",
    lazy = false,  -- we don't want to lazy load VimTeX
    tag = "v2.17", -- uncomment to pin to a specific release
    init = function()
        -- VimTeX configuration goes here, e.g.
        vim.g.vimtex_view_method = "zathura"
    end
    -- I recommend to then install:
    -- texlive-scheme-full latexmk (compiler)
    -- zathura (pdf viewer) zathura-pdf-poppler
    --
    -- Basic commands:
    -- Press <leader>ll to start (or stop) compiling the document. This turns
    -- on automatic compiling if supported by your compiler, meaning your 
    -- document will be compiled each time you save.
    --
    -- Press <leader>lk to stop the compilation process
    -- Press <leader>lc to clear auxiliary files.
    --
    -- More on github: https://github.com/lervag/vimtex
}
