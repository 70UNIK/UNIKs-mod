--banish a random joker for every card played or discarded, if no jokers left, die
SMODS.Blind	{
    key = 'unik_epic_neck',
    config = {},
	showdown = true,
    boss = {min = 1, showdown = true, hardcore = true, epic = true,no_orb = true},
    boss_colour = HEX("622c17"),
    atlas = 'unik_legendary_blinds',
    pos = {x = 0, y = 28},
    vars = {},
    dollars = 13,
    mult = 2,
    unik_exponent = {1,0.9},
    pronouns = "he_him",
    debuff = {
        akyrs_blind_difficulty = "unik_epic",
        akyrs_cannot_be_overridden = true,
        akyrs_cannot_be_disabled = true,
        akyrs_cannot_be_rerolled = true,
        akyrs_cannot_be_skipped = true,
    },
    calculate = function(self, blind, context)
		if context.discard and not G.GAME.blind.disabled then
            if #G.jokers.cards < 1 then
                 G.GAME.unik_killed_by_the_neck = true
                 G.E_MANAGER:add_event(Event({
                    delay = 0.5,
                    func = function()
                        G.GAME.blind.triggered = true
                        G.GAME.blind:wiggle()
                        UNIK.instakill()
                        return true
                    end
                }))
                 
            else
                G.E_MANAGER:add_event(Event({
                    delay = 0.5,
                    func = function()
                        local neck_banish = pseudorandom_element(G.jokers.cards, pseudoseed("unik_neck_banish"))
                        if neck_banish == nil then
                            G.GAME.blind.triggered = true
                            G.GAME.blind:wiggle()
                            UNIK.instakill()
                        else
                             G.GAME.blind.triggered = true
                            G.GAME.blind:wiggle()
                            neck_banish:gore6_break()
                            if not G.GAME.banned_keys then
                            G.GAME.banned_keys = {}
                            end
                            if not G.GAME.cry_banished_keys then
                                G.GAME.cry_banished_keys = {}
                            end
                            G.GAME.cry_banished_keys[neck_banish.config.center.key] = true
                        end
                       
                        return true
                    end
                }))
                delay(0.5)
            end
			
            
		end
	end,
    unik_before_play = function(self)
        local kill_player = false

        for i,v in pairs(G.hand.highlighted) do
            local validCards = {}
            for i=1,#G.jokers.cards do
                --print("POSSESS")
                if not G.jokers.cards[i].ability.unik_broken_neck then
                    validCards[#validCards+1] = G.jokers.cards[i]
                end
            end
            if #validCards == 0 then
                kill_player = true
            else
                local neck_banish = pseudorandom_element(validCards, pseudoseed("unik_neck_banish"))
                neck_banish.ability.unik_broken_neck = true
            end
        end
        for i=1,#G.jokers.cards do
            if G.jokers.cards[i].ability.unik_broken_neck  then
                G.jokers.cards[i].ability.unik_broken_neck = nil
                G.E_MANAGER:add_event(Event({
                    delay = 0.5,
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
                delay(0.5)
            end
        end
        if kill_player then
            G.GAME.unik_killed_by_the_neck = true
        end

    end,
    unik_kill_hand = function(self, cards, hand, handname, check)
        if check then
            if (#G.hand.highlighted) > #G.jokers.cards then
                return true
            end
        elseif G.GAME.unik_killed_by_the_neck then
            return true
        end
        return false
	end,
    unik_after_defeat = function(self,chips,blind_size)
        --backup
        if G.GAME.unik_killed_by_the_neck then
            return true
        end
        return false
    end,
    in_pool = function(self)
        return  CanSpawnEpic()
	end,
}