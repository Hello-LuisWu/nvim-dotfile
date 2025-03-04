vim.g.mapleader = " "
local map = vim.keymap
local opt = { noremap = true, silent = true }
local optv = { noremap = true, silent = false }

-- 基础键位
map.set("i", "jj", "<C-[>", opt)
map.set("n", "<Tab>", ":", optv)

map.set("n", "<BS>", ":set hlsearch!<CR>", opt)
-- map.set("i", "\\\\", "<C-[>/<++><CR>:nohlsearch<CR>c4l", opt)
map.set("n", "<leader>0", ":set wrap!<CR>", { desc = "换行按钮", noremap = true, silent = true })
map.set("v", "p", "P", opt)

map.set({ "n", "v" }, "gF", "gg=G", { desc = "自动缩进", noremap = true, silent = true })

map.set({ "n", "v" }, "<leader>ss", "<cmd>set spell!<CR>", { desc = "开启/关闭拼写", noremap = true, silent = true })
map.set({ "n", "v" }, "<leader>sj", "]s", { desc = "下一个拼写错误", noremap = true, silent = true })
map.set({ "n", "v" }, "<leader>sk", "[s", { desc = "上一个拼写错误", noremap = true, silent = true })
map.set({ "n", "v" }, "<leader>sa", "zg", { desc = "将单词添加到词典", noremap = true, silent = true })
map.set({ "n", "v" }, "<leader>sc", "zw", { desc = "将单词移出词典", noremap = true, silent = true })
map.set({ "n", "v" }, "<leader>su", "zu", { desc = "撤销 zg/zw", noremap = true, silent = true })
map.set({ "n", "v" }, "<leader>su", "<cmd>spellr<CR>", { desc = "替换错误单词（自动使用第一个建议）", noremap = true, silent = true })

map.set("n", "W", "5w", opt)
map.set("n", "B", "5b", opt)

-- 普通模式,可视模式和等待操作模式下,行的首尾 & 页面的首尾跳转
map.set({ "n", "o", "v" }, "L", "$", opt)
map.set({ "n", "o", "v" }, "H", "0", opt)
map.set({ "n", "o", "v" }, "J", "G", opt)
map.set({ "n", "o", "v" }, "K", "gg", opt)

-- Buffer 管理
map.set("n", "<leader>bl>", ":bnext<CR>", { desc = "下一个 Buffer", noremap = true, silent = true }) -- 下一个 Buffer
map.set("n", "<leader>bh", ":bprevious<CR>", { desc = "上一个 Buffer", noremap = true, silent = true }) --
map.set("n", "<leader>bq", ":bd<CR>", { desc = "关闭 Buffer", noremap = true, silent = true }) -- 关闭当前 Buffer

-- 5. 快速跳转
map.set("n", "<C-f>", "<C-f>zz", opt) -- 向下翻页并居中
map.set("n", "<C-b>", "<C-b>zz", opt) -- 向上翻页并居中
map.set("n", "n", "nzzzv", opt)       -- 搜索结果时光标居中
map.set("n", "N", "Nzzzv", opt)

map.set({ "v", "x" }, "<C-j>", ":m '>+1<CR>gv=gv", opt)
map.set({ "v", "x" }, "<C-k>", ":m '<-2<CR>gv=gv", opt)
-- map.set({ "v", "x" }, "<leader><leader>", "<C-[>", opt)

map.set("v", "<", "<gv", opt)
map.set("v", ">", ">gv", opt)
map.set("v", "<S-tab>", "<gv", opt)
map.set("v", "<tab>", ">gv", opt)

map.set("n", "Y", "yiw", opt)
map.set("n", "D", "diw", opt)
map.set("n", "C", "ciw", opt)

map.set({ "i", "n", "v" }, "<Left>", "<Nop>", opt)
map.set({ "i", "n", "v" }, "<Right>", "<Nop>", opt)
map.set({ "i", "n", "v" }, "<Up>", "<Nop>", opt)
map.set({ "i", "n", "v" }, "<Down>", "<Nop>", opt)
-- map.set("i", "<Esc>", "<Nop>", opt)
map.set("n", "q:", "<Nop>", opt)

map.set("n", "j", "gj", opt)
map.set("n", "k", "gk", opt)


map.set("i", "AA", "<C-[>I", opt)
map.set("i", "LL", "<C-[>A", opt)
map.set({ "i" }, "<C-d>", "<C-[>yypA", opt)
map.set({ "n" }, "<C-d>", "<C-[>yyp", { desc = "再制", noremap = true, silent = true })

-- 在 normal 模式配置快捷键
map.set('n', '<Leader>ha', ":%s/\\<<C-r><C-w>\\>//gc<Left><Left><Left>",
    { desc = "全局替换当前单词（带确认）", noremap = true, silent = true }) -- \%V 用于匹配可视选区
map.set('n', '<Leader>hj', ':%s/<C-r><C-w>/', { desc = "全局替换当前单词（所有行）", noremap = true, silent = true })
map.set('n', '<Leader>hJ', ':%s//gc<left><left><left>', { desc = "手输全局替换（带确认）", noremap = true, silent = true }) --
map.set('n', '<Leader>hh', ':s/<C-r><C-w>//<left>', { desc = "替换当前单词（仅所选）", noremap = true, silent = true }) --

-- 在 visual 模式配置快捷键
map.set('v', '<Leader>hh', '"hy:%s/<C-r>h//g<left><left>', { desc = "全局替换全部选中文本", noremap = true, silent = true }) --
map.set('v', '<Leader>hH', '"hy:%s/<C-r>h//gc<left><left><left>',
    { desc = "全局替换全部选中文本（带确认）", noremap = true, silent = true })

-- -- （推荐保持默认的 :%s/foo/bar/gc）
-- map.set('n', '<Leader>hj', ':%s/\\%V', { desc = "带确认的逐项替换" , noremap = true, silent = true }) -- \%V 用于匹配可视选区

-- --
map.set('n', '<Leader>hw', [[:let @/ = '\<'.expand('<cword>').'\>'<bar>set hlsearch<CR>]],
    { desc = "查找高亮当前单词", noremap = true, silent = true })


-- 窗口间的跳转
map.set("n", "<C-h>", "<C-w>h", opt)
map.set("n", "<C-j>", "<C-w>j", opt)
map.set("n", "<C-k>", "<C-w>k", opt)
map.set("n", "<C-l>", "<C-w>l", opt)

-- 13. 透明背景切换（适配你的高亮配置）
map.set("n", "<leader>tt", ":lua ToggleTransparency()<CR>", opt)
function ToggleTransparency()
    local hl = vim.api.nvim_set_hl
    hl(0, "Normal", { fg = "#ffffff", bg = "NONE" })
    hl(0, "NormalNC", { bg = "NONE" })
end

map.set("n", "<leader>wc", "<cmd>close<CR>", { desc = "关闭窗口", noremap = true, silent = true })
map.set("n", "<leader>wo", "<cmd>only<CR>", { desc = "关闭其他窗口", noremap = true, silent = true })
map.set("n", "<leader>ws", "<cmd>vsplit<CR>", { desc = "垂直分屏", noremap = true, silent = true })
map.set("n", "<leader>wS", "<cmd>split<CR>", { desc = "水平分屏", noremap = true, silent = true })
map.set("n", "<leader>wh", "<C-w>H", { desc = "将窗口移到最左边", noremap = true, silent = true })
map.set("n", "<leader>wl", "<C-w>L", { desc = "将窗口移到最右边", noremap = true, silent = true })
map.set("n", "<leader>wk", "<C-w>K", { desc = "将窗口移到最上边", noremap = true, silent = true })
map.set("n", "<leader>wj", "<C-w>J", { desc = "将窗口移到最下边", noremap = true, silent = true })
map.set("n", "<leader>w=", "<C-w>=", { desc = "窗口等宽高", noremap = true, silent = true })
map.set("n", "<leader>wn", "<C-w>n", { desc = "新建空白窗口", noremap = true, silent = true })
map.set("n", "<leader>wc", "<cmd>cd %:p:h<CR><cmd>echo getcwd()<CR>",
    { desc = "进入当前文件所在目录", noremap = true, silent = true })
map.set("n", "<leader>wr", ":Rename<space>", { desc = "重命名文件", noremap = true, silent = false })

vim.api.nvim_create_user_command("Rename", function(opts)
    local old_name = vim.fn.expand("%")
    local new_name = opts.args
    if new_name == "" then
        print("Error: 需要提供新文件名")
        return
    end
    vim.cmd("write")                -- 确保文件已保存
    os.rename(old_name, new_name)
    vim.cmd("edit " .. new_name)    -- 重新打开文件
    vim.cmd("bdelete " .. old_name) -- 关闭旧 Buffer
    print("文件已重命名: " .. old_name .. " -> " .. new_name)
end, { nargs = 1 })

-- 复制粘贴
map.set({ "n" }, "<leader>aa", "ggVG", { desc = "全选", noremap = true, silent = false })
map.set({ "n", "v" }, "<C-s>", "<cmd>w<CR>", { desc = "保存", noremap = true, silent = true })
map.set({ "v" }, "<C-c>", '"+y', { desc = "复制", noremap = true, silent = true })
-- map.set({ "v", "n" }, "<C-v>", '"+p', { desc = "粘贴", noremap = true, silent = true })
map.set("i", "<C-v>", '<Esc>"+pa', { desc = "粘贴", noremap = true, silent = true })

-- 调整窗口大小（Shift + 方向键）
map.set("n", "<S-Left>", ":vertical resize -5<CR>", { desc = "向左调整窗口宽度", noremap = true, silent = true })
map.set("n", "<S-Right>", ":vertical resize +5<CR>", { desc = "向右调整窗口宽度", noremap = true, silent = true })
map.set("n", "<S-Up>", ":resize -5<CR>", { desc = "向上调整窗口高度", noremap = true, silent = true })
map.set("n", "<S-Down>", ":resize +5<CR>", { desc = "向下调整窗口高度", noremap = true, silent = true })

map.set("i", "<C-j>", "<C-[>o", opt)
map.set("i", "<C-f>", "<C-[>O", opt)

map.set("n", "U", "<C-r>", opt)

-- markdown 相关映射
vim.api.nvim_create_autocmd("FileType", {
    pattern = "markdown",
    callback = function()
        local map = vim.keymap.set
        local opt = { noremap = true, silent = true }

        map("i", "\\\\", "<C-[>/<++><CR>:nohlsearch<CR>c4l", { desc = '清除标记', noremap = true, silent = true }) -- jkej

        map("i", "<C-CR>", "<Esc>0yf o<Esc>p0<C-a>$a", opt) -- 斜体
        map("i", "---", "<Enter>---<Enter><br/><Enter><Enter>", opt) -- 分割线
        map("i", "BB", "**** <++><Esc>F*hi", opt) -- 加粗
        map("i", "DD", "****** <++><Esc>F*hhi", opt) -- 加粗并斜体
        map("i", "II", "** <++><Esc>F*i", opt) -- 斜体
        map("i", "SS", "~~~~ <++><esc>F~hi", opt) -- 删除线
        map("i", "UU", "<u></u> <++><Esc>2F<i", opt) -- 下划线
        map( -- 展开列表
            "i",
            "LS",
            "<details><Enter><summary></summary><Enter><++><Enter></details><Esc>2k$F<i",
            opt
        )
        -- 格式块
        map(
            "i",
            "~~",
            "~~~<Enter><Enter>~~~<Enter><++><Esc>2kA",
            opt
        )
        -- 添加图片
        map("i", "PP", "![](<++>) <++><Esc>F[a", opt)
        -- 添加链接
        map("i", "PPP", "[](<++>) <++><Esc>F[a", opt)

        -- 2-4级标题
        map("i", "@@", "##<Space>", opt)
        map("i", "##", "###<Space>", opt)
        map("i", "$$", "####<Space>", opt)
    end,
})
