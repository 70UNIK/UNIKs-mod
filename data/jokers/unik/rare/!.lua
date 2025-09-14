--!Mult on final hand,
SMODS.Joker {
    key = 'unik_exclamation',
    atlas = 'placeholders',
	pos = { x = 2, y = 0 },
    rarity = 3,
    cost = 7,
    blueprint_compat = true,
    perishable_compat = true,
	eternal_compat = false,
    immutable = true,
    config = {extra = {to_be_destroyed = false}},
    add_to_deck = function(self,card,from_debuff)
        if G.GAME.no_exclamation_mark then
            selfDestruction(card,"k_unik_banished",G.C.UNIK_VOID_COLOR)
        end
    end,
    calculate = function(self, card, context)
        if context.joker_main and G.GAME.current_round.hands_left == 0 then
            card.ability.extra.to_be_destroyed = true
            
            return{
                fact_mult = 1,
            }
        end
        if context.after and card.ability.extra.to_be_destroyed and not context.blueprint and not context.repetition and not context.retrigger_joker then
            selfDestruction(card,"k_unik_banished",G.C.UNIK_VOID_COLOR)
             if not G.GAME.banned_keys then
                    G.GAME.banned_keys = {}
                end
                if not G.GAME.cry_banished_keys then
                    G.GAME.cry_banished_keys = {}
                end
                G.GAME.cry_banished_keys[card.config.center.key] = true
                G.GAME.no_exclamation_mark = true
            for i,v in pairs(G.jokers.cards) do
                if v.config.center.key == 'j_unik_exclamation' then
                    selfDestruction(v,"k_unik_banished",G.C.UNIK_VOID_COLOR)
                end
            end
            return{
            }
        end
    end,
    in_pool = function(self)
        if G.GAME.no_exclamation_mark then
            return false
        end
        return true
    end
}
