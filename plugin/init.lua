vim.cmd('color happy_hacking')

-- LSP Config for Ruby
local lspconfig = require('lspconfig')

local function on_attach(_, buffer)
  vim.api.nvim_buf_set_keymap(buffer, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>',
    { noremap = true, silent = true })
  vim.api.nvim_buf_set_keymap(buffer, 'n', '<leader>r', '<cmd>lua vim.lsp.buf.rename()<CR>',
    { noremap = true, silent = true })
end

lspconfig.solargraph.setup {
  on_attach = on_attach,
  settings = {
    solargraph = {
      diagnostics = true
    }
  }
}

-- Formatter setup for Ruby
require('formatter').setup({
  filetype = {
    ruby = {
      -- Rubocop
      function()
        return {
          exe = "rubocop",
          args = { "--auto-correct", "--stdin", "%:p", "2>/dev/null", "|", "tee", "%:p:r.out", "|", "tail", "-n", "+2" },
          stdin = true
        }
      end
    }
  }
})

vim.api.nvim_set_keymap('n', '<leader>f', '<cmd>Format<CR>', { noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<leader>t', '<cmd>!ruby %<CR>', { noremap = true, silent = true })

