--X1.5 Mult and Xlog mult when held in hand, +1 hand size while held, retained
BLINDSIDE.Blind({
    key = 'unik_blindside_epic_bellows',
    atlas = 'unik_blindside_epic_blinds',
    pos = {x = 0, y = 4},
    config = {
        extra = {
            value = 1,
            x_mult = 1.6,
            x_mult_up = 0.6,
            log_base = 50,
            log_base_down = 25,
            hand_size = 1,
            retain = true,
        }},
    hues = {"Yellow","Blue"},
    calculate = function(self, card, context) 
        if context.cardarea == G.hand and context.main_scoring then
            return {
                x_mult = card.ability.extra.x_mult,
                xlog_mult = card.ability.extra.log_base,
            }
        end
        if tableContains(card, G.hand.cards) and not card.ability.extra.unik_hand_size_added and G.STATE ~= G.STATES.SMODS_BOOSTER_OPENED then
            card.ability.extra.unik_hand_size_added = true
            --add_tag(Tag('tag_bld_toss'))
            G.hand:change_size(card.ability.extra.hand_size)
            
        end
        if not tableContains(card, G.hand.cards) and card.ability.extra.unik_hand_size_added and G.STATE ~= G.STATES.SMODS_BOOSTER_OPENED then
            card.ability.extra.unik_hand_size_added = nil
            G.hand:change_size(-card.ability.extra.hand_size)
        end
    end,
    unik_ancient = true,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {key = 'bld_retain', set = 'Other'}
        return {
            vars = {
                card.ability.extra.x_mult,card.ability.extra.log_base,card.ability.extra.hand_size
            }
        }
    end,
    upgrade = function(card)
        if not card.ability.extra.upgraded then
            card.ability.extra.x_mult = card.ability.extra.x_mult +card.ability.extra.x_mult_up
            card.ability.extra.log_base = card.ability.extra.log_base - card.ability.extra.log_base_down
            card.ability.extra.upgraded = true
        end
    end
})