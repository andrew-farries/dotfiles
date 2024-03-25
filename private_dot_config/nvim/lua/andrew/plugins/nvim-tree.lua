return {
  "nvim-tree/nvim-tree.lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local nvimtree = require("nvim-tree")

    -- configure nvim-tree
    require'nvim-tree'.setup{
      create_in_closed_folder = false,
      respect_buf_cwd = true,
      actions = {
        open_file = {
          resize_window = true,
          window_picker = {
            enable = false
          }
        },
      },
      view = {
        float = {
          enable = true,
          open_win_config = {
            relative = "win",
            border = "rounded",
            width = 50,
            height = 100,
            row = 0,
            col = 0,
          }
        }
      },
      hijack_directories = {
        auto_open = false
      },
      hijack_unnamed_buffer_when_opening = true,
      update_focused_file = {
        enable = true
      },
      renderer = {
        add_trailing = false,
        highlight_opened_files = "all",
        root_folder_modifier = ':~',
        group_empty = false,
        special_files = { "README.md" },
        icons = {
          padding = " ",
          show = {
            file = true,
            folder = true,
            folder_arrow = true,
            git = true,
          },
          glyphs = {
            default = "",
            symlink = "",
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
        indent_markers = {
          enable = true,
        },
      }
    }

    -- set keymaps
    vim.keymap.set("n", "<C-n>", "<cmd>NvimTreeFindFileToggle<CR>", { desc = "Toggle file explorer on current file" })
  end,
}
