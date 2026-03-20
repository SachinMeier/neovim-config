--
-- ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
-- ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
-- ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
-- ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
-- ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
-- ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝
--
-- File: autocmds.lua
-- Description: Autocommand functions
-- Author: Kien Nguyen-Tuan <kiennt2609@gmail.com>
-- Define autocommands with Lua APIs
-- See: h:api-autocmd, h:augroup
local autocmd = vim.api.nvim_create_autocmd -- Create autocommand

-- General settings

-- Highlight on yank
autocmd("TextYankPost", {
    callback = function()
        vim.highlight.on_yank({
            higroup = "IncSearch",
            timeout = "1000",
        })
    end,
})

-- Remove whitespace on save
autocmd("BufWritePre", {
    pattern = "",
    command = ":%s/\\s\\+$//e",
})

-- Auto format on save using the attached (optionally filtered) language servere clients
-- https://neovim.io/doc/user/lsp.html#vim.lsp.buf.format()
autocmd("BufWritePre", {
    pattern = "",
    command = ":silent lua vim.lsp.buf.format()",
})

-- Don"t auto commenting new lines
autocmd("BufEnter", {
    pattern = "",
    command = "set fo-=c fo-=r fo-=o",
})

autocmd("Filetype", {
    pattern = { "xml", "html", "xhtml", "css", "scss", "javascript", "typescript", "yaml", "lua" },
    command = "setlocal shiftwidth=2 tabstop=2",
})

-- Set colorcolumn
autocmd("Filetype", {
    pattern = { "python", "rst", "c", "cpp" },
    command = "set colorcolumn=80",
})

autocmd("Filetype", {
    pattern = { "gitcommit", "markdown", "text" },
    callback = function()
        vim.opt_local.wrap = true
        vim.opt_local.spell = true
    end,
})

-- Copy path from mini.files
autocmd("User", {
    pattern = "MiniFilesBufferCreate",
    callback = function(args)
        vim.keymap.set("n", "yy", function()
            local entry = require("mini.files").get_fs_entry()
            if entry then
                vim.fn.setreg("+", entry.path)
                vim.notify("Copied: " .. entry.path)
            end
        end, { buffer = args.data.buf_id, desc = "Copy path" })
    end,
})

autocmd({ "ColorScheme" }, {
    callback = function()
        vim.cmd([[hi Lualine_c_normal guibg=none]])
        vim.cmd([[hi StatusLine guibg=none]])
        vim.cmd([[hi StatusLineNC guibg=none]])
        vim.cmd([[hi TabLineFill guibg=none]])
        vim.cmd([[hi TabLineSel guibg=none]])
        vim.cmd([[hi TabLine guibg=none]])
    end,
})
