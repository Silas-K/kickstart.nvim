-- LSP Keymaps
--
-- -- Jump to the definition of the word under your cursor. To jump back, press <C-t>.
-- map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
--
-- -- Find references for the word under your cursor.
-- map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
--
-- -- Jump to the implementation of the word under your cursor.
-- --  Useful when your language has ways of declaring types without an actual implementation.
-- map('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
--
-- -- Jump to the type of the word under your cursor.
-- --  Useful when you're not sure what type a variable is and you want to see
-- --  the definition of its *type*, not where it was *defined*.
-- map('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
--
-- -- Fuzzy find all the symbols in your current document.
-- --  Symbols are things like variables, functions, types, etc.
-- map('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
--
-- -- Fuzzy find all the symbols in your current workspace.
-- --  Similar to document symbols, except searches over your entire project.
-- map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
--
-- -- Rename the variable under your cursor.
-- --  Most Language Servers support renaming across files, etc.
-- map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
--
-- -- Execute a code action, usually your cursor needs to be on top of an error
-- -- or a suggestion from your LSP for this to activate.
-- map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
--
-- -- Opens a popup that displays documentation about the word under your cursor
-- --  See `:help K` for why this keymap.
-- map('K', vim.lsp.buf.hover, 'Hover Documentation')
--
-- map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
--
--
--
--
--

-- Autocompletion
--
  { -- Autocompletion
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      -- Snippet Engine & its associated nvim-cmp source
      {
        'L3MON4D3/LuaSnip',
        build = (function()
          -- Build Step is needed for regex support in snippets.
          -- This step is not supported in many windows environments.
          -- Remove the below condition to re-enable on windows.
          -- if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
          --   return
          -- end
          return 'make install_jsregexp'
        end)(),
        dependencies = {
          -- `friendly-snippets` contains a variety of premade snippets.
          --    See the README about individual language/framework/plugin snippets:
          --    https://github.com/rafamadriz/friendly-snippets
          {
            'rafamadriz/friendly-snippets',
            config = function()
              require('luasnip.loaders.from_vscode').lazy_load()
            end,
          },
        },
      },
      'saadparwaiz1/cmp_luasnip',

      -- Adds other completion capabilities.
      --  nvim-cmp does not ship with all sources by default. They are split
      --  into multiple repos for maintenance purposes.
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',

      'onsails/lspkind.nvim',
    },
    config = function()
      -- See `:help cmp`
      local cmp = require 'cmp'
      local luasnip = require 'luasnip'
      local lspkind = require 'lspkind'
      lspkind.init {}
      luasnip.config.setup {}

      cmp.setup {
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        completion = { completeopt = 'menu,menuone,noinsert' },
        -- For an understanding of why these mappings were
        -- chosen, you will need to read `:help ins-completion`
        --
        -- No, but seriously. Please read `:help ins-completion`, it is really good!
        mapping = cmp.mapping.preset.insert {
          -- Select the [n]ext item
          ['<C-n>'] = cmp.mapping.select_next_item(),
          -- Select the [p]revious item
          ['<C-p>'] = cmp.mapping.select_prev_item(),

          -- Scroll the documentation window [b]ack / [f]orward
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),

          -- Accept ([y]es) the completion.
          --  This will auto-import if your LSP supports it.
          --  This will expand snippets if the LSP sent a snippet.
          ['<C-y>'] = cmp.mapping.confirm { select = true },

          -- If you prefer more traditional completion keymaps,
          -- you can uncomment the following lines
          -- ['<CR>'] = cmp.mapping.confirm { select = true },
          --['<Tab>'] = cmp.mapping.select_next_item(),
          --['<S-Tab>'] = cmp.mapping.select_prev_item(),
          -- ['<Tab>'] = cmp.mapping.confirm { select = true },

          -- Manually trigger a completion from nvim-cmp.
          --  Generally you don't need this, because nvim-cmp will display
          --  completions whenever it has completion options available.
          ['<C-Space>'] = cmp.mapping.complete {},

          -- ['<C-l>'] = cmp.mapping.complete {},

          -- ['<M-Space>'] = cmp.mapping.complete {},

          -- ['<C-l>'] = cmp.mapping(function()
          --   print 'Completion triggered'
          --   cmp.complete {}
          -- end, { 'i', 's' }),

          -- Think of <c-l> as moving to the right of your snippet expansion.
          --  So if you have a snippet that's like:
          --  function $name($args)
          --    $body
          --  end
          --
          -- <c-l> will move you to the right of each of the expansion locations.
          -- <c-h> is similar, except moving you backwards.
          ['<C-j>'] = cmp.mapping(function()
            if luasnip.expand_or_locally_jumpable() then
              luasnip.expand_or_jump()
            end
          end, { 'i', 's' }),
          ['<C-k>'] = cmp.mapping(function()
            if luasnip.locally_jumpable(-1) then
              luasnip.jump(-1)
            end
          end, { 'i', 's' }),

          -- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
          --    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
        },
        sources = {
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
          { name = 'path' },
        },

        -- -- Add pictograms to the completion window
        formatting = {
          -- fields = { cmp.ItemField.Abbr, 'kind', 'menu' },
          expandable_indicator = true,

          format = lspkind.cmp_format {
            mode = 'symbol_text', -- show only symbol annotations
            maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
            -- can also be a function to dynamically calculate max width such as
            -- maxwidth = function() return math.floor(0.45 * vim.o.columns) end,
            ellipsis_char = '...', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
            show_labelDetails = true, -- show labelDetails in menu. Disabled by default

            -- The function below will be called before any actual modifications from lspkind
            -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
            before = function(entry, vim_item)
              --...
              return vim_item
            end,
          },
        },
      }

      -- Setup up vim-dadbod
      cmp.setup.filetype({ 'sql' }, {
        sources = {
          { name = 'vim-dadbod-completion' },
          { name = 'buffer' },
        },
      })
    end,
  },





-- vim.opt.tabstop = 4
-- vim.opt.softtabstop = 4
-- vim.opt.shiftwidth = 4
-- vim.opt.expandtab = true
--
-- vim.opt.smartindent = true

-- vim.cmd [[autocmd BufNewFile,BufRead *.cshtml set filetype=html.cshtml.razor]]
-- vim.cmd [[autocmd BufNewFile,BufRead *.razor set filetype=html.cshtml.razor]]
--
-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
  --
  --

-- go back to file tree view
-- vim.keymap.set('n', '<leader>pv', vim.cmd.Ex)
