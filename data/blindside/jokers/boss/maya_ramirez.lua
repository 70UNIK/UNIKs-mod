--scored blinds permanently lose X0.05 Chips
BLINDSIDE.Joker({
    blindside_joker = true,
    key = 'unik_blindside_maya_ramirez',
    atlas = 'unik_blindside_jokers',
    pos = {x=0, y=32},
    boss_colour = HEX("FF00AB"),
    mult = 15,
    base_dollars = 8,
    order = 1,
    boss = {min = 2},
    active = true,
    loc_vars = function(self,blind)
        return { vars = { 0.05 .. "" } }
    end,
    collection_loc_vars = function(self)
        return { vars = { 0.05 .. ""} }
    end,
    death_card = {
        card = 'j_unik_jsab_maya', 
        mod_card = function(self, card) --used to apply editions and/or stickers
            
        end,
        quotes = {'unik_blindside_maya_lose'},
        say_times = 7,
    },
    calculate = function(self, blind, context)
        if context.before and not G.GAME.blind.disabled and context.scoring_hand then
			for k, v in ipairs(context.scoring_hand) do
				v.ability["perma_x_chips"] = v.ability["perma_x_chips"] or 0
				v.ability["perma_x_chips"] = v.ability["perma_x_chips"] - 0.05
				G.E_MANAGER:add_event(Event({
					func = function()
						v:juice_up()
						return true
					end,
				}))
				-- card_eval_status_text(v, "extra", nil, nil, nil, {
				-- 	message = localize('k_upgrade_ex'),
				-- 	colour = G.C.CHIPS,
				-- 	card=v,
				-- 	delay = 0.5,
				-- })
			end
            G.E_MANAGER:add_event(Event({
                func = function()
                    G.GAME.blind:wiggle()
                    BLINDSIDE.change_fire_amount({amount = 2})
                    BLINDSIDE.add_fire()
                    return true
                end,
            }))
		end
    end,
})