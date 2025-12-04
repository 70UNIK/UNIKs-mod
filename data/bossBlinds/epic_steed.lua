SMODS.Blind	{
    key = 'unik_epic_steed',
    config = {},
	showdown = true,
    boss = {min = 1, showdown = true, hardcore = true, epic = true,no_orb = true},
    boss_colour = HEX("545961"),
    atlas = 'unik_legendary_blinds',
    pos = {x = 0, y = 29},
    vars = {},
    dollars = 13,
    mult = 2,
    pronouns = "he_him",
    unik_exponent = {1,0.9},
    debuff = {
        akyrs_blind_difficulty = "unik_epic",
        akyrs_cannot_be_overridden = true,
        akyrs_cannot_be_disabled = true,
        akyrs_cannot_be_rerolled = true,
        akyrs_cannot_be_skipped = true,
    },
    unik_before_play = function(self)
        local kill_player = false

        for i,v in pairs(G.hand.highlighted) do
            v.steed_blacklist = true
        end

        for i,v in pairs(G.hand.cards) do
            if not v.steed_blacklist then
                local validCards = {}
                for i=1,#G.jokers.cards do
                    --print("POSSESS")
                    if not G.jokers.cards[i].ability.unik_marked_by_the_steed then
                        validCards[#validCards+1] = G.jokers.cards[i]
                    end
                end
                if #validCards == 0 then
                    kill_player = true
                else
                    local steed_banish = pseudorandom_element(validCards, pseudoseed("unik_steed_banish"))
                    steed_banish.ability.unik_marked_by_the_steed = true
                end
                
                
            end
        end
        for i=1,#G.jokers.cards do
            if G.jokers.cards[i].ability.unik_marked_by_the_steed then
                G.jokers.cards[i].ability.unik_marked_by_the_steed = nil
                G.E_MANAGER:add_event(Event({
                    delay = 0.5,
                    trigger = 'immediate',
                    func = function()
                        G.GAME.blind.triggered = true
                        G.GAME.blind:wiggle()
                        G.jokers.cards[i]:gore6_break()
                        if not G.GAME.banned_keys then
                        G.GAME.banned_keys = {}
                        end
                        if not G.GAME.cry_banished_keys then
                            G.GAME.cry_banished_keys = {}
                        end
                        G.GAME.cry_banished_keys[G.jokers.cards[i].config.center.key] = true
                        return true
                    end
                }))
            end
        end
        for i,v in pairs(G.hand.highlighted) do
            v.steed_blacklist = nil
        end
        if kill_player then
            G.GAME.unik_killed_by_the_steed = true
        end

    end,
    unik_kill_hand = function(self, cards, hand, handname, check)
        if check then
            if (#G.hand.cards - #G.hand.highlighted) > #G.jokers.cards then
                return true
            end
        elseif G.GAME.unik_killed_by_the_steed then
            return true
        end
        return false
	end,
    unik_after_defeat = function(self,chips,blind_size)
        --backup
        if G.GAME.unik_killed_by_the_steed then
            return true
        end
        return false
    end
}
