local M = {}
local config = require("spirit-furnace.config")

local function set_highlights()
	local utilities = require("spirit-furnace.utilities")
	local palette = require("spirit-furnace.palette")()
	local styles = config.options.styles

	local groups = {}
	for group, color in pairs(config.options.groups) do
		groups[group] = utilities.parse_color(color)
	end

	local function make_border(fg)
		fg = fg or groups.border
		return {
			fg = fg,
			bg = (config.options.extend_background_behind_borders and not styles.transparency) and palette.surface
				or "NONE",
		}
	end

	local highlights = {}
	local legacy_highlights = {
		["@attribute.diff"] = { fg = palette.elixir },
		["@boolean"] = { link = "Boolean" },
		["@class"] = { fg = palette.blossom },
		["@conditional"] = { link = "Conditional" },
		["@field"] = { fg = palette.blossom },
		["@include"] = { link = "Include" },
		["@interface"] = { fg = palette.blossom },
		["@macro"] = { link = "Macro" },
		["@method"] = { fg = palette.jade },
		["@namespace"] = { link = "Include" },
		["@number"] = { link = "Number" },
		["@parameter"] = { fg = palette.furnace, italic = styles.italic },
		["@preproc"] = { link = "PreProc" },
		["@punctuation"] = { fg = palette.incense },
		["@punctuation.bracket"] = { link = "@punctuation" },
		["@punctuation.delimiter"] = { link = "@punctuation" },
		["@punctuation.special"] = { link = "@punctuation" },
		["@regexp"] = { link = "String" },
		["@repeat"] = { link = "Repeat" },
		["@storageclass"] = { link = "StorageClass" },
		["@symbol"] = { link = "Identifier" },
		["@text"] = { fg = palette.text },
		["@text.danger"] = { fg = groups.error },
		["@text.diff.add"] = { fg = groups.git_add, bg = groups.git_add, blend = 25 },
		["@text.diff.delete"] = { fg = groups.git_delete, bg = groups.git_delete, blend = 25 },
		["@text.emphasis"] = { italic = true },
		["@text.environment"] = { link = "Macro" },
		["@text.environment.name"] = { link = "Type" },
		["@text.math"] = { link = "Special" },
		["@text.note"] = { link = "SpecialComment" },
		["@text.strike"] = { strikethrough = true },
		["@text.strong"] = { bold = styles.bold },
		["@text.title"] = { link = "Title" },
		["@text.title.1.markdown"] = { link = "markdownH1" },
		["@text.title.1.marker.markdown"] = { link = "markdownH1Delimiter" },
		["@text.title.2.markdown"] = { link = "markdownH2" },
		["@text.title.2.marker.markdown"] = { link = "markdownH2Delimiter" },
		["@text.title.3.markdown"] = { link = "markdownH3" },
		["@text.title.3.marker.markdown"] = { link = "markdownH3Delimiter" },
		["@text.title.4.markdown"] = { link = "markdownH4" },
		["@text.title.4.marker.markdown"] = { link = "markdownH4Delimiter" },
		["@text.title.5.markdown"] = { link = "markdownH5" },
		["@text.title.5.marker.markdown"] = { link = "markdownH5Delimiter" },
		["@text.title.6.markdown"] = { link = "markdownH6" },
		["@text.title.6.marker.markdown"] = { link = "markdownH6Delimiter" },
		["@text.underline"] = { underline = true },
		["@text.uri"] = { fg = groups.link },
		["@text.warning"] = { fg = groups.warn },
		["@todo"] = { link = "Todo" },

		-- lukas-reineke/indent-blankline.nvim
		IndentBlanklineChar = { fg = palette.ash, nocombine = true },
		IndentBlanklineSpaceChar = { fg = palette.ash, nocombine = true },
		IndentBlanklineSpaceCharBlankline = { fg = palette.ash, nocombine = true },
	}
	local default_highlights = {
		ColorColumn = { bg = palette.surface },
		Conceal = { bg = "NONE" },
		CurSearch = { fg = palette.base, bg = palette.elixir },
		Cursor = { fg = palette.base, bg = palette.cursor },
		CursorColumn = { bg = palette.overlay },
		-- CursorIM = {},
		CursorLine = { bg = palette.overlay },
		CursorLineNr = { fg = palette.jade, bold = styles.bold },
		-- DarkenedPanel = { },
		-- DarkenedStatusline = {},
		DiffAdd = { bg = groups.git_add, blend = 25 },
		DiffChange = { bg = groups.git_change, blend = 20 },
		DiffDelete = { bg = groups.git_delete, blend = 25 },
		DiffText = { bg = groups.git_text, blend = 40 },
		diffAdded = { link = "DiffAdd" },
		diffChanged = { link = "DiffChange" },
		diffRemoved = { link = "DiffDelete" },
		Directory = { fg = palette.core, bold = styles.bold },
		-- EndOfBuffer = {},
		ErrorMsg = { fg = groups.error, bold = styles.bold },
		FloatBorder = make_border(),
		FloatTitle = { fg = palette.core, bg = groups.panel, bold = styles.bold },
		FoldColumn = { fg = palette.ash },
		Folded = { fg = palette.text, bg = groups.panel },
		IncSearch = { link = "CurSearch" },
		LineNr = { fg = palette.ash },
		MatchParen = { fg = palette.core, bg = palette.core, blend = 30 },
		ModeMsg = { fg = palette.incense },
		MoreMsg = { fg = palette.furnace },
		NonText = { fg = palette.ash },
		Normal = { fg = palette.text, bg = palette.base },
		NormalFloat = { bg = groups.panel },
		NormalNC = { fg = palette.text, bg = config.options.dim_inactive_windows and palette._nc or palette.base },
		NvimInternalError = { link = "ErrorMsg" },
		Pmenu = { fg = palette.incense, bg = groups.panel },
		PmenuExtra = { fg = palette.ash, bg = groups.panel },
		PmenuExtraSel = { fg = palette.incense, bg = palette.overlay },
		PmenuKind = { fg = palette.core, bg = groups.panel },
		PmenuKindSel = { fg = palette.incense, bg = palette.overlay },
		PmenuSbar = { bg = groups.panel },
		PmenuSel = { fg = palette.text, bg = palette.overlay },
		PmenuThumb = { bg = palette.ash },
		Question = { fg = palette.elixir },
		QuickFixLine = { fg = palette.core },
		-- RedrawDebugNormal = {},
		RedrawDebugClear = { fg = palette.base, bg = palette.elixir },
		RedrawDebugComposed = { fg = palette.base, bg = palette.heaven },
		RedrawDebugRecompose = { fg = palette.base, bg = palette.tribulation },
		Search = { fg = palette.text, bg = palette.elixir, blend = 35 },
		SignColumn = { fg = palette.text, bg = "NONE" },
		SpecialKey = { fg = palette.blossom },
		SpellBad = { sp = palette.incense, undercurl = true },
		SpellCap = { sp = palette.incense, undercurl = true },
		SpellLocal = { sp = palette.incense, undercurl = true },
		SpellRare = { sp = palette.incense, undercurl = true },
		StatusLine = { fg = palette.incense, bg = groups.panel },
		StatusLineNC = { fg = palette.ash, bg = groups.panel, blend = 60 },
		StatusLineTerm = { fg = palette.base, bg = palette.heaven },
		StatusLineTermNC = { fg = palette.base, bg = palette.heaven, blend = 60 },
		Substitute = { link = "IncSearch" },
		TabLine = { fg = palette.incense, bg = groups.panel },
		TabLineFill = { bg = groups.panel },
		TabLineSel = { fg = palette.text, bg = palette.overlay, bold = styles.bold },
		Title = { fg = palette.core, bold = styles.bold },
		VertSplit = { fg = groups.border },
		Visual = { bg = palette.selection },
		-- VisualNOS = {},
		WarningMsg = { fg = groups.warn, bold = styles.bold },
		-- Whitespace = {},
		WildMenu = { link = "IncSearch" },
		WinBar = { fg = palette.incense, bg = groups.panel },
		WinBarNC = { fg = palette.ash, bg = groups.panel, blend = 60 },
		WinSeparator = { fg = groups.border },

		DiagnosticError = { fg = groups.error },
		DiagnosticHint = { fg = groups.hint },
		DiagnosticInfo = { fg = groups.info },
		DiagnosticOk = { fg = groups.ok },
		DiagnosticWarn = { fg = groups.warn },
		DiagnosticDefaultError = { link = "DiagnosticError" },
		DiagnosticDefaultHint = { link = "DiagnosticHint" },
		DiagnosticDefaultInfo = { link = "DiagnosticInfo" },
		DiagnosticDefaultOk = { link = "DiagnosticOk" },
		DiagnosticDefaultWarn = { link = "DiagnosticWarn" },
		DiagnosticFloatingError = { link = "DiagnosticError" },
		DiagnosticFloatingHint = { link = "DiagnosticHint" },
		DiagnosticFloatingInfo = { link = "DiagnosticInfo" },
		DiagnosticFloatingOk = { link = "DiagnosticOk" },
		DiagnosticFloatingWarn = { link = "DiagnosticWarn" },
		DiagnosticSignError = { link = "DiagnosticError" },
		DiagnosticSignHint = { link = "DiagnosticHint" },
		DiagnosticSignInfo = { link = "DiagnosticInfo" },
		DiagnosticSignOk = { link = "DiagnosticOk" },
		DiagnosticSignWarn = { link = "DiagnosticWarn" },
		DiagnosticUnderlineError = { sp = groups.error, undercurl = true },
		DiagnosticUnderlineHint = { sp = groups.hint, undercurl = true },
		DiagnosticUnderlineInfo = { sp = groups.info, undercurl = true },
		DiagnosticUnderlineOk = { sp = groups.ok, undercurl = true },
		DiagnosticUnderlineWarn = { sp = groups.warn, undercurl = true },
		DiagnosticVirtualTextError = { fg = groups.error, bg = groups.error, blend = 10 },
		DiagnosticVirtualTextHint = { fg = groups.hint, bg = groups.hint, blend = 10 },
		DiagnosticVirtualTextInfo = { fg = groups.info, bg = groups.info, blend = 10 },
		DiagnosticVirtualTextOk = { fg = groups.ok, bg = groups.ok, blend = 10 },
		DiagnosticVirtualTextWarn = { fg = groups.warn, bg = groups.warn, blend = 10 },

		Boolean = { fg = palette.jade },
		Character = { fg = palette.elixir },
		Comment = { fg = palette.incense, italic = styles.italic },
		Conditional = { fg = palette.heaven },
		Constant = { fg = palette.elixir },
		Debug = { fg = palette.jade },
		Define = { fg = palette.furnace },
		Delimiter = { fg = palette.incense },
		Error = { fg = palette.tribulation },
		Exception = { fg = palette.heaven },
		Float = { fg = palette.elixir },
		Function = { fg = palette.jade },
		Identifier = { fg = palette.text },
		Include = { fg = palette.heaven },
		Keyword = { fg = palette.heaven },
		Label = { fg = palette.blossom },
		LspCodeLens = { fg = palette.incense },
		LspCodeLensSeparator = { fg = palette.ash },
		LspInlayHint = { fg = palette.ash, bg = palette.ash, blend = 10 },
		LspReferenceRead = { bg = palette.highlight_med },
		LspReferenceText = { bg = palette.highlight_med },
		LspReferenceWrite = { bg = palette.highlight_med },
		Macro = { fg = palette.furnace },
		Number = { fg = palette.elixir },
		Operator = { fg = palette.incense },
		PreCondit = { fg = palette.furnace },
		PreProc = { link = "PreCondit" },
		Repeat = { fg = palette.heaven },
		Special = { fg = palette.blossom },
		SpecialChar = { link = "Special" },
		SpecialComment = { fg = palette.furnace },
		Statement = { fg = palette.heaven, bold = styles.bold },
		StorageClass = { fg = palette.blossom },
		String = { fg = palette.elixir },
		Structure = { fg = palette.blossom },
		Tag = { fg = palette.blossom },
		Todo = { fg = palette.jade, bg = palette.jade, blend = 20 },
		Type = { fg = palette.blossom },
		TypeDef = { link = "Type" },
		Underlined = { fg = palette.furnace, underline = true },
		Added = { fg = groups.git_add },
		Changed = { fg = groups.git_change },
		Removed = { fg = groups.git_delete },

		healthError = { fg = groups.error },
		healthSuccess = { fg = groups.info },
		healthWarning = { fg = groups.warn },

		htmlArg = { fg = palette.furnace },
		htmlBold = { bold = styles.bold },
		htmlEndTag = { fg = palette.incense },
		htmlH1 = { link = "markdownH1" },
		htmlH2 = { link = "markdownH2" },
		htmlH3 = { link = "markdownH3" },
		htmlH4 = { link = "markdownH4" },
		htmlH5 = { link = "markdownH5" },
		htmlItalic = { italic = true },
		htmlLink = { link = "markdownUrl" },
		htmlTag = { fg = palette.incense },
		htmlTagN = { fg = palette.text },
		htmlTagName = { fg = palette.blossom },

		markdownDelimiter = { fg = palette.incense },
		markdownH1 = { fg = groups.h1, bold = styles.bold },
		markdownH1Delimiter = { link = "markdownH1" },
		markdownH2 = { fg = groups.h2, bold = styles.bold },
		markdownH2Delimiter = { link = "markdownH2" },
		markdownH3 = { fg = groups.h3, bold = styles.bold },
		markdownH3Delimiter = { link = "markdownH3" },
		markdownH4 = { fg = groups.h4, bold = styles.bold },
		markdownH4Delimiter = { link = "markdownH4" },
		markdownH5 = { fg = groups.h5, bold = styles.bold },
		markdownH5Delimiter = { link = "markdownH5" },
		markdownH6 = { fg = groups.h6, bold = styles.bold },
		markdownH6Delimiter = { link = "markdownH6" },
		markdownLinkText = { link = "markdownUrl" },
		markdownUrl = { fg = groups.link, sp = groups.link, underline = true },

		mkdCode = { fg = palette.core, italic = styles.italic },
		mkdCodeDelimiter = { fg = palette.jade },
		mkdCodeEnd = { fg = palette.core },
		mkdCodeStart = { fg = palette.core },
		mkdFootnotes = { fg = palette.core },
		mkdID = { fg = palette.core, underline = true },
		mkdInlineURL = { link = "markdownUrl" },
		mkdLink = { link = "markdownUrl" },
		mkdLinkDef = { link = "markdownUrl" },
		mkdListItemLine = { fg = palette.text },
		mkdRule = { fg = palette.incense },
		mkdURL = { link = "markdownUrl" },

		--- Treesitter
		--- |:help treesitter-highlight-groups|
		["@variable"] = { fg = palette.text, italic = styles.italic },
		["@variable.builtin"] = { fg = palette.tribulation, italic = styles.italic, bold = styles.bold },
		["@variable.parameter"] = { fg = palette.furnace, italic = styles.italic },
		["@variable.parameter.builtin"] = { fg = palette.furnace, italic = styles.italic, bold = styles.bold },
		["@variable.member"] = { fg = palette.blossom },

		["@constant"] = { fg = palette.elixir },
		["@constant.builtin"] = { fg = palette.elixir, bold = styles.bold },
		["@constant.macro"] = { fg = palette.elixir },

		["@module"] = { fg = palette.text },
		["@module.builtin"] = { fg = palette.text, bold = styles.bold },
		["@label"] = { link = "Label" },

		["@string"] = { link = "String" },
		-- ["@string.documentation"] = {},
		["@string.regexp"] = { fg = palette.furnace },
		["@string.escape"] = { fg = palette.heaven },
		["@string.special"] = { link = "String" },
		["@string.special.symbol"] = { link = "Identifier" },
		["@string.special.url"] = { fg = groups.link },
		-- ["@string.special.path"] = {},

		["@character"] = { link = "Character" },
		["@character.special"] = { link = "Character" },

		["@boolean"] = { link = "Boolean" },
		["@number"] = { link = "Number" },
		["@number.float"] = { link = "Number" },
		["@float"] = { link = "Number" },

		["@type"] = { fg = palette.blossom },
		["@type.builtin"] = { fg = palette.blossom, bold = styles.bold },
		-- ["@type.definition"] = {},

		["@attribute"] = { fg = palette.furnace },
		["@attribute.builtin"] = { fg = palette.furnace, bold = styles.bold },
		["@property"] = { fg = palette.blossom, italic = styles.italic },

		["@function"] = { fg = palette.jade },
		["@function.builtin"] = { fg = palette.jade, bold = styles.bold },
		-- ["@function.call"] = {},
		["@function.macro"] = { link = "Function" },

		["@function.method"] = { fg = palette.jade },
		["@function.method.call"] = { fg = palette.furnace },

		["@constructor"] = { fg = palette.blossom },
		["@operator"] = { link = "Operator" },

		["@keyword"] = { link = "Keyword" },
		-- ["@keyword.coroutine"] = {},
		-- ["@keyword.function"] = {},
		["@keyword.operator"] = { fg = palette.incense },
		["@keyword.import"] = { fg = palette.heaven },
		["@keyword.storage"] = { fg = palette.blossom },
		["@keyword.repeat"] = { fg = palette.heaven },
		["@keyword.return"] = { fg = palette.heaven },
		["@keyword.debug"] = { fg = palette.jade },
		["@keyword.exception"] = { fg = palette.heaven },

		["@keyword.conditional"] = { fg = palette.heaven },
		["@keyword.conditional.ternary"] = { fg = palette.heaven },

		["@keyword.directive"] = { fg = palette.furnace },
		["@keyword.directive.define"] = { fg = palette.furnace },

		--- Punctuation
		["@punctuation.delimiter"] = { fg = palette.incense },
		["@punctuation.bracket"] = { fg = palette.incense },
		["@punctuation.special"] = { fg = palette.incense },

		--- Comments
		["@comment"] = { link = "Comment" },
		-- ["@comment.documentation"] = {},

		["@comment.error"] = { fg = groups.error },
		["@comment.warning"] = { fg = groups.warn },
		["@comment.todo"] = { fg = groups.todo, bg = groups.todo, blend = 15 },
		["@comment.hint"] = { fg = groups.hint, bg = groups.hint, blend = 15 },
		["@comment.info"] = { fg = groups.info, bg = groups.info, blend = 15 },
		["@comment.note"] = { fg = groups.note, bg = groups.note, blend = 15 },

		--- Markup
		["@markup.strong"] = { bold = styles.bold },
		["@markup.italic"] = { italic = true },
		["@markup.strikethrough"] = { strikethrough = true },
		["@markup.underline"] = { underline = true },

		["@markup.heading"] = { fg = palette.core, bold = styles.bold },

		["@markup.quote"] = { fg = palette.text },
		["@markup.math"] = { link = "Special" },
		["@markup.environment"] = { link = "Macro" },
		["@markup.environment.name"] = { link = "@type" },

		-- ["@markup.link"] = {},
		["@markup.link.markdown_inline"] = { fg = palette.incense },
		["@markup.link.label.markdown_inline"] = { fg = palette.core },
		["@markup.link.url"] = { fg = groups.link },

		-- ["@markup.raw"] = { bg = palette.surface },
		-- ["@markup.raw.block"] = { bg = palette.surface },
		["@markup.raw.delimiter.markdown"] = { fg = palette.incense },

		["@markup.list"] = { fg = palette.heaven },
		["@markup.list.checked"] = { fg = palette.core, bg = palette.core, blend = 10 },
		["@markup.list.unchecked"] = { fg = palette.text },

		-- Markdown headings
		["@markup.heading.1.markdown"] = { link = "markdownH1" },
		["@markup.heading.2.markdown"] = { link = "markdownH2" },
		["@markup.heading.3.markdown"] = { link = "markdownH3" },
		["@markup.heading.4.markdown"] = { link = "markdownH4" },
		["@markup.heading.5.markdown"] = { link = "markdownH5" },
		["@markup.heading.6.markdown"] = { link = "markdownH6" },
		["@markup.heading.1.marker.markdown"] = { link = "markdownH1Delimiter" },
		["@markup.heading.2.marker.markdown"] = { link = "markdownH2Delimiter" },
		["@markup.heading.3.marker.markdown"] = { link = "markdownH3Delimiter" },
		["@markup.heading.4.marker.markdown"] = { link = "markdownH4Delimiter" },
		["@markup.heading.5.marker.markdown"] = { link = "markdownH5Delimiter" },
		["@markup.heading.6.marker.markdown"] = { link = "markdownH6Delimiter" },

		["@diff.plus"] = { fg = groups.git_add, bg = groups.git_add, blend = 25 },
		["@diff.minus"] = { fg = groups.git_delete, bg = groups.git_delete, blend = 25 },
		["@diff.delta"] = { bg = groups.git_change, blend = 20 },

		["@tag"] = { link = "Tag" },
		["@tag.attribute"] = { fg = palette.furnace },
		["@tag.delimiter"] = { fg = palette.incense },

		--- Non-highlighting captures
		-- ["@none"] = {},
		["@conceal"] = { link = "Conceal" },
		["@conceal.markdown"] = { fg = palette.incense },

		-- ["@spell"] = {},
		-- ["@nospell"] = {},

		--- Semantic
		["@lsp.type.comment"] = {},
		["@lsp.type.comment.c"] = { link = "@comment" },
		["@lsp.type.comment.cpp"] = { link = "@comment" },
		["@lsp.type.enum"] = { link = "@type" },
		["@lsp.type.interface"] = { link = "@interface" },
		["@lsp.type.keyword"] = { link = "@keyword" },
		["@lsp.type.namespace"] = { link = "@namespace" },
		["@lsp.type.namespace.python"] = { link = "@variable" },
		["@lsp.type.parameter"] = { link = "@parameter" },
		["@lsp.type.property"] = { link = "@property" },
		["@lsp.type.variable"] = {}, -- defer to treesitter for regular variables
		["@lsp.type.variable.svelte"] = { link = "@variable" },
		["@lsp.typemod.function.defaultLibrary"] = { link = "@function.builtin" },
		["@lsp.typemod.operator.injected"] = { link = "@operator" },
		["@lsp.typemod.string.injected"] = { link = "@string" },
		["@lsp.typemod.variable.constant"] = { link = "@constant" },
		["@lsp.typemod.variable.defaultLibrary"] = { link = "@variable.builtin" },
		["@lsp.typemod.variable.injected"] = { link = "@variable" },

		--- Plugins
		-- romgrk/barbar.nvim
		BufferCurrent = { fg = palette.text, bg = palette.overlay },
		BufferCurrentIndex = { fg = palette.text, bg = palette.overlay },
		BufferCurrentMod = { fg = palette.core, bg = palette.overlay },
		BufferCurrentSign = { fg = palette.incense, bg = palette.overlay },
		BufferCurrentTarget = { fg = palette.elixir, bg = palette.overlay },
		BufferInactive = { fg = palette.incense },
		BufferInactiveIndex = { fg = palette.incense },
		BufferInactiveMod = { fg = palette.core },
		BufferInactiveSign = { fg = palette.ash },
		BufferInactiveTarget = { fg = palette.elixir },
		BufferTabpageFill = { fg = "NONE", bg = "NONE" },
		BufferVisible = { fg = palette.incense },
		BufferVisibleIndex = { fg = palette.incense },
		BufferVisibleMod = { fg = palette.core },
		BufferVisibleSign = { fg = palette.ash },
		BufferVisibleTarget = { fg = palette.elixir },

		-- lewis6991/gitsigns.nvim
		GitSignsAdd = { fg = groups.git_add, bg = "NONE" },
		GitSignsChange = { fg = groups.git_change, bg = "NONE" },
		GitSignsDelete = { fg = groups.git_delete, bg = "NONE" },
		SignAdd = { fg = groups.git_add, bg = "NONE" },
		SignChange = { fg = groups.git_change, bg = "NONE" },
		SignDelete = { fg = groups.git_delete, bg = "NONE" },

		-- mvllow/modes.nvim
		ModesCopy = { bg = palette.elixir },
		ModesDelete = { bg = palette.tribulation },
		ModesFormat = { bg = palette.jade },
		ModesInsert = { bg = palette.core },
		ModesReplace = { bg = palette.heaven },
		ModesVisual = { bg = palette.heaven },

		-- kyazdani42/nvim-tree.lua
		NvimTreeEmptyFolderName = { fg = palette.ash },
		NvimTreeFileDeleted = { fg = groups.git_delete },
		NvimTreeFileDirty = { fg = groups.git_dirty },
		NvimTreeFileMerge = { fg = groups.git_merge },
		NvimTreeFileNew = { fg = palette.core },
		NvimTreeFileRenamed = { fg = groups.git_rename },
		NvimTreeFileStaged = { fg = groups.git_stage },
		NvimTreeFolderIcon = { fg = palette.incense },
		NvimTreeFolderName = { fg = palette.core },
		NvimTreeGitDeleted = { fg = groups.git_delete },
		NvimTreeGitDirty = { fg = groups.git_dirty },
		NvimTreeGitIgnored = { fg = groups.git_ignore },
		NvimTreeGitMerge = { fg = groups.git_merge },
		NvimTreeGitNew = { fg = groups.git_add },
		NvimTreeGitRenamed = { fg = groups.git_rename },
		NvimTreeGitStaged = { fg = groups.git_stage },
		NvimTreeImageFile = { fg = palette.text },
		NvimTreeNormal = { link = "Normal" },
		NvimTreeOpenedFile = { fg = palette.text, bg = palette.overlay },
		NvimTreeOpenedFolderName = { link = "NvimTreeFolderName" },
		NvimTreeRootFolder = { fg = palette.core, bold = styles.bold },
		NvimTreeSpecialFile = { link = "NvimTreeNormal" },
		NvimTreeWindowPicker = { link = "StatusLineTerm" },

		-- nvim-neotest/neotest
		NeotestAdapterName = { fg = palette.furnace },
		NeotestBorder = { fg = palette.highlight_med },
		NeotestDir = { fg = palette.core },
		NeotestExpandMarker = { fg = palette.highlight_med },
		NeotestFailed = { fg = palette.tribulation },
		NeotestFile = { fg = palette.text },
		NeotestFocused = { fg = palette.elixir, bg = palette.highlight_med },
		NeotestIndent = { fg = palette.highlight_med },
		NeotestMarked = { fg = palette.jade, bold = styles.bold },
		NeotestNamespace = { fg = palette.elixir },
		NeotestPassed = { fg = palette.heaven },
		NeotestRunning = { fg = palette.elixir },
		NeotestWinSelect = { fg = palette.ash },
		NeotestSkipped = { fg = palette.incense },
		NeotestTarget = { fg = palette.tribulation },
		NeotestTest = { fg = palette.elixir },
		NeotestUnknown = { fg = palette.incense },
		NeotestWatching = { fg = palette.furnace },

		-- nvim-neo-tree/neo-tree.nvim
		NeoTreeGitAdded = { fg = groups.git_add },
		NeoTreeGitConflict = { fg = groups.git_merge },
		NeoTreeGitDeleted = { fg = groups.git_delete },
		NeoTreeGitIgnored = { fg = groups.git_ignore },
		NeoTreeGitModified = { fg = groups.git_dirty },
		NeoTreeGitRenamed = { fg = groups.git_rename },
		NeoTreeGitUntracked = { fg = groups.git_untracked },
		NeoTreeTabActive = { fg = palette.text, bg = palette.overlay },
		NeoTreeTabInactive = { fg = palette.incense },
		NeoTreeTabSeparatorActive = { link = "WinSeparator" },
		NeoTreeTabSeparatorInactive = { link = "WinSeparator" },
		NeoTreeTitleBar = { link = "StatusLineTerm" },

		-- folke/flash.nvim
		FlashLabel = { fg = palette.base, bg = palette.tribulation },

		-- folke/which-key.nvim
		WhichKey = { fg = palette.furnace },
		WhichKeyBorder = make_border(),
		WhichKeyDesc = { fg = palette.elixir },
		WhichKeyFloat = { bg = groups.panel },
		WhichKeyGroup = { fg = palette.core },
		WhichKeyIcon = { fg = palette.heaven },
		WhichKeyIconAzure = { fg = palette.heaven },
		WhichKeyIconBlue = { fg = palette.heaven },
		WhichKeyIconCyan = { fg = palette.jade },
		WhichKeyIconGreen = { fg = palette.herb },
		WhichKeyIconGrey = { fg = palette.incense },
		WhichKeyIconOrange = { fg = palette.furnace },
		WhichKeyIconPurple = { fg = palette.heaven },
		WhichKeyIconRed = { fg = palette.tribulation },
		WhichKeyIconYellow = { fg = palette.elixir },
		WhichKeyNormal = { link = "NormalFloat" },
		WhichKeySeparator = { fg = palette.incense },
		WhichKeyTitle = { link = "FloatTitle" },
		WhichKeyValue = { fg = palette.jade },

		-- lukas-reineke/indent-blankline.nvim
		IblIndent = { fg = palette.overlay },
		IblScope = { fg = palette.core },
		IblWhitespace = { fg = palette.overlay },

		-- hrsh7th/nvim-cmp
		CmpItemAbbr = { fg = palette.incense },
		CmpItemAbbrDeprecated = { fg = palette.incense, strikethrough = true },
		CmpItemAbbrMatch = { fg = palette.text, bold = styles.bold },
		CmpItemAbbrMatchFuzzy = { fg = palette.text, bold = styles.bold },
		CmpItemKind = { fg = palette.incense },
		CmpItemKindClass = { link = "StorageClass" },
		CmpItemKindFunction = { link = "Function" },
		CmpItemKindInterface = { link = "Type" },
		CmpItemKindMethod = { link = "PreProc" },
		CmpItemKindSnippet = { link = "String" },
		CmpItemKindVariable = { link = "Identifier" },

		-- NeogitOrg/neogit
		-- https://github.com/NeogitOrg/neogit/blob/master/lua/neogit/lib/hl.lua#L109-L198
		NeogitChangeAdded = { fg = groups.git_add, bold = styles.bold, italic = styles.italic },
		NeogitChangeBothModified = { fg = groups.git_change, bold = styles.bold, italic = styles.italic },
		NeogitChangeCopied = { fg = groups.git_untracked, bold = styles.bold, italic = styles.italic },
		NeogitChangeDeleted = { fg = groups.git_delete, bold = styles.bold, italic = styles.italic },
		NeogitChangeModified = { fg = groups.git_change, bold = styles.bold, italic = styles.italic },
		NeogitChangeNewFile = { fg = groups.git_stage, bold = styles.bold, italic = styles.italic },
		NeogitChangeRenamed = { fg = groups.git_rename, bold = styles.bold, italic = styles.italic },
		NeogitChangeUpdated = { fg = groups.git_change, bold = styles.bold, italic = styles.italic },
		NeogitDiffAddHighlight = { link = "DiffAdd" },
		NeogitDiffContextHighlight = { bg = palette.surface },
		NeogitDiffDeleteHighlight = { link = "DiffDelete" },
		NeogitFilePath = { fg = palette.core, italic = styles.italic },
		NeogitHunkHeader = { bg = groups.panel },
		NeogitHunkHeaderHighlight = { bg = groups.panel },

		-- vimwiki/vimwiki
		VimwikiHR = { fg = palette.incense },
		VimwikiHeader1 = { link = "markdownH1" },
		VimwikiHeader2 = { link = "markdownH2" },
		VimwikiHeader3 = { link = "markdownH3" },
		VimwikiHeader4 = { link = "markdownH4" },
		VimwikiHeader5 = { link = "markdownH5" },
		VimwikiHeader6 = { link = "markdownH6" },
		VimwikiHeaderChar = { fg = palette.incense },
		VimwikiLink = { link = "markdownUrl" },
		VimwikiList = { fg = palette.furnace },
		VimwikiNoExistsLink = { fg = palette.tribulation },

		-- nvim-neorg/neorg
		NeorgHeading1Prefix = { link = "markdownH1Delimiter" },
		NeorgHeading1Title = { link = "markdownH1" },
		NeorgHeading2Prefix = { link = "markdownH2Delimiter" },
		NeorgHeading2Title = { link = "markdownH2" },
		NeorgHeading3Prefix = { link = "markdownH3Delimiter" },
		NeorgHeading3Title = { link = "markdownH3" },
		NeorgHeading4Prefix = { link = "markdownH4Delimiter" },
		NeorgHeading4Title = { link = "markdownH4" },
		NeorgHeading5Prefix = { link = "markdownH5Delimiter" },
		NeorgHeading5Title = { link = "markdownH5" },
		NeorgHeading6Prefix = { link = "markdownH6Delimiter" },
		NeorgHeading6Title = { link = "markdownH6" },
		NeorgMarkerTitle = { fg = palette.core, bold = styles.bold },

		-- tami5/lspsaga.nvim (fork of glepnir/lspsaga.nvim)
		DefinitionCount = { fg = palette.jade },
		DefinitionIcon = { fg = palette.jade },
		DefinitionPreviewTitle = { fg = palette.jade, bold = styles.bold },
		LspFloatWinBorder = make_border(),
		LspFloatWinNormal = { bg = groups.panel },
		LspSagaAutoPreview = { fg = palette.incense },
		LspSagaCodeActionBorder = make_border(palette.jade),
		LspSagaCodeActionContent = { fg = palette.core },
		LspSagaCodeActionTitle = { fg = palette.elixir, bold = styles.bold },
		LspSagaCodeActionTruncateLine = { link = "LspSagaCodeActionBorder" },
		LspSagaDefPreviewBorder = make_border(),
		LspSagaDiagnosticBorder = make_border(palette.elixir),
		LspSagaDiagnosticHeader = { fg = palette.core, bold = styles.bold },
		LspSagaDiagnosticTruncateLine = { link = "LspSagaDiagnosticBorder" },
		LspSagaDocTruncateLine = { link = "LspSagaHoverBorder" },
		LspSagaFinderSelection = { fg = palette.elixir },
		LspSagaHoverBorder = { link = "LspFloatWinBorder" },
		LspSagaLspFinderBorder = { link = "LspFloatWinBorder" },
		LspSagaRenameBorder = make_border(palette.heaven),
		LspSagaRenamePromptPrefix = { fg = palette.tribulation },
		LspSagaShTruncateLine = { link = "LspSagaSignatureHelpBorder" },
		LspSagaSignatureHelpBorder = make_border(palette.core),
		ReferencesCount = { fg = palette.jade },
		ReferencesIcon = { fg = palette.jade },
		SagaShadow = { bg = palette.overlay },
		TargetWord = { fg = palette.furnace },

		-- ray-x/lsp_signature.nvim
		LspSignatureActiveParameter = { bg = palette.overlay },

		-- rlane/pounce.nvim
		PounceAccept = { fg = palette.tribulation, bg = palette.tribulation, blend = 20 },
		PounceAcceptBest = { fg = palette.elixir, bg = palette.elixir, blend = 20 },
		PounceGap = { link = "Search" },
		PounceMatch = { link = "Search" },

		-- ggandor/leap.nvim
		LeapLabelPrimary = { link = "IncSearch" },
		LeapLabelSecondary = { link = "StatusLineTerm" },
		LeapMatch = { link = "MatchParen" },

		-- phaazon/hop.nvim
		-- smoka7/hop.nvim
		HopNextKey = { fg = palette.tribulation, bg = palette.tribulation, blend = 20 },
		HopNextKey1 = { fg = palette.core, bg = palette.core, blend = 20 },
		HopNextKey2 = { fg = palette.heaven, bg = palette.heaven, blend = 20 },
		HopUnmatched = { fg = palette.ash },

		-- nvim-telescope/telescope.nvim
		TelescopeBorder = make_border(),
		TelescopeMatching = { fg = palette.jade },
		TelescopeNormal = { link = "NormalFloat" },
		TelescopePromptNormal = { link = "TelescopeNormal" },
		TelescopePromptPrefix = { fg = palette.incense },
		TelescopeSelection = { fg = palette.text, bg = palette.overlay },
		TelescopeSelectionCaret = { fg = palette.jade, bg = palette.overlay },
		TelescopeTitle = { fg = palette.core, bold = styles.bold },

		-- ibhagwan/fzf-lua
		FzfLuaBorder = make_border(),
		FzfLuaBufFlagAlt = { fg = palette.incense },
		FzfLuaBufFlagCur = { fg = palette.incense },
		FzfLuaCursorLine = { fg = palette.text, bg = palette.overlay },
		FzfLuaFilePart = { fg = palette.text },
		FzfLuaHeaderBind = { fg = palette.jade },
		FzfLuaHeaderText = { fg = palette.tribulation },
		FzfLuaNormal = { link = "NormalFloat" },
		FzfLuaTitle = { link = "FloatTitle" },

		-- rcarriga/nvim-notify
		NotifyBackground = { link = "NormalFloat" },
		NotifyDEBUGBody = { link = "NormalFloat" },
		NotifyDEBUGBorder = make_border(),
		NotifyDEBUGIcon = { link = "NotifyDEBUGTitle" },
		NotifyDEBUGTitle = { fg = palette.ash },
		NotifyERRORBody = { link = "NormalFloat" },
		NotifyERRORBorder = make_border(groups.error),
		NotifyERRORIcon = { link = "NotifyERRORTitle" },
		NotifyERRORTitle = { fg = groups.error },
		NotifyINFOBody = { link = "NormalFloat" },
		NotifyINFOBorder = make_border(groups.info),
		NotifyINFOIcon = { link = "NotifyINFOTitle" },
		NotifyINFOTitle = { fg = groups.info },
		NotifyTRACEBody = { link = "NormalFloat" },
		NotifyTRACEBorder = make_border(palette.furnace),
		NotifyTRACEIcon = { link = "NotifyTRACETitle" },
		NotifyTRACETitle = { fg = palette.furnace },
		NotifyWARNBody = { link = "NormalFloat" },
		NotifyWARNBorder = make_border(groups.warn),
		NotifyWARNIcon = { link = "NotifyWARNTitle" },
		NotifyWARNTitle = { fg = groups.warn },

		-- rcarriga/nvim-dap-ui
		DapUIBreakpointsCurrentLine = { fg = palette.elixir, bold = styles.bold },
		DapUIBreakpointsDisabledLine = { fg = palette.ash },
		DapUIBreakpointsInfo = { link = "DapUIThread" },
		DapUIBreakpointsLine = { link = "DapUIBreakpointsPath" },
		DapUIBreakpointsPath = { fg = palette.core },
		DapUIDecoration = { link = "DapUIBreakpointsPath" },
		DapUIFloatBorder = make_border(),
		DapUIFrameName = { fg = palette.text },
		DapUILineNumber = { link = "DapUIBreakpointsPath" },
		DapUIModifiedValue = { fg = palette.core, bold = styles.bold },
		DapUIScope = { link = "DapUIBreakpointsPath" },
		DapUISource = { fg = palette.furnace },
		DapUIStoppedThread = { link = "DapUIBreakpointsPath" },
		DapUIThread = { fg = palette.elixir },
		DapUIValue = { fg = palette.text },
		DapUIVariable = { fg = palette.text },
		DapUIType = { fg = palette.furnace },
		DapUIWatchesEmpty = { fg = palette.tribulation },
		DapUIWatchesError = { link = "DapUIWatchesEmpty" },
		DapUIWatchesValue = { link = "DapUIThread" },

		-- glepnir/dashboard-nvim
		DashboardCenter = { fg = palette.elixir },
		DashboardFooter = { fg = palette.furnace },
		DashboardHeader = { fg = palette.heaven },
		DashboardShortcut = { fg = palette.tribulation },

		-- SmiteshP/nvim-navic
		NavicIconsArray = { fg = palette.elixir },
		NavicIconsBoolean = { fg = palette.jade },
		NavicIconsClass = { fg = palette.core },
		NavicIconsConstant = { fg = palette.elixir },
		NavicIconsConstructor = { fg = palette.elixir },
		NavicIconsEnum = { fg = palette.elixir },
		NavicIconsEnumMember = { fg = palette.core },
		NavicIconsEvent = { fg = palette.elixir },
		NavicIconsField = { fg = palette.core },
		NavicIconsFile = { fg = palette.ash },
		NavicIconsFunction = { fg = palette.heaven },
		NavicIconsInterface = { fg = palette.core },
		NavicIconsKey = { fg = palette.furnace },
		NavicIconsKeyword = { fg = palette.heaven },
		NavicIconsMethod = { fg = palette.furnace },
		NavicIconsModule = { fg = palette.jade },
		NavicIconsNamespace = { fg = palette.ash },
		NavicIconsNull = { fg = palette.tribulation },
		NavicIconsNumber = { fg = palette.elixir },
		NavicIconsObject = { fg = palette.elixir },
		NavicIconsOperator = { fg = palette.incense },
		NavicIconsPackage = { fg = palette.ash },
		NavicIconsProperty = { fg = palette.core },
		NavicIconsString = { fg = palette.elixir },
		NavicIconsStruct = { fg = palette.core },
		NavicIconsTypeParameter = { fg = palette.core },
		NavicIconsVariable = { fg = palette.text },
		NavicSeparator = { fg = palette.incense },
		NavicText = { fg = palette.incense },

		-- folke/noice.nvim
		NoiceCursor = { fg = palette.highlight_high, bg = palette.text },

		-- folke/trouble.nvim
		TroubleText = { fg = palette.incense },
		TroubleCount = { fg = palette.furnace, bg = palette.surface },
		TroubleNormal = { fg = palette.text, bg = groups.panel },

		-- echasnovski/mini.nvim
		MiniAnimateCursor = { reverse = true, nocombine = true },
		MiniAnimateNormalFloat = { link = "NormalFloat" },

		MiniClueBorder = { link = "FloatBorder" },
		MiniClueDescGroup = { link = "DiagnosticFloatingWarn" },
		MiniClueDescSingle = { link = "NormalFloat" },
		MiniClueNextKey = { link = "DiagnosticFloatingHint" },
		MiniClueNextKeyWithPostkeys = { link = "DiagnosticFloatingError" },
		MiniClueSeparator = { link = "DiagnosticFloatingInfo" },
		MiniClueTitle = { bg = groups.panel, bold = styles.bold },

		MiniCompletionActiveParameter = { underline = true },

		MiniCursorword = { underline = true },
		MiniCursorwordCurrent = { underline = true },

		MiniDepsChangeAdded = { fg = groups.git_add },
		MiniDepsChangeRemoved = { fg = groups.git_delete },
		MiniDepsHint = { link = "DiagnosticHint" },
		MiniDepsInfo = { link = "DiagnosticInfo" },
		MiniDepsMsgBreaking = { link = "DiagnosticWarn" },
		MiniDepsPlaceholder = { link = "Comment" },
		MiniDepsTitle = { link = "Title" },
		MiniDepsTitleError = { link = "DiffDelete" },
		MiniDepsTitleSame = { link = "DiffText" },
		MiniDepsTitleUpdate = { link = "DiffAdd" },

		MiniDiffOverAdd = { fg = groups.git_add, bg = groups.git_add, blend = 20 },
		MiniDiffOverChange = { fg = groups.git_change, bg = groups.git_change, blend = 20 },
		MiniDiffOverContext = { bg = palette.surface },
		MiniDiffOverDelete = { fg = groups.git_delete, bg = groups.git_delete, blend = 20 },
		MiniDiffSignAdd = { fg = groups.git_add },
		MiniDiffSignChange = { fg = groups.git_change },
		MiniDiffSignDelete = { fg = groups.git_delete },

		MiniFilesBorder = { link = "FloatBorder" },
		MiniFilesBorderModified = { link = "DiagnosticFloatingWarn" },
		MiniFilesCursorLine = { link = "CursorLine" },
		MiniFilesDirectory = { link = "Directory" },
		MiniFilesFile = { fg = palette.text },
		MiniFilesNormal = { link = "NormalFloat" },
		MiniFilesTitle = { link = "FloatTitle" },
		MiniFilesTitleFocused = { fg = palette.jade, bg = groups.panel, bold = styles.bold },

		MiniHipatternsFixme = { fg = palette.base, bg = groups.error, bold = styles.bold },
		MiniHipatternsHack = { fg = palette.base, bg = groups.warn, bold = styles.bold },
		MiniHipatternsNote = { fg = palette.base, bg = groups.info, bold = styles.bold },
		MiniHipatternsTodo = { fg = palette.base, bg = groups.hint, bold = styles.bold },

		MiniIconsAzure = { fg = palette.core },
		MiniIconsBlue = { fg = palette.heaven },
		MiniIconsCyan = { fg = palette.core },
		MiniIconsGreen = { fg = palette.herb },
		MiniIconsGrey = { fg = palette.incense },
		MiniIconsOrange = { fg = palette.jade },
		MiniIconsPurple = { fg = palette.heaven },
		MiniIconsRed = { fg = palette.tribulation },
		MiniIconsYellow = { fg = palette.elixir },

		MiniIndentscopeSymbol = { fg = palette.ash },
		MiniIndentscopeSymbolOff = { fg = palette.elixir },

		MiniJump = { sp = palette.elixir, undercurl = true },

		MiniJump2dDim = { fg = palette.incense },
		MiniJump2dSpot = { fg = palette.elixir, bold = styles.bold, nocombine = true },
		MiniJump2dSpotAhead = { fg = palette.core, bg = palette.surface, nocombine = true },
		MiniJump2dSpotUnique = { fg = palette.jade, bold = styles.bold, nocombine = true },

		MiniMapNormal = { link = "NormalFloat" },
		MiniMapSymbolCount = { link = "Special" },
		MiniMapSymbolLine = { link = "Title" },
		MiniMapSymbolView = { link = "Delimiter" },

		MiniNotifyBorder = { link = "FloatBorder" },
		MiniNotifyNormal = { link = "NormalFloat" },
		MiniNotifyTitle = { link = "FloatTitle" },

		MiniOperatorsExchangeFrom = { link = "IncSearch" },

		MiniPickBorder = { link = "FloatBorder" },
		MiniPickBorderBusy = { link = "DiagnosticFloatingWarn" },
		MiniPickBorderText = { bg = groups.panel },
		MiniPickIconDirectory = { link = "Directory" },
		MiniPickIconFile = { link = "MiniPickNormal" },
		MiniPickHeader = { link = "DiagnosticFloatingHint" },
		MiniPickMatchCurrent = { link = "CursorLine" },
		MiniPickMatchMarked = { link = "Visual" },
		MiniPickMatchRanges = { fg = palette.core },
		MiniPickNormal = { link = "NormalFloat" },
		MiniPickPreviewLine = { link = "CursorLine" },
		MiniPickPreviewRegion = { link = "IncSearch" },
		MiniPickPrompt = { bg = groups.panel, bold = styles.bold },

		MiniStarterCurrent = { nocombine = true },
		MiniStarterFooter = { fg = palette.incense },
		MiniStarterHeader = { link = "Title" },
		MiniStarterInactive = { link = "Comment" },
		MiniStarterItem = { link = "Normal" },
		MiniStarterItemBullet = { link = "Delimiter" },
		MiniStarterItemPrefix = { link = "WarningMsg" },
		MiniStarterSection = { fg = palette.jade },
		MiniStarterQuery = { link = "MoreMsg" },

		MiniStatuslineDevinfo = { fg = palette.incense, bg = palette.overlay },
		MiniStatuslineFileinfo = { link = "MiniStatuslineDevinfo" },
		MiniStatuslineFilename = { fg = palette.ash, bg = palette.surface },
		MiniStatuslineInactive = { link = "MiniStatuslineFilename" },
		MiniStatuslineModeCommand = { fg = palette.base, bg = palette.tribulation, bold = styles.bold },
		MiniStatuslineModeInsert = { fg = palette.base, bg = palette.core, bold = styles.bold },
		MiniStatuslineModeNormal = { fg = palette.base, bg = palette.jade, bold = styles.bold },
		MiniStatuslineModeOther = { fg = palette.base, bg = palette.jade, bold = styles.bold },
		MiniStatuslineModeReplace = { fg = palette.base, bg = palette.heaven, bold = styles.bold },
		MiniStatuslineModeVisual = { fg = palette.base, bg = palette.heaven, bold = styles.bold },

		MiniSurround = { link = "IncSearch" },

		MiniTablineCurrent = { fg = palette.text, bg = palette.overlay, bold = styles.bold },
		MiniTablineFill = { link = "TabLineFill" },
		MiniTablineHidden = { fg = palette.incense, bg = groups.panel },
		MiniTablineModifiedCurrent = { fg = palette.overlay, bg = palette.text, bold = styles.bold },
		MiniTablineModifiedHidden = { fg = groups.panel, bg = palette.incense },
		MiniTablineModifiedVisible = { fg = groups.panel, bg = palette.text },
		MiniTablineTabpagesection = { link = "Search" },
		MiniTablineVisible = { fg = palette.text, bg = groups.panel },

		MiniTestEmphasis = { bold = styles.bold },
		MiniTestFail = { fg = palette.tribulation, bold = styles.bold },
		MiniTestPass = { fg = palette.core, bold = styles.bold },

		MiniTrailspace = { bg = palette.tribulation },

		-- goolord/alpha-nvim
		AlphaButtons = { fg = palette.core },
		AlphaFooter = { fg = palette.elixir },
		AlphaHeader = { fg = palette.heaven },
		AlphaShortcut = { fg = palette.jade },

		-- github/copilot.vim
		CopilotSuggestion = { fg = palette.ash, italic = styles.italic },

		-- nvim-treesitter/nvim-treesitter-context
		TreesitterContext = { bg = palette.overlay },
		TreesitterContextLineNumber = { fg = palette.jade, bg = palette.overlay },

		-- RRethy/vim-illuminate
		IlluminatedWordRead = { link = "LspReferenceRead" },
		IlluminatedWordText = { link = "LspReferenceText" },
		IlluminatedWordWrite = { link = "LspReferenceWrite" },

		-- HiPhish/rainbow-delimiters.nvim
		RainbowDelimiterBlue = { fg = palette.heaven },
		RainbowDelimiterCyan = { fg = palette.core },
		RainbowDelimiterGreen = { fg = palette.herb },
		RainbowDelimiterOrange = { fg = palette.jade },
		RainbowDelimiterRed = { fg = palette.tribulation },
		RainbowDelimiterViolet = { fg = palette.heaven },
		RainbowDelimiterYellow = { fg = palette.elixir },

		-- MeanderingProgrammer/render-markdown.nvim
		RenderMarkdownBullet = { fg = palette.jade },
		RenderMarkdownChecked = { fg = palette.core },
		RenderMarkdownCode = { bg = palette.overlay },
		RenderMarkdownCodeInline = { fg = palette.text, bg = palette.overlay },
		RenderMarkdownDash = { fg = palette.ash },
		RenderMarkdownH1Bg = { bg = groups.h1, blend = 20 },
		RenderMarkdownH2Bg = { bg = groups.h2, blend = 20 },
		RenderMarkdownH3Bg = { bg = groups.h3, blend = 20 },
		RenderMarkdownH4Bg = { bg = groups.h4, blend = 20 },
		RenderMarkdownH5Bg = { bg = groups.h5, blend = 20 },
		RenderMarkdownH6Bg = { bg = groups.h6, blend = 20 },
		RenderMarkdownQuote = { fg = palette.incense },
		RenderMarkdownTableFill = { link = "Conceal" },
		RenderMarkdownTableHead = { fg = palette.incense },
		RenderMarkdownTableRow = { fg = palette.incense },
		RenderMarkdownUnchecked = { fg = palette.incense },

		-- MagicDuck/grug-far.nvim
		GrugFarHelpHeader = { fg = palette.heaven },
		GrugFarHelpHeaderKey = { fg = palette.elixir },
		GrugFarHelpWinActionKey = { fg = palette.elixir },
		GrugFarHelpWinActionPrefix = { fg = palette.core },
		GrugFarHelpWinActionText = { fg = palette.heaven },
		GrugFarHelpWinHeader = { link = "FloatTitle" },
		GrugFarInputLabel = { fg = palette.core },
		GrugFarInputPlaceholder = { link = "Comment" },
		GrugFarResultsActionMessage = { fg = palette.core },
		GrugFarResultsChangeIndicator = { fg = groups.git_change },
		GrugFarResultsRemoveIndicator = { fg = groups.git_delete },
		GrugFarResultsAddIndicator = { fg = groups.git_add },
		GrugFarResultsHeader = { fg = palette.heaven },
		GrugFarResultsLineNo = { fg = palette.furnace },
		GrugFarResultsLineColumn = { link = "GrugFarResultsLineNo" },
		GrugFarResultsMatch = { link = "CurSearch" },
		GrugFarResultsPath = { fg = palette.core },
		GrugFarResultsStats = { fg = palette.furnace },

		-- yetone/avante.nvim
		AvanteTitle = { fg = palette.highlight_high, bg = palette.jade },
		AvanteReversedTitle = { fg = palette.jade },
		AvanteSubtitle = { fg = palette.highlight_med, bg = palette.core },
		AvanteReversedSubtitle = { fg = palette.core },
		AvanteThirdTitle = { fg = palette.highlight_med, bg = palette.furnace },
		AvanteReversedThirdTitle = { fg = palette.furnace },
		AvantePromptInput = { fg = palette.text, bg = groups.panel },
		AvantePromptInputBorder = { fg = groups.border },

		-- Saghen/blink.cmp
		BlinkCmpDoc = { bg = palette.highlight_low },
		BlinkCmpDocSeparator = { bg = palette.highlight_low },
		BlinkCmpDocBorder = { fg = palette.highlight_high },
		BlinkCmpGhostText = { fg = palette.ash },

		BlinkCmpLabel = { fg = palette.ash },
		BlinkCmpLabelDeprecated = { fg = palette.ash, strikethrough = true },
		BlinkCmpLabelMatch = { fg = palette.text, bold = styles.bold },

		BlinkCmpDefault = { fg = palette.highlight_med },
		BlinkCmpKindText = { fg = palette.heaven },
		BlinkCmpKindMethod = { fg = palette.core },
		BlinkCmpKindFunction = { fg = palette.core },
		BlinkCmpKindConstructor = { fg = palette.core },
		BlinkCmpKindField = { fg = palette.heaven },
		BlinkCmpKindVariable = { fg = palette.jade },
		BlinkCmpKindClass = { fg = palette.elixir },
		BlinkCmpKindInterface = { fg = palette.elixir },
		BlinkCmpKindModule = { fg = palette.core },
		BlinkCmpKindProperty = { fg = palette.core },
		BlinkCmpKindUnit = { fg = palette.heaven },
		BlinkCmpKindValue = { fg = palette.tribulation },
		BlinkCmpKindKeyword = { fg = palette.furnace },
		BlinkCmpKindSnippet = { fg = palette.jade },
		BlinkCmpKindColor = { fg = palette.tribulation },
		BlinkCmpKindFile = { fg = palette.core },
		BlinkCmpKindReference = { fg = palette.tribulation },
		BlinkCmpKindFolder = { fg = palette.core },
		BlinkCmpKindEnum = { fg = palette.core },
		BlinkCmpKindEnumMember = { fg = palette.core },
		BlinkCmpKindConstant = { fg = palette.elixir },
		BlinkCmpKindStruct = { fg = palette.core },
		BlinkCmpKindEvent = { fg = palette.core },
		BlinkCmpKindOperator = { fg = palette.core },
		BlinkCmpKindTypeParameter = { fg = palette.furnace },
		BlinkCmpKindCodeium = { fg = palette.core },
		BlinkCmpKindCopilot = { fg = palette.core },
		BlinkCmpKindSupermaven = { fg = palette.core },
		BlinkCmpKindTabNine = { fg = palette.core },

		-- folke/snacks.nvim
		SnacksIndent = { fg = palette.overlay },
		SnacksIndentChunk = { fg = palette.overlay },
		SnacksIndentBlank = { fg = palette.overlay },
		SnacksIndentScope = { fg = palette.core },

		SnacksPickerMatch = { fg = palette.jade, bold = styles.bold },

		-- justinmk/vim-sneak
		Sneak = { fg = palette.base, bg = palette.tribulation },
		SneakCurrent = { link = "StatusLineTerm" },
		SneakScope = { link = "IncSearch" },

		-- sindrets/diffview.nvim
		DiffviewPrimary = { fg = palette.heaven },
		DiffviewSecondary = { fg = palette.core },
		DiffviewNormal = { fg = palette.text, bg = palette.surface },
		DiffviewWinSeparator = { fg = palette.text, bg = palette.surface },

		DiffviewFilePanelTitle = { fg = palette.core, bold = styles.bold },
		DiffviewFilePanelCounter = { fg = palette.jade },
		DiffviewFilePanelRootPath = { fg = palette.core, bold = styles.bold },
		DiffviewFilePanelFileName = { fg = palette.text },
		DiffviewFilePanelSelected = { fg = palette.elixir },
		DiffviewFilePanelPath = { link = "Comment" },

		DiffviewFilePanelInsertions = { fg = groups.git_add },
		DiffviewFilePanelDeletions = { fg = groups.git_delete },
		DiffviewFilePanelConflicts = { fg = groups.git_merge },
		DiffviewFolderName = { fg = palette.core, bold = styles.bold },
		DiffviewFolderSign = { fg = palette.incense },
		DiffviewHash = { fg = palette.jade },
		DiffviewReference = { fg = palette.core, bold = styles.bold },
		DiffviewReflogSelector = { fg = palette.jade },
		DiffviewStatusAdded = { fg = groups.git_add },
		DiffviewStatusUntracked = { fg = groups.git_untracked },
		DiffviewStatusModified = { fg = groups.git_change },
		DiffviewStatusRenamed = { fg = groups.git_rename },
		DiffviewStatusCopied = { fg = groups.git_untracked },
		DiffviewStatusTypeChange = { fg = groups.git_change },
		DiffviewStatusUnmerged = { fg = groups.git_change },
		DiffviewStatusUnknown = { fg = groups.git_delete },
		DiffviewStatusDeleted = { fg = groups.git_delete },
		DiffviewStatusBroken = { fg = groups.git_delete },
		DiffviewStatusIgnored = { fg = groups.git_ignore },
	}
	local transparency_highlights = {
		DiagnosticVirtualTextError = { fg = groups.error },
		DiagnosticVirtualTextHint = { fg = groups.hint },
		DiagnosticVirtualTextInfo = { fg = groups.info },
		DiagnosticVirtualTextOk = { fg = groups.ok },
		DiagnosticVirtualTextWarn = { fg = groups.warn },

		FloatBorder = { fg = palette.ash, bg = "NONE" },
		FloatTitle = { fg = palette.core, bg = "NONE", bold = styles.bold },
		Folded = { fg = palette.text, bg = "NONE" },
		NormalFloat = { bg = "NONE" },
		Normal = { fg = palette.text, bg = "NONE" },
		NormalNC = { fg = palette.text, bg = config.options.dim_inactive_windows and palette._nc or "NONE" },
		Pmenu = { fg = palette.incense, bg = "NONE" },
		PmenuExtra = { fg = palette.text, bg = "NONE" },
		PmenuKind = { fg = palette.core, bg = "NONE" },
		SignColumn = { fg = palette.text, bg = "NONE" },
		StatusLine = { fg = palette.incense, bg = "NONE" },
		StatusLineNC = { fg = palette.ash, bg = "NONE" },
		TabLine = { bg = "NONE", fg = palette.incense },
		TabLineFill = { bg = "NONE" },
		TabLineSel = { fg = palette.text, bg = "NONE", bold = styles.bold },

		-- ["@markup.raw"] = { bg = "none" },
		["@markup.raw.markdown_inline"] = { fg = palette.elixir },
		-- ["@markup.raw.block"] = { bg = "none" },

		TelescopeNormal = { fg = palette.incense, bg = "NONE" },
		TelescopePromptNormal = { fg = palette.text, bg = "NONE" },
		TelescopeSelection = { fg = palette.text, bg = "NONE", bold = styles.bold },
		TelescopeSelectionCaret = { fg = palette.jade },

		TroubleNormal = { bg = "NONE" },

		WhichKeyFloat = { bg = "NONE" },
		WhichKeyNormal = { bg = "NONE" },

		IblIndent = { fg = palette.overlay, bg = "NONE" },
		IblScope = { fg = palette.core, bg = "NONE" },
		IblWhitespace = { fg = palette.overlay, bg = "NONE" },

		TreesitterContext = { bg = "NONE" },
		TreesitterContextLineNumber = { fg = palette.jade, bg = "NONE" },

		MiniFilesTitleFocused = { fg = palette.jade, bg = "NONE", bold = styles.bold },

		MiniPickPrompt = { bg = "NONE", bold = styles.bold },
		MiniPickBorderText = { bg = "NONE" },
	}

	if config.options.enable.legacy_highlights then
		for group, highlight in pairs(legacy_highlights) do
			highlights[group] = highlight
		end
	end
	for group, highlight in pairs(default_highlights) do
		highlights[group] = highlight
	end
	if styles.transparency then
		for group, highlight in pairs(transparency_highlights) do
			highlights[group] = highlight
		end
	end

	-- Reconcile highlights with config
	if config.options.highlight_groups ~= nil and next(config.options.highlight_groups) ~= nil then
		for group, highlight in pairs(config.options.highlight_groups) do
			local existing = highlights[group] or {}
			-- Traverse link due to
			-- "If link is used in combination with other attributes; only the link will take effect"
			-- see: https://neovim.io/doc/user/api.html#nvim_set_hl()
			while existing.link ~= nil do
				existing = highlights[existing.link] or {}
			end
			local parsed = vim.tbl_extend("force", {}, highlight)

			if highlight.fg ~= nil then
				parsed.fg = utilities.parse_color(highlight.fg) or highlight.fg
			end
			if highlight.bg ~= nil then
				parsed.bg = utilities.parse_color(highlight.bg) or highlight.bg
			end
			if highlight.sp ~= nil then
				parsed.sp = utilities.parse_color(highlight.sp) or highlight.sp
			end

			if (highlight.inherit == nil or highlight.inherit) and existing ~= nil then
				parsed.inherit = nil
				highlights[group] = vim.tbl_extend("force", existing, parsed)
			else
				parsed.inherit = nil
				highlights[group] = parsed
			end
		end
	end

	for group, highlight in pairs(highlights) do
		if config.options.before_highlight ~= nil then
			config.options.before_highlight(group, highlight, palette)
		end

		if highlight.blend ~= nil and (highlight.blend >= 0 and highlight.blend <= 100) and highlight.bg ~= nil then
			highlight.bg = utilities.blend(highlight.bg, highlight.blend_on or palette.base, highlight.blend / 100)
		end

		highlight.blend = nil
		highlight.blend_on = nil

		if highlight._nvim_blend ~= nil then
			highlight.blend = highlight._nvim_blend
		end

		vim.api.nvim_set_hl(0, group, highlight)
	end

	--- Terminal
	-- Mirrors the 16-color ANSI table the terminal themes ship.
	if config.options.enable.terminal then
		vim.g.terminal_color_0 = palette.border -- black
		vim.g.terminal_color_8 = palette.b_black -- bright black
		vim.g.terminal_color_1 = palette.tribulation -- red
		vim.g.terminal_color_9 = palette.b_red -- bright red
		vim.g.terminal_color_2 = palette.herb -- green
		vim.g.terminal_color_10 = palette.b_green -- bright green
		vim.g.terminal_color_3 = palette.elixir -- yellow
		vim.g.terminal_color_11 = palette.b_yellow -- bright yellow
		vim.g.terminal_color_4 = palette.heaven -- blue
		vim.g.terminal_color_12 = palette.b_blue -- bright blue
		vim.g.terminal_color_5 = palette.blossom -- magenta
		vim.g.terminal_color_13 = palette.b_magenta -- bright magenta
		vim.g.terminal_color_6 = palette.jade -- cyan
		vim.g.terminal_color_14 = palette.b_cyan -- bright cyan
		vim.g.terminal_color_7 = palette.b_white7 -- white
		vim.g.terminal_color_15 = palette.text -- bright white

		-- Support StatusLineTerm & StatusLineTermNC from vim
		vim.cmd([[
		augroup spirit-furnace
			autocmd!
			autocmd TermOpen * if &buftype=='terminal'
				\|setlocal winhighlight=StatusLine:StatusLineTerm,StatusLineNC:StatusLineTermNC
				\|else|setlocal winhighlight=|endif
			autocmd ColorSchemePre * autocmd! spirit-furnace
		augroup END
		]])
	end
end

function M.load()
	vim.opt.termguicolors = true
	if vim.g.colors_name then
		vim.cmd("hi clear")
		vim.cmd("syntax reset")
	end
	vim.o.background = require("spirit-furnace.palette")()._mode
	vim.g.colors_name = "spirit-furnace"

	set_highlights()
end

---@param options Options
function M.setup(options)
	config.extend_options(options or {})
end

return M
