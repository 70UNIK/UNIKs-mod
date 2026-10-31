if PB_UTIL and PB_UTIL.config.suits_enabled then
	table.insert(UNIK.light_suits, 'paperback_Stars')
	table.insert(UNIK.dark_suits, 'paperback_Crowns')
end

if next(SMODS.find_mod('MintysSillyMod')) then
	table.insert(UNIK.light_suits, 'minty_3s')
end

if PB_UTIL then
	table.insert(PB_UTIL.light_suits, 'unik_Noughts')
	table.insert(PB_UTIL.dark_suits, 'unik_Crosses')
end

-- Load modded suits
if next(SMODS.find_mod('Bunco')) then
	local prefix = SMODS.find_mod('Bunco')[1].prefix or "bunc"

	table.insert(UNIK.light_suits, prefix .. '_Fleurons')
	table.insert(UNIK.dark_suits, prefix .. '_Halberds')
end

--stolen from paperback
function UNIK.is_suit_type(card,type)
	return card:is_suit_shade(type)
    -- if PB_UTIL then
    --     return PB_UTIL.is_suit(card, type)
    -- else
    --     for _, v in ipairs(type == 'light' and UNIK.light_suits or UNIK.dark_suits) do
	-- 		if card:is_suit(v) then return true end
	-- 	end
	-- 	return false
    -- end
end

function UNIK.suit_in_deck(suit)
	if not G.playing_cards then return false end
		for i,v in pairs(G.playing_cards) do
			if v.base.suit == suit then
			return true
		end
	end
	return nil
  
end

--also stolen from paperback AGAIN!
function UNIK.suit_tooltip(type)
	local suits = {}
	for i, v in pairs(SMODS.Suits) do
		if type == v.shade then suits[#suits + 1] = i end
	end

	local key = 'paperback_' .. type .. '_suits'
	if #suits <= 2 then
		return {
		set = 'Other',
		key = key,
		vars = { colours = {} }
		}
	end

	-- If any modded suits were loaded, we need to dynamically
	-- add them to the localization table
	local visible_suits = {}
	for _, suit in ipairs(suits) do
		if not (
		next(SMODS.find_mod("Bunco"))
		and not (G.GAME and G.GAME.Exotic)
		and (suit == "bunc_Fleurons" or suit == "bunc_Halberds")
		) then
		visible_suits[#visible_suits + 1] = suit
		end
	end

	local text = {}
	local line = ""
	local text_parsed = {}
	local colours = {}

	for visible_i, suit in ipairs(visible_suits) do
		colours[#colours + 1] = G.C.SUITS[suit] or G.C.IMPORTANT

		line = line .. "{V:" .. visible_i .. "}" .. localize(suit, 'suits_plural') .. "{}"

		if visible_i < #visible_suits then
		line = line .. ", "
		end

		if #line > 25 then
		text[#text + 1] = line
		line = ""
		end
	end

	if #line > 0 then
		text[#text + 1] = line
	end

	for _, v in ipairs(text) do
		text_parsed[#text_parsed + 1] = loc_parse_string(v)
	end

	G.localization.descriptions.Other[key].text = text
	G.localization.descriptions.Other[key].text_parsed = text_parsed

	return {
		set = 'Other',
		key = key,
		vars = {
		colours = colours
		}
	}
end