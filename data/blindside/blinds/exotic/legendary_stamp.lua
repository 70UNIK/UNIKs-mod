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
            e_chips = 1.04,
            e_chips_up = 0.04,
            retain = true
        }},
    hues = {"Blue","Yellow"},
    calculate = function(self, card, context) 
        if context.cardarea == G.play and context.main_scoring then
            return {
                e_chips = card.ability.extra.e_chips
            }
        end
        if card.ability.extra.hand_size and card.ability.extra.selection_limit and tableContains(card, G.hand.cards) and not card.ability.extra.unik_hand_size_added 
       and G.STATE ~= G.STATES.SMODS_BOOSTER_OPENED then
            card.ability.extra.unik_hand_size_added = true
           -- card.ability.extra.unik_selection_limit_added = true
            --add_tag(Tag('tag_bld_toss'))
            G.hand:change_size(card.ability.extra.hand_size)
           -- SMODS.change_discard_limit(card.ability.extra.selection_limit)
           --  SMODS.change_play_limit(card.ability.extra.selection_limit)
        end
        if card.ability.extra.hand_size and card.ability.extra.selection_limit and tableContains(card, G.hand.cards)
        and not card.ability.extra.unik_selection_limit_added and G.STATE ~= G.STATES.SMODS_BOOSTER_OPENED then
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
            vars = {
                card.ability.extra.e_chips,card.ability.extra.selection_limit,card.ability.extra.hand_size,
            }
        }
    end,
    upgrade = function(card)
        if not card.ability.extra.upgraded then
            card.ability.extra.e_chips = card.ability.extra.e_chips + card.ability.extra.e_chips_up
            card.ability.extra.upgraded = true
        end
    end
})