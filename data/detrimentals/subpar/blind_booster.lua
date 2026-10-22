UNIK.detriment{
    key = "unik_blind_booster",
    atlas = "unik_detriments",
	pos = { x = 6, y = 4 },
    config = { extra = { boosters = 10, boosters_not_skipped = 0,chance = 1, prob = 2} },
    severity = 1,
    immutable = true,
    dongtong_compat = false,
    blueprint_compat = true,
    attributes = { 'detrimental','shop','booster','detriment'},
    loc_vars = function(self, info_queue, card)
         local new_numerator, new_denominator = SMODS.get_probability_vars(card, card.ability.extra.chance, card.ability.extra.prob,'unik_blind_booster')
        return { vars = {card.ability.extra.boosters,card.ability.extra.boosters_not_skipped,new_numerator,new_denominator} }
	end,
    in_pool = function(self, args)
        return true
    end,
    calculate = function(self, card, context)
        if context.skipping_booster then
            card.ability.extra.boosters_not_skipped = 0
            card.ability.extra.resetted = true
            return {
                message = localize('k_reset'),
                colour = G.C.BLACK,
            }
        end
        if context.ending_booster then
            if card.ability.extra.resetted  then
                card.ability.extra.resetted  = nil
                return {
                    
                }
            end
            card.ability.extra.boosters_not_skipped = card.ability.extra.boosters_not_skipped + 1
            if card.ability.extra.boosters_not_skipped >= card.ability.extra.boosters then
                selfDestruction(card,'k_unik_booster_opened',G.C.BLACK)
            else
                 return {
                    message = card.ability.extra.boosters_not_skipped .. "/" .. card.ability.extra.boosters,
                    colour = G.C.BLACK,
                }
            end
        end
        if context.unik_emplace and context.cardarea == G.pack_cards then
            if context.added.config.center.set ~= 'Joker' and SMODS.pseudorandom_probability(card, 'unik_blind_booster', card.ability.extra.chance, card.ability.extra.prob) then
                context.added.facing = 'back'
                context.added.sprite_facing = 'back'
                return {

                }
            end
        end
    end,
    add_to_deck = function (self, card, from_debuff)
        if G.shop_booster then
            for i,v in pairs(G.shop_booster.cards) do
                if (v.config.center.set == 'Booster' or string.sub(v.config.center.key,1,2) == 'p_') and v.facing ~= 'back' then
                    v:flip()
                end
            end
        end
        if G.shop_jokers then
            for i,v in pairs(G.shop_jokers.cards) do
                if (v.config.center.set == 'Booster' or string.sub(v.config.center.key,1,2) == 'p_') and v.facing ~= 'back' then
                    v:flip()
                end
            end
        end
        if G.shop_vouchers then
            for i,v in pairs(G.shop_vouchers.cards) do
                if (v.config.center.set == 'Booster' or string.sub(v.config.center.key,1,2) == 'p_') and v.facing ~= 'back' then
                    v:flip()
                end
            end
        end
        
    end,

    remove_from_deck = function (self, card, from_debuff)
        if not UNIK.has_blindbooster() then
            if G.shop_booster then
                for i,v in pairs(G.shop_booster.cards) do
                    if (v.config.center.set == 'Booster' or string.sub(v.config.center.key,1,2) == 'p_') and v.facing ~= 'front' then
                        v:flip()
                    end
                end
            end
            if G.shop_jokers then
                for i,v in pairs(G.shop_jokers.cards) do
                    if (v.config.center.set == 'Booster' or string.sub(v.config.center.key,1,2) == 'p_') and v.facing ~= 'front' then
                        v:flip()
                    end
                end
            end
            if G.shop_vouchers then
                for i,v in pairs(G.shop_vouchers.cards) do
                    if (v.config.center.set == 'Booster' or string.sub(v.config.center.key,1,2) == 'p_') and v.facing ~= 'front' then
                        v:flip()
                    end
                end
            end
        end
    end
}

local boostadd = SMODS.add_booster_to_shop
function SMODS.add_booster_to_shop(key)
    local card = boostadd(key)
    if card.config.center.set == 'Booster' and UNIK.has_blindbooster() then
        if card.facing ~= 'back' then
            card.facing = 'back'
            card.sprite_facing = 'back'
        end
    end
    return card
end

local boostflip = create_shop_card_ui
function create_shop_card_ui(card, type, area)
    local ret = boostflip(card, type, area)
    if card.config.center.set == 'Booster' and UNIK.has_blindbooster() then
        if card.facing ~= 'back' then
            card.facing = 'back'
            card.sprite_facing = 'back'
        end
    end
    return ret
end

function UNIK.has_blindbooster(args)
    local truth = next(SMODS.find_card('detr_unik_blind_booster'))
    print(truth)
    return truth
end