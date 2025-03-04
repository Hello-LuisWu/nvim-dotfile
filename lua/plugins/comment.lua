return {
    'numToStr/Comment.nvim',
    config = function()
        local comment = require("Comment")
        -- 配置 comment.nvim
        comment.setup({
            -- 基础配置
            padding = true, -- 在注释符号和内容之间添加空格（例如 "// 内容" vs "//内容"）
            sticky = true,  -- 注释后保持光标位置不变（NORMAL 模式下有效）
            ignore = "^$",  -- 忽略空行（不注释空行）

            -- 快捷键映射配置
            toggler = {
                line = "<C-\\>",      -- NORMAL 模式：切换单行注释（默认：gcc）
                block = "<leader>\\", -- NORMAL 模式：切换块注释（默认：gbc）
            },
            opleader = {
                line = "<C-\\>",      -- NORMAL/VISUAL 模式：操作符模式行注释（默认：gc + 文本对象）
                block = "<leader>\\", -- NORMAL/VISUAL 模式：操作符模式块注释（默认：gb + 文本对象）
            },
            extra = {
                above = "gcO", -- 在当前行上方插入注释并进入 INSERT 模式
                below = "gco", -- 在当前行下方插入注释并进入 INSERT 模式
                eol = "gcA",   -- 在行尾插入注释并进入 INSERT 模式
            },

            -- 映射启用配置
            mappings = {
                basic = true, -- 启用基础快捷键（gc/gb/gcc/gbc 等）
                extra = true, -- 启用额外快捷键（gcO/gco/gcA）
            },
            ---Function to call before (un)comment
            --  pre_hook = nil,
            ---Function to call after (un)comment
            post_hook = nil,
        --     pre_hook = function(ctx)
        --         -- 如果是 JSON 文件，强制使用 '//' 注释
        --         if vim.bo.filetype == "json" then
        --             return {
        --                 line = "//%s", -- 单行注释符号（%s 表示注释内容占位）
        --                 block = nil    -- JSON 不支持块注释
        --             }
        --         end
        --     end,
        })
        -- 手动设置 JSON 的注释符号（覆盖默认配置）
       local ft = require("Comment.ft")

        -- 设置 JSON 和 JSONC 的注释符号
  --      ft.set("json", "//%s")                -- 纯 JSON 用单行注释
       ft.set("jsonc", { "//%s", "/*%s*/" }) -- JSONC 支持行和块注释



        -- 自动识别 .json 为 jsonc（可选）
        vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
            pattern = "*.json",
            callback = function()
                vim.bo.filetype = "jsonc"
            end,
        })
    end
}
