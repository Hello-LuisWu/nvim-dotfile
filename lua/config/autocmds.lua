vim.api.nvim_create_user_command("MakeDirectory", function()
    ---@diagnostic disable-next-line: missing-parameter
    local path = vim.fn.expand("%")
    local dir = vim.fn.fnamemodify(path, ":p:h")
    if vim.fn.isdirectory(dir) == 0 then
        vim.fn.mkdir(dir, "p")
    else
        vim.notify("Directory already exists", "WARN", { title = "Nvim" })
    end
end, { desc = "Create directory if it doesn't exist" })

vim.api.nvim_create_autocmd("FileType", {
    pattern = { "python", "lua" },
    callback = function()
        vim.opt_local.cindent = false -- 关闭 C 风格缩进
    end,
})


-- 插入模式显示绝对行号，
vim.api.nvim_create_autocmd({ "InsertEnter" }, {
    pattern = { "*" },
    callback = function()
        vim.opt.relativenumber = false
        vim.opt.cursorline = false
        vim.opt.number = true
    end,
})
-- 离开插入模式显示相对行号
vim.api.nvim_create_autocmd({ "InsertLeave" }, {
    pattern = { "*" },
    callback = function()
        vim.opt.relativenumber = true
        vim.opt.cursorline = true
        vim.opt.number = true
    end,
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = { "markdown", "tex" },       -- 针对 Markdown 和 LaTeX 文件
    callback = function()
        vim.opt_local.wrap = true          -- 自动折行
        vim.opt_local.spell = true         -- 启用拼写检查
        vim.opt_local.spelllang = { "en" } -- 设置拼写检查语言
        vim.opt_local.conceallevel = 2
        vim.opt_local.concealcursor = "v"
    end,
})

-- Python 文件配置
vim.api.nvim_create_autocmd("FileType", {
    group = group,
    pattern = "python",
    callback = function()
        vim.opt_local.shiftwidth = 4 -- 缩进 4 空格
        vim.opt_local.tabstop = 4
        vim.opt_local.textwidth = 88 -- PEP8 推荐行长度
    end,
})

-- vim Options
local abbreviations = {
    qml = "1014150883@qq.com",
    gml = "luiswuking@gmail.com",
    qqq = "1014150884",
    wxn = "LuisWu-35",
    phe = "18755141108",
}

for key, value in pairs(abbreviations) do
    vim.cmd("ab " .. key .. " " .. value)
end

-- 换行不要延续注释
vim.api.nvim_create_autocmd({ "BufEnter" }, {
    pattern = { "*" },
    callback = function()
        vim.opt.formatoptions = vim.opt.formatoptions - { "c", "r", "o" }
    end,
})

-- 高亮复制区域
vim.api.nvim_create_autocmd({ "TextYankPost" }, {
    pattern = { "*" },
    callback = function()
        vim.highlight.on_yank({
            timeout = 300,
        })
    end,
})

-- 重新打开缓冲区恢复光标位置
vim.api.nvim_create_autocmd("BufReadPost", {
    pattern = "*",
    callback = function()
        if vim.fn.line("'\"") > 0 and vim.fn.line("'\"") <= vim.fn.line("$") then
            vim.fn.setpos(".", vim.fn.getpos("'\""))
            vim.cmd("silent! foldopen")
        end
    end,
})

-- 离开插入模式 时关闭粘贴模式
vim.api.nvim_create_autocmd("InsertLeave", {
    pattern = "*",
    command = "set nopaste",
})

local group = vim.api.nvim_create_augroup("MyAutoCmds", { clear = true })

-- -- 保存时自动格式化（需安装 LSP 或格式化工具）
-- vim.api.nvim_create_autocmd("BufWritePre", {
--     group = group,
--     pattern = "*",
--     callback = function()
--         vim.lsp.buf.format({ async = false }) -- 同步格式化（需已配置 LSP）
--     end,
-- })


vim.api.nvim_create_autocmd("FileType", {
    group = group,
    pattern = "python",
    callback = function()
        vim.opt_local.shiftwidth = 4 -- Python 使用 4 空格缩进
        vim.opt_local.tabstop = 4
    end,
})
