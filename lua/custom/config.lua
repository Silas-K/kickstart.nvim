-- CUSTOM CONFIGURATION
--
-- python file
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'python' },
  callback = function()
    vim.keymap.set('n', '<leader>rp', function()
      -- Save the current buffer
      vim.cmd 'w'
      -- Run the current python file
      vim.cmd('term python "' .. vim.fn.expand '%:p' .. '"')
    end, { desc = '[R]un the current [p]ython file.', noremap = true, silent = true })
  end,
})

-- c/c++ files
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'c', 'cpp' },
  callback = function()
    vim.keymap.set('n', '<leader>cc', function()
      vim.cmd 'w'
      vim.cmd 'make %:r'
    end, { desc = 'Compile current c++ file.' })

    vim.keymap.set('n', '<leader>cm', function()
      vim.cmd 'w'
      vim.cmd 'make'
    end, { desc = 'Compile current c++ file with make.' })

    vim.keymap.set('n', '<leader>cg', function()
      -- Save the current buffer
      vim.cmd 'w'
      -- Compile the current file with the makefile
      vim.cmd 'make'
      vim.cmd('terminal ' .. 'make run')
    end, { desc = '[C]ompile current c++ file and [r]un it.' })

    vim.keymap.set('n', '<leader>cr', function()
      -- Save the current buffer
      vim.cmd 'w'
      -- Compile the current file into an executable
      vim.cmd 'make %:p:r'
      local executable = vim.fn.expand '%:p:r'
      -- Open a new terminal buffer and execute the generated executable
      vim.cmd('terminal ' .. executable)
      -- Execute the generated executable
      -- vim.cmd('! ' .. executable)
      -- vim.cmd('terminal ' .. executable)
    end, { desc = '[C]ompile current c++ file and [r]un it.' })
  end,
})

-- Custom Keymaps
-- Move selection up and down
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")
