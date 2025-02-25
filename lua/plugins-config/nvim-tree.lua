local status, nvim_tree = pcall(require, "nvim-tree")
if not status then
	vim.notify("没有找到 nvim-tree")
	return
end

--vim.api.nvim_create_autocmd("VimEnter", {
--  callback = function()
--    require("nvim-tree.api").tree.open()
--	vim.cmd("wincmd l")
--  end
--})

vim.api.nvim_create_autocmd("BufEnter", {
  nested = true,
  callback = function()
    -- 获取当前打开的窗口数量
    local wins = vim.api.nvim_tabpage_list_wins(0)
    if #wins == 1 and vim.bo.filetype == "NvimTree" then
      vim.cmd("quit")  -- 只有 NvimTree 剩下时，自动退出 Neovim
    end
  end
})


nvim_tree.setup({
  sort_by = "case_sensitive",
	-- 是否显示 git 状态
	git = {
		enable = true,
	},
	-- 过滤文件
	filters = {
		dotfiles = true, -- 过滤 dotfile
		custom = { "node_modules" }, -- 其他过滤目录
	},
  view = {
	-- 文件浏览器展示位置，左侧：left, 右侧：right
	side = "left",
	-- 行号是否显示
	number = false,
	relativenumber = false,
	signcolumn = "yes", -- 显示图标
	width = 30,
  },
  renderer = {
    group_empty = true,
  },
})

