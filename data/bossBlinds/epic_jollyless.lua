SMODS.Blind{
    key = 'unik_epic_jollyless',
    config = {},
	showdown = true,
    boss = {min = 1, showdown = true, hardcore = true, epic = true,no_orb = true},
    boss_colour = HEX("0d2232"),
    atlas = 'unik_legendary_blinds',
    pos = {x = 0, y = 21},
    vars = {},
    dollars = 13,
    mult = 2,
    in_pool = function(self)
        return  CanSpawnEpic()
	end,
    debuff = {
        akyrs_blind_difficulty = "epic",
        akyrs_cannot_be_overridden = true,
        akyrs_cannot_be_disabled = true,
        akyrs_cannot_be_rerolled = true,
        akyrs_unskippable_blind = true,
    },
    set_blind = function(self, reset, silent)
        G.GAME.unik_pentagram_manager_fix = true
        if not reset then
            if G.jokers and G.jokers.cards then
                for i,v in pairs(G.jokers.cards) do
                    if (v.config.center.pools and v.config.center.pools.M) or v.config.center.key == "j_cry_mprime" or v:is_jolly() then
                        G.E_MANAGER:add_event(Event({
                            func = function()
                                v:start_dissolve()
                                G.GAME.blind:wiggle()
                                return true
                            end
                        }))
                        delay(0.1)
                    end
                end  
            end
            if G.playing_cards then
                for k, v in ipairs(G.playing_cards) do
                    local destroy = true
                    if SMODS.has_no_suit(v) or SMODS.has_no_rank(v) then
                        G.E_MANAGER:add_event(Event({
                            func = function()
                                v:start_dissolve()
                                G.GAME.blind:wiggle()
                                return true
                            end
                        }))
                        delay(0.1)
                        SMODS.calculate_context({ remove_playing_cards = true, removed = v })
                    else
                        for l,w in ipairs(G.playing_cards) do
                            --abstract
                            if SMODS.has_enhancement(v,"m_cry_abstract") and SMODS.has_enhancement(w,"m_cry_abstract") and v ~= w then
                                destroy = false
                            elseif SMODS.has_enhancement(v,"m_unik_pink") and SMODS.has_enhancement(w,"m_unik_pink") and v ~= w then
                                destroy = false
                            elseif v:get_id() == w:get_id() and v.base.suit == w.base.suit and v ~= w then
                                destroy = false
                            elseif SMODS.has_no_suit(w) and SMODS.has_no_rank(w) and SMODS.has_no_suit(v) and SMODS.has_no_rank(v) and v.config.center.key == w.config.center.key and v ~= w then
                                destroy = false
                            end
                        end
                        if destroy then
                            G.E_MANAGER:add_event(Event({
                                func = function()
                                    v:start_dissolve()
                                    G.GAME.blind:wiggle()
                                    return true
                                end
                            }))
                            delay(0.1)
                            SMODS.calculate_context({ remove_playing_cards = true, removed = v })
                        end
                    end
                end
                
            end
            G.GAME.unik_pentagram_manager_fix = nil
        end
    end,
}