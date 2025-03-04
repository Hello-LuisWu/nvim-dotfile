return {
    "nvim-lualine/lualine.nvim",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    }, -- 图标依赖
    -- event = { "BufReadPre", "BufNewFile" }, -- 在打开文件时加载
    event = "VeryLazy",
    opts = function(_, opts)
        local trouble = require("trouble")
        local symbols = trouble.statusline({
            mode = "lsp_document_symbols",
            groups = {},
            title = false,
            filter = { range = true },
            format = "{kind_icon}{symbol.name:Normal}",
            -- The following line is needed to fix the background color
            -- Set it to the lualine section you want to use
            hl_group = "lualine_c_normal",
        })
        table.insert(opts.sections.lualine_c, {
            symbols.get,
            cond = symbols.has,
        })
    end,
    opts = {
        --[[ 全局配置选项 ]] --
        options = {
            theme = "auto", -- 自动匹配当前配色方案 (可指定为 'tokyonight'/'dracula' 等)
            component_separators = { left = "", right = "" }, -- 组件分隔符 (例: |)
            section_separators = { left = "", right = "" }, -- 区块分隔符 
            disabled_filetypes = { -- 禁用状态栏的文件类型
                "alpha", -- 启动界面
                "neo-tree", -- 文件树
                "toggleterm", -- 终端
            },
            globalstatus = true, -- 全局状态栏模式 (单状态栏)
            refresh = { -- 刷新频率配置
                statusline = 1000, -- 主状态栏刷新间隔 (ms)
                tabline = 1000, -- 标签栏刷新间隔
                winbar = 1000, -- 窗口栏刷新间隔
            }
        },
        --[[ 活动窗口状态栏 ]] --
        sections = {
            -- 左侧区块 (从右到左)
            lualine_a = {                     -- 模式显示区块
                {
                    "mode",                   -- 显示当前模式 (NORMAL/INSERT/VISUAL)
                    -- fmt = function(str) return " " .. str end, -- 添加图标前缀
                    color = { gui = "bold" }, -- 文字加粗
                    --           separator = { right = "" }, -- 右侧分隔符
                }
            },
            lualine_b = { -- 版本控制区块
                {
                    "branch", -- Git 分支显示
                    icon = "", -- 分支图标
                },
            },
            lualine_c = { -- 中央信息区块
                {
                    "filename",
                    path = 1, -- 文件名 (0=仅名称, 1=显示路径)
                    icon = '', -- 文件图标
                    color = function()
                        if vim.bo.readonly then
                            return { fg = '#ff0000', bg = '#222222', gui = 'bold' } -- 只读文件时，变红色加粗
                        end
                    end,
                    -- icon = "",
                    symbols = {
                        modified = '●', -- 文件未保存时显示
                        readonly = '' -- 只读文件标识
                    }
                },
                {
                    "diagnostics", -- LSP 诊断信息
                    sources = { "nvim_lsp" }, -- 诊断源
                    -- sources = { "nvim_diagnostic" }, -- 诊断源
                    sections = { "error", "warn", "info", "hint" }, -- 显示类型
                    symbols = {
                        error = "✘  ", -- 错误 (Nerd Font 图标)
                        warn = "⚠ ", -- 警告
                        info = "» ", -- 信息
                        hint = "⚑ ", -- 提示
                    },
                    colors = { -- 诊断颜色
                        error = "#FF6C6B", -- 红色
                        warn = "#ECBE7B", -- 黄色
                        info = "#7EB3C9", -- 蓝色
                        hint = "#98be65", -- 绿色
                    },
                    -- colored = true, -- 启用颜色编码
                    update_in_insert = false, -- 插入模式不更新
                    color = function()
                        local errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
                        if errors > 0 then
                            return { fg = '#ff0000', bg = '#222222' } -- 有错误时，使用红色
                        else
                            return { fg = '#00ff00', bg = '#222222' } -- 无错误时，使用绿色
                        end
                    end,
                },
                -- { "neo-tree", color = { fg = "#61afef" } },
            },

            -- 右侧区块 (从左到右)
            lualine_x = { -- 文件信息区块
                {
                    "diff", -- Git 变更状态
                    symbols = {
                        added = " ", -- 新增文件
                        modified = " ", -- 修改文件
                        removed = " ", -- 删除文件
                    },
                    colored = true, -- 启用颜色显示
                },
                -- {
                --     function()
                --         local current_line = vim.fn.line(".")
                --         local total_lines = vim.fn.line("$")
                --         local chars = { "██", "▇▇", "▆▆", "▅▅", "▄▄", "▃▃", "▂▂", "▁▁", " " }
                --         local line_ratio = current_line / total_lines
                --         local index = math.ceil(line_ratio * #chars)
                --         return chars[index]
                --     end
                -- }, -- 进度 (行号/列号)

                {
                    "filetype",       -- 文件类型
                    icon_only = true, -- 仅显示图标
                    colored = true,   -- 颜色显示
                },
            },
            lualine_y = { -- 光标信息区块
                {
                    "fileformat", -- 文件格式
                    symbols = {
                        unix = "", -- UNIX (LF)
                        dos = "", -- Windows (CRLF)
                        mac = "", -- Mac (CR)
                    },
                },
                {
                    "encoding",         -- 文件编码
                    -- icon = "", -- 编码图标
                    fmt = string.upper, -- 显示大写 (UTF-8 → UTF-8)
                },
            },
            lualine_z = {      -- 时间区块
                {
                    function() -- 自定义时间函数
                        -- 中文星期映射表
                        local weekday_map = { "天", "一", "二", "三", "四", "五", "六" }
                        local time = os.date("*t")
                        return string.format(
                            "%02d/%02d 星期%s %02d:%02d", -- 格式: 月日星期 时间
                            time.month,
                            time.day,
                            weekday_map[time.wday],
                            time.hour,
                            time.min
                        )
                    end,
                    --icon = "", -- 时钟图标
                    -- separator = { left = "" }, -- 左侧分隔符
                    -- color = { fg = "#7EB3C9", bg = "#1E1E2E" }, -- 颜色配置
                }
            }
        },

        --[[ 非活动窗口状态栏 ]] --
        inactive_sections = {
            lualine_c = { { "filename", path = 1, color = { fg = "#7F7F7F" } } }, -- 灰色文件名
            lualine_x = { "location" }, -- 仅显示位置
        },

        --[[ 扩展配置 ]] --
        extensions = { "neo-tree", "toggleterm", "lazy" } -- 支持插件集成
    },
}
