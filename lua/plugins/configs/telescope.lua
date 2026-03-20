--
-- ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
-- ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
-- ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
-- ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
-- ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
-- ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝
--
-- File: plugins/configs/telescope.lua
-- Description: nvim-telescope config
-- Author: Kien Nguyen-Tuan <kiennt2609@gmail.com>
return {
    defaults = {
        prompt_prefix = "   ",
        selection_caret = " ",
        entry_prefix = " ",
        sorting_strategy = "ascending",
        layout_config = {
            horizontal = {
                prompt_position = "top",
                preview_width = 0.55,
            },
            width = 0.87,
            height = 0.80,
        },
        file_ignore_patterns = {
            "node_modules/",
            "%.git/",
            "dist/",
            "build/",
            "%.next/",
            "%.turbo/",
            "%.devbox/",
            "%.jj/",
            "coverage/",
            "%.cache/",
            "%.vercel/",
            "%.DS_Store",
            "%.cursor/",
            "%.astro/",
            "%.idea/",
            "linear%-docs/",
            "%.yarn/",
            "out/",
            "%.tsbuildinfo",
        },
        mappings = {
            n = {
                ["q"] = require("telescope.actions").close,
                ["gy"] = function(prompt_bufnr)
                    local entry = require("telescope.actions.state").get_selected_entry()
                    vim.fn.setreg("+", entry.path or entry.filename or entry.value)
                    require("telescope.actions").close(prompt_bufnr)
                    vim.notify("Copied: " .. (entry.path or entry.filename or entry.value))
                end,
            },
            i = {
                ["<C-y>"] = function(prompt_bufnr)
                    local entry = require("telescope.actions.state").get_selected_entry()
                    vim.fn.setreg("+", entry.path or entry.filename or entry.value)
                    require("telescope.actions").close(prompt_bufnr)
                    vim.notify("Copied: " .. (entry.path or entry.filename or entry.value))
                end,
            },
        },
    },

    pickers = {
        find_files = {
            find_command = {
                "fd", "--type", "f", "--hidden", "--no-ignore",
                "--exclude", ".git",
                "--exclude", "node_modules",
                "--exclude", ".devbox",
                "--exclude", ".jj",
                "--exclude", "dist",
                "--exclude", "build",
                "--exclude", ".next",
                "--exclude", ".turbo",
                "--exclude", "coverage",
                "--exclude", ".cache",
                "--exclude", ".vercel",
                "--exclude", ".DS_Store",
                "--exclude", ".cursor",
                "--exclude", ".astro",
                "--exclude", ".idea",
                "--exclude", "linear-docs",
                "--exclude", ".yarn",
                "--exclude", "out",
                "--exclude", "*.tsbuildinfo",
            },
        },
    },

    extensions_list = { "themes", "terms" },
    extensions = {},
}
