return {
    'akinsho/toggleterm.nvim',
    version = "*",
    config = function()
        require("toggleterm").setup({
            -- 基础设置
            size = function(term)
                -- 根据终端方向动态调整尺寸
                if term.direction == "horizontal" then
                    return 15
                elseif term.direction == "vertical" then
                    return vim.o.columns * 0.4 -- 占用 40% 的屏幕宽度
                else
                    return 20    -- 浮动终端默认尺寸
                end
            end,
            open_mapping = [[<c-t>]], -- 打开/关闭终端的快捷键
            direction = "float", -- 默认方向（float/vertical/horizontal/tab）
            close_on_exit = true, -- 进程退出时自动关闭终端
            shell = vim.o.shell, -- 使用系统默认 shell（Windows 可设置为 "pwsh.exe"）
            auto_scroll = true, -- 自动滚动到底部
            float_opts = {
                border = "double", -- 浮动窗口边框样式
                width = 120, -- 浮动终端宽度
                height = 40, -- 浮动终端高度
                winblend = 3, -- 窗口透明度（0-100）
            },

            -- 外观设置
            highlights = {
                FloatBorder = {
                    guifg = "#8B8000", -- 浮动终端边框颜色
                },
            },
            shade_terminals = false, -- 禁用终端背景变暗
            start_in_insert = true, -- 打开终端时自动进入插入模式

            -- 功能设置
            persist_size = true, -- 记住终端尺寸
            persist_mode = true, -- 记住终端模式
            insert_mappings = true, -- 在插入模式启用快捷键
            terminal_mappings = true -- 在终端模式启用快捷键
        })

        -- 自定义终端示例：LazyGit
        local Terminal = require('toggleterm.terminal').Terminal
        local lazygit = Terminal:new({
            cmd = "lazygit", -- 需要先安装 lazygit
            hidden = true, -- 不在常规终端列表中显示
            direction = "float", -- 使用浮动窗口
            float_opts = {
                border = "curved", -- 曲线边框
                width = 160,
                height = 40,
            },
            on_open = function(term)
                vim.cmd("startinsert!") -- 打开时进入插入模式
                vim.api.nvim_buf_set_keymap(
                    term.bufnr,
                    "t",
                    "<ESC>",
                    "<cmd>close<CR>",
                    { noremap = true, silent = true }
                ) -- 按 ESC 关闭窗口
            end,
        })
    end
}
