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
	core = "#f7d98e",
	blossom = "#ea9297",
	furnace = "#e48a45",
	herb = "#9dc957",
	cursor = "#f7d98e",

	-- bright ANSI, used only by the embedded terminal
	b_white7 = "#dcceb4",
	b_red = "#ff795a",
	b_green = "#bae183",
	b_yellow = "#ffd579",
	b_blue = "#92b3e4",
	b_magenta = "#fdb0b3",
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
	-- paper: aged rice paper, muted so it never glares. Pigments darkened to ~5:1;
	-- core becomes bronze patina since two golds can't stay distinct on paper.
	paper = {
		base = "#e6dcc6", surface = "#ddd1b7", overlay = "#d2c4a6", _nc = "#dfd5c0",
		highlight_low = "#d2ccbe", highlight_med = "#bab2a2", highlight_high = "#a69d89",
		border = "#cabfa6", selection = "#c9b48e",
		_mode = "light",
		ash = "#8c7c66",
		incense = "#6e5f4c",
		text = "#3a2e22",
		heaven = "#2e5a9b",
		jade = "#1a664a",
		elixir = "#795a00",
		blossom = "#943e50",
		furnace = "#8e4717",
		core = "#59623b",
		tribulation = "#a92c18",
		herb = "#3f6414",
		cursor = "#a92c18",
		b_white7 = "#5a4a38",
		b_red = "#c1341d",
		b_green = "#4a741a",
		b_yellow = "#846200",
		b_blue = "#3668b1",
		b_magenta = "#a9485c",
		b_cyan = "#217656",
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
