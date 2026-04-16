---1 Hand Size this round
SMODS.Tag {
    key = "unik_blindside_handcuffs",
    hide_ability = false,
    atlas = 'unik_tags',
    pos = {x = 5, y = 5},
    in_pool = function(self, args)
        return false
    end,
    loc_vars = function(self, info_queue,tag)
        return {
            vars = {
                1
            }
        }
	end,
    config = {
        extra = {
            hand_size = 1,
            hex = true,
        }
    },
   set_ability = function (self, tag)
        tag.config.extra.give = true
        if tag.savetable then
            tag.config.extra.give = false
        end
    end,
    apply = function(self, tag, context)
        if tag.config.extra.give and #G.hand.cards > 0 then
            tag.config.extra.give = false
            G.hand:change_size(-1)
            G.GAME.round_resets.temp_handsize = (G.GAME.round_resets.temp_handsize or 0) - 1
        end
        if context.type == 'shop_start' and not (next(SMODS.find_card("j_bld_taglock")) and not (G.GAME.blind.boss or G.GAME.last_joker)) then
            tag:yep('+', G.C.RED, function() 
                return true end)
            tag.triggered = true
        end
        if context.type == 'shop_start' and (next(SMODS.find_card("j_bld_taglock")) and not (G.GAME.blind.boss or G.GAME.last_joker)) then
            tag.config.extra.give = true
        end
        if tag.config.extra.give and context.type == 'round_start_bonus' then
            tag.config.extra.give = false
            G.hand:change_size(-1)
            G.GAME.round_resets.temp_handsize = (G.GAME.round_resets.temp_handsize or 0) - 1
            return true
        end
    end,
}