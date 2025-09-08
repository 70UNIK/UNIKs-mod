--LAST TILE: Add Mosaic to all scored cards on final hand, self destructs.
SMODS.Joker {
    key = 'unik_last_tile',
    atlas = 'unik_rare',
	pos = { x = 2, y = 1 },
    rarity = 3,
    cost = 7,
    blueprint_compat = false,
    perishable_compat = true,
	eternal_compat = true,
    immutable = true,
    config = {extra = {to_be_destroyed = false}},
    loc_vars = function(self, info_queue, center)
        if not center.edition or (center.edition and not center.edition.unik_shining_glitter) then
			info_queue[#info_queue + 1] = G.P_CENTERS.e_unik_shining_glitter
		end
	end,
    pixel_size = { w = 71, h = 71 },
    calculate = function(self, card, context)
        if context.before and G.GAME.current_round.hands_left == 0 and not context.blueprint and not context.repetition and not context.retrigger_joker then
            --print("turn them happy")
            card.ability.extra.to_be_destroyed = true
            
            for i,v in pairs(context.scoring_hand) do
                v:set_edition({ unik_shining_glitter = true }, true,nil, true)
            end
            return{
               
            }
        end
        if context.after and card.ability.extra.to_be_destroyed and not context.blueprint and not context.repetition and not context.retrigger_joker then
            G.E_MANAGER:add_event(Event({
                trigger="immediate",

                func = function()
                    
                    
                    return true
                end
            }))
            G.E_MANAGER:add_event(Event({
                trigger="immediate",
                func = function()
                    --Dissolving
                        play_sound('tarot1')
                        card.T.r = -0.2
                        card:juice_up(0.3, 0.4)
                        card.states.drag.is = true
                        card.children.center.pinch.x = true
                        card:shatter()
                    
                    return true
                end
            }))
            return{
                message = localize("k_unik_weapon_destroyed"),
                colour = G.C.DARK_EDITION,
            }
        end
    end,
}