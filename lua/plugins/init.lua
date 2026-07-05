return {
  -- Luarocks install, must be installed first
  {
    "vhyrro/luarocks.nvim",
    priority = 1000, -- Very high priority is required, luarocks.nvim should run as the first plugin in your config.
    config = true,
  },
  "nvim-lua/plenary.nvim", -- "lua functions that many plugins use"
  "bluz71/vim-nightfly-guicolors", -- preferred colorscheme
  "szw/vim-maximizer", -- maximizes and restores current window

  --essential plugins
  "tpope/vim-surround", -- wrap content with character
  {
    "vim-scripts/ReplaceWithRegister",
    keys = {
      { "<leader>gr", "<Plug>ReplaceWithRegisterOperator", desc = "ReplaceWithRegisterOperator" },
    },
  },

  "kyazdani42/nvim-web-devicons", -- file explorer icons
  "nvim-tree/nvim-web-devicons",

  {
    "folke/snacks.nvim",
    opts = {
      explorer = { enabled = false },
    },
  },

  "nvim-lualine/lualine.nvim", -- status line
  "numtostr/comment.nvim", -- comment line

  -- "Pocco81/auto-save.nvim", -- auto save

  -- fuzzy finding

  -- autocompletion
  -- "hrsh7th/nvim-cmp",
  -- "hrsh7th/cmp-buffer",
  -- "hrsh7th/cmp-path",

  -- snippets
  -- "L3MON4D3/LuaSnip",
  -- "hrsh7th/nvim-cmp",
  -- "hrsh7th/cmp-buffer",
  -- "hrsh7th/cmp-path",
  -- "saadparwaiz1/cmp_luasnip",
  -- "rafamadriz/friendly-snippets",

  -- managing & installing lsp servers, formatters & linters
  -- "williamboman/mason.nvim", -- in charge of managing lp servers, linters & formatters
  -- "williamboman/mason-lspconfig.nvim", -- bridges gap b/w mason & lspconfig
  -- "jay-babu/mason-nvim-dap.nvim",

  -- configuring lsp servers
  "neovim/nvim-lspconfig",
  "hrsh7th/cmp-nvim-lsp", -- for autocompletion
  { "akinsho/bufferline.nvim", enabled = false },
  { "gcmt/taboo.vim" },
  {
    "glepnir/lspsaga.nvim",
    branch = "main",
    dependencies = {
      { "nvim-tree/nvim-web-devicons" },
      { "nvim-treesitter/nvim-treesitter" },
    },
  }, -- enhanced lsp uis
  "onsails/lspkind.nvim", -- vs-code like icons for autocompletion

  -- formatting & linting
  "jayp0521/mason-null-ls.nvim",

  -- treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    build = function()
      require("nvim-treesitter.install").update({ with_sync = true })
    end,
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
  },

  -- auto closing
  "windwp/nvim-autopairs",
  "windwp/nvim-ts-autotag",

  -- Sessions
  "tpope/vim-obsession",

  -- git integration
  "lewis6991/gitsigns.nvim",
  "tpope/vim-fugitive",
  "tpope/vim-rhubarb",

  -- vimspector
  "puremourning/vimspector",

  -- debugger plugins
  "mfussenegger/nvim-dap",
  -- "mfussenegger/nvim-dap-python",
  "leoluz/nvim-dap-go",
  "rcarriga/nvim-dap-ui",
  "theHamsta/nvim-dap-virtual-text",
}
