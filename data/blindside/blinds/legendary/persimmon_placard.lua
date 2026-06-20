BLINDSIDE.Blind({
    key = 'unik_blindside_persimmon_placard',
    atlas = 'unik_blindside_blinds',
    pos = {x = 8, y = 2},
    config = {
        extra = {
            value = 1,
            x_mult = 3,
            money = 2,
            x_mult_up = 2,
            money_up = 3,
        }},
    hues = {"Yellow"},
    calculate = function(self, card, context) 
        if context.unik_after_effect and context.scoring_hand then
            local cards = 0
            for i,v in pairs(context.scoring_hand) do
                if v.debuff or v.facing == 'back' then
                    cards = cards + 1
                end
            end
            
            if cards > 0 then
                return {
                    rescore = cards
                }
            end
        end
        if context.cardarea == G.play and context.before and card.facing ~= 'back' and not context.blueprint then
            for i=1, #G.play.cards do
                if G.play.cards[i] ~= card then
                    G.play.cards[i].config.center.blind_debuff(G.play.cards[i], true)
                    
                end
            end
        end
        if context.cardarea == G.play and context.after and card.facing ~= 'back' and not context.blueprint then
            for i=1, #G.play.cards do
                if  G.play.cards[i] ~= card then
                    G.play.cards[i]:set_debuff(false)

                end
            end
        end
        if context.cardarea == G.play and context.main_scoring then
            return {
                x_mult = card.ability.extra.x_mult,
                p_dollars = card.ability.extra.money,
            }
        end
    end,
    legendary = true,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = { set = "Other", key = "unik_rescore" }
        return {
            vars = {
                card.ability.extra.x_mult,
                card.ability.extra.money
            }
        }
    end,
    upgrade = function(card)
        if not card.ability.extra.upgraded then
            card.ability.extra.x_mult = card.ability.extra.x_mult + card.ability.extra.x_mult_up
            card.ability.extra.money = card.ability.extra.money + card.ability.extra.money_up
        card.ability.extra.upgraded = true
        end
    end
})