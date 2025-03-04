return {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    -- or                              , branch = '0.1.x',
    dependencies = { 'nvim-lua/plenary.nvim' },
    keys = {
        { "<leader>ff", mode = { "n" }, function() require('telescope.builtin').find_files() end,  desc = "Find File" },
        { "<leader>fg", mode = { "n" }, function() require('telescope.builtin').live_grep() end,   desc = "Find Grep" },
        { "<leader>fo", mode = { "n" }, function() require('telescope.builtin').oldfiles() end,    desc = "Find Old File" },
        { "<leader>fb", mode = { "n" }, function() require('telescope.builtin').buffers() end,     desc = "Find Buffers" },
        { "<leader>fh", mode = { "n" }, function() require('telescope.builtin').help_tags() end,   desc = "FInd Help File" },
        { "<leader>fc", mode = { "n" }, function() require('telescope.builtin').colorscheme() end, desc = "FInd Colorscheme" },
    },
    config = function()
        local function open_specific_folder()
            require("telescope.builtin").find_files({
                cwd = "~/projects", -- 替换为你的目标路径
                hidden = true, -- 是否显示隐藏文件
                layout_config = {
                    width = 0.9, -- 窗口宽度（比例）
                    height = 0.8, -- 窗口高度
                },
            })
        end
    end
}
