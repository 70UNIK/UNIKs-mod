--Must defeat the next 15 blinds back-to-back (deck and discards refreshed)
--How it works: Check current blind. If defeated, load next blind, change status dynamically
--Cannot use ://RUN: will yield a NOPE!
SMODS.Blind{
    --Hahahahahah no jolly for you
    key = 'unik_epic_miser',
    config = {},
	showdown = true,
    boss = {min = 1, showdown = true, hardcore = true, epic = true,no_orb = true},
    boss_colour = HEX("772166"),
    atlas = 'unik_legendary_blinds',
    pos = {x = 0, y = 22},
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
    loc_vars = function(self)
        G.GAME.unik_miser_blind_interval =  G.GAME.unik_miser_blind_interval or 0
        G.GAME.unik_miser_blinds = G.GAME.unik_miser_blinds or 15
		return { vars = { math.ceil(G.GAME.unik_miser_blinds * (1+G.GAME.unik_miser_blind_interval*0.1)) } } -- no bignum?
	end,
	collection_loc_vars = function(self)
		return { vars = { localize('k_unik_miser_placeholder') }}
	end,
	set_blind = function(self)
        G.GAME.unik_miser_blind_interval =  G.GAME.unik_miser_blind_interval or 0
        G.GAME.unik_miser_blinds = G.GAME.unik_miser_blinds or 15
        G.GAME.unik_miser_blinds = math.ceil(G.GAME.unik_miser_blinds * (1+G.GAME.unik_miser_blind_interval*0.1))
        G.GAME.unik_miser_blinds_actual = G.GAME.unik_miser_blinds
        
	end,
    defeat = function(self, blind_on_deck)
        G.GAME.unik_miser_blind_interval =  G.GAME.unik_miser_blind_interval + 0.1
    end,
}

local evalOverride = Game.update_round_eval
function Game:update_round_eval(dt)
    if G.GAME.unik_miser_blinds_actual and G.GAME.unik_miser_blinds_actual  > 0 then
        
        G.GAME.unik_miser_blinds_actual  = G.GAME.unik_miser_blinds_actual  - 1
        local text = localize('k_unik_back_to_back1') ..  G.GAME.unik_miser_blinds_actual .. localize('k_unik_back_to_back2')
        attention_text({
            scale = 0.75, text = text, hold = 2, align = 'cm', offset = {x = 0,y = -2.7},major = G.play
        })
        reset_blinds()
        local obj = G.P_BLINDS[G.GAME.round_resets.blind_choices.Boss]
        local obj2 = G.P_BLINDS[G.GAME.round_resets.blind_choices.Big]
        local obj3 = G.P_BLINDS[G.GAME.round_resets.blind_choices.Small]
        -- print("-----------------")
        -- print(obj.key)
        -- print(obj2.key)
        -- print(obj3.key)
        -- print("-----------------")
        -- print(G.GAME.blind_on_deck)
        -- print(G.GAME.round_resets.blind)
        -- print(G.GAME.round_resets.blind_states[G.GAME.blind_on_deck])
        -- print(G.GAME.round_resets.blind)
        
        G.GAME.facing_blind = true
         G.GAME.chips = 0
         G.GAME.round_resets.lost = true
         G.GAME.blind_on_deck = 
        not (G.GAME.round_resets.blind_states.Small == 'Defeated' or G.GAME.round_resets.blind_states.Small == 'Skipped' or G.GAME.round_resets.blind_states.Small == 'Hide') and 'Small' or
        not (G.GAME.round_resets.blind_states.Big == 'Defeated' or G.GAME.round_resets.blind_states.Big == 'Skipped'or G.GAME.round_resets.blind_states.Big == 'Hide') and 'Big' or 
        'Boss'
         ChangePhaseCrown()
        G.GAME.blind:defeat()
        -- G.FUNCS.select_blind(e)
        G.E_MANAGER:add_event(Event({
            trigger = 'immediate',
            func = function()
                ease_round(1)
                inc_career_stat('c_rounds', 1)
                if _DEMO then
                    G.SETTINGS.DEMO_ROUNDS = (G.SETTINGS.DEMO_ROUNDS or 0) + 1
                    inc_steam_stat('demo_rounds')
                    G:save_settings()
                end
                G.GAME.round_resets.blind = G.P_BLINDS[G.GAME.round_resets.blind_choices[G.GAME.blind_on_deck]]
                G.GAME.round_resets.blind_states[G.GAME.blind_on_deck] = 'Current'
                return true
            end})) 
        G.E_MANAGER:add_event(Event({
        trigger = 'immediate',
        func = function()
            new_round()
            return true
        end
        }))
    else
        evalOverride(self,dt)
    end
    
end