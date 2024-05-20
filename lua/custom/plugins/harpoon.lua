return {
  'ThePrimeagen/harpoon',
  config = function()
    local mark = require 'harpoon.mark'
    local ui = require 'harpoon.ui'
    local term = require 'harpoon.term'
    local cmdui = require 'harpoon.cmd-ui'
    local tmux = require 'harpoon.tmux'

    local function navigate(number)
      return function()
        ui.nav_file(number)
      end
    end

    vim.keymap.set('n', '<leader>a', mark.add_file, { desc = '[A]dd to harpoon list' })
    vim.keymap.set('n', '<leader>ht', ui.toggle_quick_menu, { desc = 'Toggle harpoon quick menu' })
    vim.keymap.set('n', '<leader>hh', navigate(1), { desc = 'Navigate to harpoon file 1' })
    vim.keymap.set('n', '<leader>hj', navigate(2), { desc = 'Navigate to harpoon file 2' })
    vim.keymap.set('n', '<leader>hk', navigate(3), { desc = 'Navigate to harpoon file 3' })
    vim.keymap.set('n', '<leader>hl', navigate(4), { desc = 'Navigate to harpoon file 4' })
    vim.keymap.set('n', '<leader>h;', navigate(4), { desc = 'Navigate to harpoon file 4' })
  end,
}
