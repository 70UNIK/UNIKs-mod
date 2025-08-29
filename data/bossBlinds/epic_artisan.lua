--epic artisan: Korruptoitunuttietokoneenluoja (Corrupt Computer Creator), cause company reference
--Rerolls increase requirements by ^1.1. If tension < 23 on blind selection, die
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
    mult = 2,
    death_message = "special_lose_unik_artisan_builds_epic",
	ignore_showdown_check = true,
	in_pool = function(self)
        return  CanSpawnEpic()
	end,
    debuff = {
        akyrs_blind_difficulty = "epic",
        akyrs_cannot_be_overridden = true,
        akyrs_cannot_be_disabled = true,
        akyrs_cannot_be_rerolled = true,
        akyrs_cannot_be_skipped = true,
    },
    loc_vars = function(self, info_queue, card)
        local exponent = 1.05
        local maxRerolls = G.GAME.global_rerolls_pause_val
        local current = G.GAME.ante_rerolls
        if not G.GAME.ante_rerolls then
            current = 0
        end
        if not G.GAME.global_rerolls_pause_val or maxRerolls^0.8 < 12 then
            maxRerolls = 12
        end
        --very complex variations for 1 blind, as it has to adapt to if reroll abuse is enabled or not.
		return { vars = { exponent.. "",(math.ceil(maxRerolls^0.8)).."",current } }
	end,
    collection_loc_vars = function(self)
        local exponent = 1.05

        --very complex variations for 1 blind, as it has to adapt to if reroll abuse is enabled or not.
		return { vars = { exponent.. "",localize("k_unik_artisan_builds_epic_placeholder"), 0 .. ""} }
	end,
    set_blind = function(self, reset, silent)
        if not reset then
            local maxRerolls = G.GAME.global_rerolls_pause_val
            if not G.GAME.global_rerolls_pause_val or maxRerolls^0.8 < 12 then
                maxRerolls = 12
            end
            G.GAME.unik_original_chips_artisan = G.GAME.blind.chips
            if G.GAME.ante_rerolls and G.GAME.ante_rerolls > 0 then
                for i = 1,G.GAME.ante_rerolls do
                    G.GAME.blind.chips = G.GAME.blind.chips + (G.GAME.unik_original_chips_artisan^1.05)       
                    G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
                    G.HUD_blind:recalculate(true)

                end
                G.GAME.blind:wiggle()
                G.GAME.blind.triggered = true

            end
            if G.GAME.ante_rerolls and G.GAME.ante_rerolls < math.ceil(maxRerolls^0.8) then
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

