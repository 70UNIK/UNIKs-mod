SMODS.Blind{
    key = 'unik_legendary_pentagram',
    boss = {min = 1,legendary = true,showdown = true,no_orb = true}, 
    atlas = "unik_legendary_blinds",
    pos = {x=0, y=5},
    boss_colour= HEX("600000"), --all legendary blinds will be blood red and black.
    dollars = 13,
    mult = 6,
    config = {},
    debuff = {
        akyrs_blind_difficulty = "legendary",
        akyrs_cannot_be_overridden = true,
        akyrs_cannot_be_disabled = true,
        akyrs_cannot_be_rerolled = true,
        akyrs_cannot_be_skipped = true,
    },
    set_blind = function(self, reset, silent)
        G.GAME.unik_pentagram_manager_fix = true
        
        if not reset then
            --print("vvvv")
            G.GAME.unik_prevent_killing_cursed_jokers = true
            G.GAME.unik_killed_by_pentagram = true
            local jimbo = false
            --forcibly spawn every cursed joker in the collection until jimbo is created
            while jimbo == false do
                -- G.E_MANAGER:add_event(Event({
				-- 	delay = 0.5,
				-- 	func = function()
                        local card2 = create_card("Joker", G.jokers, nil, UnikDetrimentalRarity(), nil, nil, nil, "unik_pentagram_curse")
                        --destroy card2 if its jimbo
                        if (card2.ability.name ~= "Joker") then
                            card2:start_materialize()
                            card2.ability.cry_absolute = true
                            card2:add_to_deck() --This causes problems. Why?
                            G.jokers:emplace(card2)
                            G.GAME.blind.triggered = true
                            G.GAME.blind:wiggle()
                            G.ROOM.jiggle = G.ROOM.jiggle + 2
                            delay(0.3)
                        else
                            card2:remove()
                            jimbo = true
                            break
                        end
                --         return true
                --     end
                -- }))
                if jimbo == true then
                    break
                end
            end
            --add the clones to the list
            local cloneList = {}
            for _, v in pairs(G.jokers.cards) do
                --crashes with double broken scale
                if v.config.center.key ~= "j_unik_broken_scale" and v.config.center.rarity == UnikDetrimentalRarity() then
                    v.ability.cry_absolute = true
                    cloneList[#cloneList + 1] = v
                elseif v.config.center.key == "j_unik_broken_scale" then
                    v:start_dissolve() --fix a crash related to this
                end
            end
            --clone every single one of them
            for _, v in pairs(cloneList) do
                -- G.E_MANAGER:add_event(Event({
				-- 	delay = 0.5,
				-- 	func = function()
                        local card2 = create_card("Joker", G.jokers, nil, nil, nil, nil,v.config.center.key)
                        card2:add_to_deck()
                        G.jokers:emplace(card2)
                        card2.ability.cry_absolute = true
                        card2:start_materialize()
                        G.GAME.blind.triggered = true
                        G.GAME.blind:wiggle()
                        G.ROOM.jiggle = G.ROOM.jiggle + 2
                        delay(0.3)
                --         return true
                --     end
                -- }))
            end
            local text = localize('k_unik_legendary_pentagram_start')
            attention_text({
                scale = 0.6, text = text, hold = 2, align = 'cm', offset = {x = 0,y = -2.7},major = G.play,colour = G.C.UNIK_EYE_SEARING_RED
            })
            G.GAME.blind.triggered = true
            G.GAME.blind:wiggle()
        end
    end,
    --If disabled, destroy all cursed jokers
    disable = function(self)
        G.GAME.unik_prevent_killing_cursed_jokers = nil
        G.GAME.unik_prevent_killing_cursed_jokers = true
        G.GAME.unik_killed_by_pentagram = nil
        for _, v in pairs(G.jokers.cards) do
            --print("Joker in set:")
            --print(v.ability.name)
            if v.config.center.rarity == UnikDetrimentalRarity() then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        play_sound('tarot1')
                        v.T.r = -0.2
                        v:juice_up(0.3, 0.4)
                        v.states.drag.is = true
                        v.children.center.pinch.x = true
                        -- This part destroys the card.
                        G.E_MANAGER:add_event(Event({
                            trigger = 'after',
                            delay = 0.0,
                            blockable = false,
                            func = function()
                                v:start_dissolve()
                                card_eval_status_text(v, "extra", nil, nil, nil, {
                                    message = localize("k_unik_pentagram_purified"),
                                    colour = G.C.MULT,
                                })
                                return true;
                            end
                        }))
                        return true
                    end
                }))
            end
        end
    end,
    defeat = function(self)
		G.GAME.unik_killed_by_pentagram = nil
        G.GAME.unik_prevent_killing_cursed_jokers = nil
        G.GAME.unik_pentagram_manager_fix = nil
	end,
}