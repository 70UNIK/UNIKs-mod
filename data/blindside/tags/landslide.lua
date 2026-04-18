--each played blind permanently loses 10 chips or 1 Mult
SMODS.Tag {
        key = "unik_blindside_landslide",
    hide_ability = false,
    atlas = 'unik_tags',
    pos = {x = 8, y = 5},
    in_pool = function(self, args)
        return false
    end,
    loc_vars = function(self, info_queue,tag)
        return {
            vars = {
                self.config.extra.chips,self.config.extra.mult,
            }
        }
	end,
    config = {
        extra = {
            mult = 0.5,
            chips = 4,
            hex = true,
        }
    },
    apply = function(self, tag, context)
        if context.type == 'shop_start' and not (next(SMODS.find_card("j_bld_taglock")) and not (G.GAME.blind.boss or G.GAME.last_joker)) then
            tag:yep('+', G.C.RED, function() 
                return true end)
            tag.triggered = true
        end
        if context.type == 'before' then
            for key, highlighted in pairs(G.play.cards) do
                if pseudorandom(pseudoseed('landslide_unik')) > 0.5 then
                    highlighted.ability["perma_bonus"] = highlighted.ability["perma_bonus"] or 0
                            highlighted.ability["perma_bonus"] = highlighted.ability["perma_bonus"] - self.config.extra.chips
                   G.E_MANAGER:add_event(Event({
                        trigger = 'before',
                        func = function()
                            
                            tag:juice_up()
                            play_sound('cancel', 0.8+ (0.9 + 0.2*math.random())*0.2, 1)
                            return true
                        end
                    }))
                    card_eval_status_text(highlighted, "extra", nil, nil, nil, {
                        message = localize({
                            type = "variable",
                            key = "a_chips",
                            vars = { number_format(highlighted.ability["perma_bonus"]) },
                        }),
                        colour = G.C.CHIPS,
                        card=highlighted,
                        delay = 0.5,
                    })

                else
                    highlighted.ability["perma_mult"] = highlighted.ability["perma_mult"] or 0
                    highlighted.ability["perma_mult"] = highlighted.ability["perma_mult"] - self.config.extra.mult
                     G.E_MANAGER:add_event(Event({
                        trigger = 'before',
                        func = function()
                            
                            
                            tag:juice_up()
                            play_sound('cancel', 0.8+ (0.9 + 0.2*math.random())*0.2, 1)
                            return true
                        end
                    }))
                    card_eval_status_text(highlighted, "extra", nil, nil, nil, {
                        message = localize({
                            type = "variable",
                            key = "a_mult",
                            vars = { number_format(highlighted.ability["perma_mult"]) },
                        }),
                        colour = G.C.MULT,
                        card=highlighted,
                        delay = 0.5,
                    })
                   
                end
            end
        end
    end,
}