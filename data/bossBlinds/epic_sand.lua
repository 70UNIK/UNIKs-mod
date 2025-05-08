--Cryptid: ^2 Blind size per tag held
--Almanac: Increase blind size by {Tags Held}1.1
SMODS.Blind	{
    key = 'unik_epic_sand',
    config = {},
	showdown = true,
    boss = {min = 1, showdown = true, hardcore = true, epic = true,no_orb = true},
    boss_colour = HEX("544318"),
    atlas = 'unik_legendary_blinds',
    pos = {x = 0, y = 15},
    vars = {},
    dollars = 13,
    jen_dollars = 25, --dollar change with almanac
    mult = 2,
    jen_blind_resize = 1e9,
	ignore_showdown_check = true,
    loc_vars = function(self)
        local tags = 0
        if #G.HUD_tags ~= 0 then
            tags = #G.HUD_tags
        end
        local part1 = "k_unik_epic_sand_cry_1"
        local part2 = "k_unik_epic_sand_cry_2"
        local part3 = ""
        local endling = ""
        local end2 = ""
        if (SMODS.Mods["jen"] or {}).can_load then
            part1 = "k_unik_epic_sand_almanac_1"
            part2 = "k_unik_epic_sand_almanac_2"
            part3 = "{"
            endling = "}"
            end2 = "1.1"
        else
            endling = " "
            end2 = localize('k_unik_tag')
        end
        return {vars = { localize(part1),localize(part2),part3,tostring(tags),endling..end2} }
	end,
	collection_loc_vars = function(self)
        local part1 = "k_unik_epic_sand_cry_1"
        local part2 = "k_unik_epic_sand_cry_2"
        local part3 = ""
        local endling = ""
        local end2 = ""
        if (SMODS.Mods["jen"] or {}).can_load then
            part1 = "k_unik_epic_sand_almanac_1"
            part2 = "k_unik_epic_sand_almanac_2"
            part3 = "{"
            endling = "}"
            end2 = "1.1"
        else
            endling = " "
            end2 = localize('k_unik_tag')
        end
        return {vars = { localize(part1),localize(part2),part3,localize('k_unik_epic_sand_placeholder'),endling..end2} }
		
	end,
	in_pool = function(self)
        --maybe its funnier to have it spawn even without stone hands in deck in almanac
        if (G.GAME.round_resets.ante < self.boss.min) or (G.HUD_tags and #G.HUD_tags < 2) then
            return false
        end
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
    set_blind = function(self, reset, silent)
        if not reset then
            G.GAME.blind.original_chips = G.GAME.blind.chips
        end
        if not reset and not G.GAME.blind.disabled and #G.HUD_tags ~= 0 then
            if (SMODS.Mods["jen"] or {}).can_load then
                G.GAME.blind.chips = to_big(G.GAME.blind.chips):arrow(to_big(#G.HUD_tags), to_big(1.1))
                G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
                G.HUD_blind:recalculate(true)
                G.GAME.blind:wiggle()
                G.GAME.blind.triggered = true
                G.hand_text_area.blind_chips:juice_up()
            else
                for i = 1,#G.HUD_tags do
                    G.GAME.blind.chips = G.GAME.blind.chips^2
                    G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
                    G.HUD_blind:recalculate(true)
                    G.GAME.blind:wiggle()
                    G.GAME.blind.triggered = true
                    G.hand_text_area.blind_chips:juice_up()
                end
            end
        end
    end,
}