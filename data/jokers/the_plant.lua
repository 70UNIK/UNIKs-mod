SMODS.Atlas {
	key = "unik_the_plant",
	path = "unik_the_plant.png",
	px = 71,
	py = 95
}
SMODS.Joker {
    dependencies = {
		items = {
			"set_cry_cursed",
		},
	},
	key = 'unik_the_plant',
    no_dbl = true,
    atlas = 'unik_the_plant',
    rarity = "cry_cursed",
	pos = { x = 0, y = 0 },
	-- soul_pos sets the soul sprite, used for legendary jokers and basically all of Jen's Jokers
	soul_pos = { x = 2, y = 0,extra = { x = 1, y = 0 } },
    cost = 1,
    experimental = true, --requires a complex function for iterating per card so this is appropriate
    config = { extra = {minFaceCards = 7, faceCards = 12, selfDestruct = false,debuff_name = "unik_plant",entered = false} },
    pools = { ["unik_boss_blind_joker"] = true, ["unik_copyrighted"] = true },
	blueprint_compat = false,
    perishable_compat = false,
    loc_vars = function(self, info_queue, center)
        info_queue[#info_queue + 1] = G.P_CENTERS.bl_plant
        --Nerf to requiring half of face cards destroyed (rounded to whole num), so its more in line with Blacklist's requirements
        return { vars = { center.ability.extra.minFaceCards,center.ability.extra.faceCards} }
	end,
    set_badges = function(self, card, badges)
        badges[#badges+1] = create_badge(localize('k_unik_blind_start_plant'), G.C.UNIK_THE_PLANT, G.C.WHITE, 1.0 )
    end,
    immutable = true,
    add_to_deck = function(self, card, from_debuff)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            func = function()
                card.ability.extra.faceCards = G.GAME.unik_face_cards
                if Card.get_gameset(card) ~= "modest" then
                    card.ability.extra.minFaceCards = math.ceil(G.GAME.unik_face_cards/2)
                else
                    card.ability.extra.minFaceCards = math.ceil(G.GAME.unik_face_cards*4/5)
        
                end
                card.ability.extra.entered = true
                return true
            end
        }))
    end,
    in_pool = function(self)
        local cards = 0
        if G.playing_cards then
            for k, v in pairs(G.playing_cards) do
                if v:is_face(true) then
                    cards =  cards + 1 
                end
            end
        end
		return cards > 1
	end,
    update = function(self,card,dt)
        if card.added_to_deck and card.ability.extra.entered == true then
            card.ability.extra.faceCards = G.GAME.unik_face_cards
            if card.ability.extra.selfDestruct == false and (card.ability.extra.faceCards <= 0 or card.ability.extra.faceCards < card.ability.extra.minFaceCards) then
                selfDestruction(card,"k_unik_plant_no_face",HEX("709284"))
                card.ability.extra.selfDestruct = true
            end
        end
    end,
    calculate = function(self, card, context)

        if context.setting_blind and (G.GAME.blind and (G.GAME.blind.config.blind.name == "The Plant")) and not (G.GAME.blind.disabled) then
            selfDestruction(card,"k_unik_blind_start_plant",HEX("709284"))
            card.ability.extra.selfDestruct = true
        end
    end
}


