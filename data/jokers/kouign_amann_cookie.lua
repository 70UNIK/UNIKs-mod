local k_amann_quotes = {
	normal = {
		'k_k_amann_normal1',
		'k_k_amann_normal2',
		'k_k_amann_normal3',
		'k_k_amann_normal4',
		'k_k_amann_normal5',
		'k_k_amann_normal6',
	},
	-- drama = {
	-- 	'k_unik_unik_scared1',
	-- 	'k_unik_unik_scared2',
	-- 	'k_unik_unik_scared3',
	-- },
	-- gods = {
	-- 	'k_unik_unik_godsmarble1',
	-- 	'k_unik_unik_godsmarble2',
	-- 	'k_unik_unik_godsmarble3',
	-- 	'k_unik_unik_godsmarble4',
	-- 	'k_unik_unik_godsmarble5',
	-- 	'k_unik_unik_godsmarble6',
	-- 	'k_unik_unik_godsmarble7',
	-- }
}
SMODS.Joker {
    key = 'unik_kouign_amann_cookie',
    atlas = 'placeholders',
	pos = { x = 2, y = 0 },
    rarity = 3,
    cost = 8,
    blueprint_compat = true,
    perishable_compat = true,
	eternal_compat = true,
    demicoloncompat = true,
    config = { extra = {retriggers = 1,decrease = 0.1},immutable = {max_retriggers = 50, max_decrease = 0.5} },
    loc_vars = function(self, info_queue, center)
        return { 
            vars = {math.min(center.ability.extra.retriggers,center.ability.immutable.max_retriggers),1-math.min(center.ability.extra.decrease,center.ability.immutable.max_decrease)} 
        }
	end,
    enhancement_gate = 'm_cry_light',
    calculate = function(self, card, context)
        if context.repetition and context.cardarea == G.play then
            if SMODS.has_enhancement(context.other_card,'m_cry_light') then
                local rep = math.min(card.ability.extra.retriggers,card.ability.immutable.max_retriggers)
                local decrease = 1-math.min(card.ability.extra.decrease,card.ability.immutable.max_decrease)
                local card2 = context.other_card
                if decrease < 1 then
                    card2.ability.extra.req = card2.ability.extra.req^decrease
                end
                if card2.ability.extra.current > card2.ability.extra.req then
                    card2.ability.extra.current = card2.ability.extra.req
                end
                card2.ability.extra.current = card2.ability.extra.current^decrease
                return {
                    message = localize("k_again_ex"),
                    repetitions = to_number(
                        rep
                    ),
                    card = card,
                }
            end
        end
    end,
}