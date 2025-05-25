SMODS.Sound({
	key = "positive",
	path = "positive.ogg",
})
SMODS.Shader({
    key = "positive",
    path = "positive.fs",
})

SMODS.Edition({
	key = "positive",
	order = 66666,
	weight = 0, -- should not appear normally in stores as its a detrimental one
	shader = "positive", --placeholder for now until I program one. It should have negative shine, but with a polychromesque shine from normal to overlay to a bit of negative, just to show its the opposite
	extra_cost = -4, --Its a detrimental edition, hence lower cost
    apply_to_float = true,
	sound = {
		sound = "unik_positive",
		per = 1.5,
		vol = 0.5,
	},
    -- loc_txt = {
	-- 	name = 'Positive',
    --     label = 'Positive',
	-- 	text = {
	-- 		"{C:red}#1#{} #2#"
	-- 	}
	-- },
    in_shop = false,
    badge_colour = G.C.UNIK_SHITTY_EDITION,
	config = { card_limit = -1},
    loc_vars = function(self, info_queue, card)
        local key = 'e_unik_positive'
        if card.ability and card.ability.consumeable and card.area ~= G.hand then
			key = 'e_unik_positive_consumable'
		elseif card.ability and (card.ability.set == "Default" or card.ability.set == "Enhanced" or (card.ability.consumeable and card.area and card.area == G.hand)) then
			key = 'e_unik_positive_playing_card'
		end
        return { key = key ,vars = { self.config.card_limit} }
    end,
    get_weight = function(self)
		return G.GAME.edition_rate * (G.GAME.unik_bad_editions_everywhere and 4)
	end,
})
SMODS.DrawStep {
    key = 'edition',
    order = 999,
    func = function(self, layer)
        if (self.edition and self.edition.unik_positive) then
            self.children.center:draw_shader('negative_shine', nil, self.ARGS.send_to_shader)
        end
        if self.ability.set == "unik_lartceps" and (self.config.center.discovered or self.bypass_discovery_center) then
            self.children.center:draw_shader('negative_shine', nil, self.ARGS.send_to_shader)
        end
    end,
    conditions = { vortex = false, facing = 'front' },
}