require('g')
local m = {}

local function open_nvim_tree(data)
    -- buffer is a [No Name]
    local no_name = data.file == "" and bo[data.buf].buftype == ""
    -- buffer is a directory
    local directory = fn.isdirectory(data.file) == 1
    if not directory and not no_name then
      return
    end
    -- change to the directory
    if directory then
        exec.cd(data.file)
    end
    -- open the tree
    require("nvim-tree.api").tree.toggle()
end

function m.config()
    maps({
        {'n', '<Leader>f', '<Cmd>NvimTreeToggle<CR>', {} },
    })
    autocmds('Auto Open Nvim-tree',{
      {
        'VimEnter',{
          callback = open_nvim_tree
        }
      }
    })
end

function m.setup()
    require "nvim-tree".setup {
      disable_netrw = true,
      hijack_cursor = true, -- 光标上下移动时自动跳到文件名首
      hijack_netrw = false,
      sort_by = "name",
      view = {
        width = 50,
        hide_root_folder = false,
        side = "left",
        number = true,
        relativenumber = true,
        signcolumn = "auto",
        float = {
          enable = true,
          quit_on_focus_loss = true,
          open_win_config = {
            relative = "editor",
            border = "rounded",
            width = 25,
            height = 15,
            row = 0,
            col = 0,
          },
        },
      },
      renderer = {
        add_trailing = false,
        group_empty = false,
        highlight_git = true,
        full_name = false,
        highlight_opened_files = "name",
        highlight_modified = "icon",
        root_folder_label = ":~:s?$?/",
        indent_width = 2,
        indent_markers = {
          enable = true,
          inline_arrows = false,
          icons = {
            corner = "└",
            edge = "│",
            item = "│",
            bottom = "─",
            none = " ",
          },
        },
        icons = {
          webdev_colors = true,
          git_placement = "before",
          modified_placement = "after",
          padding = " ",
          symlink_arrow = " ➛ ",
          show = {
            file = true,
            folder = true,
            folder_arrow = true,
            git = true,
            modified = true,
          },
          glyphs = {
            default = "",
            symlink = "",
            bookmark = "",
            modified = "●",
            folder = {
              arrow_closed = "",
              arrow_open = "",
              default = "",
              open = "",
              empty = "",
              empty_open = "",
              symlink = "",
              symlink_open = "",
            },
            git = {
              unstaged = "✗",
              staged = "✓",
              unmerged = "",
              renamed = "➜",
              untracked = "★",
              deleted = "",
              ignored = "◌",
            },
          },
        },
        special_files = { "Cargo.toml", "Makefile", "README.md", "readme.md" },
        symlink_destination = true,
      },
      hijack_directories = {
        enable = true,
        auto_open = true,
      },
      update_focused_file = {
        enable = false,
        update_root = false,
        ignore_list = {},
      },
      system_open = {
        cmd = "",
        args = {},
      },
      diagnostics = {
        enable = false,
        show_on_dirs = false,
        show_on_open_dirs = true,
        debounce_delay = 50,
        severity = {
          min = diagnostic.severity.HINT,
          max = diagnostic.severity.ERROR,
        },
        icons = {
          hint = "",
          info = "",
          warning = "",
          error = "",
        },
      },
      filters = {
        dotfiles = false,
        git_clean = false,
        no_buffer = false,
        custom = {"^.git$"},
        exclude = {},
      },
      filesystem_watchers = {
        enable = true,
        debounce_delay = 50,
        ignore_dirs = {},
      },
      git = {
        enable = true,
        ignore = true,
        show_on_dirs = true,
        show_on_open_dirs = true,
        timeout = 400,
      },
      modified = {
        enable = true,
        show_on_dirs = true,
        show_on_open_dirs = true,
      },
      actions = {
        use_system_clipboard = true,
        change_dir = {
          enable = true,
          global = false,
          restrict_above_cwd = false,
        },
        expand_all = {
          max_folder_discovery = 300,
          exclude = {},
        },
        file_popup = {
          open_win_config = {
            col = 1,
            row = 1,
            relative = "cursor",
            border = "shadow",
            style = "minimal",
          },
        },
        open_file = {
          quit_on_open = false,
          resize_window = true,
          window_picker = {
            enable = true,
            picker = "default",
            chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
            exclude = {
              filetype = { "notify", "packer", "qf", "diff", "fugitive", "fugitiveblame" },
              buftype = { "nofile", "terminal", "help" },
            },
          },
        },
        remove_file = {
          close_window = true,
        },
      },
      trash = {
        cmd = "gio trash",
      },
      live_filter = {
        prefix = "[FILTER]: ",
        always_show_folders = true,
      },
      tab = {
        sync = {
          open = false,
          close = false,
          ignore = {},
        },
      },
      notify = {
        threshold = log.levels.INFO,
      },
      ui = {
        confirm = {
          remove = true,
          trash = true,
        },
      },
      log = {
        enable = false,
        truncate = false,
        types = {
          all = false,
          config = false,
          copy_paste = false,
          dev = false,
          diagnostics = false,
          git = false,
          profile = false,
          watcher = false,
        },
      },
    }
end

return m
