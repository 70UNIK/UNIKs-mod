--"Mid Fusion" sprites, for when someone is about to be godsmarbled as opposed to just being scared from high score
--Overrides high score scared sprites
local card_draw_ref2 = Card.draw
function Card:draw(layer)
    local CEN = self.gc and self:gc()
    if CEN then
		self.was_in_pack_area = G.pack_cards and self.area and self.area == G.pack_cards
		if (self.facing or '') == 'front' then
			if self.config and (SMODS.Mods["jen"] or {}).can_load then
                --Copied from Jen's, credit to him for original code
                local godsmarble_fear = not CEN.cant_scare and ((Jen.gods() and CEN.fusable))
                --print("22222")
                if not CEN.update and self.children.floating_sprite then
                    --print("33333")
					if (CEN.godsmarbling and godsmarble_fear) and not self.about_to_get_godsmarbled then
						self.about_to_get_godsmarbled = true
                        if CEN.godsmarbling_back then
                            self.children.center:set_sprite_pos(CEN.godsmarbling_back)
                        end
                        --print("fear2")
						self.children.floating_sprite:set_sprite_pos(CEN.godsmarbling)
					elseif not (CEN.godsmarbling and godsmarble_fear) and self.about_to_get_godsmarbled then
						self.about_to_get_godsmarbled = nil
                        --only set back to original if not in drama
                        if CEN.godsmarbling_back and not self.in_drama_state then
                            self.children.center:set_sprite_pos(CEN.pos)
                        end
                        --only set back to original if not in drama
                        if not self.in_drama_state then
                            self.children.floating_sprite:set_sprite_pos(CEN.soul_pos)
                        end
					end
				end
                --do not spam shake too much (or else it gets too annoying)
				if self.about_to_get_godsmarbled and not self.in_drama_state then
					self:juice_up(0, math.random()/(Jen.dramatic and 3 or 6))
				end
            end
        end
    end
    CEN = nil

    card_draw_ref2(self, layer)

end