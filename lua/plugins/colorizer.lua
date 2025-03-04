return {
    "NvChad/nvim-colorizer.lua",
    keys = {
        { "<leader>oc", mode = { "n", "x", "o" }, "<cmd>ColorizerToggle<CR>", desc = "Colorizer Toggle" },
    },
    opts = {
        filetypes = {
            "*",
            css = { rgb_fn = true },  -- Enable parsing rgb(...) functions in css.
            html = { names = false }, -- Disable parsing "names" like Blue or Gray
        },
        user_default_options = {
            RGB = true,               -- #RGB hex codes
            RRGGBB = true,            -- #RRGGBB hex codes
            names = true,             -- "Name" codes like Blue or blue
            names_opts = {            -- options for mutating/filtering names.
                lowercase = true,     -- name:lower(), highlight `blue` and `red`
                camelcase = true,     -- name, highlight `Blue` and `Red`
                uppercase = true,     -- name:upper(), highlight `BLUE` and `RED`
                strip_digits = false, -- ignore names with digits,
                -- highlight `blue` and `red`, but not `blue3` and `red4`
            },
            RRGGBBAA = false,    -- #RRGGBBAA hex codes
            AARRGGBB = false,    -- 0xAARRGGBB hex codes
            rgb_fn = true,       -- CSS rgb() and rgba() functions
            hsl_fn = false,      -- CSS hsl() and hsla() functions
            css = false,         -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
            css_fn = false,      -- Enable all CSS *functions*: rgb_fn, hsl_fn
            -- Available modes for `mode`: foreground, background,  virtualtext
            mode = "background", -- Set the display mode.
            -- Available methods are false / true / "normal" / "lsp" / "both"
            -- True is same as normal
            tailwind = false,                               -- Enable tailwind colors
            -- parsers can contain values used in |user_default_options|
            sass = { enable = false, parsers = { "css" } }, -- Enable sass colors
            virtualtext = "■",
            -- update color values even if buffer is not focused
            -- example use: cmp_menu, cmp_docs
            always_update = false,
        },
        -- all the sub-options of filetypes apply to buftypes
        buftypes = {
            "*",
            -- exclude prompt and popup buftypes from highlight
            "!prompt",
            "!popup",
        },
    }, --
}
