return {

    {
        "iamcco/markdown-preview.nvim",
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        build = "cd app && yarn install",
        init = function()
            vim.g.mkdp_filetypes = { "markdown" }
        end,
        ft = { "markdown" },
        keys = { { "<leader>md", "<cmd>MarkdownPreviewToggle<cr>", desc = "Markdown Preview" } },
        config = function()
            vim.g.mkdp_auto_close = true
            vim.g.mkdp_open_to_the_world = false
            vim.g.mkdp_open_ip = "127.0.0.1"
            vim.g.mkdp_port = "8888"
            vim.g.mkdp_browser = ""
            vim.g.mkdp_echo_preview_url = true
            vim.g.mkdp_page_title = "${name}"
        end,
    },

    {
        "dkarter/bullets.vim",
        ft = "markdown",
        config = function()
            vim.g.bullets_enabled_file_types = { "markdown", "telekasten", "text", "gitcommit", "scratch" }
            vim.g.bullets_outline_levels = { "num", "abc", "std-" }
        end,
    },

    {

        "img-paste-devs/img-paste.vim",
        ft = "markdown",
        config = function()
            vim.cmd([[
        autocmd FileType markdown nmap <buffer><silent> <leader>p :call mdip#MarkdownClipboardImage()<CR>
        " there are some defaults for image directory and image name, you can change them
        " let g:mdip_imgdir = 'img'
        " let g:mdip_imgname = 'image'
        function! g:LatexPasteImage(relpath)
            execute "normal! i\\includegraphics{" . a:relpath . "}\r\\caption{I"
            let ipos = getcurpos()
            execute "normal! a" . "mage}"
            call setpos('.', ipos)
            execute "normal! ve\<C-g>"
        endfunction
        autocmd FileType markdown let g:PasteImageFunction = 'g:MarkdownPasteImage'
        autocmd FileType tex let g:PasteImageFunction = 'g:LatexPasteImage'
        ]])
        end,
    },
    {
        "Kicamon/markdown-table-mode.nvim",
        cmd = "TableModeToggle",
        config = function()
            require("markdown-table-mode").setup({
                filetype = {
                    "*.*",
                },
            })
        end,
    },
    {
        "richardbizik/nvim-toc",
        ft = { "markdown" },
        opts = {
            toc_header = "文档目录",
        },
    },
}
