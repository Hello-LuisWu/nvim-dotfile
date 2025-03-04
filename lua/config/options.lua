local opt = vim.opt
-- ----------------------------
-- 基础设置
-- ----------------------------
-- 设置相对行号
opt.number = true         -- 显示行号
opt.relativenumber = true -- 显示相对行号
-- opt.mouse = "r"           -- 禁用鼠标, nvim 默认值为 a
opt.mouse = "a"           -- 启用鼠标, nvim 默认值为开启
opt.modifiable = true     -- 确保缓冲区可修改

opt.modifiable = true     -- 确保缓冲区可修改

-- 共享系统剪贴板
opt.clipboard = vim.env.SSH_TTY and "" or "unnamedplus"
-- opt.clipboard = "unnamedplus"

-- 编码设置
opt.encoding = "utf-8"                 -- 设置 Neovim 内部编码
opt.fileencoding = "utf-8"             -- 自动检测文件编码的顺序
opt.fileencodings = "utf-8,gbk,latin1" -- 自动检测文件编码的顺序
opt.fileformats = "unix,dos,mac"       -- 文件格式支持，优先次序从左到右
opt.fileformat = "unix"                -- 文件格式支持，优先次序从左到右
vim.scriptencoding = "utf-8"           --脚本文件所使用的编码
opt.helplang = "cn"                    -- 帮助文件所使用的语言

-- ----------------------------
-- 界面与显示
-- ----------------------------
opt.numberwidth = 4               -- 行号宽度设置为4个字符
opt.termguicolors = true          -- 启用 24-bit 彩色模式
opt.cursorline = true             -- 高亮光标所在行
opt.cursorcolumn = false          -- 禁止高亮光标所在列
opt.signcolumn = "yes"            -- 始终显示左侧标记列,行号前面多出一列,用于插件提示
opt.showmode = false              -- 是否在命令行显示当前模式
opt.title = true                  -- 在终端标题栏显示当前文件名
opt.wrap = false                  -- 不自动换行, 用 <leader>0 切换
opt.linebreak = true              -- 不在单词内部换行(需开启自动换行 )
opt.breakindent = true            -- 折行后的行保持缩进
opt.scrolloff = 3                 -- 上下滚动时光标离窗口上下边界 3 行
opt.sidescrolloff = 8             -- 左右移动时,光标离左右窗口边界保持88个字符的距离
opt.whichwrap = "b,s,<,>,[,],h,l" -- 左右键可以已到下一行或者上一行
-- opt.colorcolumn = "100"   -- 右边添加参考线
opt.showmatch = true              -- 匹配括号高亮
opt.matchtime = 2                 -- 匹配括号高亮持续时间（十分之一秒）
opt.pumheight = 10                -- 弹出菜单最多显示10行
opt.cmdheight = 0                 -- 命令行高为1
opt.showcmd = false               -- 显示输入的命令
--[[ opt.list = true
opt.lcs = "eol:↴" ]]
opt.fillchars = {
    horiz = "━", -- 水平分割线（上下窗口分隔）
    horizup = "┻", -- 水平分割线顶部（仅 Neovim 0.10+）
    horizdown = "┳", -- 下部分水平分割线
    vert = "┃", -- 垂直分割线
    vertleft = "┫", -- 左边垂直分割线
    vertright = "┣", -- 右边垂直分割线
    verthoriz = "╋", -- 交叉分割线
    foldopen = "",
    foldclose = "",
    fold = "━", -- 折叠的填充字符（默认：.）
    foldsep = " ", -- 折叠间的分隔符    msgsep = "‾", -- 消息分隔线
    eob = " ", -- 文件末尾空白行的提示符（默认是 "~"）
    stl = " ", -- 状态栏左侧填充
    diff = "⣿", -- `diff` 模式下的填充字符
    stlnc = " ", -- 非当前窗口状态栏填充
}
opt.laststatus = 2 -- 显示状态行，值为 0 不显示，值为 1 当有多个窗口才显示，值为2 永久显示
opt.showtabline = 2 -- 2 总是显示标签页，0 不显示，1 出现多个标签页才显示
-- opt.tabpagemax = 9   -- 最多可以打开 9 个标签页，默认10个

-- ----------------------------
-- 编辑体验
-- ----------------------------
-- 关于缩进
-- Neovim Lua 配置中正确启用文件类型检测
vim.cmd('filetype on')                             -- 启用基础检测
vim.cmd('filetype plugin on')                      -- 启用插件支持
vim.cmd('filetype indent on')                      -- 启用缩进规则
vim.cmd("filetype plugin indent on")               -- 传统 Vimscript 方式
vim.filetype.add({ extension = { ... } })          -- 启用文件类型检测, Neovim 0.10+ 的 Lua API
opt.modifiable = true                              -- 确保缓冲区可修改
opt.tabstop = 4                                    -- 一个 tab 占用 4 个空格
opt.shiftwidth = 4                                 -- 缩进宽度为 4, 自动缩进时每级缩进的空格数
opt.softtabstop = 4                                -- 编辑时每个 tab 键等同于 4 个空格, 按退格键时删除的“虚拟空格”数量
opt.smarttab = true                                -- 智能使用 tabstop 和 shiftwidth
opt.shiftround = true
opt.expandtab = true                               -- 使用空格替代 tab , 将 Tab 转换为空格
opt.autoindent = true                              -- 自动继承上一行的缩进
vim.o.smartindent = true                           -- 开启新行时使用智能自动缩进, 智能缩进（如 C 语言风格的代码块）
opt.cindent = true                                 -- 启用C语言风格缩进
opt.autochdir = false                              -- 自动切换当前目录为当前文件所在的目录
opt.completeopt = "menu,menuone,noselect,noinsert" -- 补全菜单行为：显示菜单，即使只有一个选项，不自动选择
opt.wildmenu = true                                -- 自动补全不自动选中
opt.virtualedit = "block,onemore"                  -- 光标可以定位到最后一个字的后面
opt.confirm = true                                 -- 退出时文件没保存,会问你是否保存
opt.backspace = { "start", "eol", "indent" }       -- 正常删除
-- 细化缩进规则（可选）
vim.opt.cinkeys = "0{,0},0),:,!^F,o,O,e"           -- 触发缩进的字符
vim.opt.cinoptions = "g0,h1,N-s"                   -- 缩进细节（如 `g0` 控制作用域声明缩进）
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "python", "lua" },
    callback = function()
        vim.opt_local.cindent = false -- 关闭 C 风格缩进
    end,
})


-- 备份和撤销
opt.backup = false      -- 禁用备份文件
opt.writebackup = false -- 禁用写入文件前的备份
opt.swapfile = false    -- 禁用交换文件
opt.undofile = false    -- 禁用撤销文件
opt.undolevels = 10000  -- 设置撤销级别
-- vim.o.backupdir = "~/.config/nvim/backup//" -- 设置备份文件存储路径
-- vim.o.directory = "~/.config/nvim/swap//"   -- 设置交换文件存储路径
-- vim.o.undodir = "~/.config/nvim/undo//"     -- 设置撤销文件存储路径
opt.history = 1000 -- 命令历史和搜索历史的最大记录条数

-- ----------------------------
-- 搜索与替换
-- ----------------------------
opt.hlsearch = true      -- 开启搜索高亮
opt.incsearch = true     -- 搜索逐字高亮
opt.ignorecase = true    -- 搜索忽略大小写
opt.smartcase = true     -- 如果包含大写字母，则进行大小写敏感搜索
opt.inccommand = "split" -- 实时预览替换效果（输入 :%s/foo/bar 时）

-- ----------------------------
-- 文件与缓冲区
-- ----------------------------
opt.hidden = true    -- 允许隐藏被修改的缓冲区（切换文件时不强制保存）
opt.autoread = true  -- 当文件被外部程序修改时自动重新加载
opt.autowrite = true -- 在切换缓冲区或执行某些命令时自动保存

-- ----------------------------
-- 窗口与布局
-- ----------------------------
opt.splitbelow = true    -- 新的水平分屏窗口在下方打开
opt.splitright = true    -- 新的垂直分屏窗口在右侧打开
opt.splitkeep = "screen" -- 保持屏幕不动
opt.winblend = 0         -- 窗口透明度
opt.equalalways = false  -- 不自动调整窗口大小相等（若需启用设为 true）

-- ----------------------------
-- 性能优化
-- ----------------------------
opt.updatetime = 300   -- 光标移动后 300ms 更新状态
opt.timeoutlen = 500   -- 快捷键映射等待超时时间
opt.lazyredraw = false -- 执行宏或未映射的快捷键时减少重绘（提升性能）,开启可能会导致插件报错
opt.synmaxcol = 240    -- 语法高亮的最大列数，超过则跳过
opt.filetype = "on"

-- 启用代码折叠
opt.foldenable = true                               -- 开启折叠
opt.foldmethod = 'expr'                             -- 指定折叠方式
vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()' -- 基于表达式折叠
-- opt.foldmethod = "marker"
opt.foldcolumn = "1"                                -- 在编辑器左侧显示折叠标记的列, 0 为不显示
opt.foldlevel = 99                                  -- 一次折叠的层级有多少
opt.foldlevelstart = 99                             -- 打开文件时的默认折叠层级,
-- opt.foldtext = "折叠区域"


-- ----------------------------
-- 其他杂项
-- ----------------------------
vim.opt.shell = "/bin/zsh"                                         -- 设置 Neovim 使用的 shell (比如 terminal 所使用的shell)
vim.opt.guicursor = "n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50" -- 光标形状（终端需支持）
opt.spell = false                                                  -- 禁止拼写支持
opt.spelllang = { "en" }                                           -- 设置拼写检查语言



opt.wildmode = "longest:full,full"   -- 命令行补全模式
vim.g.markdown_recommended_style = 0 -- 禁用推荐的 Markdown 风格



opt.timeout = true
--opt.cscopequickfix = "s-,c-,d-,i-,t-,e-"
-- opt.background = "dark"

-- 查找文件向下搜索到子文件夹
opt.path:append({ "**" })
opt.wildignore:append({ "*/node_modules/*" })
opt.formatoptions:append({ "r" })
opt.formatoptions:append({ "r" })
