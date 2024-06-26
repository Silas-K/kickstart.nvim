-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {

  {
    'folke/tokyonight.nvim',
    priority = 1000, -- Make sure to load this before all the other start plugins.
    -- init = function()
    --   vim.cmd.colorscheme 'tokyonight-night'
    --
    --   -- You can configure highlights by doing something like:
    --   vim.cmd.hi 'Comment gui=none'
    -- end,
  },

  {
    'tomasiser/vim-code-dark',
    priority = 1000, -- Make sure to load this before all the other start plugins.
    -- init = function()
    --   vim.cmd.colorscheme 'codedark'
    --
    --   -- You can configure highlights by doing something like:
    --   vim.cmd.hi 'Comment gui=none'
    -- end,
  },
  {
    'rose-pine/neovim',
    priority = 1000, -- Make sure to load this before all the other start plugins.
    -- init = function()
    --   vim.cmd.colorscheme 'rose-pine-moon'
    --
    --   -- You can configure highlights by doing something like:
    --   vim.cmd.hi 'Comment gui=none'
    -- end,
  },
  {
    'doums/darcula',
    priority = 1000, -- Make sure to load this before all the other start plugins.
    -- init = function()
    --   vim.cmd.colorscheme 'darcula'
    --
    --   -- You can configure highlights by doing something like:
    --   vim.cmd.hi 'Comment gui=none'
    -- end,
  },
  {
    {
      'catppuccin/nvim',
      name = 'catppuccin',
      priority = 1000,

      init = function()
        vim.cmd.colorscheme 'catppuccin-macchiato'
        vim.cmd.hi 'Comment gui=none'
      end,
    },
  },

  -- NOTE: icons in file explorer (`nvim .`)
  {
    'prichrd/netrw.nvim',
    opts = {
      -- Put your configuration here, or leave the object empty to take the default
      -- configuration.
      icons = {
        symlink = '', -- Symlink icon (directory and file)
        directory = '', -- Directory icon
        file = '', -- File icon
      },
      use_devicons = true, -- Uses nvim-web-devicons if true, otherwise use the file icon specified above
      mappings = {}, -- Custom key mappings
    },
  },

  -- NOTE: Basic syntax highlighting for .razor & .cshtml files
  { 'jlcrochet/vim-razor' },

  -- NOTE: Show Borders around windows
  -- {
  --   'nvim-zh/colorful-winsep.nvim',
  --   config = true,
  --   event = { 'WinNew' },
  -- },

  -- {
  --   'jmederosalvarado/roslyn.nvim',
  --   opts = {
  --     dotnet_cmd = 'dotnet', -- this is the default
  --     roslyn_version = '4.8.0-3.23475.7', -- this is the default
  --     -- on_attach = on_attach,
  --     -- capabilities = capabilities,
  --   },
  -- },
}
