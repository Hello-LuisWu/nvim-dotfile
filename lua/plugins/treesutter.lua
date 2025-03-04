return {
    "nvim-treesitter/nvim-treesitter",
    enable = false,
    dependencies = { "p00f/nvim-ts-rainbow" }, -- 彩色括号
    event = { "BufReadPost", "BufNewFile" },
    config = function()
        require 'nvim-treesitter.configs'.setup {
            ensure_installed = {
                "vim",
                "bash",
                "c",
                "cpp",
                "javascript",
                "json",
                "lua",
                "python",
                "tsx",
                "css",
                "html",
                "rust",
                "markdown",
                "markdown_inline"
            }, -- 安装 Markdown 和内联 Markdown 支持
            -- 高亮配置
            highlight = {
                enable = true, -- 启用 Treesitter 高亮

                -- 禁用特定语言
                disable = { "c", "rust" },

                disable = function(lang, buf)
                    -- 设置最大文件大小为 100 KB
                    local max_filesize = 100 * 1024 -- 100 KB

                    -- 使用 pcall 以安全方式调用 vim.loop.fs_stat 来获取文件的大小
                    local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))

                    -- 如果成功获取到文件的大小并且文件大小超过 max_filesize，则禁用 Treesitter
                    if ok and stats and stats.size > max_filesize then
                        return true
                    end
                end,
                additional_vim_regex_highlighting = false, -- 禁用额外的正则匹配高亮
            },

            -- 增量选择(incremental selection)配置，编辑时通过快捷键进行语法树节点的逐步选择
            incremental_selection = {
                enable = true,                 --启用增量选择功能
                keymaps = {
                    init_selection = "tnn",    -- 初始化选择（开始选择第一个节点）
                    node_incremental = "trn",  -- 逐步增量选择当前节点（向下选择更细的语法节点）
                    scope_incremental = "trc", -- 逐步增量选择当前范围（向上选择更大的语法块）
                    node_decremental = "trm",  -- 逐步减少当前选择的节点（退回上一个节点）
                },
            },
            folding = {
                enable = true,
                disable = { 'markdown' }, -- 对特定文件禁用
            },
            rainbow = {
                enable = true,        -- 启用
                -- disable = { "jsx", "cpp" }, -- 禁用某些语言的彩虹括号
                extended_mode = true, -- 在更多语言中启用
                max_file_lines = nil, -- 不限文件行数
                colors = {            -- 颜色配置
                    "#cc241d",
                    "#a89984",
                    "#b16286",
                    "#d79921",
                    "#689d6a",
                    "#d65d0e",
                    "#458588",
                }, --
                termcolors = {
                    "Red",
                    "Green",
                    "Yellow",
                    "Blue",
                    "Magenta",
                    "Cyan",
                    "White",
                }, -- 终端颜色
            },
        }
    end
}
