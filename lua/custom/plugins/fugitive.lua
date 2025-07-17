return {
  'tpope/vim-fugitive',
  config = function()
    vim.keymap.set('n', '<leader>gs', vim.cmd.Git, { desc = 'Git summary' })

    local Fugitive_Group = vim.api.nvim_create_augroup('Fugitive_Group', {})

    local autocmd = vim.api.nvim_create_autocmd
    autocmd('BufWinEnter', {
      group = Fugitive_Group,
      pattern = '*',
      callback = function()
        if vim.bo.ft ~= 'fugitive' then
          return
        end

        local bufnr = vim.api.nvim_get_current_buf()
        local function map_git_key(lhs, cmd, desc)
          vim.keymap.set('n', lhs, function()
            vim.cmd.Git(cmd)
          end, { buffer = bufnr, remap = false, desc = desc })
        end

        map_git_key('<leader>gp', 'push', 'Git push')
        map_git_key('<leader>gP', 'pull', 'Git pull')
        map_git_key('<leader>gc', 'commit', 'Git commit')

        -- local opts = { buffer = bufnr, remap = false }
        -- vim.keymap.set('n', '<leader>p', function()
        --   vim.cmd.Git 'push'
        -- end, { opts, desc = 'Git push' })
        --
        -- vim.keymap.set('n', '<leader>P', function()
        --   vim.cmd.Git 'pull'
        -- end, { opts, desc = 'Git pull' })
      end,
    })
  end,
}
