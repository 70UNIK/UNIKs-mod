--spawn a cursed joker after a boss blind. Destroys itself after spawning two total cursed jokers. It CAN spawn itself as well!
--modest makes it only spawn 1, which may seem redundant until with this, it keeps you in tension until the boss blind ends and gives time to use a knife to stop it.

SMODS.Joker {
	-- How the code refers to the joker.
	key = 'unik_monster_spawner',
    atlas = 'unik_cursed',
    rarity = 'unik_detrimental',
	pos = { x = 3, y = 1 },
    cost = 1,
	blueprint_compat = false,
    perishable_compat = false,
    no_dbl = true,
	eternal_compat = false,
    config = { extra = {max_jokers = 2,jokers_spawned = 0,self_destruct = false} },
	loc_vars = function(self, info_queue, center)
		return { vars = {center.ability.extra.max_jokers,center.ability.extra.jokers_spawned} }
	end,
    immutable = true,
    calculate = function(self, card, context)
        if
        context.end_of_round
        and not context.individual
        and not context.repetition
        and G.GAME.blind.boss
        and not context.blueprint_card
        and not context.retrigger_joker
    then
        G.E_MANAGER:add_event(Event({
            func = function()
                local card2 = create_card("Joker", G.jokers, nil, 'unik_detrimental', nil, nil, nil, "unik_monster_spawner")
                --destroy card2 if its jimbo
                if (card2.ability.name ~= "Joker") then
                    card:juice_up(0.8, 0.8)
                    card2:start_materialize()
                    card2:add_to_deck() --This causes problems. Why?
                    G.jokers:emplace(card2)
                    delay(0.15)
                else
                    card2:remove()
                    card.ability.extra.self_destruct = true
                    selfDestruction(card,"k_extinct_ex",HEX("b9cb92"))
                end
                return true
            end
        }))
        card.ability.extra.jokers_spawned = card.ability.extra.jokers_spawned + 1
        if card.ability.extra.jokers_spawned >= card.ability.extra.max_jokers and card.ability.extra.self_destruct == false then
            card.ability.extra.self_destruct = true
            selfDestruction(card,"k_extinct_ex",G.C.BLACK)
            --return true
        end
        return{
            message = localize("k_unik_spawned"),
            colour = G.C.BLACK,
        }
    end
    end,
}