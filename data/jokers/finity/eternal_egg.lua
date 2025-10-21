--Increase Emult by ^1 if scoring above the best hand in this run.
SMODS.Atlas {
		key = "unik_eternal_egg",
		path = "unik_eternal_egg.png",
		px = 71,
		py = 95,
	}
	
local egg_quotes = {

	with_egg = {
		'k_unik_eternal_egg_normal1',
		'k_unik_eternal_egg_normal2',
		'k_unik_eternal_egg_normal3',
		'k_unik_eternal_egg_normal8',
        'k_unik_eternal_egg_normal7',
	},
	eggless = {
		'k_unik_eternal_egg_normal1',
		'k_unik_eternal_egg_normal2',
		'k_unik_eternal_egg_normal4',
		'k_unik_eternal_egg_normal5',
        'k_unik_eternal_egg_normal6',
	},

}

if FinisherBossBlinddecksprites then
    FinisherBossBlinddecksprites["bl_unik_fuck_eternal_egg"] = {"unik_eternal_egg",{ x = 2, y = 0 }}
end

if FinisherBossBlindQuips then
    FinisherBossBlindQuips["bl_unik_fuck_eternal_egg"] = {"eternal_egg",4} 
end


SMODS.Joker {
    key = "unik_eternal_egg",
    atlas = 'unik_eternal_egg',
    config = {
      extra = {Emult = 0.5},
      immutable = {base_emult = 1.0}
    },
    no_pointer = true,
    no_code = true,
    loc_vars = function(self, info_queue, center)
        local BlindSize = 0
        local quoteset = 'eggless'
        info_queue[#info_queue + 1] = G.P_CENTERS.p_unik_egg_pack
        if not center.ability.eternal then
            info_queue[#info_queue + 1] = { set = "Other", key = "eternal" }
        end
        if (G.jokers and G.jokers.cards) then
            for i,v in pairs(G.jokers.cards) do
                if v.ability.eternal and v.config.center.key == 'j_egg' then
                    quoteset = 'with_egg'
                end
            end
        end
        return {
            vars = { center.ability.extra.Emult + center.ability.immutable.base_emult,localize(egg_quotes[quoteset][math.random(#egg_quotes[quoteset])] .. "")}
        }
    end,
    eternal_compat = true,
    perishable_compat = false,
    demicolon_compat = true,
    blueprint_compat = true,
    unlocked = true,
    discovered = true, --workaround:
    rarity = "finity_showdown",
    pos = { x = 0, y = 0 },
    soul_pos = { x = 1, y = 0 },
    cost = 10, 

    calculate = function(self, card, context)
        if context.forcetrigger then
            return {
				e_mult = card.ability.extra.Emult + card.ability.immutable.base_emult,
                colour = G.C.DARK_EDITION,
			}
        end
        if (context.other_joker and card ~= context.other_joker) then
            if context.other_joker.config.center.key == 'j_egg' and context.other_joker.ability.eternal then --Common
				return {
                    e_mult = card.ability.extra.Emult + card.ability.immutable.base_emult,
                    colour = G.C.DARK_EDITION,
				}
            end
        end

    end,

    set_badges = function (self, card, badges)
        SMODS.create_mod_badges({ mod = SMODS.find_mod("finity")[1] }, badges)
    end,
}
