--all blinds in a symbol pack are upgraded
SMODS.Tag {
    key = "unik_blindside_super_booster",
    hide_ability = false,
    atlas = 'unik_tags',
    pos = {x = 6, y = 1},
    in_pool = function(self, args)
        if G.GAME.selected_back.effect.center.config.extra then
            if not G.GAME.selected_back.effect.center.config.extra.blindside then return false end
            return true
        else
        return false
        end
    end,
    pools = {["bld_obj_blindside"] = true},
    loc_vars = function(self, info_queue,tag)
        
	end,
    config = {
        extra = {
        }
    },
    apply = function(self, tag, context)
        if context.type == 'symbol_pack_opened' and not G.GAME.suppress_super_booster_tag then
            local valid = false
            if G.pack_cards and G.pack_cards.cards then
                for _, v in ipairs(G.pack_cards.cards) do
                    if not v.ability.upgrade then
                        valid = true
                    end
                end
            else
                valid = true
            end
            
            if valid then
                G.GAME.suppress_super_booster_tag = true
                G.E_MANAGER:add_event(Event({trigger = 'after', func = function()
                        if G.pack_cards and G.pack_cards.cards ~= nil and G.pack_cards.cards[1] and G.pack_cards.VT.y < G.ROOM.T.h then
                            upgrade_blinds(G.pack_cards.cards)
                            G.GAME.suppress_super_booster_tag = nil
                            tag:yep('+', G.C.DARK_EDITION, function()
                                return true
                            end)
                            tag.triggered = true
                        return true
                    end
                end}))
                
            end
            
        end
    end,
}