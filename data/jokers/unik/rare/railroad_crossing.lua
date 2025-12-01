--retrigger all crosses, debuffs all but 2 random suits in deck per hand
SMODS.Joker {
    key = "unik_railroad_crossing",
    atlas = "unik_uncommon",
    rarity = 3,
    cost = 7,
    pos = { x = 9, y = 1 },
    blueprint_compat = true,
    perishable_compat = true,
	eternal_compat = true,
    config = {extra = {retriggers = 1}},
    loc_vars = function(self, info_queue, center)
        G.GAME.unik_saved_suits_railroad = G.GAME.unik_saved_suits_railroad or {'Spades','Hearts'}
         info_queue[#info_queue + 1] = { set = "Other", key = "unik_rescore" }
        return {
            vars = {center.ability.extra.retriggers,localize("unik_Crosses","suits_plural"),localize(G.GAME.unik_saved_suits_railroad[1] .. "","suits_plural"),localize(G.GAME.unik_saved_suits_railroad[2] .. "","suits_plural"),
            colours = {G.C.SUITS[G.GAME.unik_saved_suits_railroad[1] .. ""],G.C.SUITS[G.GAME.unik_saved_suits_railroad[2] .. ""]}}
        }
	end,
    update = function(self,card,dt)
        if card.added_to_deck then
            if G.playing_cards then
                for k, v in pairs(G.playing_cards) do
                    if v.base.suit ~= 'unik_Crosses' and not v:is_suit(G.GAME.unik_saved_suits_railroad[1], true, true) and not v:is_suit(G.GAME.unik_saved_suits_railroad[2], true, true) then
                        v:set_debuff(true)
                    else
                        v:set_debuff()
                    end
                end
            end
        end
    end,
    remove_from_deck = function(self, card, from_debuff)
        if G.playing_cards then
            for k, v in pairs(G.playing_cards) do
                if v.base.suit ~= 'unik_Crosses' and not v:is_suit(G.GAME.unik_saved_suits_railroad[1], true, true) and not v:is_suit(G.GAME.unik_saved_suits_railroad[2], true, true) then
                    v:set_debuff()
                end
            end
        end
    end,
    calculate = function(self, card, context)
        if context.unik_kite_experiment and context.scoring_hand then
            local validCards = {}
            for i,v in pairs(context.scoring_hand) do
                if v:is_suit('unik_Crosses') then
                    validCards[#validCards+1] = v;
                end
            end
            if #validCards > 0 then
                return {
                    target_cards = validCards,
                    rescore = card.ability.extra.retriggers,
                    card = card,
                    message = '+1',
                }
            end   
        end
    end,
    in_pool = function(self)
		return UNIK.suit_in_deck('unik_Crosses') 
	end,
}

function UNIK.railroad_suits()

    local saved_suits = {}
    local all_suits = {}
    for k, v in pairs(G.playing_cards) do
        local already_checked = false
        if not v.config.center.unik_specific_suit and not SMODS.has_no_suit(v) then
            for i,w in pairs(all_suits) do
                if v.base.suit == w then
                    already_checked = true
                    break
                end
            end
            if not already_checked and v.base.suit ~= 'unik_Crosses' then
                all_suits[#all_suits+1] = v.base.suit
            end
        end
    end
    for i = 1, 2 do
        if #all_suits > 0 then
            local index = pseudorandom('railroad_suit',1,#all_suits)
            table.insert(saved_suits,all_suits[index])
            table.remove(all_suits,index)
        end
    end
    if #saved_suits < 2 then
        table.insert(saved_suits,'Spades') --default to spades if no other valid suit in deck
        table.insert(saved_suits,'Hearts')
    end
    G.GAME.unik_saved_suits_railroad = saved_suits
end