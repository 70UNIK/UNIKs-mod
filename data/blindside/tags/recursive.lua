SMODS.Tag {
    key = "unik_blindside_recursive",
    hide_ability = false,
    atlas = 'unik_tags',
    pos = {x = 4, y = 0},
    in_pool = function(self, args)
        return false
    end,
    pools = {["bld_obj_blindside"] = true},
    config = {chancefail = 1, chance = 2},
    loc_vars = function(self, info_queue,tag)
        info_queue[#info_queue + 1] = { set = "Other", key = "unik_rescore" }
        local chance, trigger = SMODS.get_probability_vars(tag, self.config.chancefail, self.config.chance, 'recursive_unik')
		return { vars = { chance,trigger } }
	end,
    apply = function(self, tag, context)
        if context.type == 'shop_start' and not (next(SMODS.find_card("j_bld_taglock")) and not (G.GAME.blind.boss or G.GAME.last_joker)) then
            tag:yep('+', G.C.SUITS["unik_Noughts"], function() 
                return true end)
            tag.triggered = true
        end
        if context.type == 'unik_rescoring_cards' and context.scoring_hand then
            local cards = {}
            for i,v in pairs(context.scoring_hand) do
                if not SMODS.pseudorandom_probability(tag, 'recursive_unik', self.config.chancefail, self.config.chance, 'unik_aquamarine_resc') and v.facing ~= 'back' then
                    cards[#cards+1] = v
                end
            end
            if #cards >= 0 then
                cards.unik_scoring_segment = true
                local total = {cards}
                return {
                    target_cards = total,
                    card = tag,
                    from_tag = true,
                    message = '+1',
                    colour = G.C.SUITS["unik_Noughts"],
                }
            end
            
        end
    end,
}