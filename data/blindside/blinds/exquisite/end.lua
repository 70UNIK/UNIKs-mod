BLINDSIDE.Blind({
    key = 'unik_blindside_end',
    atlas = 'unik_blindside_blinds',
    pos = {x = 8, y = 6},
    config = {
        extra = {
            value = 1,
            x_mult = 1.75,
            x_score = 2.5,
            x_score_up = 1,
            retain = true,
        }},
    hues = {"Purple"},
    calculate = function(self, card, context) 
        if context.cardarea == G.hand and context.main_scoring then
            if G.GAME.current_round.hands_left == 0 then
                return {
                    x_mult = card.ability.extra.x_mult,
                }
            else
                return {
                    x_score = card.ability.extra.x_score
                }
            end
            
        end
        if G.GAME.current_round.hands_left ~= 0 and context.burn_card and context.cardarea == G.play and context.burn_card == card then
            card.ability.extra.succeed = nil
            return { remove = true }
        end
       
    end,
    unik_exquisite = true,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {key = 'bld_retain', set = 'Other'}
        if not card.added_to_deck or not G.GAME or not G.GAME.current_round then
            return {
                vars = {
                    card.ability.extra.x_score,card.ability.extra.x_mult
                }
            }
        end
        return {
            key = ( G.GAME.current_round.hands_left == 0 or (G.GAME.current_round.hands_left <= 1 and G.STATE == G.STATES.SELECTING_HAND)) 
            and 'm_unik_blindside_end' or 'm_unik_blindside_end_inactive',
            vars = {
                card.ability.extra.x_score,card.ability.extra.x_mult
            }
        }
    end,
    upgrade = function(card)
        if not card.ability.extra.upgraded then
            card.ability.extra.x_score = card.ability.extra.x_score + card.ability.extra.x_score_up
            card.ability.extra.upgraded = true
        end
    end
})