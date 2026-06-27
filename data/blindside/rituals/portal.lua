--pentatope but exotic blinds
--it however bloats your deck in return

SMODS.Atlas({
	key = "unik_blindside_portal", --this is easier to spell then consumables
	path = "unik_blindside_portal.png",
	px = 71,
	py = 95,
})

SMODS.Consumable {
    key = 'unik_blindside_portal',
    set = 'bld_obj_ritual',
    atlas = 'unik_blindside_portal',
    hidden = true,
    soul_sets = {
        'bld_obj_ritual',
        'bld_obj_filmcard',
        'bld_obj_mineral',
        'Playing Card',
        'Enhanced',
    },
    soul_rate = 0.001, --extremely rare
    can_use = function (self, card)
        return true
    end,
    config = {extra = {tags = 3}},
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_TAGS['tag_bld_voodoo']
        --local n,d = SMODS.get_probability_vars(card, card.ability.extra.base, card.ability.extra.odds,"unik_erosion")
        return {
            vars = {
                card.ability.extra.tags
            }
        }
    end,
    pos = {x=0, y=0},
    use = function(self, card, area)
        G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.4,func = function() 
                play_sound('bld_crack', 1.0, 1)
                card:juice_up(0.8, 0.5)
        return true end }))
        delay(1)
        G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.4,func = function()
                play_sound('bld_crack', 0.8, 1.1)
                card:juice_up(0.8, 0.5)
        return true end }))
        delay(1)
        G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.4,func = function()
                play_sound('bld_crack', 0.6, 1.2)
                card:juice_up(0.8, 0.5)
                if card.area then
                    card.area:remove_card()
                end
                
        card:explode()
        return true end }))
        local args = {}
        delay(1)
        args.guaranteed = true
        args.options = G.P_CENTER_POOLS.bld_obj_blindcard_crossmod_unik_exotic
        args.unik_exotic = true
        local cardtype = BLINDSIDE.poll_enhancement(args)
        local legendary = SMODS.create_card({ set = 'Playing Card', enhancement = cardtype, area = G.play })
        legendary:add_to_deck()
        legendary.states.visible = false
        G.playing_card = (G.playing_card and G.playing_card + 1) or 1
        legendary.playing_card = G.playing_card
        table.insert(G.playing_cards, legendary)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 1,
            func = function()
                legendary.states.visible = true
                    play_sound('unik_jenomega', 1,1)
                    legendary:add_to_deck()
                    G.play:emplace(legendary)
                    G.deck.config.card_limit = G.deck.config.card_limit + 1
                    G.ROOM.jiggle = G.ROOM.jiggle + 5
                    legendary:juice_up(2,2)
                return true
            end
        }))
        
        SMODS.calculate_context({ playing_card_added = true, cards = {legendary} })
        --local legendary = G.play[1]
        delay(1)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 1.2,
            func = function()
                
                draw_card(G.play, G.deck, 90, 'up')
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.7,
                    func = function()
                        pseudoshuffle(G.deck.cards, 'unik_portal'..G.GAME.round_resets.ante)
                        return true
                    end
                }))
                return true
            end
        }))
        delay(0.6)
        for i = 1, card.ability.extra.tags do
            G.E_MANAGER:add_event(Event({
                func = function ()
                    add_tag(Tag('tag_bld_voodoo'))
                    play_sound('generic1', 0.9 + math.random()*0.1, 0.8)
                    play_sound('holo1', 1.2 + math.random()*0.1, 0.4)
                    return true
                end
            }))
        end
        
    end,
}