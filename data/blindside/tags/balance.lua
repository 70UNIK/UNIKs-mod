--balances chips and mult by ^0.85 after scoring
SMODS.Tag {
    key = "unik_blindside_balance",
    hide_ability = false,
    atlas = 'unik_tags',
    pos = {x = 7, y = 0},
   in_pool = function(self, args)
            if G.GAME.selected_back.effect.center.config.extra then
                if not G.GAME.selected_back.effect.center.config.extra.blindside then return false end
                return true
            else
            return false
            end
        end,
    loc_vars = function(self, info_queue,tag)
        return {
            vars = {
                self.config.extra.amount
            }
        }
	end,
    config = {
        extra = {
            amount = 0.8,
        }
    },
    apply = function(self, tag, context)
        if context.type == 'shop_start' and not (next(SMODS.find_card("j_bld_taglock")) and not (G.GAME.blind.boss or G.GAME.last_joker)) then
            tag:yep('+', G.C.DARK_EDITION, function() 
                return true end)
            tag.triggered = true
        end
        if context.type == 'after_hand' then
            UNIK.balance_exp(self.config.extra.amount,nil,true)
            tag_area_status_text(tag, "Balanced", G.C.DARK_EDITION, false, 0)
            G.E_MANAGER:add_event(Event({trigger = 'immediate', func = function()
                tag:juice_up()
                return true
            end}))
            return true
        end
    end,
}