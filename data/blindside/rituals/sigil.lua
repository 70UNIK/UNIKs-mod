--create an ancient blind, create a soul tag

SMODS.Atlas({
	key = "unik_blindside_sigil", --this is easier to spell then consumables
	path = "unik_blindside_sigil.png",
	px = 71,
	py = 95,
})
SMODS.Sound({
	key = "jenomega",
	path = "jenomega.ogg",
})
SMODS.ObjectType {
    key = "unik_obj_blindcard_ancient",
    default = "m_unik_blindside_epic_wall",
    inject_card = function(self, center)
        SMODS.ObjectType.inject_card(self, center)
        SMODS.insert_pool(G.P_CENTER_POOLS['unik_obj_blindcard_ancient'], center)
    end,
    delete_card = function(self, center)
        SMODS.ObjectType.delete_card(self, center)
        SMODS.remove_pool(G.P_CENTER_POOLS['unik_obj_blindcard_ancient'], center.key)
    end,
}


SMODS.Consumable {
    key = 'unik_blindside_sigil',
    set = 'bld_obj_ritual',
    atlas = 'unik_blindside_sigil',
    hidden = true,
    soul_sets = {
        'bld_obj_ritual',
        'bld_obj_filmcard',
        'bld_obj_mineral',
        'Playing Card',
        'Enhanced',
    },
    soul_rate = 0.003,
    can_use = function (self, card)
        return true
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
                card.area:remove_card()
        card:explode()
        return true end }))
        local args = {}
        delay(0.75)
        args.guaranteed = true
        args.options = G.P_CENTER_POOLS.unik_obj_blindcard_ancient
        args.unik_ancient = true
        local cardtype = BLINDSIDE.poll_enhancement(args)
        local legendary = SMODS.create_card({ set = 'Playing Card', enhancement = cardtype, area = G.play })
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
                    G.ROOM.jiggle = G.ROOM.jiggle + 5
                    legendary:juice_up(2,2)
                return true
            end
        }))
        delay(1)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 1.2,
            func = function()
                local legendary = G.play[1]
                draw_card(G.play, G.deck, 90, 'up')
                SMODS.calculate_context({ playing_card_added = true, cards = {legendary} })
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.7,
                    func = function()
                        pseudoshuffle(G.deck.cards, 'unik_sigil'..G.GAME.round_resets.ante)
                        return true
                    end
                }))
                return true
            end
        }))
    end,
}