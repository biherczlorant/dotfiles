return {
  {
    "nvim-telescope/telescope.nvim",
    branch = "master",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      { "<leader>pf", "<cmd>Telescope find_files<CR>", desc = "Find Files" },
    },
  },

  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    opts = {
      ensure_installed = { "cpp", "c", "lua", "vim", "vimdoc", "markdown" },
      sync_install = false,
      auto_install = true,
      highlight = { enable = true },
    },
    config = function(_, opts)
      local configs_ok, configs = pcall(require, "nvim-treesitter.configs")
      if configs_ok then
          configs.setup(opts)
      else
      end
    end,
  },

  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    keys = {
      { "<leader>e", "<cmd>Neotree toggle<cr>", desc = "Toggle Neo-tree" },
    },
  },

  {
    "stevearc/overseer.nvim",
    cmd = { "OverseerRun", "OverseerToggle", "OverseerInfo", "OverseerTaskAction", "OverseerQuickAction" },
    opts = {},
    keys = {
      { "<leader>or", "<cmd>OverseerRun<cr>", desc = "Run task" },
      { "<leader>ot", "<cmd>OverseerToggle<cr>", desc = "Toggle task window" },
      { "<leader>os", ":OverseerShell ", desc = "Run shell command" },
    },
    config = function()
      local overseer = require("overseer")
  
      local function cmake_root()
        local file = vim.fs.find("CMakeLists.txt", { upward = true })[1]
        return file and vim.fs.dirname(file) or vim.fn.getcwd()
      end
  
      overseer.setup({ templates = { "builtin" } })
  
      overseer.register_template({
        name = "cmake configure",
        builder = function()
          local root = cmake_root()
          return {
            cmd = "cmake",
            args = { "-S", root, "-B", root .. "/build" },
            cwd = root,
            components = { "default" },
          }
        end,
      })
  
      overseer.register_template({
        name = "cmake build",
        builder = function()
          local root = cmake_root()
          return {
            cmd = "cmake",
            args = { "--build", root .. "/build" },
            cwd = root,
            components = { "default" },
          }
        end,
      })
    end,
  }
}
