

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
                if not SMODS.Suits[v.unik_specific_suit] then
                    self.ENHANCEMENT_OVERRIDE_SUITS[#self.ENHANCEMENT_OVERRIDE_SUITS + 1] = v.unik_specific_suit
                end
            end
            if v.unik_specific_base_value and SMODS.Rank.max_id.value then
                if not SMODS.Ranks[v.unik_specific_base_value] then
                    SMODS.Rank.max_id.value = SMODS.Rank.max_id.value + 1
                    self.ENHANCEMENT_OVERRIDE_RANKS[i] = {v.unik_specific_base_value,SMODS.Rank.max_id.value}
                end
            end
        end
    end
end

local faceHook = Card.is_face
function Card:is_face(from_boss)
    if self.debuff and not from_boss then return end
    if G.P_CENTERS[self.config.center.key].set == "Enhanced" and G.P_CENTERS[self.config.center.key].force_no_face then
        return false
    end
    local ret = faceHook(self,from_boss)
    return ret
end

local getIDenhance = Card.get_id
function Card:get_id()
    if G.P_CENTERS[self.config.center.key].set == "Enhanced" and 
        G.P_CENTERS[self.config.center.key].unik_specific_base_value
    then
        if not SMODS.Ranks[G.P_CENTERS[self.config.center.key].unik_specific_base_value] then
            return G.ENHANCEMENT_OVERRIDE_RANKS[self.config.center.key][2]
        else
            return SMODS.Ranks[G.P_CENTERS[self.config.center.key].unik_specific_base_value].id
        end
    end
	local vars = getIDenhance(self)

	return vars
end

local suit_hook = Card.is_suit
function Card:is_suit(suit, bypass_debuff, flush_calc)
    if G.P_CENTERS[self.config.center.key].set == "Enhanced" and 
    G.P_CENTERS[self.config.center.key].unik_specific_suit
    then
        return suit == G.P_CENTERS[self.config.center.key].unik_specific_suit
    end
    return suit_hook(self,suit, bypass_debuff, flush_calc)
end

function Card:get_baseValOverride()
    if G.P_CENTERS[self.config.center.key].set == "Enhanced" and 
        G.P_CENTERS[self.config.center.key].unik_specific_base_value
    then
        return G.P_CENTERS[self.config.center.key].unik_specific_base_value
    end
    return self.base.value
end

--pibby and bun bun
function Card:get_rank_value()
    if SMODS.has_no_rank(self) then
        return 0
    end
    if G.P_CENTERS[self.config.center.key].set == "Enhanced" and 
        G.P_CENTERS[self.config.center.key].unik_specific_base_value
    then
        if not SMODS.Ranks[G.P_CENTERS[self.config.center.key].unik_specific_base_value] then
            return 0
        else
            return SMODS.Ranks[G.P_CENTERS[self.config.center.key].unik_specific_base_value].nominal
        end
    end
    return self.base.nominal
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
    if G.P_CENTERS[self.config.center.key].set == "Enhanced" and 
        G.P_CENTERS[self.config.center.key].unik_specific_base_value
    then
        if G.P_CENTERS[self.config.center.key].unik_is_custom_rank then
            rank_mult = 0
            vars = 10*self.base.nominal*rank_mult + self.base.suit_nominal*mult + (self.base.suit_nominal_original or 0)*0.0001*mult + 10*self.base.face_nominal*rank_mult + 0.000001*self.unique_val
        end
        if not SMODS.Ranks[G.P_CENTERS[self.config.center.key].unik_specific_base_value] then
            rank_mult = 0
            specific_rank_nominal = 0
        else
            specific_rank_nominal = SMODS.Ranks[G.P_CENTERS[self.config.center.key].unik_specific_base_value].nominal
        end
        vars = 10*specific_rank_nominal*rank_mult + specific_suit_nominal*mult + (self.base.suit_nominal_original or 0)*0.0001*mult + 10*self.base.face_nominal*rank_mult + 0.000001*self.unique_val
    end
    if G.P_CENTERS[self.config.center.key].set == "Enhanced" and 
    G.P_CENTERS[self.config.center.key].unik_specific_suit
    then
        if SMODS.Suits[G.P_CENTERS[self.config.center.key].unik_specific_suit] then
            -- print(SMODS.Suits[G.P_CENTERS[self.config.center.key].unik_specific_suit].max_nominal.value)
            specific_suit_nominal = SMODS.Suits[G.P_CENTERS[self.config.center.key].unik_specific_suit].suit_nominal
        end
        mult = 1
        vars = 10*specific_rank_nominal*rank_mult + specific_suit_nominal*mult + (self.base.suit_nominal_original or 0)*0.0001*mult + 10*self.base.face_nominal*rank_mult + 0.000001*self.unique_val
    end
    return vars
end

function unik_get_all_suits()
    local suits = {}
    for i = 1, #SMODS.Suit.obj_buffer do
        suits[#suits + 1] = SMODS.Suit.obj_buffer[i]
    end
    for i = 1, #G.ENHANCEMENT_OVERRIDE_SUITS do
        suits[#suits + 1] = G.ENHANCEMENT_OVERRIDE_SUITS[i]
    end
    return suits
end
function unik_get_all_suits2()
    local suits = {}
    for i = 1, #SMODS.Suit.obj_buffer do
        suits[SMODS.Suit.obj_buffer[i]] = true
    end
    for i = 1, #G.ENHANCEMENT_OVERRIDE_SUITS do
        suits[G.ENHANCEMENT_OVERRIDE_SUITS[i]] = true
    end
    return suits
end