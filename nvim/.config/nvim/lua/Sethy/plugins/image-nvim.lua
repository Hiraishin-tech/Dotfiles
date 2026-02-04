return {
    {
        -- luarocks.nvim is a Neovim plugin designed to streamline the installation
        -- of luarocks packages directly within Neovim. It simplifies the process
        -- of managing Lua dependencies, ensuring a hassle-free experience for
        -- Neovim users.
        -- https://github.com/vhyrro/luarocks.nvim
        "vhyrro/luarocks.nvim",
        -- this plugin needs to run before anything else
        priority = 1001,
        opts = {
            rocks = { "magick" },
            hererocks = true, -- Lets lazy.nvim install the correct lua version
        },
    },
    -- requires pngpaste ( On Linux wayland install wl-clipboard, On MacOS brew install pngpaste )
    -- "HakonHarnes/img-clip.nvim",
    -- event = "VeryLazy",
    -- keys = {
    --     -- suggested keymap
    --     { "<leader>pi", "<cmd>PasteImage<cr>", desc = "Paste image from system clipboard" },
    -- },
    -- opts = {
    --     default = {
    --         insert_mode_after_paste = false,
    --         url_encode_path = true,
    --         template = "$FILE_PATH",
    --         use_cursor_in_template = true,
    --
    --         prompt_for_file_name = true,
    --         show_dir_path_in_prompt = true,
    --
    --         use_absolute_path = false,
    --         relative_to_current_file = true,
    --
    --         embed_image_as_base64 = false,
    --         max_base64_size = 10,
    --
    --         -- dir_path = function()
    --         --     local cwd = vim.fn.getcwd()
    --         --     local vault_name = "sethVault"  -- obsidian vault dir
    --         --     local vault_images_path = "Archives/All-Vault-Images/"
    --         --
    --         --     if cwd:match(vault_name) then
    --         --         return vault_images_path
    --         --     else
    --         --         return "assets"
    --         --     end
    --         -- end
    --         dir_path = function()
    --             local cwd = vim.fn.getcwd()
    --             local vault_name = "Pictures"
    --             local vault_images_path = "/home/tomas/Pictures/"
    --
    --             if cwd:match(vault_name) then
    --                 return vault_images_path
    --             else
    --                 return "assets"
    --             end
    --         end,
    --
    --         drag_and_drop = {
    --             enabled = true,
    --             insert_mode = true,
    --             copy_images = true,
    --             download_images = true, -- download images from URL
    --         },
    --     },
    --     -- add options here
    --     -- or leave it empty to use the default settings
    -- },
    -- Showing images in terminal (konsole doesn't work, e. g. kitty does)
    {
        "3rd/image.nvim",
        enabled = true,
        ft = { "markdown", "vimwiki" },
        dependencies = {
            "luarocks.nvim",
        },
        config = function()
            require("image").setup({
                backend = "kitty",
                kitty_method = "normal",
                integrations = {
                    -- Notice these are the settings for markdown files
                    markdown = {
                        enabled = true,
                        clear_in_insert_mode = true,
                        -- Set this to false if you don't want to render images coming from
                        -- a URL
                        download_remote_images = true,
                        -- Change this if you would only like to render the image where the
                        -- cursor is at
                        -- I set this to true, because if the file has way too many images
                        -- it will be laggy and will take time for the initial load
                        only_render_image_at_cursor = false,
                        -- markdown extensions (ie. quarto) can go here
                        filetypes = { "markdown", "vimwiki" },
                    },
                    neorg = {
                        enabled = true,
                        clear_in_insert_mode = false,
                        download_remote_images = true,
                        only_render_image_at_cursor = false,
                        filetypes = { "norg" },
                    },
                    -- This is disabled by default
                    -- Detect and render images referenced in HTML files
                    -- Make sure you have an html treesitter parser installed
                    -- ~/github/dotfiles-latest/neovim/nvim-lazyvim/lua/plugins/treesitter.lua
                    -- html = {
                    --     enabled = true,
                    -- },
                    -- This is disabled by default
                    -- Detect and render images referenced in CSS files
                    -- Make sure you have a css treesitter parser installed
                    -- ~/github/dotfiles-latest/neovim/nvim-lazyvim/lua/plugins/treesitter.lua
                    -- css = {
                    --     enabled = true,
                    -- },
                },
                max_width = 100,
                max_height = 12,
                -- max_width_window_percentage = nil,

                -- This is what I changed to make my images look smaller, like a
                -- thumbnail, the default value is 50
                -- max_height_window_percentage = 20,
                -- max_height_window_percentage = 40,

                -- toggles images when windows are overlapped
                -- window_overlap_clear_enabled = false,
                -- window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
                --
                -- -- auto show/hide images when the editor gains/looses focus
                -- editor_only_render_when_focused = true,

                -- auto show/hide images in the correct tmux window
                -- In the tmux.conf add `set -g visual-activity off`
                tmux_show_only_in_active_window = true,

                -- render image files as images when opened
                -- TODO: add support for rendering .ico files
                hijack_file_patterns = { "*.png", "*.jpg", "*.jpeg", "*.gif", "*.webp", "*.avif", },
            })
        end,
    },
}
