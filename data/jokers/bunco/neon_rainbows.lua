--scored flourescent cards become polychrome and shielded.
SMODS.Joker {
    key = "unik_bunc_neon_rainbows",
    atlas = 'placeholders',
    rarity = 2,
    cost = 7,
    pos = { x = 1, y = 0 },
    blueprint_compat = false,
    perishable_compat = true,
	eternal_compat = true,
    demicoloncompat = true,
    immutable = true,
    discovered = true,
    unlocked = true,
    pronouns = "it_its",
    loc_vars = function(self, info_queue, center)
        if not center.edition or (center.edition and not center.edition.bunc_fluorescent )then
            info_queue[#info_queue + 1] = G.P_CENTERS.e_bunc_fluorescent
        end
        if not center.ability.unik_shielded then
            info_queue[#info_queue + 1] = { set = "Other", key = "unik_shielded" }
        end
        if not center.edition or (center.edition and not center.edition.polychrome )then
            info_queue[#info_queue + 1] = G.P_CENTERS.e_polychrome
        end
	end,
    set_badges = function (self, card, badges)
      SMODS.create_mod_badges({ mod = SMODS.find_mod("Bunco")[1] }, badges)
    end,
    calculate = function(self, card, context)
        if (context.forcetrigger or (context.before)) and not context.blueprint and not context.repetition and not context.retrigger_joker then
            if context.scoring_hand then
                for i,v in pairs(context.scoring_hand) do
                    if v.edition and v.edition.bunc_fluorescent then
                        v:set_edition({polychrome = true}, true,nil, true)
                        v.ability.unik_shielded = true
                    end
                end
                return{
                }        
            end
        end
    end,
    in_pool = function(self)
        for i,v in pairs(G.playing_cards) do 
            if v.edition and v.edition.bunc_fluorescent then
                return true
            end
        end
		return false
	end,
}