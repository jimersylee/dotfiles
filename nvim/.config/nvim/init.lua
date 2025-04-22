-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

vim.o.background = "light"
vim.opt.wrap = true          -- 启用自动换行
vim.opt.linebreak = true     -- 在单词边界处换行
vim.opt.laststatus = 3 -- views can only be fully collapsed with the global statusline
-- 只显示绝对行号，不显示相对行号
vim.wo.number = true
vim.wo.relativenumber = false

