return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    dependencies = {
        'nvim-tree/nvim-web-devicons',
        'echasnovski/mini.icons',
    },
    config = function()
        -- 引入 which-key 插件
        local wk = require("which-key")
        wk.setup({
            -- 布局预设："classic"经典/"modern"现代/"helix"螺旋
            preset = "modern",
            -- 延迟显示时间（单位ms），可以是函数动态计算
            delay = function(ctx)
                return ctx.plugin and 0 or 0 -- 插件映射立即显示，其他延迟0ms
            end,

            -- 自定义过滤器，用于过滤没有描述的映射
            filter = function(mapping)
                -- return mapping.desc and mapping.desc ~= ""
                return true
            end,

            -- 映射补充/覆盖
            spec = {
            },
            notify = true, -- 检测到映射问题时显示通知

            --[[ 触发器配置 ]] --
            triggers = {
                { "<auto>", mode = "nixsotc" }, -- 自动检测所有模式
                -- 补充触发器
                { "g",      mode = "n" }, -- 普通模式的g键
                { "z",      mode = "n" }, -- 普通模式的z键
                { "y",      mode = "n" }, -- 普通模式的y键
                { "d",      mode = "n" }, -- 普通模式的d键
                { "c",      mode = "n" }, -- 普通模式的c键
            },

            -- 视觉模式延迟触发配置
            defer = function(ctx)
                return ctx.mode == "V" or ctx.mode == "<C-V>" -- 行选择和块选择模式延迟触发
            end,

            --[[ 插件集成 ]] --
            plugins = {
                marks = true, -- 显示标记（'和`）
                registers = true, -- 显示寄存器（"和<C-r>）
                spelling = {
                    enabled = true, -- 拼写建议（z=）
                    suggestions = 20, -- 最多显示建议数
                },
                presets = { -- 内置预设帮助
                    operators = true, -- 操作符帮助（例如：d, y 等）
                    motions = true, -- 移动帮助（例如：w, b, j 等）
                    text_objects = true, -- 文本对象帮助
                    windows = true, -- 窗口管理帮助（例如：<C-w> 系列）
                    nav = true, -- 导航相关键帮助
                    z = true, -- z 系列（如折叠、拼写等）
                    g = true, -- g 系列的帮助
                },
            },

            win = {
                no_overlap = false,   -- 禁止弹出窗口与光标重叠
                padding = { 1, 1 },   -- 设置弹出窗口的内边距（上/下，左/右）
                title = "which key",  -- 显示窗口标题
                title_pos = "center", -- 标题位置
                zindex = 1000,        -- 设置窗口的 z-index

                bo = {
                },
                wo = {
                    winblend = 20, -- 弹窗背景0-100的不透明度，
                },
            },
            layout = {
                width = { min = 20 }, -- 最小列宽
                spacing = 9,          -- 列间距
            },
            keys = {
                scroll_down = "<c-d>", -- binding to scroll down inside the popup
                scroll_up = "<c-u>", -- binding to scroll up inside the popup
            },
            --[[ 排序规则 ]] --
            sort = { "local", "order", "group", "alphanum", "mod" }, -- 排序映射方式，按本地、顺序、组、字母数字、修饰符等排序
            -- 动态扩展配置（<=2个子项时自动展开）
            -- expand = 0,
            -- 键描述格式化规则
            replace = { -- 替换映射中的特殊字符（例如：将 `<Space>` 替换为 "SPC"）
                key = {
                    function(key)
                        return require("which-key.view").format(key)
                    end,
                },
                desc = {
                    { "<Plug>%(?(.*)%)?", "%1" }, -- 简化<Plug>显示
                    { "^%+",              "" },
                    { "<[cC]md>",         "" },   -- 去除Cmd前缀
                    { "<[cC][rR]>",       "" },
                    { "<[sS]ilent>",      "" },
                    { "^lua%s+",          "" },
                    { "^call%s+",         "" },
                    { "^:%s*",            "" },
                },
            },
            icons = {
                breadcrumb = "»", -- 路径分隔符
                -- separator = "➜", -- 键描述分隔符
                separator = " ",  -- 键描述分隔符
                group = "+",      -- 组前缀符号
                ellipsis = "…",
                mappings = true,  -- 启用图标映射
                rules = {},
                colors = true,    -- 使用mini.icons颜色
                keys = {          -- 特殊键图标映射
                    Up = " ",
                    Down = " ",
                    Left = " ",
                    Right = " ",
                    C = "󰘴 ",
                    M = "󰘵 ",
                    D = "󰘳 ",
                    S = "󰘶 ",
                    CR = "󰌑 ",
                    Esc = "󱊷 ",
                    ScrollWheelDown = "󱕐 ",
                    ScrollWheelUp = "󱕑 ",
                    NL = "󰌑 ",
                    BS = "󰁮",
                    Space = "󱁐",
                    Tab = "󰌒 ",
                    F1 = "󱊫",
                    F2 = "󱊬",
                    F3 = "󱊭",
                    F4 = "󱊮",
                    F5 = "󱊯",
                    F6 = "󱊰",
                    F7 = "󱊱",
                    F8 = "󱊲",
                    F9 = "󱊳",
                    F10 = "󱊴",
                    F11 = "󱊵",
                    F12 = "󱊶",
                },
            },
            --[[ 界面配置 ]] --
            show_help = true, -- 底部显示帮助提示
            show_keys = true, -- 显示已按的键序列

            --[[ 禁用配置 ]] --
            disable = {
                ft = { "TelescopePrompt" }, -- 在Telescope窗口禁用
                bt = { "terminal" }, -- 在终端缓冲区禁用
            },
            debug = false, -- 开启调试模式（会在当前目录生成wk.log 日志文件）
        })

        --  按键配置(空的不显示）
        wk.add({
            {
                mode = { "n", "v" },
                { "<leader>f", group = "查找", icon = "󰮗" }, -- group
                -- { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find File" },
                -- { "<leader>fb", function() print("hello") end, desc = "Foobar" },
                -- { "<leader>fn", desc = "New File" },
                { "<leader>w", group = "窗口", icon = "" },
                { "<leader>g", group = "git", icon = "" },
                { "<leader>b", group = "buffer", icon = "" },
                { "<leader>\\", desc = "块注释", icon = "󰆈" },
                { "<leader>-", desc = "yazi 文件浏览器", icon = "󰇥" },
                { "<leader>0", icon = "󰖶" },
                { "<leader>a", icon = "󰚡" },
                { "<leader>o", group = "杂项", icon = "" },
                { "<leader>m", group = "Markdown", icon = "" },
                { "<leader>t", group = "终端", icon = "" },
                { "<leader>h", group = "搜索与替换", icon = "" },
                { "<leader>x", group = "Trouble", icon = "" },
                --
            },
            {
                mode = "n",
                { "<leader>s", group = "拼写", icon = "", },
                --   kkjfzjkj tjdjnhkfkj jkdfgjk jrgzdjf
                -- kjdjrkt jzksrfgj jko;orsfgjk rzjkgj jiserbgjfj EAUIFDesa zrsfhxiop
            },
        })
    end
}
