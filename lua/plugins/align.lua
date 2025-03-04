return {
    'Vonr/align.nvim',
    branch = "v2",
    lazy = true,
    init = function()
        local NS = { noremap = true, silent = true } -- 通用按键配置

        -- 可视化模式映射
        -- 按1个字符对齐（默认左对齐）
        vim.keymap.set('x', 'aa', function()
            require 'align'.align_to_char({ length = 1 })
        end, NS)

        -- 按2个字符对齐（带预览）
        vim.keymap.set('x', 'ad', function()
            require 'align'.align_to_char({
                preview = true,
                length = 2, -- 对齐两个连续字符
            })
        end, NS)

        -- 按字符串对齐（非正则，带预览）
        vim.keymap.set('x', 'aw', function()
            require 'align'.align_to_string({
                preview = true,
                regex = false, -- 普通字符串匹配
            })
        end, NS)

        -- 按正则表达式对齐（带预览）
        vim.keymap.set('x', 'ar', function()
            require 'align'.align_to_string({
                preview = true,
                regex = true, -- 使用Vim正则表达式
            })
        end, NS)

        -- 普通模式映射
        -- 操作符模式：gaw 对齐段落到字符串（带预览）
        vim.keymap.set('n', 'gaw', function()
            local a = require 'align'
            a.operator(a.align_to_string, {
                regex = false,
                preview = true,
            })
        end, NS)

        -- 操作符模式：gaa 对齐段落到单个字符
        vim.keymap.set('n', 'gaa', function()
            local a = require 'align'
            a.operator(a.align_to_char) -- 默认长度1
        end, NS)

        -- 可选：添加更多自定义对齐规则
        -- 例如对齐等号（带预览）
        -- vim.keymap.set('x', '<Leader>=', function()
        --     require'align'.align_to_string({
        --         preview = true,
        --         pattern = '=',  -- 指定对齐字符
        --     })
        -- end, NS)
    end
}
