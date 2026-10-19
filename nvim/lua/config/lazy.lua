local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
    error("lazy.nvim not found at " .. lazypath)
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins")
