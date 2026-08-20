--^1.05 Chips, --> ^1.08 Chips
--+2 Card selection limit when played or held
--+2 hand size when held
--retained
BLINDSIDE.Blind({
    key = 'unik_blindside_legendary_sapphire_stamp',
    atlas = 'unik_blindside_legendary_blinds',
    pos = {x = 0, y = 4},
    config = {
        extra = {
            value = 1,
            selection_limit = 2,
            hand_size = 2,
            xlogchips_base = 10,
            xlogchips_basedown = 3,
            xchips = 2,
            xchips_up = 1,
            retain = true
        }},
    hues = {"Blue","Yellow"},
    calculate = function(self, card, context) 
        if (context.cardarea == G.play or (context.cardarea == G.hand and card.ability.extra.upgraded)) and context.main_scoring then
            return {
                x_chips = card.ability.extra.xchips,
                xlog_chips = card.ability.extra.xlogchips_base,
            }
        end
        if card.ability.extra.hand_size and card.ability.extra.selection_limit and tableContains(card, G.hand.cards) and not card.ability.extra.unik_hand_size_added 
       and G.STATE ~= G.STATES.SMODS_BOOSTER_OPENED and not context.blueprint then
            card.ability.extra.unik_hand_size_added = true
           -- card.ability.extra.unik_selection_limit_added = true
            --add_tag(Tag('tag_bld_toss'))
            G.hand:change_size(card.ability.extra.hand_size)
           -- SMODS.change_discard_limit(card.ability.extra.selection_limit)
           --  SMODS.change_play_limit(card.ability.extra.selection_limit)
        end
        if card.ability.extra.hand_size and card.ability.extra.selection_limit and tableContains(card, G.hand.cards)
        and not card.ability.extra.unik_selection_limit_added and G.STATE ~= G.STATES.SMODS_BOOSTER_OPENED and not context.blueprint then
           -- card.ability.extra.unik_hand_size_added = true
            --add_tag(Tag('tag_bld_toss'))
            card.ability.extra.unik_selection_limit_added = true
           -- G.hand:change_size(card.ability.extra.hand_size)
            SMODS.change_discard_limit(card.ability.extra.selection_limit)
             SMODS.change_play_limit(card.ability.extra.selection_limit)
        end
        if card.ability.extra.hand_size and card.ability.extra.selection_limit and not tableContains(card, G.hand.cards) and card.ability.extra.unik_hand_size_added 
         and G.STATE ~= G.STATES.SMODS_BOOSTER_OPENED then
            card.ability.extra.unik_hand_size_added = nil
            G.hand:change_size(-card.ability.extra.hand_size)
        end
        if card.ability.extra.selection_limit and not tableContains(card, G.hand.cards)
        and card.ability.extra.unik_selection_limit_added and G.STATE ~= G.STATES.SMODS_BOOSTER_OPENED then
            card.ability.extra.unik_selection_limit_added = nil
            SMODS.change_discard_limit(-card.ability.extra.selection_limit)
             SMODS.change_play_limit(-card.ability.extra.selection_limit)
        end
    end,
    unik_exotic = true,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {key = 'bld_retain', set = 'Other'}
        return {
            key = card.ability.extra.upgraded and 'm_unik_blindside_legendary_sapphire_stamp_upgraded' or 'm_unik_blindside_legendary_sapphire_stamp',
            vars = {
                card.ability.extra.xchips,card.ability.extra.xlogchips_base,card.ability.extra.selection_limit,card.ability.extra.hand_size,
            }
        }
    end,
    upgrade = function(card)
        if not card.ability.extra.upgraded then
            card.ability.extra.xlogchips_base = card.ability.extra.xlogchips_base - card.ability.extra.xlogchips_basedown
            card.ability.extra.xchips = card.ability.extra.xchips + card.ability.extra.xchips_up
            card.ability.extra.upgraded = true
        end
    end
})