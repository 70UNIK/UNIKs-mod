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
        if context.type == 'self_tag_added' then
            G.hand:change_size(-1)
            print("-1 Handsize")
        end
        if context.type == 'self_tag_removed' then
            G.hand:change_size(1)
            print("+1 Handsize")
        end
        if context.type == 'shop_start' and not BLINDSIDE.taglock_active() then
            -- print("+1 Handsize")
            -- G.hand:change_size(1)
            tag:yep('+', G.C.BLACK, function() 
                return true end)
            tag.triggered = true
        end
    end,
}