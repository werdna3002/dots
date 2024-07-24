-- init.lua

-- Ensure lazy.nvim is installed
local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/lazy/start/lazy.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({'git', 'clone', '--depth', '1', 'https://github.com/folke/lazy.nvim.git', install_path})
  vim.cmd [[packadd lazy.nvim]]
end

-- Print plugin list
print(vim.inspect({
  'nvim-treesitter/nvim-treesitter',
  'neovim/nvim-lspconfig',
  'hrsh7th/nvim-cmp',
  'hrsh7th/cmp-nvim-lsp',
  'nvim-lua/plenary.nvim',
  'nvim-telescope/telescope.nvim',
}))

-- Require lazy.nvim
require('lazy').setup({
  'nvim-treesitter/nvim-treesitter',
  'neovim/nvim-lspconfig',
  'hrsh7th/nvim-cmp',
  'hrsh7th/cmp-nvim-lsp',
  'nvim-lua/plenary.nvim',
  'nvim-telescope/telescope.nvim',
  'easymotion/vim-easymotion',
})

-- Basic options
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.wrap = false
vim.opt.termguicolors = true

-- Key mappings
vim.g.mapleader = ' '
vim.api.nvim_set_keymap('n', '<leader>ff', '<cmd>Telescope find_files<cr>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>fg', '<cmd>Telescope live_grep<cr>', { noremap = true, silent = true })

-- Easymotion mappings
vim.api.nvim_set_keymap('n', '<Leader>s', '<Plug>(easymotion-s)', {})
vim.api.nvim_set_keymap('n', '<Leader>w', '<Plug>(easymotion-w)', {})
vim.api.nvim_set_keymap('n', '<Leader>j', '<Plug>(easymotion-j)', {})
vim.api.nvim_set_keymap('n', '<Leader>k', '<Plug>(easymotion-k)', {})
vim.api.nvim_set_keymap('n', '<Leader>f', '<Plug>(easymotion-f)', {})
vim.api.nvim_set_keymap('n', '<Leader>t', '<Plug>(easymotion-t)', {})

-- LSP settings
local lspconfig = require('lspconfig')
local cmp = require('cmp')

cmp.setup({
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = {
    ['<C-n>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
    ['<C-p>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
  },  
  sources = {
    { name = 'nvim_lsp' },
  },
})

local capabilities = require('cmp_nvim_lsp').default_capabilities()

lspconfig.tsserver.setup {
  capabilities = capabilities,
}

lspconfig.pyright.setup {
  capabilities = capabilities,
}

-- Treesitter configuration
require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained",
  highlight = {
    enable = true,
  },
}

--vim UI plugin with vscode
vim.api.nvim_exec([[
    " THEME CHANGER
    function! SetCursorLineNrColorInsert(mode)
        " Insert mode: blue
        if a:mode == "i"
            call VSCodeNotify('nvim-theme.insert')

        " Replace mode: red
        elseif a:mode == "r"
            call VSCodeNotify('nvim-theme.replace')
        endif
    endfunction

    augroup CursorLineNrColorSwap
        autocmd!
        autocmd ModeChanged *:[vV\x16]* call VSCodeNotify('nvim-theme.visual')
        autocmd ModeChanged *:[R]* call VSCodeNotify('nvim-theme.replace')
        autocmd InsertEnter * call SetCursorLineNrColorInsert(v:insertmode)
        autocmd InsertLeave * call VSCodeNotify('nvim-theme.normal')
        autocmd CursorHold * call VSCodeNotify('nvim-theme.normal')
        autocmd ModeChanged [vV\x16]*:* call VSCodeNotify('nvim-theme.normal')
    augroup END
]], false)
