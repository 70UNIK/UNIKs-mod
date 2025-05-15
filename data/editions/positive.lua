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
    loc_vars = function(self)
        return { vars = { self.config.card_limit} }
    end,
})
SMODS.DrawStep {
    key = 'edition',
    order = 999,
    func = function(self, layer)
        if (self.edition and self.edition.unik_positive) then
            self.children.center:draw_shader('negative_shine', nil, self.ARGS.send_to_shader)
        end

    end,
    conditions = { vortex = false, facing = 'front' },
}