SMODS.Tag {
    key = "unik_blindside_peak",
    hide_ability = false,
    atlas = 'unik_tags',
    pos = {x = 3, y = 1},
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
                self.config.extra.chips,self.config.extra.mult,self.config.extra.x_mult,self.config.extra.x_chips
            }
        }
	end,
    config = {
        extra = {
            mult = 1,
            chips = 10,
            x_mult = 0.1,
            x_chips = 0.1,
        }
    },
    apply = function(self, tag, context)
        if context.type == 'shop_start' and not (next(SMODS.find_card("j_bld_taglock")) and not (G.GAME.blind.boss or G.GAME.last_joker)) then
            tag:yep('+', G.C.SUITS["unik_Crosses"], function() 
                return true end)
            tag.triggered = true
        end
        if context.type == 'before' then
            for key, highlighted in pairs(G.play.cards) do
                if pseudorandom(pseudoseed('peak_unik')) > 0.75 then
                    highlighted.ability["perma_bonus"] = highlighted.ability["perma_bonus"] or 0
                            highlighted.ability["perma_bonus"] = highlighted.ability["perma_bonus"] + self.config.extra.chips
                   G.E_MANAGER:add_event(Event({
                        trigger = 'before',
                        func = function()
                            
                            tag:juice_up()
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

                elseif pseudorandom(pseudoseed('peak_unik')) > 0.5 then
                    highlighted.ability["perma_mult"] = highlighted.ability["perma_mult"] or 0
                    highlighted.ability["perma_mult"] = highlighted.ability["perma_mult"] + self.config.extra.mult
                     G.E_MANAGER:add_event(Event({
                        trigger = 'before',
                        func = function()
                            
                            
                            tag:juice_up()
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
                   
                elseif pseudorandom(pseudoseed('peak_unik')) > 0.25 then
                    highlighted.ability["perma_x_mult"] = highlighted.ability["perma_x_mult"] or 0
                    highlighted.ability["perma_x_mult"] = highlighted.ability["perma_x_mult"] + self.config.extra.x_mult
                    
                 G.E_MANAGER:add_event(Event({
                        trigger = 'before',
                        func = function()
                            
                            
                            tag:juice_up()
                            return true
                        end
                    }))
                     card_eval_status_text(highlighted, "extra", nil, nil, nil, {
                            message = localize({
                                type = "variable",
                                key = "a_xmult",
                                vars = { number_format(1+highlighted.ability["perma_x_mult"]) },
                            }),
                            colour = G.C.MULT,
                            card=highlighted,
                            delay = 0.5,
                        })
                else
                        highlighted.ability["perma_x_chips"] = highlighted.ability["perma_x_chips"] or 0
                highlighted.ability["perma_x_chips"] = highlighted.ability["perma_x_chips"] + self.config.extra.x_chips

                card_eval_status_text(highlighted, "extra", nil, nil, nil, {
                    message = localize({
                        type = "variable",
                        key = "a_xchips",
                        vars = { number_format(1+highlighted.ability["perma_x_chips"]) },
                    }),
                    colour = G.C.CHIPS,
                    card=highlighted,
                    delay = 0.5,
                })
                end
            end
        end
    end,
}