{
  config,
  pkgs,
  # mrc,
  ...
}: {
  home.packages = with pkgs; [
    vscode-extensions.ms-vscode.cpptools
  ];
  programs = {
    neovim = {
      plugins = [
        ## Treesitter
        pkgs.vimPlugins.nvim-treesitter
        pkgs.vimPlugins.nvim-treesitter.withAllGrammars
        pkgs.vimPlugins.nvim-treesitter-textobjects
        pkgs.vimPlugins.nvim-lspconfig

        pkgs.vimPlugins.trouble-nvim
        pkgs.vimPlugins.plenary-nvim
        pkgs.vimPlugins.telescope-nvim
        pkgs.vimPlugins.telescope-fzf-native-nvim
        pkgs.vimPlugins.fidget-nvim

        ## cmp
        pkgs.vimPlugins.nvim-cmp
        pkgs.vimPlugins.cmp-nvim-lsp
        pkgs.vimPlugins.cmp-buffer
        pkgs.vimPlugins.cmp-cmdline

        pkgs.vimPlugins.clangd_extensions-nvim
        pkgs.vimPlugins.luasnip
        pkgs.vimPlugins.cmp_luasnip
        pkgs.vimPlugins.lspkind-nvim
        pkgs.vimPlugins.nvim-lint
        pkgs.vimPlugins.vim-surround
        pkgs.vimPlugins.vim-obsession
        # pkgs.vimPlugins.kommentary
        pkgs.vimPlugins.neoformat
        pkgs.vimPlugins.lazygit-nvim
        pkgs.vimPlugins.gitsigns-nvim
        # pkgs.vimPlugins.rainbow
        # pkgs.vimPlugins.vim-sleuth
        pkgs.vimPlugins.lualine-nvim
        pkgs.vimPlugins.nvim-web-devicons
        # pkgs.vimPlugins.lightspeed-nvim
        # pkgs.vimPlugins.leap-nvim
        pkgs.vimPlugins.vim-repeat
        # pkgs.vimPlugins.kanagawa-nvim
        # mrc.vimPlugins.no-neck-pain-nvim

        ## Debugging
        pkgs.vimPlugins.nvim-dap
        pkgs.vimPlugins.nvim-dap-ui
        pkgs.vimPlugins.nvim-dap-virtual-text

				pkgs.vimPlugins.mason-nvim
				pkgs.vimPlugins.mason-lspconfig-nvim
				pkgs.vimPlugins.nui-nvim
				pkgs.vimPlugins.neo-tree-nvim
				pkgs.vimPlugins.go-nvim
				pkgs.vimPlugins.indent-blankline-nvim
				pkgs.vimPlugins.persistence-nvim
				pkgs.vimPlugins.null-ls-nvim
				pkgs.vimPlugins.dressing-nvim
				pkgs.vimPlugins.which-key-nvim
				pkgs.vimPlugins.crates-nvim
				pkgs.vimPlugins.rust-tools-nvim
				# pkgs.vimPlugins.inlay-hints-nvim
				pkgs.vimPlugins.catppuccin-nvim
				pkgs.vimPlugins.neodev-nvim
				pkgs.vimPlugins.nvim-notify
				pkgs.vimPlugins.mini-nvim
				pkgs.vimPlugins.comment-nvim

				# 'saecki/crates.nvim',
				# 'numToStr/Comment.nvim'
				# 'kevinhwang91/nvim-bqf',
				# 'ribelo/taskwarrior.nvim',
				# 'simrat39/inlay-hints.nvim',
				# "jackMort/ChatGPT.nvim",
				# 'olexsmir/gopher.nvim',
			];
      extraConfig = ''
        lua << EOF
        ${builtins.readFile config/options.lua}
        ${builtins.readFile config/mappings.lua}
        ${builtins.readFile config/cmp.lua}
        ${builtins.readFile config/treesitter.lua}
        ${builtins.readFile config/lspconfig.lua}
        ${builtins.readFile config/luasnip.lua}
        ${builtins.readFile config/trouble.lua}
        ${builtins.readFile config/telescope.lua}
        ${builtins.readFile config/lualine.lua}
        ${builtins.readFile config/fidget.lua}
        ${builtins.readFile config/gitsigns.lua}
        ${builtins.readFile config/filetree.lua}
        ${builtins.readFile config/banner.lua}
				-- The line beneath this is called `modeline`. See `:help modeline`
				-- vim: syntax=lua ts=2 sts=2 sw=2 et
      '';
        # ${builtins.readFile config/kommentary.lua}
        # ${builtins.readFile config/lint.lua}
        # ${builtins.readFile config/leap.lua}
        # ${builtins.readFile config/clangd_extensions.lua}
        # ${builtins.readFile config/dap.lua}
        # ${builtins.readFile config/indent-blankline.lua}
      enable = true;
      viAlias = true;
      vimAlias = true;
    };
  };
}
        #touch config/cmp.lua config/treesitter.lua config/lspconfig.lua config/luasnip.lua config/trouble.lua config/telescope.lua config/lualine.lua config/fidget.lua config/gitsigns.lua
