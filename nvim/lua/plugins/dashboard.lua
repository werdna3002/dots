
return {
    {
        "goolord/alpha-nvim",
        event = "VimEnter",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        config = function()
            local alpha = require("alpha")
            local dashboard = require("alpha.themes.dashboard")

            dashboard.section.header.val = {
                [[         /\         ]],
                [[        /  \        ]],
                [[       / /\ \       ]],
                [[      / ____ \      ]],
                [[     /_/    \_\     ]],
                [[                     ]],
                [[      VOID + NVIM    ]],
            }

            dashboard.section.buttons.val = {
                dashboard.button("f", "  Find file", "<cmd>Telescope find_files<CR>"),
                dashboard.button("g", "  Search text", "<cmd>Telescope live_grep<CR>"),
                dashboard.button("r", "  Recent files", "<cmd>Telescope oldfiles<CR>"),
                dashboard.button("e", "  File explorer", "<cmd>Neotree toggle<CR>"),
                dashboard.button("p", "  Plugins", "<cmd>Lazy<CR>"),
                dashboard.button("q", "  Quit", "<cmd>qa<CR>"),
            }

            dashboard.section.footer.val = "Happy hacking :3"

            dashboard.config.opts.noautocmd = true
            alpha.setup(dashboard.config)
        end,
    },
}

