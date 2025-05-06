--EPIC DECISION:
--Upon entering the blind:
--Open a Lartceps Bundle pack (choose 5 from 10):
--Cannot be skipped at all.
--- Hellspawn: Add 20 Cursed Jokers. Temporarily create a Showman in the process. (Default)
--- Placard: All cards are permenantly debuffed then destroy all undebuffed cards
--- Wipe (styled as a code card): Destroy all but 1 card in the deck
--- Garbage: Add random cards equal to 2x your deck size
--- Sinners: The next 4 Boss Blinds will become Epic+ Blinds. 
--- Trim (styled as a code card): Set Joker slots to 0 (Almanac)/Remove empty joker slots then halve joker slots (Cryptid)
--- Reeducation: All your Jokers, Cards and Consumeables become Positive.
--- Expulsion: Randomly banish 66% of owned Jokers, eternals included
--- Extortion: Set money to -$666.
--- Escalation: Ante^1.5, tension^1.5, straddle^1.5, rounded up.
--- Summit: Increases next blind/current blind size by ^^2.
--- The Single (Styled as a tarot): Set hand size to 1.
--- Bretheren Moon (Styled as a planet): Remove all bonuses and set all hand levels to 0. 
--- Powerdown: Destroy 50% of jokers, cards, consumeables and halve all levels (rounded down). Art is MX ripping GF in 2
--- Mouth of Sauron: Add "matla" unhancement to 50% of cards in deck (create a lartceps on trigger, then self destructs)
--- Expiry: Unredeem all vouchers
--- Blank Larceps (almanac exclusive): copies and automatically triggers the last lartceps used
-- Likewise, Lartceps are always eternal and rental and always have the positive edition (reservia counter). They will also have a "triggering" sticker (1 in 2 chance to be used at the start of blind)
SMODS.Blind	{
    key = 'unik_epic_decision',
    config = {},
	showdown = true,
    boss = {min = 1, showdown = true, hardcore = true, epic = true,no_orb = true},
    boss_colour = G.C.UNIK_LARTCEPS,
    atlas = 'unik_legendary_blinds',
    pos = {x = 0, y = 16},
    vars = {},
    dollars = 13,
    jen_dollars = 25, --dollar change with almanac
    mult = 2,
    jen_blind_resize = 1e9,
	ignore_showdown_check = true,
	in_pool = function(self)
        --maybe its funnier to have it spawn even without stone hands in deck in almanac
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
    unik_booster_before_blind = function(self)
    end,
    set_blind = function(self, reset, silent)
        if not reset then
            G.GAME.blind:wiggle()
            G.GAME.blind.triggered = true
            G.GAME.unik_mortons_fork = true --flag will prevent other booster tags from triggering
            G.GAME.unik_halt_round = true
            G.GAME.cry_fastened = true
            if G.jokers.cards then
				G.GAME.blind:wiggle()
				G.GAME.blind.triggered = true
				for i,v in pairs(G.jokers.cards) do
					v:juice_up(0,0.25)
				end
			end
            --PLACEHOLDER: Will open a random booster pack for now
            --Booster will contain:
            --4 cursed Jokers
            --1 "tarot" to banish the rightmost joker
            G.GAME.blind:alert_debuff(true)
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                func = function()
                    local key = "p_unik_lartceps_bundle"
                    local card = Card(
                        G.play.T.x + G.play.T.w / 2 - G.CARD_W * 1.27 / 2,
                        G.play.T.y + G.play.T.h / 2 - G.CARD_H * 1.27 / 2,
                        G.CARD_W * 1.27,
                        G.CARD_H * 1.27,
                        G.P_CARDS.empty,
                        G.P_CENTERS[key],
                        { bypass_discovery_center = true, bypass_discovery_ui = true }
                    )
                    card.cost = 0
                    card.from_tag = true
                    G.FUNCS.use_card({ config = { ref_table = card } })
                    card:start_materialize()
                    pack_opened = true
                    return true
                end,
            }))
        end
    end
}

G.FUNCS.can_skip_booster = function(e)
	if G.pack_cards and (not (G.GAME.STOP_USE and G.GAME.STOP_USE > 0)) and
	(G.STATE == G.STATES.SMODS_BOOSTER_OPENED or G.STATE == G.STATES.PLANET_PACK or G.STATE == G.STATES.STANDARD_PACK or G.STATE == G.STATES.BUFFOON_PACK or (G.hand  )) then 
		--if a booster is unskippable (when its unskippable conditionsa re fulfilled), unhighlight it
		local obj = SMODS.OPENED_BOOSTER.config.center
		if obj.unskippable and type(obj.unskippable) == "function" then
			if obj:unskippable() == true then
				e.config.colour = G.C.UI.BACKGROUND_INACTIVE
				e.config.button = nil
			else
				e.config.colour = G.C.GREY
				e.config.button = 'skip_booster'
			end
		else
			e.config.colour = G.C.GREY
			e.config.button = 'skip_booster'
		end
	else
	e.config.colour = G.C.UI.BACKGROUND_INACTIVE
	e.config.button = nil
	end
end