SMODS.Blind	{
    key = 'unik_epic_bird',
    config = {},
	showdown = true,
    boss = {min = 1, showdown = true, hardcore = true, epic = true,no_orb = true},
    boss_colour = HEX("405c25"),
    atlas = 'unik_legendary_blinds',
    pos = {x = 0, y = 30},
    vars = {},
    dollars = 13,
    mult = 2,
    pronouns = "it_its",
    debuff = {
        akyrs_blind_difficulty = "unik_epic",
        akyrs_cannot_be_overridden = true,
        akyrs_cannot_be_disabled = true,
        akyrs_cannot_be_rerolled = true,
        akyrs_cannot_be_skipped = true,
    },
	set_blind = function(self, reset, silent)
        if not reset and not G.GAME.blind.disabled  then
            G.GAME.blind:wiggle()
            G.GAME.blind.triggered = true
            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
                update_hand_text(
				{ sound = "button", volume = 0.7, pitch = 0.8, delay = 0.3 },
				{ handname = localize("k_all_hands_no_sf"), chips = "...", mult = "...", level = "" }
			)
            delay(1.3)
            G.E_MANAGER:add_event(Event({
                trigger = "after",
                delay = 0.2,
                func = function()
                    play_sound("tarot1")
                    G.GAME.blind.children.animatedSprite:juice_up(0.8, 0.5)
                    G.ROOM.jiggle = G.ROOM.jiggle + 3
                    G.TAROT_INTERRUPT_PULSE = true
                    return true
                end,
            }))
            delay(1.3)
            update_hand_text({ delay = 0 }, { mult = "=-2", StatusText = true, forceRed = true })
            G.E_MANAGER:add_event(Event({
                trigger = "after",
                delay = 0.9,
                func = function()
                    play_sound("tarot1")
                    G.GAME.blind.children.animatedSprite:juice_up(0.8, 0.5)
                    G.ROOM.jiggle = G.ROOM.jiggle + 3
                    return true
                end,
            }))
            delay(1.3)
            update_hand_text({ delay = 0 }, { chips = "=-2", StatusText = true, forceRed = true})
            G.E_MANAGER:add_event(Event({
                trigger = "after",
                delay = 0.9,
                func = function()
                    play_sound("tarot1")
                    G.GAME.blind.children.animatedSprite:juice_up(0.8, 0.5)
                    G.ROOM.jiggle = G.ROOM.jiggle + 3
                    G.TAROT_INTERRUPT_PULSE = nil
                    return true
                end,
            }))
            update_hand_text({ sound = "button", volume = 1.0, pitch = 0.8, delay = 0 }, { level = "=0" })
            delay(1.3)
            if G.GAME.hands then
                for i,v in ipairs(G.handlist) do
                    if v ~= 'Straight Flush' then
                        G.GAME.hands[v].level = 0
                        G.GAME.hands[v].chips = -2 --ALWAYS NEGATIVE!
                        G.GAME.hands[v].mult = -2
                    end

                end
            end
            update_hand_text(
                { sound = "button", volume = 1.0, pitch = 0.8, delay = 0 },
                { mult = 0, chips = 0, handname = "", level = "" }
            )
            return true end })) 
        end
    end,
}