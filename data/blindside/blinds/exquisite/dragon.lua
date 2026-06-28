
BLINDSIDE.Blind({
    key = 'unik_blindside_dragon',
    atlas = 'unik_blindside_blinds',
    pos = {x = 8, y = 5},
    config = {
        extra = {
            value = 1,
            x_mult = 2,
            x_mult_up = 0.5,
            retain = true,
            chance = 1,
            trigger = 2,
            trigger_down = 1,
            hand_size = 1,
        }},
    hues = {"Green"},
    calculate = function(self, card, context) 
        if context.cardarea == G.hand and context.main_scoring then
            return {
                x_mult = card.ability.extra.x_mult,
            }
        end
        if G.hand.cards and card and card.ability.extra.hand_size and tableContains(card, G.hand.cards) 
        and not card.ability.extra.dragon_attempt_made
        and not card.ability.extra.unik_hand_size_added and G.STATE ~= G.STATES.SMODS_BOOSTER_OPENED then
            card.ability.extra.dragon_attempt_made = true
            print("Attempt made")
            if SMODS.pseudorandom_probability(card, pseudoseed("dragondraw"), card.ability.extra.chance, card.ability.extra.trigger, 'dragondraw') then
                card.ability.extra.unik_hand_size_added = true
                G.GAME.bellows_hs_tracker = G.GAME.bellows_hs_tracker or 0
                G.GAME.bellows_hs_tracker =G.GAME.bellows_hs_tracker + 1
                --add_tag(Tag('tag_bld_toss'))
                G.hand:change_size(card.ability.extra.hand_size)
                print("hand_mod: " .. G.GAME.bellows_hs_tracker)
            else
                card_eval_status_text(card, 'extra', nil, nil, nil, {instant = true, message = localize('k_nope_ex') --[[index]], volume = 0.7, colour = G.C.GREEN})
            end
            
            
        end
        if G.hand.cards and card and card.ability.extra.hand_size and not tableContains(card, G.hand.cards) 
        and G.STATE ~= G.STATES.SMODS_BOOSTER_OPENED then
            if card.ability.extra.dragon_attempt_made then
                card.ability.extra.dragon_attempt_made = nil
                print("attempt_refresh")
            end
            if card.ability.extra.unik_hand_size_added then
                card.ability.extra.unik_hand_size_added = nil
                G.hand:change_size(-card.ability.extra.hand_size)
                G.GAME.bellows_hs_tracker = G.GAME.bellows_hs_tracker or 0
                G.GAME.bellows_hs_tracker =G.GAME.bellows_hs_tracker - 1
                print("hand_mod: " .. G.GAME.bellows_hs_tracker)
            end
            
        end
    end,
    unik_exquisite = true,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {key = 'bld_retain', set = 'Other'}
        local chance, trigger = SMODS.get_probability_vars(card, card.ability.extra.chance, card.ability.extra.trigger, 'dragondraw')
        
        return {
            vars = {
                card.ability.extra.x_mult,chance,trigger,card.ability.extra.hand_size, card.ability.extra.unik_hand_size_added and localize("k_unik_applied") or localize("k_unik_not_applied"),colours = {
					card.ability.extra.unik_hand_size_added and G.C.FILTER or  G.C.UI.TEXT_INACTIVE,
				},
            }
        }
    end,
    upgrade = function(card)
        if not card.ability.extra.upgraded then
            card.ability.extra.x_mult = card.ability.extra.x_mult +card.ability.extra.x_mult_up
          --  card.ability.extra.trigger = card.ability.extra.trigger - card.ability.extra.trigger_down
            card.ability.extra.upgraded = true
        end
    end
})