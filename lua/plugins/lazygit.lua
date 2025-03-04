return {
    "kdheepak/lazygit.nvim",
    lazy = true,                    -- 只有在调用时才加载插件，提升启动速度
    cmd = {
        "LazyGit",                  -- 打开 lazygit
        "LazyGitConfig",            -- 打开 lazygit 配置文件
        "LazyGitCurrentFile",       -- 在当前文件所在的 Git 项目中打开 lazygit
        "LazyGitFilter",            -- 在当前 Git 项目中打开 lazygit 并过滤 commit 记录
        "LazyGitFilterCurrentFile", -- 在当前文件的 Git 记录中打开 lazygit 并过滤 commit 记录
    },
    dependencies = {
        "nvim-lua/plenary.nvim", -- 依赖 plenary.nvim 以提供浮动窗口边框等功能
    },
    keys = {
        { "<leader>gg", "<cmd>LazyGit<cr>", desc = "打开 LazyGit" } -- 设置快捷键 <leader>lg 打开 LazyGit
    },
    config = function()
        require("lazygit").setup({
            floating_window_winblend = 0,
            floating_window_scaling_factor = 0.3,
            floating_window_border_chars = { '&', '─', '*', '(', '#', '─', '╰', '│' },
            -- floating_window_border_chars = { '&', '─', '*', '(', '╯', '─', '╰', '│' },
            floating_window_use_plenary = 1,
            use_neovim_remote = 1,
            use_custom_config_file_path = 0,
            config_file_path = "",
            on_exit_callback = nil
        })
    end
}
