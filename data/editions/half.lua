--HALF
--Debuffed if at least 4 cards are selected (literally half joker)
--Card is "ripped" in half and has its sprite center adjusted
--fuzzy:
-- -10 - 0 Mult, -50 - 0 Chips, -$0 - -$4
--Sound is literally from yoshis island
SMODS.Sound({
	key = "templerun_rip",
	path = "templerun_rip.ogg",
})
SMODS.Shader({
    key = "halfjoker",
    path = "halfjoker.fs",
})
SMODS.Edition({
	key = "halfjoker",
	order = 66666,
	weight = 0, -- should not appear normally in stores as its a detrimental one
	shader = "halfjoker", --placeholder for now until I program one. It should have negative shine, but with a polychromesque shine from normal to overlay to a bit of negative, just to show its the opposite
	extra_cost = -3, --Its a detrimental edition, hence lower cost
    apply_to_float = true,
    disable_base_shader = true,
    detrimental = true,
    no_shadow = true,
	sound = {
		sound = "unik_templerun_rip",
		per = 1,
		vol = 1,
	},
    get_weight = function(self)
		if G.GAME.unik_bad_editions_everywhere then
			return G.GAME.edition_rate * 4
		else
			return 0
		end
	end,
    on_apply = function(card)
        if card.ability.set ~= "Default" and card.ability.set ~= "Enhanced" then
            local X, Y, W, H = card.T.x, card.T.y, card.T.w, card.T.h
            H = H/1.7
            card.T.h = H
            card.children.center.scale.y = card.children.center.scale.y/1.7
        end
	end,
	on_remove = function(card)
        if card.ability.set ~= "Default" and card.ability.set ~= "Enhanced" then
            local X, Y, W, H = card.T.x, card.T.y, card.T.w, card.T.h
            H = H*1.7
            card.T.h = H
            card.children.center.scale.y = card.children.center.scale.y*1.7
        end
	end,
    on_load = function(card)
        if card.ability.set ~= "Default" and card.ability.set ~= "Enhanced"  then
            local X, Y, W, H = card.T.x, card.T.y, card.T.w, card.T.h
            H = H/1.7
            card.T.h = H
            card.children.center.scale.y = card.children.center.scale.y/1.7
        end
	end,
    config = { size = 3},
    -- calculate = function(self, card, context)
    --     local isDebuffed = false
    --     if context.full_hand ~= nil and #context.full_hand > self.config.size and not isDebuffed then
    --         isDebuffed = true
    --     else
    --         isDebuffed = false
    --     end
    --     if G.hand and G.hand.highlighted and #G.hand.highlighted > 3 and not isDebuffed then
    --         isDebuffed = true
    --     else
    --         isDebuffed = false
    --     end
    --     SMODS.debuff_card(card,isDebuffed,"half_joker_edition_debuff")
    -- end,
    in_shop = false,
    badge_colour = G.C.UNIK_SHITTY_EDITION,
})

-- local half_debuff_hook = Card.highlight
-- function Card:highlight(is_higlighted)
--     half_debuff_hook(self,is_higlighted)
    

-- end
local updateStickerHook2 = Card.update
function Card:update(dt)
    local ret = updateStickerHook2(self,dt)
        if G.jokers and self.edition and self.edition.unik_halfjoker then
            if (G.hand and G.hand.highlighted and #G.hand.highlighted > 3) or (G.play and G.play.cards and #G.play.cards > 3) then
                if self.ability.set ~= "Voucher" then
                    self:set_debuff(true)
                end
            elseif not self.debuffed_by_blind then
                if self.ability.set ~= "Voucher" then
                    self:set_debuff()
                end
            end
        end

        -- if (G.hand and G.hand.highlighted and #G.hand.highlighted > 3) or (G.play and G.play.cards and #G.play.cards > 3) then
        --     if G.playing_cards then
        --         for k, v in pairs(G.playing_cards) do
        --             if v.edition and v.edition.unik_halfjoker then
        --                 v:set_debuff(true)
        --             end
        --         end
        --     end
        --     if G.jokers and G.jokers.cards then
        --         for k, v in pairs(G.jokers.cards) do
        --             if v.edition and v.edition.unik_halfjoker then
        --                 v:set_debuff(true)
        --             end
        --         end
        --     end
        --    if G.consumeables and G.consumeables.cards then
        --         for k, v in pairs(G.consumeables.cards) do
        --             if v.edition and v.edition.unik_halfjoker then
        --                 v:set_debuff(true)
        --             end
        --         end
        --     end
        -- end


    return ret
end

-- local editionHook = Card.set_edition
-- function Card:set_edition(edition, immediate, silent)
--     self:set_sprites(self.config.center)
--     editionHook(self,edition,immediate,silent)

    
-- end
-- local spriteHook = Card.set_sprites
-- function Card:set_sprites(_center, _front)
--     spriteHook(self,_center,_front)
--     local X, Y, W, H = self.T.x, self.T.y, self.T.w, self.T.h
--     if self.edition and self.edition.unik_halfjoker and self.ability and not self.ability.ripped_in_half then
        
--         self.children.center.scale.y = self.children.center.scale.y/1.7
--         H = H/1.7
--         self.T.h = H

--         self.ability.ripped_in_half = true
--     elseif (not self.edition or (self.edition and not self.edition.unik_halfjoker)) and self.ability and self.ability.ripped_in_half then
--         self.children.center.scale.y = self.children.center.scale.y*1.7
--         H = H*1.7
--         self.T.h = H


--         self.ability.ripped_in_half = nil
--     end
-- end