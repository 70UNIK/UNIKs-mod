-- local groupHook = has_group_of
-- function has_group_of(num, hands)
--     if not hands then return false end

--     return groupHook(num,hands)
-- end
--scaling blinds will use scale_card instead so its easier to block from being copied
--The Snow (/)
--The Line (/)
--The Trench (/)
--Monolith (/)
BLINDSIDE.Blind:take_ownership("m_bld_monolith",{
    calculate = function(self, card, context)
         if context.before then
                local _best_hand, _hand, _tally = nil, nil, -1
                for k, v in ipairs(G.handlist) do
                    if G.GAME.hands[v].visible and G.GAME.hands[v].played > _tally then
                        _hand = v
                        _best_hand = k
                        _tally = G.GAME.hands[v].played
                    end
                end
                if _hand then
                    if _hand == context.scoring_name then
                         SMODS.scale_card(card, {
                            ref_table = card.ability.extra,
                            ref_value = "xmult",
                            scalar_value = "xmult_lose",
                            operation = '-',
                                no_message = true,

                        })
                        card.ability.extra.xmult = math.max(card.ability.extra.xmult,0)
                        --card.ability.extra.xmult = math.max(0, card.ability.extra.xmult - card.ability.extra.xmult_lose)
                        return {
                            message = localize("k_downgrade_ex")
                        }
                    else
                        SMODS.scale_card(card, {
                            ref_table = card.ability.extra,
                            ref_value = "xmult",
                            scalar_value = "xmult_gain",
                            operation = '+',
                                no_message = true,

                        })
                       --card.ability.extra.xmult = card.ability.extra.xmult + card.ability.extra.xmult_gain
                        return {
                            message = localize("k_upgrade_ex")
                        }
                    end
                end
            end
            
            if context.cardarea == G.play and context.main_scoring then
                return {
                    xmult = card.ability.extra.xmult
                }
            end
    end,
},true)
BLINDSIDE.Blind:take_ownership("m_bld_trench",{
    calculate = function(self, card, context)
         if context.cardarea == G.play and context.main_scoring then
            --card.ability.extra.xchips = card.ability.extra.xchips + card.ability.extra.xchips_gain
            return {
                xchips = card.ability.extra.xchips,
                func = function ()
                         SMODS.scale_card(card, {
                            ref_table = card.ability.extra,
                            ref_value = "xchips",
                            scalar_value = "xchips_gain",
                            operation = '+',
                                no_message = true,

                        })
                    end
            }
        end
    end,
},true)
BLINDSIDE.Blind:take_ownership("m_bld_line",{
        replace_base_card = true,
    no_rank = true,
    no_suit = true,
    overrides_base_rank = true,
    blindside_blind = true,
    calculate = function(self, card, context)
        if context.modify_hand and context.scoring_hand then
            local i_scored = false
            for key, value in pairs(context.scoring_hand) do
                if value == card then
                    i_scored = true
                end
            end

            if not i_scored then
                return
            end

            if G.GAME.current_round.discards_left > 0 then
                 SMODS.scale_card(card, {
                            ref_table =card.ability.extra,
                            ref_value = "xmult",
                            scalar_value = "custom_scaler",
                            scalar_table = {
                                custom_scaler = G.GAME.current_round.discards_left * card.ability.extra.xmult_gain,
                            },
                            message_key = "a_xmult",
                            message_colour = G.C.MULT,
                        })
                        --ease_discard(-G.GAME.current_round.discards_left)
                return {
                    message = localize('k_upgrade_ex'),
                    func = function ()
                        ease_discard(-G.GAME.current_round.discards_left)
                       
                    end
                }
            end
        end

        if context.main_scoring and context.cardarea == G.play and card.ability.extra.xmult > 1 then
            return {
                xmult = card.ability.extra.xmult
            }
        end
        end,
},true)
BLINDSIDE.Blind:take_ownership("m_bld_snow",{
    replace_base_card = true,
    no_rank = true,
    no_suit = true,
    overrides_base_rank = true,
    blindside_blind = true,
    calculate = function(self, card, context)
        if context.cardarea == G.play and context.main_scoring then
            return {
                chips = card.ability.extra.chips
            }
        end

        if context.cardarea == G.hand and context.main_scoring then
            --card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.gain_chips
            SMODS.scale_card(card, {
                ref_table = card.ability.extra,
                ref_value = "chips",
                scalar_value = "gain_chips",
                operation = '+',
                message_colour = G.C.CHIPS,
                -- force_full_val = true,
                -- operation = function(ref_table, ref_value, initial, scaling)
                --     ref_table[ref_value] = initial + scaling * cards
                -- end,
            })
            -- SMODS.scale_card(card, {
            --     ref_table = card.ability.extra,
            --     ref_value = "x_mult",
            --     scalar_value = "x_mult_bonus",
            --     operation = '+',
            --     message_colour = G.C.PURPLE
            -- })
            return {
                -- message = localize('k_upgrade_ex')
            }
        end

        if context.after and context.scoring_hand then
            local i_scored = false
            for key, value in pairs(context.scoring_hand) do
                if value == card then
                    i_scored = true
                    break
                end
            end

            if i_scored then
                card.ability.extra.chips = 0
                return {
                    message = localize('k_reset')
                }
            end
        end   
    end,
},true)

--curb excessive acorn scaling
BLINDSIDE.Blind:take_ownership("m_bld_amber_acorn",{
    config = {
        extra = {
            value = 1,
            xchips = 1,
            xchips_increase = 0.2,
            xchipsup = 0.2,
            hues = {"Yellow"},
        }
    },
    hues = {"Yellow"},
    replace_base_card = true,
    no_rank = true,
    no_suit = true,
    overrides_base_rank = true,
    blindside_blind = true,
    calculate = function(self, card, context)
        if context.cardarea == G.play and context.before and not context.blueprint and not context.blueprint_card then
            local scoring = false
            for i,v in pairs(context.scoring_hand) do
                if v == card then
                    scoring = true
                    break
                end
            end
            if scoring then
                local step = 0
                for i, held_card in pairs(G.hand.cards) do
                    local stored_step = step
                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        delay = 0.4,
                        func = function()
                            
                            held_card:juice_up()
                            held_card:flip()
                            if not held_card.ability.extra then
                                held_card.ability.extra = {temp_flipped = true}
                            else
                                if held_card.ability.extra.temp_flipped then
                                    held_card.ability.extra.temp_flipped = false
                                else
                                    held_card.ability.extra.temp_flipped = true
                                end
                            end
                            play_sound('chips1', 0.8 + (stored_step * 0.02))
                            card:juice_up()
                            G.ROOM.jiggle = G.ROOM.jiggle + 0.7    
                            return true
                        end
                    }))
                    step = step + 5
                end
                SMODS.scale_card(card, {
                    ref_table = card.ability.extra,
                    ref_value = "xchips",
                    scalar_value = "custom_scaler",
                    scalar_table = {
                        custom_scaler = card.ability.extra.xchips_increase * #G.hand.cards,
                    },
                    -- scalar_value = "xchips_gain",
                    message_key = "a_xchips",
                            message_colour = G.C.CHIPS,
                        force_full_val = true,

                })
            end
        end
        if context.cardarea == G.play and context.main_scoring then
            return {
                xchips = card.ability.extra.xchips,
            }
        end
    end,
},true)

--All in (raise/spectrum) calculation fix: make it compatible with stuff like pairs and 3 of a kinds for situations like:
--goob
--devils deal.

SMODS.PokerHandPart:take_ownership("bld_allin",{
    func = function(hand)
        if G.GAME.selected_back.effect.center.config.extra then
            if not G.GAME.selected_back.effect.center.config.extra.blindside then return {} end
            local colorsuits = {}
            local threshold = #hand
            local colors = {'Red', 'Green', 'Blue', 'Yellow', 'Purple', 'Faded'}
            for _, v in ipairs(colors) do
                colorsuits[v] = true
            end

            local checker = false
            if next(find_joker('j_bld_checker', true)) then
                checker = true
            end

            -- < 5 hand cant be a spectrum
            if (#hand < 5 and not checker) or #hand < 3 then return {} end

            local nonwilds = {}
            for i = 1, #hand do
                local cardcolors = {}
                for _, v in ipairs(colors) do
                    -- determine table of suits for each card (for future faster calculations)
                    if hand[i]:is_color(v, nil, true) then
                        table.insert(cardcolors, v)
                    end
                end
                -- if somehow no suits: spectrum is impossible
                if #cardcolors == 0 then
                    return {}
                -- if only 1 suit: can be handled immediately
                elseif #cardcolors == 1 then
                    -- if suit is already present, lower the threshold. Ideally, duplicate colors when a spectrum can otherwise be made should not disrupt it, otherwise remove suit from "not yet used suits"
                    local thresholdtrigger = false
                    if colorsuits[cardcolors[1]] == false then 
                        threshold = threshold - 1
                        thresholdtrigger = true
                    end
                    --If the threshold is lower than 5 (min for spectrum), it cannot be one (checkers requires no pairs)
                    if (threshold < 5 and thresholdtrigger) then
                        return {} 
                    end
                    colorsuits[cardcolors[1]] = false
                -- add all cards with 2-4 suits to a table to be looked at
                elseif #cardcolors < 8 then
                    table.insert(nonwilds, cardcolors)
                end
            end

            -- recursive function for iterating over combinations
            local isSpectrum 
            isSpectrum = function(i, remaining)
                -- traversed all the cards, found spectrum
                if i == #nonwilds + 1 then
                    return true
                end

                -- copy remaining suits
                local newremaining = {}
                for k, v in pairs(remaining) do
                    newremaining[k] = v
                end

                -- for every suit of the current card: 
                for _, suit in ipairs(nonwilds[i]) do
                    -- do nothing if suit has already been used
                    if remaining[suit] == true then
                        -- use up suit on this card and check next card
                        newremaining[suit] = false
                        if isSpectrum(i + 1, newremaining) then
                            return true
                        end
                        -- reset suit before continuing
                        newremaining[suit] = true
                    end
                end
                return false
            end

            -- begin iteration from first (not already considered) card
            if isSpectrum(1, colorsuits) then
                return {hand}
            else
                return {}
            end
        else
            return {}
        end
    end
 })

 --exclude cursed tags
 SMODS.Joker:take_ownership("j_bld_matryoshka",{
    calculate = function(self, card, context)
            if context.setting_blind and card.ability.extra.last_tag then
                G.E_MANAGER:add_event(Event({
                    func = function ()
                        add_tag(Tag(card.ability.extra.last_tag))
                        card:juice_up(0.65, 0.65)
                        play_sound('generic1', 0.9 + math.random()*0.1, 0.8)
                        play_sound('holo1', 1.2 + math.random()*0.1, 0.4)
                        return true
                    end
                }))
                delay(0.4)
                G.E_MANAGER:add_event(Event({
                    func = function ()
                        add_tag(Tag(card.ability.extra.last_tag))
                        card:juice_up(0.65, 0.65)
                        play_sound('generic1', 0.9 + math.random()*0.1, 0.8)
                        play_sound('holo1', 1.2 + math.random()*0.1, 0.4)
                        return true
                    end
                }))
                return {

                }
            end
            if context.tag_triggered and not (context.tag_triggered.config and context.tag_triggered.config.extra and (context.tag_triggered.config.extra.hex or context.tag_triggered.config.extra.cannot_copy)) then
                print(inspect(context.tag_triggered))
                card.ability.extra.last_tag = context.tag_triggered.key
            end
        end,
        loc_vars = function (self, info_queue, card)
            info_queue[#info_queue+1] = card.ability.extra.last_tag and {key = card.ability.extra.last_tag, set = 'Tag'} or nil
            info_queue[#info_queue+1] = {key = 'tag_unik_blindside_cursed', set = 'Tag'}
            return {
                vars = {
                    card.ability.extra.last_tag and localize({key = card.ability.extra.last_tag, type = 'name_text', set = 'Tag'}) or localize("matryoshka_none")
                }
            }
        end
 },true)

--exquisite blinds:
--epic rarity equivalent
--stronger than premiums, weaker than legendaries
--examples include Pit Blinds and Hyperblinds