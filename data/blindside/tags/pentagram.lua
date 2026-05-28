--each hand creates 1 random Crude Blind in hand
SMODS.Tag {
    key = "unik_blindside_pentagram",
    hide_ability = false,
    atlas = 'unik_tags',
    pos = {x = 7, y = 5},
    in_pool = function(self, args)
        return false
    end,
    loc_vars = function(self, info_queue,tag)

	end,
    config = {
        extra = {
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
            local cardsadded = {}
             G.E_MANAGER:add_event(Event({
                delay = 1,
                trigger = 'before',
                    func = function()
                        local args = {}
                        args.guaranteed = true
                        args.options = G.P_CENTER_POOLS.bld_obj_blindcard_generate
                        args.cursed = true
                        local cardtype = BLINDSIDE.poll_enhancement(args)
                        
                        local cardr = SMODS.create_card { set = "Base", enhancement = cardtype, area = G.hand }
                        cardr:add_to_deck()
                        G.playing_card = (G.playing_card and G.playing_card + 1) or 1
                        cardr.playing_card = G.playing_card
                        table.insert(G.playing_cards, cardr)
                        cardr:start_materialize()
                        G.hand:emplace(cardr)
                        cardsadded[#cardsadded+1] = cardr
                        tag:juice_up(3,3)
                        G.E_MANAGER:add_event(Event({
                            func = function()
                               SMODS.calculate_context({ playing_card_added = true, cards = cardsadded })
                                    
                                return true
                            end
                        }))
                        return true
                    end
                }))
            
        end
    end,
}