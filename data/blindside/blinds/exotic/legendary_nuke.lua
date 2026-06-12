--^1.4 Mult --> ^1.6 Mult, destroy all other played and held blinds if score exceeds ^1.5 requirements (0000
BLINDSIDE.Blind({
    key = 'unik_blindside_legendary_indigo_icbm',
    atlas = 'unik_blindside_legendary_blinds',
    pos = {x = 0, y = 1},
    config = {
        extra = {
            value = 1,
            e_mult = 1.35,
            e_mult_up = 0.15,
            requirements = 1.75,
            requirements_up = 0.5,
        }},
    hues = {"Purple","Green"},
    calculate = function(self, card, context) 
        if context.destroy_card and (context.cardarea == G.play or (not card.ability.extra.upgraded and context.cardarea == G.hand)) and context.destroy_card ~= card
        and SMODS.calculate_round_score() > G.GAME.blind.chips^card.ability.extra.requirements then
            return {
                remove = true,
            }
        end
        if context.after and context.scoring_hand and card.ability.extra.upgraded 
        and SMODS.calculate_round_score() > G.GAME.blind.chips^card.ability.extra.requirements then
            if SMODS.in_scoring(card,context.scoring_hand) then
                for i,v in pairs(G.hand.cards) do
                    v.unik_burned_by_hook = true
                end
            end
        end
        if context.cardarea == G.play and context.main_scoring then
            return {
                e_mult = card.ability.extra.e_mult
            }
        end
    end,
    unik_exotic = true,
    loc_vars = function(self, info_queue, card)
        local BlindSize = 0
        if G.GAME and G.GAME.blind and G.GAME.blind.chips then
            BlindSize = G.GAME.blind.chips^card.ability.extra.requirements
        end
        if card.ability.extra.upgraded then
            info_queue[#info_queue+1] = {key = 'bld_burn', set = 'Other'}
        end
        return {
            key = card.ability.extra.upgraded and 'm_unik_blindside_legendary_indigo_icbm_upgraded' or 'm_unik_blindside_legendary_indigo_icbm',
            vars = {
                card.ability.extra.e_mult,card.ability.extra.requirements,BlindSize,
            }
        }
    end,
    upgrade = function(card)
        if not card.ability.extra.upgraded then
            card.ability.extra.e_mult = card.ability.extra.e_mult + card.ability.extra.e_mult_up
            card.ability.extra.requirements = card.ability.extra.requirements + card.ability.extra.requirements_up
            card.ability.extra.upgraded = true
        end
    end
})