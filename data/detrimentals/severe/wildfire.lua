--The Flame, all enhanced cards are debuffed
UNIK.detriment{
    key = "unik_wildfire",
    atlas = "unik_detriments",
	pos = { x = 4, y = 3 },
    severity = 3,
     attributes = { 'detrimental','debuff','enhancements' },
    config = { extra = {minCards = 2, cards = 4, selfDestruct = false,entered = false} },
    loc_vars = function(self, info_queue, center)
        return { key = next(SMODS.find_mod("Bunco")) and 'detr_unik_wildfire_bunc' or 'detr_unik_wildfire',
        vars = { center.ability.extra.minCards,center.ability.extra.cards} }
	end,
	blueprint_compat = false,
    dongtong_compat = false,
    immutable = true,
    add_to_deck = function(self, card, from_debuff)
        local cards = 0
        if G.playing_cards then
            for k, v in pairs(G.playing_cards) do
                if next(SMODS.get_enhancements(v)) then
                    cards =  cards + 1 
                end
            end
        end
        card.ability.extra.minCards = math.floor(cards/2)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            func = function()
                card.ability.extra.entered = true
                return true
            end
        }))
    end,
    in_pool = function(self)
        local enhanced = 0
        if G.playing_cards then
            for k, v in pairs(G.playing_cards) do
                if next(SMODS.get_enhancements(v)) then
                    enhanced =  enhanced + 1 
                end
            end
        end
		return enhanced > 1
	end,
    remove_from_deck = function(self, card, from_debuff)
        if G.playing_cards then
            for k, v in pairs(G.playing_cards) do
                if next(SMODS.get_enhancements(v)) then
                    v:set_debuff()
                end
            end
        end
    end,
    update = function(self,card,dt)
        if card.added_to_deck and card.ability.extra.entered == true then
            local cards = 0
            if G.playing_cards then
                for k, v in pairs(G.playing_cards) do
                    if next(SMODS.get_enhancements(v)) then
                        v:set_debuff(true)
                        cards =  cards + 1 
                    end
                end
            end
            card.ability.extra.cards = cards         
            if card.ability.extra.selfDestruct == false and (card.ability.extra.cards <= 0 or card.ability.extra.cards < card.ability.extra.minCards) then
                selfDestruction(card,"k_unik_flame_extinguish",G.C.UNIK_THE_FLAME)
                card.ability.extra.selfDestruct = true
            end
        end
    end,

    calculate = function(self, card, context)
        if context.setting_blind and (G.GAME.blind and (G.GAME.blind.config.blind.key  == "bl_bunc_flame")) and not (G.GAME.blind.disabled) then
            selfDestruction(card,"k_unik_blind_start_flame",G.C.UNIK_THE_FLAME)
            card.ability.extra.selfDestruct = true
        end
    end
}
