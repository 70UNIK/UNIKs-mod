-- 1.4x Chips, has it's own suit and is considered a 7.
SMODS.Enhancement {
	atlas = 'unik_enhancements',
	pos = {x = 0, y = 0},
	key = 'unik_pink',
	not_stoned = true,
	overrides_base_rank = true, --enhancement do not generate in grim, incantation, etc...
	replace_base_card = true, --So no base chips and no image
    config = { extra = { Echips = 0.05}, immutable = {base_echips = 1.0} },
    weight = 0,
    shatters = true, --lefunny
    force_no_face = true, --true = always face, false = always face
	--NEW! specific_suit suit. Like abstracted!

	unik_specific_suit = "unik_pink",
	unik_specific_rank = 7,
    unik_specific_base_value = "7",
    unik_is_custom_rank = false, 

    loc_vars = function(self, info_queue, card)
        return {
            vars = { card.ability.extra.Echips + card.ability.immutable.base_echips}
        }
    end,
    in_pool = function(self)
        return false
    end,
	calculate = function(self, card, context, effect)
		if context.cardarea == G.play and context.main_scoring then
            return {
				e_chips = card.ability.extra.Echips + card.ability.immutable.base_echips,
                colour = G.C.DARK_EDITION,
			}
		end
        if context.destroy_card and context.destroy_card == card and context.cardarea == G.play then
            for i,v in pairs(G.play.cards) do
                if v:get_id() ~= 7 then
                    return { remove = true }
                end
            end
		end
        if (context.cardarea == "unscored") and context.destroy_card == card then
            for i,v in pairs(G.play.cards) do
                if v:get_id() ~= 7 then
                    return { remove = true }
                end
            end
        end
	end,
}

-- local enhancementOverrideSuit = Card.is_suit
-- function Card:is_suit(suit, bypass_debuff, flush_calc)
--     return enhancementOverrideSuit(self, bypass_debuff, flush_calc)
-- end
function Game:unik_initialize_stuff()
    self.ENHANCEMENT_OVERRIDE_RANKS = {

    }
    self.ENHANCEMENT_OVERRIDE_SUITS = {
    
    }
    for i,v in pairs(self.P_CENTERS) do
        if v.set == "Enhanced" then
            if v.unik_specific_suit then
                self.ENHANCEMENT_OVERRIDE_SUITS[#self.ENHANCEMENT_OVERRIDE_SUITS + 1] = v.unik_specific_suit
            end
            if v.unik_specific_rank and v.unik_specific_base_value and v.unik_is_custom_rank and SMODS.Rank.max_id.value then
                --USAGE: unik_specific_rank, unik_specific_base_value, unik_specific_max_id
                SMODS.Rank.max_id.value = SMODS.Rank.max_id.value + 1
                self.ENHANCEMENT_OVERRIDE_RANKS[i] = {v.unik_specific_rank,v.unik_specific_base_value,SMODS.Rank.max_id.value}
            end
        end
    end
end

local faceHook = Card.is_face
function Card:is_face(from_boss)
    if self.debuff and not from_boss then return end
    if G.P_CENTERS[self.config.center.key].set == "enhancement" and G.P_CENTERS[self.config.center.key].force_no_face then
        return false
    end
    local ret = faceHook(self,from_boss)
    return ret
end

--TODO: remove dependency on cryptid functions
--Add a hook to getID for abstracts (and to conditionally enable the check)
local getIDenhance = Card.get_id
function Card:get_id()
	--Force suit to be suit X if specified in enhancement, only if not vampired
    if G.P_CENTERS[self.config.center.key].set == "enhancement" and 
        G.P_CENTERS[self.config.center.key].unik_specific_rank and
        G.P_CENTERS[self.config.center.key].unik_specific_base_value
    then
        if G.P_CENTERS[self.config.center.key].unik_is_custom_rank then
            return G.ENHANCEMENT_OVERRIDE_RANKS[self.config.center.key][3]
        else
            return G.ENHANCEMENT_OVERRIDE_RANKS[self.config.center.key][1]
        end
    end
    -- if SMODS.has_enhancement(self, "m_unik_pink") then
    --     return 7
    -- elseif SMODS.has_enhancement(self, "m_cry_abstract") then
    --     return SMODS.Rank.max_id.value + 1
    -- end
	local vars = getIDenhance(self)

	return vars
end

function Card:get_baseValOverride()
    if G.P_CENTERS[self.config.center.key].set == "enhancement" and 
        G.P_CENTERS[self.config.center.key].unik_specific_rank and
        G.P_CENTERS[self.config.center.key].unik_specific_base_value
    then
        return G.ENHANCEMENT_OVERRIDE_RANKS[self.config.center.key][2]
    end
    return self.base.value
end

--sorting
local nominalGet = Card.get_nominal
function Card:get_nominal(mod)
    local mult = 1
    local rank_mult = 1
    local specific_rank_nominal = self.base.nominal
    local specific_suit_nominal = self.base.suit_nominal
    if mod == 'suit' then mult = 10000 end
    local vars = nominalGet(self,mod)
    if G.P_CENTERS[self.config.center.key].set == "enhancement" and 
        G.P_CENTERS[self.config.center.key].unik_specific_rank and
        G.P_CENTERS[self.config.center.key].unik_specific_base_value
    then
        if G.P_CENTERS[self.config.center.key].unik_is_custom_rank then
            rank_mult = 0
            vars = 10*self.base.nominal*rank_mult + self.base.suit_nominal*mult + (self.base.suit_nominal_original or 0)*0.0001*mult + 10*self.base.face_nominal*rank_mult + 0.000001*self.unique_val
        else
            specific_rank_nominal = G.P_CENTERS[self.config.center.key].unik_specific_rank
            vars = 10*specific_rank_nominal*rank_mult + specific_suit_nominal*mult + (self.base.suit_nominal_original or 0)*0.0001*mult + 10*self.base.face_nominal*rank_mult + 0.000001*self.unique_val
        end
    end
    if G.P_CENTERS[self.config.center.key].set == "enhancement" and 
    G.P_CENTERS[self.config.center.key].unik_specific_suit
    then
        if SMODS.Suits[G.P_CENTERS[self.config.center.key].unik_specific_suit] then
            -- print(SMODS.Suits[G.P_CENTERS[self.config.center.key].unik_specific_suit].max_nominal.value)
            specific_suit_nominal = SMODS.Suits[G.P_CENTERS[self.config.center.key].unik_specific_suit].suit_nominal
        end
        mult = 1
        vars = 10*specific_rank_nominal*rank_mult + specific_suit_nominal*mult + (self.base.suit_nominal_original or 0)*0.0001*mult + 10*self.base.face_nominal*rank_mult + 0.000001*self.unique_val
    end
    -- if SMODS.has_enhancement(self, "m_cry_abstract") then
    --     mult = 1
    --     rank_mult = 0
    --     return 10*self.base.nominal*rank_mult + self.base.suit_nominal*mult + (self.base.suit_nominal_original or 0)*0.0001*mult + 10*self.base.face_nominal*rank_mult + 0.000001*self.unique_val
    -- end
    -- if SMODS.has_enhancement(self, "m_unik_pink") then
    --     mult = 1
    --     rank_mult = 1
    --     return 10*7*rank_mult + self.base.suit_nominal*mult + (self.base.suit_nominal_original or 0)*0.0001*mult + 10*self.base.face_nominal*rank_mult + 0.000001*self.unique_val
    -- end

    return vars
end