--destroys the oldest held detrimental tag
SMODS.Tag {
    key = "unik_blindside_shield",
    hide_ability = false,
    atlas = 'unik_tags',
    pos = {x = 8, y = 0},
    in_pool = function(self, args)
        if G.GAME.selected_back.effect.center.config.extra then
            if not G.GAME.selected_back.effect.center.config.extra.blindside then return false end
            return true
        else
        return false
        end
    end,
    pools = {["bld_obj_blindside"] = true},
    apply = function(self, tag, context)
        if (context.type == 'tag_add') then
            if (context.tag.key == 'tag_bld_debuff' or (G.P_TAGS[context.tag.key] and G.P_TAGS[context.tag.key].config and G.P_TAGS[context.tag.key].config.extra and G.P_TAGS[context.tag.key].config.extra.hex)) and not G.GAME.unik_suppress_shield then
                G.GAME.unik_suppress_shield = true
                G.E_MANAGER:add_event(Event({
                    func = function ()
                        context.tag:nope()
                        context.tag.triggered = true
                        tag:yep('+', G.C.GREEN, function() 
                            return true end)
                        tag.triggered = true
                        G.GAME.unik_suppress_shield = nil
                        return true
                    end
                }))
                
            end
        end
        if (context.type == 'self_tag_added') then
            for key, tag2 in pairs(G.GAME.tags) do
                if (tag2.key == 'tag_bld_debuff' or (G.P_TAGS[tag2.key] and G.P_TAGS[tag2.key].config and G.P_TAGS[tag2.key].config.extra and G.P_TAGS[tag2.key].config.extra.hex)) and not G.GAME.unik_suppress_shield then
                    G.GAME.unik_suppress_shield = true
                                    G.E_MANAGER:add_event(Event({
                                func = function ()
                            tag2:nope()
                            tag2.triggered = true
                            tag:yep('+', G.C.GREEN, function() 
                                return true end)
                            tag.triggered = true
                            G.GAME.unik_suppress_shield = nil
                                            return true
                        end
                    }))
                end
            end
        end
    end,
    -- set_ability = function (self, tag)
    --     for key, tag2 in pairs(G.GAME.tags) do
    --         if (tag2.key == 'tag_bld_debuff' or (G.P_TAGS[tag2.key] and G.P_TAGS[tag2.key].config and G.P_TAGS[tag2.key].config.extra and G.P_TAGS[tag2.key].config.extra.hex)) and not G.GAME.unik_suppress_shield then
    --             G.GAME.unik_suppress_shield = true
    --                             G.E_MANAGER:add_event(Event({
    --                         func = function ()
    --                     tag2:nope()
    --                     tag2.triggered = true
    --                     tag:yep('+', G.C.GREEN, function() 
    --                         return true end)
    --                     tag.triggered = true
    --                     G.GAME.unik_suppress_shield = nil
    --                                     return true
    --                 end
    --             }))
    --         end
    --     end
    -- end,
}
