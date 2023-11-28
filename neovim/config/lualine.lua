local colors = {
	blue   = '#80a0ff',
	cyan   = '#79dac8',
	black  = '#080808',
	white  = '#c6c6c6',
	red    = '#ff5189',
	violet = '#d183e8',
	orange = '#fe8019',
	grey   = '#303030',
}

local bubbles_theme = {
	normal = {
		a = { fg = colors.black, bg = colors.violet },
		b = { fg = colors.white, bg = colors.grey },
		c = { fg = colors.black, bg = colors.black },
	},
	insert = { a = { fg = colors.black, bg = colors.blue } },
	visual = { a = { fg = colors.black, bg = colors.cyan } },
	replace = { a = { fg = colors.black, bg = colors.red } },
	inactive = {
		a = { fg = colors.white, bg = colors.black },
		b = { fg = colors.white, bg = colors.black },
		c = { fg = colors.black, bg = colors.black },
	},
}

local err = {
	'diagnostics',
	source = { 'nvim' },
	sections = { 'error' },
	diagnostics_color = { error = { bg = colors.red, fg = colors.white } },
}

local warn = {
	'diagnostics',
	source = { 'nvim' },
	sections = { 'warn' },
	diagnostics_color = { warn = { bg = colors.orange, fg = colors.white } },
}

local dia = {
	'diagnostics',
}

require('lualine').setup({
		options = {
			theme = bubbles_theme,
			component_separators = '|',
			section_separators = { left = '', right = '' },
		},
		sections = {
			lualine_a = {
				{
					'mode',
					separator = {
						--left = ''
						right = '',
					},
					right_padding = 2,
				},
			},
			lualine_b = { { 'filename', path = 1 }, 'branch' },
			lualine_c = { 'fileformat', dia },
			lualine_x = {},
			lualine_y = { 'filetype', 'progress' },
			lualine_z = {
				{
					'location',
					separator = {
						left = '',
						-- right = ''
					},
					left_padding = 2,
				},
			},
		},
		inactive_sections = {
			lualine_a = { { 'filename', show_filename_only = false } },
			lualine_b = {},
			lualine_c = {},
			lualine_x = {},
			lualine_y = {},
			lualine_z = { 'location' },
		},
		tabline = {},
		extensions = { 'neo-tree' },
})
