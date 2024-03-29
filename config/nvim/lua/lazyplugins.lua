require('g')
-- 自动下载
local lazypath = fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
opt.rtp:prepend(lazypath)
-- 插件
require("lazy").setup({
    {
     'keaising/im-select.nvim',
      config=function ()
        require('im_select').setup({
          default_im_select  = "1033",
          default_command = '/mnt/c/Users/wuqin/bin/im-select.exe',
        })
      end
    },
    {
      'phaazon/hop.nvim',
      branch = 'v2',
      config=function ()
        require('hop').setup()
      end
    },
    {
      "kylechui/nvim-surround",
      version = "*", -- Use for stability; omit to use `main` branch for the latest features
      event = "VeryLazy",
      config = function()
          require("nvim-surround").setup({
          })
      end
    }
})
-- 键位映射
maps({
  -- hop
  { 'n', 'w', '<Cmd>HopWordCurrentLine<CR>', {} },
  { 'n', 'W', '<Cmd>HopWord<CR>', {} },
  { 'n', 'f', '<Cmd>HopChar1CurrentLine<CR>', {} },
  { 'n', 'F', '<Cmd>HopPattern<CR>', {} },
})