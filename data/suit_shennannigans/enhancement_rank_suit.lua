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
        for i,v in pairs(SMODS.Ranks) do
            if G.P_CENTERS[self.config.center.key].unik_specific_base_value == i then
                return v.max_id.value
            end
        end
        return SMODS.Ranks[G.P_CENTERS[self.config.center.key].unik_specific_base_value].id
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
        specific_rank_nominal = 0
        if SMODS.Ranks[G.P_CENTERS[self.config.center.key].unik_specific_base_value] then
            specific_rank_nominal = SMODS.Ranks[G.P_CENTERS[self.config.center.key].unik_specific_base_value].nominal
        end
        vars = 10*specific_rank_nominal*rank_mult + specific_suit_nominal*mult + (self.base.suit_nominal_original or 0)*0.0001*mult + 10*self.base.face_nominal*rank_mult + 0.000001*self.unique_val
    end
    if G.P_CENTERS[self.config.center.key].set == "Enhanced" and 
    G.P_CENTERS[self.config.center.key].unik_specific_suit
    then
        specific_suit_nominal = 0
        if SMODS.Suits[G.P_CENTERS[self.config.center.key].unik_specific_suit] then
            -- print(SMODS.Suits[G.P_CENTERS[self.config.center.key].unik_specific_suit].max_nominal.value)
            specific_suit_nominal = SMODS.Suits[G.P_CENTERS[self.config.center.key].unik_specific_suit].suit_nominal
        end
        mult = 1
        vars = 10*specific_rank_nominal*rank_mult + specific_suit_nominal*mult + (self.base.suit_nominal_original or 0)*0.0001*mult + 10*self.base.face_nominal*rank_mult + 0.000001*self.unique_val
    end
    return vars
end

--If a mod somehow generates enhancement_exclusive_ranks/suits, override it.
local playing_card_hook = create_playing_card
function create_playing_card(card_init, area, skip_materialize, silent, colours, skip_emplace)
    local card = playing_card_hook(card_init, area, skip_materialize, silent, colours, skip_emplace)

    local suit_prefix = string.sub(card.base.suit, 1, 1)
    local rank_suffix = card.base.id
    print('suit: ' .. card.base.suit)
    print('id: ' .. card.base.id)
    print('val: '..card.base.value)
    for i,v in pairs(SMODS.Suits) do
        if SMODS.Suits[i].backup_suit and i == card.base.suit then
             local newSuit = SMODS.Suits[i].backup_suit
             if SMODS.Suits[SMODS.Suits[i].backup_suit] then
                
             else
                newSuit = 'Spades'
                print("none exist, change to spades")
             end             
             card:change_suit(newSuit)
             print("WHOOPS! ILLEGAL ENHANCEMENT_ONLY SUIT DETECTED! Reverting to " .. newSuit)
             break
        end
    end
    suit_prefix = string.sub(card.base.suit, 1, 1)..'_'
    for i,v in pairs(SMODS.Ranks) do
        if SMODS.Ranks[i].backup_rank and (i == card.base.id) then
            local newRank = SMODS.Ranks[i].backup_rank
            for i,v in pairs(SMODS.Ranks) do
                print(i.. " --> "..v.id)
            end
            if not SMODS.Ranks[SMODS.Ranks[i].backup_rank] then
                newRank = '2'
                print("none exist, change to 2")
            end
            card:set_base(suit_prefix..'_'..SMODS.Ranks[newRank].id)
            print("WHOOPS! ILLEGAL ENHANCEMENT_ONLY RANK DETECTED! Reverting to " .. newRank)
            break
        end
    end

    return card
end