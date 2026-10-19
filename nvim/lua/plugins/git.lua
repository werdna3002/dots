
return {
    {
        "lewis6991/gitsigns.nvim",
        event = { "BufReadPre", "BufNewFile" },
        opts = {
            signs = {
                add = { text = "┃" },
                change = { text = "┃" },
                delete = { text = "_" },
                topdelete = { text = "‾" },
                changedelete = { text = "~" },
                untracked = { text = "┆" },
            },
        },
        keys = {
            {
                "]h",
                function()
                    require("gitsigns").nav_hunk("next")
                end,
                desc = "Next Git change",
            },
            {
                "[h",
                function()
                    require("gitsigns").nav_hunk("prev")
                end,
                desc = "Previous Git change",
            },
            {
                "<leader>hs",
                function()
                    require("gitsigns").stage_hunk()
                end,
                desc = "Stage hunk",
            },
            {
                "<leader>hr",
                function()
                    require("gitsigns").reset_hunk()
                end,
                desc = "Reset hunk",
            },
            {
                "<leader>hp",
                function()
                    require("gitsigns").preview_hunk()
                end,
                desc = "Preview hunk",
            },
            {
                "<leader>hb",
                function()
                    require("gitsigns").blame_line()
                end,
                desc = "Git blame line",
            },
        },
    },

    {
        "tpope/vim-fugitive",
        cmd = { "Git", "G", "Gdiffsplit", "Gvdiffsplit", "Gblame" },
        keys = {
            {
                "<leader>gg",
                "<cmd>Git<cr>",
                desc = "Git status",
            },
            {
                "<leader>gc",
                "<cmd>Git commit<cr>",
                desc = "Git commit",
            },
            {
                "<leader>gd",
                "<cmd>Gvdiffsplit<cr>",
                desc = "Git vertical diff",
            },
            {
                "<leader>gl",
                "<cmd>Git log --oneline --graph --decorate<cr>",
                desc = "Git log",
            },
        },
    },
}

