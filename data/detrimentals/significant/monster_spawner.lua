-- creates arandom detriment after defeating a boss blind, self destructgs after creating 2 detriments.
UNIK.detriment{
    key = "unik_monster_spawner",
    atlas = "unik_detriments",
	pos = { x = 4, y = 2 },
    config = { extra = { spawn_detriments = 1, detriments_spawned = 0, detriments_max = 2} }, --why emult? 
    severity = 2,
    immutable = true,
    dongtong_compat = false,
    blueprint_compat = true,
    attributes = { 'detrimental','xmult','chips','detriment'},
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.spawn_detriments,card.ability.extra.detriments_max,card.ability.extra.detriments_spawned} }
	end,
    calculate = function(self, card, context)
        if
            context.end_of_round
            and not context.individual
            and context.cardarea == G.unik_detriment_area
            and G.GAME.blind.boss
        then
            UNIK.create_detriment({seed = "unik_monster_spawner" })
            card.ability.extra.detriments_spawned = card.ability.extra.detriments_spawned + 1
            if card.ability.extra.detriments_spawned >= card.ability.extra.detriments_max then
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