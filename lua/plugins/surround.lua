return {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
        require("nvim-surround").setup({
            -- 配置插件的键映射
            keymaps = {
                -- 插入模式下的键映射
                insert = "<C-g>s",       -- 在插入模式下添加围绕符号
                insert_line = "<C-g>S",  -- 在插入模式下添加跨行围绕符号
                -- 正常模式下的键映射
                normal = "ys",           -- 在正常模式下用"ys"进行围绕操作
                normal_cur = "yss",      -- 在当前行进行围绕
                normal_line = "yS",      -- 在正常模式下进行跨行围绕
                normal_cur_line = "ySS", -- 在当前行进行跨行围绕
                -- 可视模式下的键映射
                visual = "D",            -- 可视模式下添加围绕符号
                visual_line = "gS",      -- 可视行模式下进行跨行围绕
                -- 删除操作
                delete = "ds",           -- 删除围绕符号
                -- 更改围绕符号
                change = "cs",           -- 更改围绕符号
                change_line = "cS",      -- 跨行更改围绕符号
            },

            -- 配置围绕的符号
            surrounds = {
                ["*"] = { add = { "*", "*" } },     -- 配置markdown 单星号围绕(斜体)
                ["2"] = { add = { "**", "**" } },   -- 配置markdown 双星号围绕(粗体)
                ["3"] = { add = { "***", "***" } }, -- 配置markdown 三星号围绕(写粗体)
                ["("] = { add = { "(", ")" } },     -- 配置圆括号围绕
                [")"] = { add = { "(", ")" } },     -- 配置圆括号围绕
                ["{"] = { add = { "{", "}" } },     -- 配置花括号围绕
                ["}"] = { add = { "{", "}" } },     -- 配置花括号围绕
                ["["] = { add = { "[", "]" } },     -- 配置方括号围绕
                ["]"] = { add = { "[", "]" } },     -- 配置方括号围绕
                ["<"] = { add = { "<", ">" } },     -- 配置尖括号围绕
                [">"] = { add = { "<", ">" } },     -- 配置尖括号围绕
                ["'"] = { add = { "'", "'" } },     -- 配置单引号围绕
                ['"'] = { add = { '"', '"' } },     -- 配置双引号围绕
                ["`"] = { add = { "`", "`" } },     -- 配置反引号围绕
                ["t"] = {                           -- 配置 HTML 标签围绕
                    add = function()
                        local config = require("nvim-surround.config")
                        local result = config.get_input("Enter the tag name: ")
                        if result then
                            return { { "<" .. result .. ">" }, { "</" .. result .. ">" } }
                        end
                    end
                },
                ["f"] = { -- 配置函数调用围绕
                    add = function()
                        local config = require("nvim-surround.config")
                        local result = config.get_input("Enter the function name: ")
                        if result then
                            return { { result .. "(" }, { ")" } }
                        end
                    end
                },
            },

            -- 配置别名
            aliases = {
                ["s"] = ">",                                   -- 配置"a"代表"("，用于别名
                ["b"] = ")",                                   -- 配置"b"代表")"
                ["B"] = "}",                                   -- 配置"B"代表"}"
                ["r"] = "]",                                   -- 配置"r"代表"]"
                ["q"] = { '"', "'", "`" },                     -- 配置"q"代表引号字符（双引号、单引号、反引号）
                ["a"] = { "}", "]", ")", ">", '"', "'", "`" }, -- 配置"s"代表多个符号
            },

            -- 配置高亮
            highlight = {
                duration = 200, -- 配置高亮持续时间（毫秒）
            },

            -- 配置光标移动行为
            move_cursor = "begin", -- 配置围绕操作后光标移到围绕的开始位置
            -- move_cursor = "sticky",         -- 配置光标“粘住”当前字符随文本移动
            -- move_cursor = false,            -- 配置光标不移动

            -- 配置行缩进
            indent_lines = function(start, stop)
                local b = vim.bo
                -- 仅在已有格式化器时才进行缩进
                if start < stop
                    and (b.equalprg ~= ""
                        or b.indentexpr ~= ""
                        or b.cindent
                        or b.smartindent
                        or b.lisp) then
                    vim.cmd(string.format("silent normal! %dG=%dG", start, stop))
                end
            end,
        })
        -- 导入 keymap 工具函数
        -- local keymap = vim.keymap.set

        -- -- "正常模式" (Normal Mode)
        -- -- [ hjbrlhsgfbhhjlsdhvbhg ]
        -- keymap("n", "<CR>a",
        --     "<Plug>(nvim-surround-normal)",
        --     { desc = "[S]urround [A]dd: 添加环绕符号（需配合文本对象，如 saiw= 给单词加等号）" })

        -- keymap(
        --     "n",
        --     "<CR>d",
        --     "<Plug>(nvim-surround-delete)",
        --     { desc = "[S]urround [D]elete: 删除环绕符号" }
        -- )
        -- keymap(
        --     "n",
        --     "<CR>r",
        --     "<Plug>(nvim-surround-change)",
        --     { desc = "[S]urround [R]eplace: 修改环绕符号" }
        -- )
        -- keymap(
        --     "n",
        --     "<CR>rl",
        --     "<Plug>(nvim-surround-change-line)",
        --     { desc = "[S]urround [R]eplace [L]ine: 修改环绕符号（行模式）" }
        -- )

        -- -- 视觉模式 (Visual Mode)
        -- keymap(
        --     "x",
        --     "<CR>s",
        --     "<Plug>(nvim-surround-visual)",
        --     { desc = "[S]urround 添加环绕符号（视觉模式选择内容后使用）" }
        -- )
        -- keymap(
        --     "x",
        --     "<CR>S",
        --     "<Plug>(nvim-surround-visual-line)",
        --     { desc = "[S]urround [L]ine: 添加环绕符号（行模式）" }
        -- )

        -- -- 插入模式 (Insert Mode)
        -- keymap("i",
        --     "<C-s>",
        --     "<Plug>(nvim-surround-insert)",
        --     { desc = "插入模式快速添加环绕符号（如输入 <C-s>' 添加单引号）" })
        -- keymap("i",
        --     "<C-s><C-s>",
        --     "<Plug>(nvim-surround-insert-line)",
        --     { desc = "插入模式添加多行环绕符号（如输入 <C-s><C-s>{ 添加花括号）" })
    end
}
