vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
vim.keymap.set('n', '<leader>lf', function()
  vim.fn.jobstart('zellij r -f -c -- lazygit', { detach = true })
end, { desc = 'Open [L]azyGit Floating' })
vim.keymap.set('n', '<leader>ll', function()
  vim.fn.jobstart('zellij r -c -- lazygit', { detach = true })
end, { desc = 'Open [L]azyGit Pane' })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

-- See `:help telescope.builtin`
vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader>b', require('telescope.builtin').buffers, { desc = 'Find existing [b]uffers' })
vim.keymap.set('n', '<leader>j', require('telescope.builtin').jumplist, { desc = 'Find existing [j]umplist' })
vim.keymap.set('n', '<leader>m', require('telescope.builtin').marks, { desc = 'Find existing [m]arks' })
vim.keymap.set('n', '<leader>/', function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = '[/] Fuzzily search in current buffer' })

vim.keymap.set('n', '<leader><space>', require('telescope.builtin').find_files, { desc = 'Search Files' })
vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>xe', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>xq', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })
local _border = 'single'

vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
  border = _border,
})

vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, {
  border = _border,
})

vim.diagnostic.config {
  float = { border = _border },
}
require('lspconfig.ui.windows').default_options = {
  border = _border,
}

-- LSP settings.
--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(client, bufnr)
  -- NOTE: Remember that lua is a real programming language, and as such it is possible
  -- to define small helper and utility functions so you don't have to repeat yourself
  -- many times.
  --
  -- In this case, we create a function that lets us more easily define mappings specific
  -- for LSP related items. It sets the mode, buffer and description for us each time.
  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end

    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end

  nmap('<leader>cr', vim.lsp.buf.rename, '[R]e[n]ame')
  nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

  nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
  nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
  nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
  nmap('gt', vim.lsp.buf.type_definition, 'Type [D]efinition')
  nmap('<leader>ss', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
  nmap('<leader>sS', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

  -- See `:help K` for why this keymap
  nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
  nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')
  vim.keymap.set('n', '<leader>cf', vim.lsp.buf.format, { desc = 'Format Code' })
  if client.name == 'rust_analyzer' then
    -- vim.keymap.set("n", "K", "<CMD>RustHoverActions<CR>", { buffer = bufnr })
    vim.keymap.set('n', '<leader>ct', '<CMD>RustDebuggables<CR>', { buffer = bufnr, desc = 'Run Test' })
    vim.keymap.set('n', '<leader>dr', '<CMD>RustDebuggables<CR>', { buffer = bufnr, desc = 'Run' })
    require('inlay-hints').on_attach(client, bufnr)
  end

  -- Lesser used LSP functionality
  nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
  nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
  nmap('<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, '[W]orkspace [L]ist Folders')

  -- Create a command `:Format` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    vim.lsp.buf.format()
  end, { desc = 'Format current buffer with LSP' })
end

-- Enable the following language servers
--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
--
--  Add any additional override configuration in the following tables. They will be passed to
--  the `settings` field of the server config. You must look up that documentation yourself.
local servers = {
  -- clangd = {},
  gopls = {
    gopls = {
      completeUnimported = true,
      usePlaceholders = true,
      analyses = {
        unusedparams = true,
      },
    },
  },
  -- pyright = {},
  rust_analyzer = {
    cargo = { features = { 'all' } },
    checkOnSave = {
      command = 'cargo clippy',
    },
    check = {
      command = 'cargo clippy',
    },
    ['rust-analyzer'] = {
      cargo = { features = { 'all' } },
      checkOnSave = {
        command = 'cargo clippy',
      },
      check = {
        command = 'cargo clippy',
      },
    },
  },
  -- tsserver = {},

  lua_ls = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
    },
  },
}

-- Setup neovim lua configuration
require('neodev').setup()

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Ensure the servers above are installed
require('mason').setup {}
local mason_lspconfig = require 'mason-lspconfig'

mason_lspconfig.setup {
  ensure_installed = vim.tbl_keys(servers),
}

mason_lspconfig.setup_handlers {
  function(server_name)
    --[[
    ['rust-analyzer'] = {
    checkOkSave = {
      command = 'clippy',
    },
  },

    --]]
    require('lspconfig')[server_name].setup {
      capabilities = capabilities,
      on_attach = on_attach,
      settings = servers[server_name],
    }
  end,
}

require('rust-tools').setup {
  tools = {
    runnables = {
      use_telescope = true,
    },
    inlay_hints = {
      auto = false,
      show_parameter_hints = false,
    },
  },
  server = {
    on_attach = on_attach,
    settings = {
      ['rust-analyzer'] = {
        check = {
          command = 'clippy',
        },
      },
    },
  },
}

-- nvim-cmp setup
local cmp = require 'cmp'
local luasnip = require 'luasnip'

luasnip.config.setup {}

cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert {
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete {},
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  },
  sources = {
    { name = 'copilot' },
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'friendly' },
    { name = 'crates' },
  },
}

vim.keymap.set('n', "<leader>xx", "<cmd>TroubleToggle document_diagnostics<cr>",  {desc = "Document Diagnostics (Trouble)" })
vim.keymap.set('n', "<leader>xX", "<cmd>TroubleToggle workspace_diagnostics<cr>", {desc = "Workspace Diagnostics (Trouble)" })
vim.keymap.set('n', "<leader>xL", "<cmd>TroubleToggle loclist<cr>",               {desc = "Location List (Trouble)" })
vim.keymap.set('n', "<leader>xQ", "<cmd>TroubleToggle quickfix<cr>",              {desc = "Quickfix List (Trouble)" })
vim.keymap.set('n', "[q",
function()
	if require("trouble").is_open() then
		require("trouble").previous({ skip_groups = true, jump = true })
	else
		vim.cmd.cprev()
	end
end,
{desc = "Previous trouble/quickfix item"}
)
vim.keymap.set('n', "]q",
function()
	if require("trouble").is_open() then
		require("trouble").next({ skip_groups = true, jump = true })
	else
		vim.cmd.cnext()
	end
end,
{desc = "Next trouble/quickfix item"}
)
vim.keymap.set('n','<leader>qs', function() require("persistence").load() end, {desc = "Restore Session" })
vim.keymap.set('n',"<leader>ql", function() require("persistence").load({ last = true }) end, {desc = "Restore Last Session" })
vim.keymap.set('n',"<leader>qd", function() require("persistence").stop() end, {desc = "Don't Save Current Session" })
