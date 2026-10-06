--Upgrades a random Blind in your deck


SMODS.Tag {
    key = "unik_blindside_wrench",
    hide_ability = false,
    atlas = 'unik_tags',
    pos = {x = 5, y = 1},
    in_pool = function(self, args)
        return UNIK.hasBlindside() and pseudorandom('wrench_spawn'..G.SEED) < 0.65
    end,
    pools = {["bld_obj_blindside"] = true},
    loc_vars = function(self, info_queue,tag)
        
	end,
    config = {
        extra = {
            cannot_copy = true
        }
    },
    blindside_tag = true,
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
                local card = pseudorandom_element(cards, pseudoseed("unik_wrench_tag"))
                card.to_be_upgraded = true
                upgrade_blinds({card},nil,nil,tag)
                tag:yep('+', G.C.DARK_EDITION, function() 
                    
                    G.CONTROLLER.locks[lock] = nil   
                    card.to_be_upgraded = nil
                    tag.triggered = true
                    
                    return true end)
                
            else
                G.GAME.unik_wrench_lock_tag = nil
            end
            
        end
    end,
}