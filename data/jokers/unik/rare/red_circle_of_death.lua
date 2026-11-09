-- ..!: on final hand, if your hand score does not meet requirements, !Mult then self Destructs.
SMODS.Joker {
    key = 'unik_red_circle_of_death',
    atlas = 'unik_normal_jokers',
	pos = { x = 12, y = 3 },
    rarity = 3,
    cost = 8,
    blueprint_compat = true,
    perishable_compat = true,
	eternal_compat = false,
    immutable = true,
    attributes = { 'eemult','hands','factorialmult'},
    loc_vars = function(self, info_queue, center)
        info_queue[#info_queue + 1] = { set = "Other", key = "unik_banishing" }
	end,
    pronouns = "it_its",
    config = {extra = {to_be_destroyed = false}},
    add_to_deck = function(self, card, from_debuff)
        card.ability.extra.to_be_destroyed = false
    end,
    calculate = function(self, card, context)
        if context.joker_main and G.GAME.current_round.hands_left <= 0 and (SMODS.calculate_round_score() + G.GAME.chips) < G.GAME.blind.chips then
            
            card.ability.extra.to_be_destroyed = true
            return{
               factorial_mult = 1,
            }
        end
        if context.after and ( card.ability.extra.to_be_destroyed) and not context.blueprint and not context.repetition and not context.retrigger_joker then
            if not G.GAME.banned_keys then
                G.GAME.banned_keys = {}
            end -- i have no idea if this is always initialised already tbh
            if not G.GAME.cry_banished_keys then
                G.GAME.cry_banished_keys = {}
            end -- 
            G.GAME.cry_banished_keys['j_unik_red_circle_of_death'] = true
            selfDestruction(card,'k_unik_dead_ex',G.C.RED)
            return{
                -- message = localize("k_unik_weapon_destroyed"),
                -- colour = G.C.DARK_EDITION,
            }
        end
    end,
    unlocked = false,
  	discovered = false,
    check_for_unlock = function(self, args)
        if args.type == "unik_lose_to_showdown" then
            return true
        end
    end,
}