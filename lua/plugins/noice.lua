return {
    "folke/noice.nvim",
    event = "VeryLazy", -- 延迟加载
    enabled = true,
    dependencies = {
        "MunifTanjim/nui.nvim",         -- 必要依赖
        "rcarriga/nvim-notify",         -- 通知系统增强
        "nvim-telescope/telescope.nvim" -- 消息历史查看
    },
    opts = {
        -- 消息模块配置
        messages = {
            enabled = true,              -- 启用消息美化
            view = "mini",               -- 默认消息视图 (mini|notify)
            view_error = "notify",       -- 错误消息视图
            view_warn = "notify",        -- 警告消息视图
            view_history = "messages",   -- 历史消息视图 (:messages)
            view_search = "virtualtext", -- 搜索计数显示方式
        },

        -- 弹出消息配置
        popupmenu = {
            enabled = true,  -- 启用 neovim 原生弹出菜单
            backend = "nui", -- 使用 nui 作为后端 (nui|cmp)
        },

        -- 命令行配置
        cmdline = {
            enabled = true,         -- 启用命令行美化
            view = "cmdline_popup", -- 命令行弹出样式
            format = {
                -- 自定义命令行格式
                cmdline = { pattern = "^:", icon = "📝", lang = "vim" },
                search_down = { icon = "🔍 👇" }, -- 向下搜索图标
                search_up = { icon = "🔍 👆" }, -- 向上搜索图标
                filter = { icon = "" }, -- 过滤器图标
                lua = { icon = "" }, -- Lua 命令图标
                help = { icon = "❓" }, -- 帮助命令图标
            },
        },

        -- LSP 相关配置
        lsp = {
            override = {
                -- 覆盖默认 LSP 处理程序
                ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                ["vim.lsp.util.stylize_markdown"] = true,
                ["cmp.entry.get_documentation"] = true,
            },
            signature = {
                enabled = true,     -- 启用 LSP 签名帮助
                auto_open = {
                    enabled = true, -- 自动打开签名帮助
                    trigger = true, -- 自动触发
                },
            },
            progress = {
                enabled = true,                    -- 显示 LSP 进度
                format = "lsp_progress",           -- 进度格式
                format_done = "lsp_progress_done", -- 完成格式
                throttle = 1000 / 30,              -- 更新频率 (ms)
            },
        },

        -- 通知系统配置
        notify = {
            enabled = true,  -- 启用通知集成
            view = "notify", -- 默认通知视图
        },

        -- 路由配置 (消息显示规则)
        routes = {
            {
                -- 将长消息重定向到通知系统
                filter = { event = "msg_show", min_height = 5 },
                view = "notify",
            },
            {
                -- 隐藏搜索计数消息
                filter = { event = "msg_show", find = "%dL, %dB" },
                opts = { skip = true },
            },
            {
                -- 隐藏写入文件消息
                filter = { event = "msg_show", find = "%d+ lines, %d+ bytes" },
                opts = { skip = true },
            },
        },

        -- 格式设置
        format = {
            -- 自定义输出格式
            spinner = {
                name = "moon",  -- 动画类型 (可选: dots, moon, etc.)
                interval = 100, -- 帧间隔 (ms)
            },
            level = {
                icons = {
                    error = "", -- 错误图标
                    warn = "", -- 警告图标
                    info = "", -- 信息图标
                    debug = "" -- 调试图标
                }
            }
        },

        -- 视图配置
        views = {
            cmdline_popup = {
                -- 命令行弹出窗口样式
                position = {
                    row = "10%", -- 垂直居中
                    col = "50%", -- 水平居中
                },
                size = {
                    width = "60%", -- 宽度占比
                    height = "auto",
                },
                border = {
                    style = "rounded", -- 边框样式
                    padding = { 0, 1 },
                },
            },
            notify = {
                -- 通知窗口样式
                timeout = 3000, -- 默认显示时间
                replace = true, -- 替换现有通知
                merge = true,   -- 合并相似通知
            },
        },

        -- 按键映射
        keys = {
  { "<leader>sn", "", desc = "+noice"},
    { "<S-Enter>", function() require("noice").redirect(vim.fn.getcmdline()) end, mode = "c", desc = "Redirect Cmdline" },
    { "<leader>snl", function() require("noice").cmd("last") end, desc = "Noice Last Message" },
    { "<leader>snh", function() require("noice").cmd("history") end, desc = "Noice History" },
    { "<leader>sna", function() require("noice").cmd("all") end, desc = "Noice All" },
    { "<leader>snd", function() require("noice").cmd("dismiss") end, desc = "Dismiss All" },
    { "<leader>snt", function() require("noice").cmd("pick") end, desc = "Noice Picker (Telescope/FzfLua)" },
    { "<c-f>", function() if not require("noice.lsp").scroll(4) then return "<c-f>" end end, silent = true, expr = true, desc = "Scroll Forward", mode = {"i", "n", "s"} },
    { "<c-b>", function() if not require("noice.lsp").scroll(-4) then return "<c-b>" end end, silent = true, expr = true, desc = "Scroll Backward", mode = {"i", "n", "s"}},
        },
    },
    config = function(_, opts)

        -- 自定义 Telescope 扩展
        require("telescope").load_extension("noice")

        -- 高级配置：动画效果
        vim.api.nvim_set_hl(0, "NoiceCompletionItemKindDefault", { fg = "#7EB3C9" })

        -- 禁用传统消息系统
        vim.opt.cmdheight = 0 -- 命令行高度
        vim.opt.shortmess:append({ W = true, I = true, c = true })
        require("noice").setup(opts) -- 初始化配置
    end
}
