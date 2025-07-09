-- 1.4x Chips, has it's own suit and is considered a 7.
SMODS.Enhancement {
	atlas = 'unik_enhancements',
	pos = {x = 0, y = 0},
	key = 'unik_pink',
	not_stoned = true,
	overrides_base_rank = true, --enhancement do not generate in grim, incantation, etc...
	replace_base_card = true, --So no base chips and no image
    config = { extra = { Echips = 1.07} },
    weight = 0,
    immutable = true,
    shatters = true, --lefunny
    force_no_face = true, --true = always face, false = always face
	--NEW! specific_suit suit. Like abstracted!
	specific_suit = "unik_pink",
	specific_rank = 7,
    specific_base_value = "7",
    loc_vars = function(self, info_queue, card)
        return {
            vars = { card.ability.extra.Echips}
        }
    end,
    in_pool = function(self)
        return false
    end,
	calculate = function(self, card, context, effect)
		if context.cardarea == G.play and context.main_scoring then
            return {
				e_chips = card.ability.extra.Echips,
                colour = G.C.DARK_EDITION,
			}
		end
        if context.destroy_card == card and context.cardarea == G.play then
            for i,v in pairs(G.play.cards) do
                if v:get_id() ~= 7 then
                    return { remove = true }
                end
            end
		end
	end,
}

local faceHook = Card.is_face
function Card:is_face(from_boss)
    if self.debuff and not from_boss then return end
    if SMODS.has_enhancement(self, "m_unik_pink") then
        return
    end
    local ret = faceHook(self,from_boss)
    return ret
end
--Add a hook to getID for abstracts (and to conditionally enable the check)
local getIDenhance = Card.get_id
function Card:get_id()
	--Force suit to be suit X if specified in enhancement, only if not vampired
	if Cryptid.cry_enhancement_has_specific_rank(self) and not self.vampired then
		--Get the max value + 1, to always be the last at the list
        if self.config.center.key == "m_unik_pink" then
            return 7
        elseif self.config.center.key == "m_cry_abstract" then
            return SMODS.Rank.max_id.value + 1
        end
	end
	local vars = getIDenhance(self)

	return vars
end

function Card:get_baseValOverride()
    if Cryptid.cry_enhancement_has_specific_rank(self) and not self.vampired then
		--Get the max value + 1, to always be the last at the list
        if self.config.center.key == "m_unik_pink" then
            return 7
        end
	end
    return self.base.value
end
