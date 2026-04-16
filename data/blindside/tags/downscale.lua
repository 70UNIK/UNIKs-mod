--^^0.95 Mult after hand is scored
SMODS.Tag {
    key = "unik_blindside_downscale",
    hide_ability = false,
    atlas = 'unik_tags',
    pos = {x = 4, y = 5},
    in_pool = function(self, args)
        return false
    end,
    loc_vars = function(self, info_queue,tag)
        return {
            vars = {
                self.config.extra.e_mult
            }
        }
	end,
    config = {
        extra = {
            e_mult = 0.9,
            hex = true,
        }
    },
    apply = function(self, tag, context)
        if context.type == 'shop_start' and not (next(SMODS.find_card("j_bld_taglock")) and not (G.GAME.blind.boss or G.GAME.last_joker)) then
            tag:yep('+', G.C.RED, function() 
                return true end)
            tag.triggered = true
        end
        if context.type == 'after_hand' then
            mult = mod_mult(mult ^ self.config.extra.e_mult)
            update_hand_text({delay = 0}, {mult = mult})
            tag_area_status_text(tag, "^0.9", G.C.DARK_EDITION, false, 0)
            G.E_MANAGER:add_event(Event({trigger = 'immediate', func = function()
                play_sound('unik_emult',0.9,1)
                tag:juice_up()
                return true
            end}))
            return true
        end
    end,
}