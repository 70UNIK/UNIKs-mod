--Upgrades a random Blind in your deck


SMODS.Tag {
    key = "unik_blindside_wrench",
    hide_ability = false,
    atlas = 'unik_tags',
    pos = {x = 5, y = 1},
    in_pool = function(self, args)
        return false
    end,
    pools = {["bld_obj_blindside"] = true},
    loc_vars = function(self, info_queue,tag)
        
	end,
    config = {
        extra = {
        }
    },
    apply = function(self, tag, context)
        if (context.type == 'immediate' or context.type == "round_start_bonus") then 
            local cards = {}
            for i,v in pairs (G.playing_cards) do
                if not v.ability.upgraded and not v.to_be_upgraded then
                    cards[#cards+1] = v
                end
            end
            if #cards > 0 then
                local lock = tag.ID
                G.CONTROLLER.locks[lock] = true
                tag:yep('+', G.C.DARK_EDITION, function() 
                    local card = pseudorandom_element(cards, pseudoseed("unik_wrench_tag"))
                    card.to_be_upgraded = true
                    upgrade_blinds({card})
                    G.E_MANAGER:add_event(Event({func = function()
                        
                        G.CONTROLLER.locks[lock] = nil
                        G.GAME.unik_wrench_lock_tag = nil
                        card.to_be_upgraded = nil
                    return true; end}))
                    
                    return true end)
                tag.triggered = true
            else
                G.GAME.unik_wrench_lock_tag = nil
            end
            
        end
    end,
}