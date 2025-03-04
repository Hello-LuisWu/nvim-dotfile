return {
    {
        'echasnovski/mini.indentscope',
        version = '*',
        event = { "BufReadPre", "BufNewFile" }, -- 在打开文件时加载
        dependencies = {
    {
        'lukas-reineke/indent-blankline.nvim',
        -- event = { "BufReadPre", "BufNewFile" }, -- 在打开文件时加载
        main = "ibl",
        opts = {
            -- 基础配置
            scope = {
                enabled = false, -- 启用作用域高亮
                char = "▎", -- 作用域字符
                show_start = true, -- 显示作用域开始线
                show_end = false, -- 不显示作用域结束线
                highlight = "Function", -- 作用域高亮
                injected_languages = true, -- 检测注入语言
            },
            exclude = {
                filetypes = {
                    "help", "dashboard", "neo-tree", "Trouble", "lazy", "mason",
                    "notify", "toggleterm", "lspinfo","txt"
                },
                buftypes = { "terminal", "nofile" },
            },

        },
    },
        },
        opts = {
            symbol = '▎', -- 缩进线符号 (可尝试 "▏", "┆", "┊" 等)
            draw = {
                -- 绘制延迟（事件触发到开始绘制的时间，单位毫秒）
                delay = 50,

                -- 动画效果函数（n当前步数，total总步数）
                -- 这里使用线性渐隐动画（返回值是每帧间隔时间）
                animation = function(n, total)
                    return math.floor(20 * (1 - n / total)) -- 线性渐隐
                end,

                -- 绘制条件判断函数（返回true时绘制）
                -- 默认只绘制完整计算的作用域（过滤不完整的作用域）
                predicate = function(scope) return not scope.body.is_incomplete end,

                -- 符号显示优先级（数值越大显示层级越高）
                priority = 2,
            },

            -- 快捷键映射配置
            mappings = {
                -- 文本对象操作
                object_scope = 'ii',             -- 选择当前缩进作用域
                object_scope_with_border = 'ai', -- 选择包含边界的缩进作用域
                -- 跳转操作
                goto_top = '[i',                 -- 跳转到作用域顶部边界
                goto_bottom = ']i',              -- 跳转到作用域底部边界
            },

            -- 作用域计算配置
            options = {
                -- 作用域边界类型（both: 上下边界都识别，top: 仅顶部，bottom: 仅底部，none: 不识别）
                border = 'both',

                -- 是否基于光标列位置计算参考缩进
                -- 开启后可实现水平移动光标时的动态作用域显示
                indent_at_cursor = true,

                -- 作用域扫描行数限制（上下最大行数之和）
                n_lines = 10000,

                -- 是否优先将当前行视为相邻作用域的边界
                -- 适合光标在函数头部时检测函数体作用域
                try_as_border = false,
            },

        },
        config = function(_, opts)
            -- 配置颜色（确保与主题兼容）
            vim.api.nvim_set_hl(0, "MiniIndentscopeSymbol", { fg = "#167369" })

            require("mini.indentscope").setup(opts)

            -- 大文件禁用规则
            vim.api.nvim_create_autocmd("FileType", {
                callback = function(args)
                    if vim.fn.line("$") > 5000 then
                        vim.b.miniindentscope_disable = true
                    end
                end,
            })
        end,
    },

}
