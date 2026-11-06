-- Spirit Furnace palette: shared accents over a selectable ramp.
-- Variants set the ramp (base/surface/overlay/_nc + highlight grays) and may
-- override individual accents. Select with:
--   require("spirit-furnace").setup({ variant = "lifted" })  -- furnace is the default
local config = require("spirit-furnace.config")

-- accents + neutrals, unless a variant overrides them
local shared = {
	ash = "#806c55",
	incense = "#9a8467",
	text = "#f6e7cb",

	tribulation = "#f5502a",
	elixir = "#ebb944",
	jade = "#58b98a",
	heaven = "#749ad2",
	core = "#a9e3c9",
	blossom = "#cc95dc",
	furnace = "#e48a45",
	herb = "#9dc957",
	cursor = "#a9e3c9",

	-- bright ANSI, used only by the embedded terminal
	b_white7 = "#dcceb4",
	b_red = "#ff795a",
	b_green = "#bae183",
	b_yellow = "#ffd579",
	b_blue = "#92b3e4",
	b_magenta = "#e2b2f0",
	b_cyan = "#81d0a6",

	none = "NONE",
}

-- per-variant dark ramp and accent overrides
local ramps = {
	-- furnace: lacquered rosewood brown, lit from the pill furnace (default)
	furnace = {
		base = "#261207", surface = "#33190b", overlay = "#432310", _nc = "#1e0902",
		highlight_low = "#3f291c", highlight_med = "#664534", highlight_high = "#795846",
		border = "#492b1a", selection = "#303321",
		_mode = "dark",
	},
	-- lifted: furnace with the floor raised and the steps widened, so the depth
	-- survives on a basic laptop LCD instead of crushing to flat brown.
	lifted = {
		base = "#2e170c", surface = "#412619", overlay = "#5a3824", _nc = "#271107",
		highlight_low = "#4b3226", highlight_med = "#6c4b3a", highlight_high = "#7f5e4c",
		border = "#583926", selection = "#363725",
		_mode = "dark",
	},
	-- paper: an old yellowed scroll, dimmed well below white so it never glares.
	-- Pigments re-fit to ~4.5:1; core is ink-lacquer since gold and green crowd on paper.
	paper = {
		base = "#c9b98f", surface = "#c1b082", overlay = "#b7a573", _nc = "#c3b389",
		highlight_low = "#b0aa99", highlight_med = "#99917d", highlight_high = "#857c65",
		border = "#ae9d70", selection = "#b9ceac",
		_mode = "light",
		ash = "#7c6c56",
		incense = "#5e503d",
		text = "#2d2216",
		heaven = "#1d4988",
		jade = "#00563b",
		elixir = "#634500",
		blossom = "#673575",
		furnace = "#7b3600",
		core = "#683f4c",
		tribulation = "#951300",
		herb = "#305400",
		cursor = "#951300",
		b_white7 = "#443524",
		b_red = "#a51000",
		b_green = "#325b00",
		b_yellow = "#6e4c00",
		b_blue = "#1f5197",
		b_magenta = "#723a82",
		b_cyan = "#005d3f",
	},
}

local built = {}

-- Returns the merged palette for the configured variant. Memoized per variant
-- so the frequent parse_color() lookups don't rebuild it.
return function()
	local v = config.options.variant
	if v == "auto" then
		v = vim.o.background == "light" and config.options.light_variant or config.options.dark_variant
	end
	if not ramps[v] then v = "furnace" end
	if not built[v] then
		built[v] = vim.tbl_extend("force", {}, shared, ramps[v])
	end
	return built[v]
end
