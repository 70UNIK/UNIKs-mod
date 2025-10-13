
SMODS.Joker {
    key = 'unik_multesers',
    atlas = 'unik_uncommon',
	pos = { x = 7, y = 2 },
    rarity = 2,
    cost = 6,
    blueprint_compat = true,
    perishable_compat = true,
	eternal_compat = false,
    demicoloncompat = true,
    config = { extra = {mult = 10, mult_mod = 0.1,destroyed = false,depleted_threshold = -10} },
    pools = {  ["autocannibalism_food"] = true,["Food"] = true},
    loc_vars = function(self, info_queue, center)
        local sign = "+"
        if lenient_bignum(center.ability.extra.mult) < lenient_bignum(0) then
            sign = ""
        end
        local key = 'j_unik_multesers'
        if center.ability.unik_depleted then
            key = 'j_unik_multesers_depleted'
        end
        return { 
            key = key, vars = {center.ability.extra.mult,center.ability.extra.mult_mod,center.ability.extra.depleted_threshold,sign} }
	end,
    calculate = function(self, card, context)
        if context.forcetrigger and not card.ability.extra.destroyed then
            return {
                mult = card.ability.extra.mult,
                colour = G.C.CHIPS,
            }
        end
        if context.individual and context.cardarea == G.play and not card.ability.extra.destroyed then
            -- if a seven
            return {

                mult = card.ability.extra.mult,
                colour = G.C.CHIPS,
            }
        end
    end,
}