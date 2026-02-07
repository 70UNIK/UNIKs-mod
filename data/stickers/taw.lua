--completely indestructible.
--completely unremovable.
--dont think about trying to remove it via unik_taw = nil, it WILL regenerate in some shape or form
local tawSeed = math.random(1,100)..math.random(1,100)..math.random(1,100)..math.random(1,100)..math.random(1,100)..math.random(1,100)..math.random(1,100)..'_taw'

SMODS.Sticker{
    key="unik_taw",
    badge_colour=HEX("030001"),
    atlas = 'unik_stickers', 
    pos = { x = 4, y = 0 },
    rate = 0.0,
    no_sticker_sheet = true,
    order = 3200,
}

local updateStickerHook = Card.update
function Card:update(dt)
    if self.added_to_deck then
        if self.unik_taw then
            self.ability.unik_taw = true
            self.ability[tawSeed] = true
        end
        if self.ability.unik_taw then
            self.cry_absolute = nil
            self.unik_taw = true
            self.ability.eternal = nil
            self.ability.cry_absolute = nil
            self.ability[tawSeed] = true
            self.ability.perishable = nil
            self.ability.unik_disposable = nil
            self.ability.unik_niko = nil
            self.ability.unik_decaying = nil
            self.ability.immune_to_vermillion = true
        end
        if self.ability[tawSeed] then
            self.ability.unik_taw = true
        end
        if self.config.center.key == 'j_jen_kosmos' then
            self.ability.unik_taw = true
        end
    end
    if self.config.center.key == 'j_paperback_jimbocards' then
        self.ability.unik_taw = true
    end
    local ret = updateStickerHook(self,dt)
    return ret
end

local remove_ref = Card.remove
function Card.remove(self)
    -- Check that the card being removed is a joker that's in the player's deck and that it's not being sold
    if not G.GAME.ignore_delete_context then
        if self.ability.unik_taw and not self.ability.unik_already_used_taw and not self.ability.unik_bypass_taw and not G.SETTINGS.paused then
            local _card = nil
            --create a new card instead with edition if it's a decrementing one
            if self.config.center.pools and (self.config.center.pools.autocannibalism_food) then
                _card = create_card("Joker", G.jokers, nil, nil, nil, nil, self.config.center.key)
                if self.edition then
                    _card:set_edition(self.edition.key,true)
                end
                
            else
                _card = copy_card(self, nil, nil, nil, nil)
            end
            _card:add_to_deck()
            _card:start_materialize()
            if self.ability.set == 'Joker' then
                G.jokers:emplace(_card)
            elseif self.playing_card then
                table.insert(G.playing_cards, _card)
                G.deck:emplace(_card)
            elseif self.area == G.consumeables then
                G.consumeables:emplace(_card)
            end
            
            _card.ability.destroyed_by_megatron = nil
        end
    end


    local ret = remove_ref(self)
    return ret
end

--balatro's soul hook; bypass taw:
local cuc = Card.use_consumeable
function Card:use_consumeable(area, copier)
    if self.config.center.key == 'c_jen_soul_omega' then
        for k, v in pairs(G.jokers.cards) do
            if v.ability.unik_taw then
                v.ability.unik_bypass_taw = true
            end 
        end
        for k, v in pairs(G.consumeables.cards) do
            if v.ability.unik_taw then
                v.ability.unik_bypass_taw = true
            end 
        end
        for k, v in pairs(G.playing_cards) do
            if v.ability.unik_taw then
                v.ability.unik_bypass_taw = true
            end 
        end
    end
    
    local c = cuc(self, area, copier)
    --backup to remove bypass if balasoul fails to trigger 
    if self.ability.extinct and self.config.center.key == 'c_jen_soul_omega' then
        for k, v in pairs(G.jokers.cards) do
            if v.ability.unik_taw then
                v.ability.unik_bypass_taw = nil
            end 
        end
        for k, v in pairs(G.consumeables.cards) do
            if v.ability.unik_taw then
                v.ability.unik_bypass_taw = nil
            end 
        end
        for k, v in pairs(G.playing_cards) do
            if v.ability.unik_taw then
                v.ability.unik_bypass_taw = nil
            end 
        end
    end
    return c
end

local user = Card.use_consumeable
function Card:use_consumeable(area, copier)
    self.ability.unik_already_used_taw = true
    local ret = user(self,area,copier)
    return ret
end

local is_eternalref = SMODS.is_eternal
function SMODS.is_eternal(c, ...)
    if c and c.ability and c.ability.unik_taw then
        return true
    end
    if c then
        return is_eternalref(c, ...)
    end
end