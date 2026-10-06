
BLINDSIDE.Blind({
    key = 'unik_blindside_dragon',
    atlas = 'unik_blindside_blinds',
    pos = {x = 8, y = 5},
    config = {
       -- card_limit = 1,
        extra = {
            value = 1,
            x_mult = 2,
            x_mult_up = 1,
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
         if context.main_eval and (context.hand_drawn and context.cardarea == G.hand and tableContains(card, context.hand_drawn)) or (context.other_drawn and context.cardarea == G.hand and tableContains(card, context.other_drawn)) then
            card.ability.card_limit = 0
            if SMODS.pseudorandom_probability(card, pseudoseed("dragondraw"), card.ability.extra.chance, card.ability.extra.trigger, 'dragondraw') then
                card.ability.card_limit = 1
            else
                card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize('k_nope_ex') --[[index]], volume = 0.7, colour = G.C.GREEN})
            end
         end
    end,

    unik_exquisite = true,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {key = 'bld_retain', set = 'Other'}
        local chance, trigger = SMODS.get_probability_vars(card, card.ability.extra.chance, card.ability.extra.trigger, 'dragondraw')
        
        return {
            vars = {
                card.ability.extra.x_mult,chance,trigger,card.ability.extra.hand_size, card.ability.card_limit and card.ability.card_limit > 0 and localize("k_unik_applied") or localize("k_unik_not_applied"),colours = {
					card.ability.card_limit and card.ability.card_limit > 0 and G.C.FILTER or  G.C.UI.TEXT_INACTIVE,
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


local drawer = draw_card
function draw_card(from, to, percent, dir, sort, card, delay, mute, stay_flipped, vol, discarded_only)
    
    local ret = drawer(from, to, percent, dir, sort, card, delay, mute, stay_flipped, vol, discarded_only)
    return ret
end