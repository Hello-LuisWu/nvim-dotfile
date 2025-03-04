return {
    'akinsho/bufferline.nvim',
    event = "VeryLazy",
    keys = {
        { "<leader><tab>p", "<cmd>BufferLineTogglePin<cr>", desc = "固定/取消固定缓冲区" },
        { "<leader><tab>c", "<cmd>BufferLinePicqkClosekClose<cr>", desc = "选择并关闭缓冲区" },
        { "<leader><tab>h", "<cmd>BufferLineCyclePrev<cr>", desc = "切换到上一个缓冲区" },
        { "<leader><tab>l", "<cmd>BufferLineCycleNext<cr>", desc = "切换到下一个缓冲区" },
        { "<leader><tab>1", "<cmd>BufferLineGoToBuffer 1<cr>", desc = "切换到第一个缓冲区" },
        { "<leader><tab>2", "<cmd>BufferLineGoToBuffer 2<cr>", desc = "切换到第二个缓冲区" },
        { "<leader><tab>3", "<cmd>BufferLineGoToBuffer 3<cr>", desc = "切换到第三个缓冲区" },
        { "<leader><tab>4", "<cmd>BufferLineGoToBuffer 4<cr>", desc = "切换到第四个缓冲区" },
        { "<leader><tab>5", "<cmd>BufferLineGoToBuffer 5<cr>", desc = "切换到第五个缓冲区" },
        { "<leader><tab>6", "<cmd>BufferLineGoToBuffer 6<cr>", desc = "切换到第六个缓冲区" },
        { "<leader><tab>7", "<cmd>BufferLineGoToBuffer 7<cr>", desc = "切换到第七个缓冲区" },
        { "<leader><tab>8", "<cmd>BufferLineGoToBuffer 8<cr>", desc = "切换到第八个缓冲区" },
        { "<leader><tab>9", "<cmd>BufferLineGoToBuffer 9<cr>", desc = "切换到第九个缓冲区" },
        { "<leader><tab>$", "<cmd>BufferLineGoToBuffer -1<cr>", desc = "切换到最后一个缓冲区" },
    },
    -- version = "*",
    tag = "v4.9.1",
    -- enable = false,
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = function()
        local bufferline = require("bufferline") -- ✅ 正确方式
        bufferline.setup({
            options = {
                -- 模式设置，可选 "buffers" 或 "tabs"（显示标签页）
                mode = "buffers",

                -- 样式预设，可选 default/minimal 或自定义组合
                style_preset = bufferline.style_preset.default,

                -- 是否允许主题覆盖高亮组（设置为 true 可自定义主题）
                themable = true,

                -- 缓冲区编号显示方式（"none" | "ordinal" | "buffer_id" | "both" | 自定义函数）
                numbers = "ordinal",
                -- numbers = function(opts)
                --     return string.format('%s·%s', opts.ordinal, opts.id)
                -- end,

                -- 关闭缓冲区命令（支持字符串格式或函数）
                close_command = "bdelete! %d",

                -- 鼠标右键命令（支持字符串格式或函数）
                right_mouse_command = "bdelete! %d",

                -- 鼠标左键命令（默认跳转缓冲区）
                left_mouse_command = "buffer %d",

                -- 鼠标中键命令（默认 nil）
                middle_mouse_command = nil,

                -- 指示器样式（图标样式或下划线）
                indicator = {
                    icon = '▎', -- 图标样式时的符号
                    style = 'icon' -- 可选 'icon' | 'underline' | 'none'
                },

                -- 图标配置
                buffer_close_icon = '󰅖', -- 关闭按钮图标
                modified_icon = '●', -- 已修改文件图标
                close_icon = '', -- 关闭区域图标
                left_trunc_marker = '', -- 左侧截断标记
                right_trunc_marker = '', -- 右侧截断标记

                name_formatter = function(buf)
                    return buf.name:gsub('^%./', '')
                end,

                -- 显示限制
                max_name_length = 18,   -- 最大名称长度
                max_prefix_length = 15, -- 去重前缀最大长度
                truncate_names = true,  -- 是否截断长名称

                -- 标签尺寸
                tab_size = 18,

                -- lsp 诊断集成（false | "nvim_lsp" | "coc"）
                diagnostics = false,
                diagnostics_update_in_insert = false, -- 插入模式更新诊断（仅 coc）
                diagnostics_update_on_event = true,   -- use nvim's diagnostic handler
                diagnostics_indicator = function(count, level)
                    -- local icon = level:match("error") and " " or " "
                    -- return icon .. count
                    return "(" .. count .. ")"
                end,

                -- 侧边栏偏移配置（如 nvimtree）
                offsets = {
                    {
                        filetype = "neo-tree",
                        text = "File Explorer", -- 自定义显示的文本
                        text_align = "left",    -- 文本对齐方式
                        separator = true,       -- 显示分隔线
                    }
                },

                -- 图标显示控制
                color_icons = true,             -- 是否彩色显示文件类型图标
                show_buffer_icons = true,       -- 显示缓冲区图标
                show_buffer_close_icons = true, -- 显示缓冲区关闭按钮
                show_close_icon = true,         -- 显示右侧关闭按钮

                -- 名称格式化函数（自定义缓冲区显示名称）
                -- 标签页指示器
                show_tab_indicators = true,

                -- 分组配置
                groups = {
                    options = {
                        toggle_hidden_on_enter = true -- 进入隐藏组时自动展开
                    },
                    items = {
                        {
                            name = "测试文件",
                            matcher = function(buf)
                                return buf.name:match('%_test')
                            end,
                            priority = 2,
                            icon = ""
                        }
                    }
                },

                -- 分隔符样式（支持预设或自定义字符）
                separator_style = "slope", -- 可选 "slope" | "thick" | "thin" 或 {"|", "|"}

                -- 强制等宽标签（禁用去重）
                enforce_regular_tabs = true,

                -- 始终显示 bufferline
                always_show_bufferline = true,

                -- 鼠标悬停事件配置（需要 neovim 0.8+）
                hover = {
                    enabled = true,
                    delay = 200,
                    reveal = { 'close' }
                },

                -- 排序方式（支持函数自定义）
                sort_by = 'insert_after_current', -- 可选 'id' | 'extension' | 'directory' 等

                -- 快速选择配置
                pick = {
                    alphabet = "abcdefghijklmnopqrstuvwxyz1234567890" -- 选择快捷键字符集
                },

                -- 自定义区域（右上角显示诊断信息）
                -- custom_areas = {
                --     right = function()
                --         local result = {}
                --         local seve = vim.diagnostic.severity
                --         local error = #vim.diagnostic.get(0, { severity = seve.ERROR })
                --         local warning = #vim.diagnostic.get(0, { severity = seve.WARN })
                --         local info = #vim.diagnostic.get(0, { severity = seve.INFO })
                --         local hint = #vim.diagnostic.get(0, { severity = seve.HINT })

                --         if error ~= 0 then
                --             table.insert(result, { text = "  " .. error, link = "DiagnosticError" })
                --         end

                --         if warning ~= 0 then
                --             table.insert(result, { text = "  " .. warning, link = "DiagnosticWarn" })
                --         end

                --         if hint ~= 0 then
                --             table.insert(result, { text = "  " .. hint, link = "DiagnosticHint" })
                --         end

                --         if info ~= 0 then
                --             table.insert(result, { text = "  " .. info, link = "DiagnosticInfo" })
                --         end
                --         return result
                --     end
                -- },

            },
        })
    end,

}
