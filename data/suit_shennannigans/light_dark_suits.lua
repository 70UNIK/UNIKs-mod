if PB_UTIL and PB_UTIL.config.suits_enabled then
  table.insert(UNIK.light_suits, 'paperback_Stars')
  table.insert(UNIK.dark_suits, 'paperback_Crowns')
end

-- Load modded suits
if next(SMODS.find_mod('Bunco')) then
  local prefix = SMODS.find_mod('Bunco')[1].prefix or "bunc"

  table.insert(UNIK.light_suits, prefix .. '_Fleurons')
  table.insert(UNIK.dark_suits, prefix .. '_Halberds')
end

--stolen from paperback
function UNIK.is_suit_type(card,type)
    if PB_UTIL then
        return PB_UTIL.is_suit(card, type)
    else
        for _, v in ipairs(type == 'light' and UNIK.light_suits or UNIK.dark_suits) do
			if card:is_suit(v) then return true end
		end
		return false
    end
end

--also stolen from paperback
function UNIK.suit_tooltip(type)
  local suits = type == 'light' and UNIK.light_suits or UNIK.dark_suits

  local key = 'unik_' .. type .. '_suits'
  local colours = {}

  -- If any modded suits were loaded, we need to dynamically
  -- add them to the localization table
  if #suits > 2 then
    local text = {}
    local line = ""
    local text_parsed = {}

    for i = 1, #suits do
      local suit = suits[i]

      -- Remove Bunco exotic suits if they are not revealed yet
      if next(SMODS.find_mod("Bunco")) and not (G.GAME and G.GAME.Exotic) then
        if suit == "bunc_Fleurons" or suit == "bunc_Halberds" then
          suit = nil
        end
      end

      if suit ~= nil then
        colours[#colours + 1] = G.C.SUITS[suit] or G.C.IMPORTANT
        line = line .. "{V:" .. i .. "}" .. localize(suit, 'suits_plural') .. "{}"

        if i < #suits then
          line = line .. ", "
        end

        if #line > 30 then
          text[#text + 1] = line
          line = ""
        end
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
  end

  return {
    set = 'Other',
    key = key,
    vars = {
      colours = colours
    }
  }
end