-- Leader keys (set before loading plugins)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Basic editor settings
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = "a"
vim.opt.clipboard = "unnamedplus"
vim.opt.breakindent = true
vim.opt.undofile = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.signcolumn = "yes"
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300
vim.opt.termguicolors = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.scrolloff = 8
-- Compile and run the current file with F5
vim.keymap.set("n", "<F5>", function()
    vim.cmd("write")

    local file = vim.fn.expand("%:p")
    local ext = vim.fn.expand("%:e")
    local output = vim.fn.expand("%:p:r")

    local commands = {
        c = "gcc " .. vim.fn.shellescape(file)
            .. " -o " .. vim.fn.shellescape(output)
            .. " && " .. vim.fn.shellescape(output),

        cpp = "g++ " .. vim.fn.shellescape(file)
            .. " -o " .. vim.fn.shellescape(output)
            .. " && " .. vim.fn.shellescape(output),

        py = "python3 " .. vim.fn.shellescape(file),
    }

    local command = commands[ext]

    if not command then
        vim.notify("No run command configured for ." .. ext,
            vim.log.levels.WARN)
        return
    end

    vim.cmd("botright 12new")
    vim.fn.termopen({ "fish", "-lc", command })
    vim.cmd("startinsert")
end, { desc = "Compile and run current file" })

vim.keymap.set("n", "<leader>r", function()
    vim.api.nvim_feedkeys(
        vim.api.nvim_replace_termcodes("<F5>", true, false, true),
        "m",
        false
    )
end, { desc = "Run current file" })
-- Load lazy.nvim
require("config.lazy")
