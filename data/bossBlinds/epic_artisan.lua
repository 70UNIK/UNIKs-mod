--epic artisan: Korruptoitunuttietokoneenluoja (Corrupt Computer Creator), cause company reference
--Rerolls increase requirements by ^1.1. If tension < 23 on blind selection, die
--Baseline Cryptid/no punish reroll abuse version: Rerolls increase reqs by ^1.05, If less than 10 rerolls done in this ante, die on blind select. 
local function KillPlayerOnSelect()
    G.E_MANAGER:add_event(  -- From buffoonery, supposed to oneshot you
    Event({
        trigger = "after",
        delay = 0.2,
        func = function()
            if G.STATE ~= G.STATES.SELECTING_HAND then
                return false
            end
            G.STATE = G.STATES.HAND_PLAYED
            G.STATE_COMPLETE = true
            end_round()
            return true
        end,
    }),
    "other"
)
end
SMODS.Blind	{
    key = 'unik_epic_artisan',
    config = {},
	showdown = true,
    boss = {min = 1, showdown = true, hardcore = true, epic = true,no_orb = true},
    boss_colour = HEX("0f2140"),
    atlas = 'unik_legendary_blinds',
    pos = {x = 0, y = 6},
    vars = {},
    dollars = 13,
    jen_dollars = 25, --dollar change with almanac
    mult = 2,
    jen_blind_resize = 1e9,
    death_message = "special_lose_unik_artisan_builds_epic",
	ignore_showdown_check = true,
	in_pool = function(self)
        if G.GAME.modifiers.unik_legendary_at_any_time then
            return true
        end
        if (SMODS.Mods["jen"] or {}).can_load then
            return G.GAME.round > Jen.config.ante_threshold * 2
        else

            local hasExotic = false
            if not G.jokers or not G.jokers.cards then
                return false
            end
            
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i].config.center.rarity == "cry_exotic" then
                    hasExotic = true
                end
            end
            return (G.GAME.round > 50 and hasExotic and Cryptid.gameset() ~= "modest") --only appear after round 50 in mainline cryptid, and you have an exotic at hand
        end
	end,
    loc_vars = function(self, info_queue, card)
        local exponent = 1.05
        local line2 = ""
        local line3 = ""
        local maxRerolls = G.GAME.global_rerolls_pause_val
        if not G.GAME.global_rerolls_pause_val or maxRerolls < 12 then
            maxRerolls = 12
        end
        if (SMODS.Mods["jen"] or {}).can_load then
            exponent = 1.1
            if Jen.config.punish_reroll_abuse then
                line2 = localize('k_unik_artisan_builds_epic_line2')
            else
                line2 = localize('k_unik_artisan_builds_epic_line2alt') .. (math.ceil(maxRerolls^1.1)) ..localize('k_unik_artisan_builds_epic_line2alt2')
            end
        else
            line2 = localize('k_unik_artisan_builds_epic_line2alt') .. (math.ceil(maxRerolls^1.1)) ..localize('k_unik_artisan_builds_epic_line2alt2')
            exponent = 1.05
        end
        line3 = 'k_unik_artisan_builds_epic_line3'

        --very complex variations for 1 blind, as it has to adapt to if reroll abuse is enabled or not.
		return { vars = { exponent.. "",line2,localize(line3) } }
	end,
    collection_loc_vars = function(self)
        local exponent = 1.05
        local line2 = ""
        local line3 = ""
        if (SMODS.Mods["jen"] or {}).can_load then
            exponent = 1.1
            if Jen.config.punish_reroll_abuse then
                line2 = 'k_unik_artisan_builds_epic_line2'
            else
                line2 = 'k_unik_artisan_builds_epic_placeholder'
            end
        else
            line2 = 'k_unik_artisan_builds_epic_placeholder'
            exponent = 1.05
        end
        line3 = 'k_unik_artisan_builds_epic_line3'

        --very complex variations for 1 blind, as it has to adapt to if reroll abuse is enabled or not.
		return { vars = { exponent.. "",localize(line2),localize(line3) } }
	end,
    set_blind = function(self, reset, silent)
        if not reset then
            local maxRerolls = G.GAME.global_rerolls_pause_val
            if maxRerolls < 12 then
                maxRerolls = 12
            end
            G.GAME.unik_original_chips_artisan = G.GAME.blind.chips
            if G.GAME.ante_rerolls and G.GAME.ante_rerolls > 0 then
                for i = 1,G.GAME.ante_rerolls do
                    --almanac version: ^1.1
                    if (SMODS.Mods["jen"] or {}).can_load then
                        G.GAME.blind.chips = G.GAME.blind.chips + (G.GAME.unik_original_chips_artisan^1.1)
                    else --cryptid version: ^1.05
                        G.GAME.blind.chips = G.GAME.blind.chips + (G.GAME.unik_original_chips_artisan^1.05)
                    end
                    
                    G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
                    G.HUD_blind:recalculate(true)

                end
                G.GAME.blind:wiggle()
                G.GAME.blind.triggered = true

            end
            --Alamanc version: KILL player if tension is < 23 (aka you're forced to reroll to the point of triggering straddle)
            if (SMODS.Mods["jen"] or {}).can_load then
                if Jen.config.punish_reroll_abuse then
                    if G.GAME.tension < 23 then
                        --kill player
                        local text = localize('k_unik_artisan_builds_epic_lose')
                        attention_text({
                            scale = 0.9, text = text, hold = 2, align = 'cm', offset = {x = 0,y = -2.7},major = G.play,colour = G.C.UNIK_EYE_SEARING_RED
                        })
                        G.GAME.blind:wiggle()
                        G.GAME.blind.triggered = true
                        KillPlayerOnSelect()
                    else
                        local text = localize('k_unik_artisan_builds_epic')
                        attention_text({
                            scale = 0.9, text = text, hold = 2, align = 'cm', offset = {x = 0,y = -2.7},major = G.play,colour = HEX("0f2140")
                        })
                    end
                else
                    if G.GAME.ante_rerolls and G.GAME.ante_rerolls < maxRerolls^1.1 then --crank it up to 30
                        --kill player
                        local text = localize('k_unik_artisan_builds_epic_lose')
                        attention_text({
                            scale = 0.9, text = text, hold = 2, align = 'cm', offset = {x = 0,y = -2.7},major = G.play,colour = G.C.UNIK_EYE_SEARING_RED
                        })
                        G.GAME.blind:wiggle()
                        G.GAME.blind.triggered = true
                        KillPlayerOnSelect()
                    else
                        local text = localize('k_unik_artisan_builds_epic')
                        attention_text({
                            scale = 0.9, text = text, hold = 2, align = 'cm', offset = {x = 0,y = -2.7},major = G.play,colour = HEX("0f2140")
                        })
                    end
                end
            else --cryptid version: kill player if less than 12 rerolls
                if G.GAME.ante_rerolls and G.GAME.ante_rerolls < math.ceil(maxRerolls^1.1) then
                    --kill player
                    local text = localize('k_unik_artisan_builds_epic_lose')
                    attention_text({
                        scale = 0.9, text = text, hold = 2, align = 'cm', offset = {x = 0,y = -2.7},major = G.play,colour = G.C.UNIK_EYE_SEARING_RED
                    })
                    G.GAME.blind:wiggle()
                    G.GAME.blind.triggered = true
                    KillPlayerOnSelect()
                else
                    local text = localize('k_unik_artisan_builds_epic')
                    attention_text({
                        scale = 0.9, text = text, hold = 2, align = 'cm', offset = {x = 0,y = -2.7},major = G.play,colour = HEX("0f2140")
                    })
                end
            end
            
        end
    end,
    disable = function()
        G.GAME.blind.chips = G.GAME.unik_original_chips_artisan
        G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
        G.HUD_blind:recalculate(true)
    end,
    defeat = function()
        G.GAME.ante_rerolls = 0
    end
}

