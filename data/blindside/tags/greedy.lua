--+$4 per hand lost this round, +$3 per discard lost this round
SMODS.Tag {
    key = "unik_blindside_greedy",
    hide_ability = false,
    atlas = 'unik_tags',
    pos = {x = 6, y = 0},
    pools = {["bld_obj_blindside"] = true},
    config = {},
    in_pool = function(self, args)
        if G.GAME.selected_back.effect.center.config.extra then
            if not G.GAME.selected_back.effect.center.config.extra.blindside then return false end
            return true
        else
        return false
        end
    end,
    loc_vars = function(self, info_queue,tag)
		return { vars = { 3,3 } }
	end,
    apply = function(self, tag, context)
        if context.type == 'shop_start' and not BLINDSIDE.taglock_active() then
            tag:yep('+', G.C.BLUE, function() 
                return true end)
            tag.triggered = true
        end
        if context.type == 'hand_mod' and context.hand_mod_val < 0 then
            G.E_MANAGER:add_event(Event({trigger = 'after', func = function()
                tag:juice_up(1,1)
                ease_dollars(3)
                delay(0.3)
                return true
            end}))
            
        end
        if context.type == 'discard_mod' and context.discard_mod_val < 0 then
            G.E_MANAGER:add_event(Event({trigger = 'after', func = function()
                tag:juice_up(1,1)
                ease_dollars(3)
                delay(0.3)
                return true
            end}))
        end
    end,
}