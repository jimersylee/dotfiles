-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
vim.o.background = "light"
vim.opt.wrap = true -- 启用自动换行
vim.opt.linebreak = true -- 在单词边界处换行
vim.opt.breakindent = true
vim.opt.laststatus = 3 -- views can only be fully collapsed with the global statusline
vim.wo.number = true --显示行号
vim.wo.relativenumber = true -- 显示相对行号
