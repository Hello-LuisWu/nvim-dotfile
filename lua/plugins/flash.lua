return {
    "folke/flash.nvim",
    event = "VeryLazy",
    vscode = true,
    keys = {
        -- { "<CR>",  mode = { "n", "x", "o" }, function() require("flash").jump() end,              desc = "Flash" },
        { "s",     mode = { "n", "x", "o" }, function() require("flash").jump() end,              desc = "Flash" },
        { "S",     mode = { "n", "o", "x" }, function() require("flash").treesitter() end,        desc = "Flash Treesitter" },
        { "r",     mode = "o",               function() require("flash").remote() end,            desc = "Remote Flash" },
        { "R",     mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
        { "<c-s>", mode = { "c" },           function() require("flash").toggle() end,            desc = "Toggle Flash Search" },
    },
    opts = {

        --[[ 搜索配置 ]] --
        search = {
            multi_window = true, -- 跨窗口搜索
            forward = true, -- 默认搜索方向 (向前)
            wrap = true, -- 循环搜索
            mode = "exact", -- 匹配模式：exact(精确)/search(正则)/fuzzy(模糊)
            incremental = false, -- 非实时增量搜索
            exclude = { -- 排除文件类型/窗口
                "notify", "cmp_menu", "noice", "flash_prompt",
                function(win) return not vim.api.nvim_win_get_config(win).focusable end
            },
            trigger = "",       -- 触发标签前的输入字符（不建议修改）
            max_length = false, -- 最大匹配长度限制（false为无限制）
        },

        --[[ 跳转配置 ]] --
        jump = {
            jumplist = true, -- 记录跳转历史
            pos = "start", -- 跳转位置：start/end/range
            history = false, -- 不记录搜索历史
            register = false, -- 不存入寄存器
            nohlsearch = false, -- 跳转后保留高亮
            autojump = false, -- 单结果自动跳转
        },

        --[[ 标签显示配置 ]] --
        label = {
            uppercase = false, -- 允许大写标签
            exclude = "", -- 排除特定字符
            current = true, -- 显示当前窗口首个匹配标签
            after = true, -- 在匹配后显示标签
            before = false, -- 在匹配前显示标签
            style = "overlay", -- 标签样式：overlay（悬浮）/eol（行尾）/right_align（右对齐）/inline（行内）
            reuse = "lowercase", -- 标签重用策略：lowercase（小写）/all（全部）/none（不重用）
            distance = true, -- 优先显示靠近光标的标签
            min_pattern_length = 0, -- 显示标签的最小模式长度
            rainbow = { -- 彩虹标签（用于Treesitter范围可视化）
                enabled = false, -- 默认关闭
                shade = 5, -- 颜色深度（1-9）
            },
        },


        --[[ 高亮配置 ]] --
        highlight = {
            backdrop = true, -- 显示背景遮罩
            matches = true, -- 高亮匹配项
            priority = 5000, -- 高亮优先级
            groups = { -- 高亮组配置
                match = "FlashMatch", -- 匹配项高亮
                current = "FlashCurrent", -- 当前匹配项
                backdrop = "FlashBackdrop", -- 背景遮罩
                label = "FlashLabel", -- 标签高亮
            },
        },


        --[[ 模式专用配置 ]] --
        modes = {
            search = { -- 常规搜索模式
                enabled = false, -- 默认不启用（需手动切换）
                highlight = { backdrop = false },
                jump = { history = true, register = true, nohlsearch = true },
            },
            char = {                                     -- f/t/F/T 增强模式
                enabled = true,
                multi_line = true,                       -- 跨行匹配
                label = { exclude = "hjkliardc" },       -- 禁用的标签字符
                keys = { "f", "F", "t", "T", ";", "," }, -- 触发键
                jump_labels = true,                      -- 是否显示跳转标签
                autohide = false,                        -- 无标签时自动隐藏
                search = { wrap = false },
            },
            treesitter = { -- Treesitter模式
                labels = "abcdefghijklmnopqrstuvwxyz",
                jump = { pos = "range", autojump = true },
                label = { before = true, after = true, style = "inline" },
            },
            remote_op = {       -- 远程操作模式
                restore = true, -- 操作后恢复窗口状态
                motion = false, -- 是否启用新动作
            },
        },

        --[[ 提示窗口配置 ]] --
        prompt = {
            enabled = true, -- 启用提示窗口
            prefix = { { "🛸", "FlashPromptIcon" } }, -- 提示前缀
            win_config = { -- 窗口位置
                relative = "editor",
                width = 1, -- 宽度占满编辑器
                height = 1,
                row = -1, -- 底部显示
                col = 0,
                zindex = 1000,
            },
        },

        --[[ 高级功能 ]] --
        action = nil, -- 自定义跳转动作
        pattern = "", -- 初始匹配模式
        continue = false, -- 继续上次搜索
        config = nil, -- 动态配置函数
    },
}
