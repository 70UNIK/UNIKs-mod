--4 in 5 chance to either:
--get a cursed Joker
--permanently debuff a joker owned
--make 2 jokers positive
--create a vessel tag (next blind has 3x blind size)
--otherwise get an extended empowered tag (soul, awakening or foundation for those who are willing to take it slow and preserve their current build (mostly))

SMODS.Tag{
    atlas = 'unik_tags',
    key = 'unik_demon',
    pos = { x = 0, y = 0 },
    config = { type = "round_start_bonus", odds = 4 },
    min_ante = 2,
    loc_vars = function(self, info_queue)
		info_queue[#info_queue + 1] = G.P_TAGS.tag_unik_extended_empowered
        info_queue[#info_queue + 1] = G.P_TAGS.tag_unik_vessel
        info_queue[#info_queue + 1] = G.P_TAGS.tag_unik_manacle
        info_queue[#info_queue + 1] = G.P_CENTERS.e_unik_positive
        local new_numerator, new_denominator = SMODS.get_probability_vars(self, 3,4, 'unik_demon_tag')
		return { vars = { new_numerator, new_denominator } }
	end,
	apply = function(self, tag, context)
		if context.type == "new_blind_choice" then
			if SMODS.pseudorandom_probability(self, 'unik_demon_tag', 3, 4, 'unik_demon_tag') then
                --cursed joker creation
                --if owning OAS:
                for i,v in pairs(G.jokers.cards) do
                    if v.config.center.key == 'j_oops' then
                        check_for_unlock({ type = "unik_bloodbath" })
                    end
                end
                if pseudorandom("unik_get_demoned") < 0.2 then
                    
                    local lock = tag.ID
                    G.CONTROLLER.locks[lock] = true
                    tag:too_bad("TOO BAD",  G.C.UNIK_VOID_COLOR, function()
                        local card = create_card("Joker", G.jokers, nil, UnikDetrimentalRarity(), nil, nil, nil, "unik_demon")
                        card:add_to_deck()
                        G.jokers:emplace(card)
                        G.CONTROLLER.locks[lock] = nil
                        return true
                    end)
                    tag.triggered = true
                --Destroy a random Joker
                elseif pseudorandom("unik_get_demoned") < 0.4 then

                            local deletable_jokers = {}
                            for k, v in pairs(G.jokers.cards) do
                                if not v.ability.eternal and v.config.center.rarity ~= UnikDetrimentalRarity() then
                                    deletable_jokers[#deletable_jokers + 1] = v
                                end
                            end
                            if #deletable_jokers > 0 then
                                local lock = tag.ID
                                G.CONTROLLER.locks[lock] = true
                                tag:too_bad("TOO BAD",  G.C.UNIK_VOID_COLOR, function()
                                    local _first_dissolve = nil
                                    local select = pseudorandom_element(deletable_jokers, pseudoseed("unik_delete_select"))
                                    select:start_dissolve(nil, _first_dissolve)
                                    _first_dissolve = true
                                    --card_eval_status_text(G.jokers.cards[select], "extra", nil, nil, nil, { message = localize("k_disabled_ex") ,colour = G.C.BLACK})
                                    G.CONTROLLER.locks[lock] = nil
                                    return true
                                end)
                                tag.triggered = true
                            else
                                local lock = tag.ID
                                G.CONTROLLER.locks[lock] = true
                                tag:too_bad("TOO BAD",  G.C.UNIK_VOID_COLOR, function()
                                    local card = create_card("Joker", G.jokers, nil, UnikDetrimentalRarity(), nil, nil, nil, "unik_demon")
                                    card:add_to_deck()
                                    G.jokers:emplace(card)
                                    G.CONTROLLER.locks[lock] = nil
                                    return true
                                end)
                                tag.triggered = true

                            end

                --turn a joker positive
                elseif pseudorandom("unik_get_demoned") < 0.6 then

                            local validEntries = {}
                            for k, v in pairs(G.jokers.cards) do
                                if not v.edition then
                                    validEntries[#validEntries + 1] = v
                                elseif v.edition and not v.edition.unik_positive then
                                    validEntries[#validEntries + 1] = v
                                
                                end
                            end
                            --print(validEntries)
                            if #validEntries > 0 then
                                local lock = tag.ID
                                G.CONTROLLER.locks[lock] = true
                                tag:too_bad("TOO BAD",  G.C.UNIK_VOID_COLOR, function()
                                    local select = pseudorandom_element(validEntries, pseudoseed("unik_positive_select"))
                                    select:set_edition({ unik_positive = true }, true,nil, true)
                                    G.CONTROLLER.locks[lock] = nil
                                    return true
                                end)
                                tag.triggered = true
                            else
                                local lock = tag.ID
                                G.CONTROLLER.locks[lock] = true
                                tag:too_bad("TOO BAD",  G.C.UNIK_VOID_COLOR, function()
                                    local emp = Tag("tag_unik_manacle")
                                    if Cryptid then
                                        emp.ability.shiny = Cryptid.is_shiny()
                                    end
                                    	
                                    add_tag(emp)
                                    G.CONTROLLER.locks[lock] = nil   
                                    return true
                                end)
                                tag.triggered = true
                            end

                --manacle
                elseif pseudorandom("unik_get_demoned") < 0.8 then
                    local lock = tag.ID
                    G.CONTROLLER.locks[lock] = true
                    tag:too_bad("TOO BAD",  G.C.UNIK_VOID_COLOR, function()
                        local emp = Tag("tag_unik_manacle")
                        if Cryptid then
                            emp.ability.shiny = Cryptid.is_shiny()
                        end
                        add_tag(emp)
                        G.CONTROLLER.locks[lock] = nil   
                        return true
                    end)
                    tag.triggered = true
                -- vessel tag
                else 
                    
                    local lock = tag.ID
                    G.CONTROLLER.locks[lock] = true
                    tag:too_bad("TOO BAD",  G.C.UNIK_VOID_COLOR, function()
                        local emp = Tag("tag_unik_vessel")
                        if Cryptid then
                            emp.ability.shiny = Cryptid.is_shiny()
                        end
                        add_tag(emp)
                        G.CONTROLLER.locks[lock] = nil   
                        return true
                    end)
                    tag.triggered = true
                end
                for i = 1, #G.GAME.tags do
                    if G.GAME.tags[i] ~= tag then
                        if G.GAME.tags[i]:apply_to_run({ type = "new_blind_choice" }) then
                            break
                        end
                    end
                end
                --return true
			else
                local lock = tag.ID
				G.CONTROLLER.locks[lock] = true
				tag:yep("+", G.C.SECONDARY_SET.Spectral, function()
					local emp = Tag("tag_unik_extended_empowered")
                    if Cryptid then
                        if tag.ability.shiny then -- good fucking luck
                            emp.ability.shiny = Cryptid.is_shiny()
                        end
                    end
					add_tag(emp)
					tag.triggered = true
					emp:apply_to_run({ type = "new_blind_choice" })
					G.CONTROLLER.locks[lock] = nil
					return true
				end)
			end
			return true
		end
	end,
}


function Tag:too_bad(message, _colour, func)
    stop_use()

    G.E_MANAGER:add_event(Event({
        delay = 0.4,
        trigger = 'after',
        func = (function()
            attention_text({
                text = message,
                colour = G.C.UNIK_EYE_SEARING_RED,
                scale = 1, 
                hold = 0.3/G.SETTINGS.GAMESPEED,
                cover = self.HUD_tag,
                cover_colour = _colour or G.C.UNIK_VOID_COLOR,
                align = 'cm',
                })
                play_sound('cancel', 1.0, 0.5)
            return true
        end)
    }))
    G.E_MANAGER:add_event(Event({
        trigger = 'after',
        delay = 0.1,
        func = (function()
            self.HUD_tag.states.visible = false
            play_sound('cancel', 0.78, 0.5)
            return true
        end)
    }))
    G.E_MANAGER:add_event(Event({
        func = func
    }))
    
    G.E_MANAGER:add_event(Event({
        trigger = 'after',
        delay = 0.7,
        func = (function()
            self:remove()
            return true
        end)
    }))
end