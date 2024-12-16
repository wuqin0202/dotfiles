require 'g'
-- 若检测 vim 未安装 packer.nvim 则自动安装
local ensure_packer = function()
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    cmd [[packadd packer.nvim]]
    return true
  end
  return false
end
local packer_bootstrap = ensure_packer()
-- 自动检测该文件是否被修改，若被修改则自动应用修改
autocmds('PackerCompile', {
    {'BufWritePost', {
        pattern = 'plugin.lua',
        command = 'source <afile> | PackerCompile',
    }},
})
-- 插件安装
require('packer').startup(function(use)
	-- packer 管理自己的版本
	use 'wbthomason/packer.nvim'
	-- 自动补全
    require 'plugin-config.coc'
	use {
        'neoclide/coc.nvim',
        branch = 'release',
	}
	-- 显示 16 进制编码的颜色
	use {
        'norcalli/nvim-colorizer.lua',
        config = "require 'colorizer'.setup()",
    }
	-- markdown 预览
    require 'plugin-config.markdown'
    use {
        'iamcco/markdown-preview.nvim',
        run = 'cd app && npm install',
        ft = { 'markdown' },
    }
	-- 中文help doc
    use {
        'yianwillis/vimcdoc',
        event = 'VimEnter',
    }
	-- 文件管理器
    require 'plugin-config/nvim-tree'.config()
	use {
        'nvim-tree/nvim-tree.lua',
        requires = { 'nvim-tree/nvim-web-devicons' },
        config = "require 'plugin-config/nvim-tree'.setup()",
	}
	-- 浮动终端
    require 'plugin-config/vim-floaterm'
	use 'voldikss/vim-floaterm'
	-- 离开插入模式自动切换英文
	use {
        'yaocccc/vim-fcitx2en',
        event = 'InsertLeavePre',
    }
    -- 操作成对括号
    use {
        'kylechui/nvim-surround',
        config = "require('nvim-surround').setup()",
    }
    -- fzf 模糊查询
    use {
        'junegunn/fzf',
        event = "CmdLineEnter"
    }
    use {
        'junegunn/fzf.vim',
        run = 'cd ~/.fzf && ./install --all',
        after = "fzf"
    }
    use {
        'wuqin0202/dracula.vim',
        as = 'dracula',
    }
    -- copilot 智能编程
    require 'plugin-config/copilot'
    use {
        'github/copilot.vim',
        event = 'InsertEnter',
    }
    -- wilder 弹出式命令行
    use {
        'gelguy/wilder.nvim',
        event = 'CmdlineEnter',
        config = "require 'plugin-config/wilder'.setup()"
    }
    -- tab 栏
    require 'plugin-config/barbar'.config()
    use {
        'romgrk/barbar.nvim',
        requires = 'nvim-tree/nvim-web-devicons'
    }
end)

if packer_bootstrap then
    require('packer').sync()
end
