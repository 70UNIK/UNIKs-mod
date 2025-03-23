--Transferrable function designed to be used for all suit based jokers
SMODS.Joker {
    dependencies = {
		items = {
			"set_cry_cursed",
		},
	},
	key = 'unik_broken_window',
    atlas = 'unik_cursed',
    rarity = "cry_cursed",
	pos = { x = 3, y = 0 },
    cost = 1,
    config = { extra = {minCards = 7, cards = 13, selfDestruct = false,suit = "Diamonds",debuff_name = "unik_window",death_message = "k_unik_window_fixed",color = "a9a295",entered = false} },
    pools = { ["unik_boss_blind_joker"] = true},
	blueprint_compat = false,
    perishable_compat = false,
    loc_vars = function(self, info_queue, center)
        --Nerf to requiring half of cards destroyed (rounded to whole num), so its more in line with Blacklist's requirements
        return { vars = { center.ability.extra.minCards,center.ability.extra.cards} }
	end,
    set_badges = function(self, card, badges)
        badges[#badges+1] = create_badge(localize('k_unik_blind_start_window'), G.C.UNIK_THE_WINDOW, G.C.WHITE, 1.0 )
    end,
    immutable = true,
    add_to_deck = function(self, card, from_debuff)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            func = function()
                card.ability.extra.cards = G.GAME.unik_diamonds
                if Card.get_gameset(card) ~= "modest" then
                    card.ability.extra.minCards = math.ceil(G.GAME.unik_diamonds/2)
                else
                    card.ability.extra.minCards = math.ceil(G.GAME.unik_diamonds*4/5)
        
                end
                card.ability.extra.entered = true
                return true
            end
        }))
    end,
    update = function(self,card,dt)
        if card.added_to_deck and card.ability.extra.entered == true then
            card.ability.extra.cards = G.GAME.unik_diamonds
            if card.ability.extra.selfDestruct == false and (card.ability.extra.cards <= 0 or card.ability.extra.cards < card.ability.extra.minCards) then
                selfDestruction(card,"k_unik_window_fixed",HEX("a9a295"))
                card.ability.extra.selfDestruct = true
            end
        end
    end,
    calculate = function(self, card, context)
        if context.setting_blind and (G.GAME.blind and (G.GAME.blind.config.blind.name == "The Window")) and not (G.GAME.blind.disabled) then
            selfDestruction(card,"k_unik_blind_start_window",HEX("a9a295"))
            card.ability.extra.selfDestruct = true
        end
    end
}
