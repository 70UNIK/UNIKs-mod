--0.5X mult after scoring, debuffs up to two random Jokers and set their sell prices to $0. Sell to remove this joker and the debuffs. Selling costs double the sum of the original jokers selling prices.
SMODS.Joker {
    dependencies = {
		items = {
			"set_cry_cursed",
		},
	},
	-- How the code refers to the joker.
	key = 'unik_impounded',
    atlas = 'unik_cursed',
    rarity = 'unik_detrimental',
	pos = { x = 4, y = 1 },
    cost = 0,
	blueprint_compat = false,
    no_dbl = true,
    perishable_compat = false,
	eternal_compat = false,
    config = { extra = {x_mult = 0.5,multiplier = 20,cost = -15,fallback_cost = 20,impoundedSeed = ""} },
    loc_vars = function(self, info_queue, center)
        if not center.ability.unik_impounded then
            info_queue[#info_queue + 1] = { set = "Other", key = "unik_impounded" }
        end
        return { 
            vars = { center.ability.extra.x_mult,center.ability.extra.multiplier,center.ability.extra.fallback_cost} }
	end,
    immutable = true,
    sellable = true,
    override_cursed_cost = true,
    --add debuffs
    add_to_deck = function(self, card, from_debuff)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            func = function()
                local validEntries = {}
                local ghostTrap = false
                --Stop impounding if it detects a ghost trap to avoid infinite loops
                for i,v in pairs(G.jokers.cards) do
                    if v.config.center.rarity ~= 'unik_detrimental' and v.config.center.key ~= "j_unik_impounded" and not v.ability.unik_impounded then
                        validEntries[#validEntries + 1] = v
                    end
                    if v.config.center.key == "j_unik_ghost_trap" or v.config.center.key == "j_cry_formidiulosus" then
                        ghostTrap = true
                        validEntries = {}
                        break
                    end
                end
                if #validEntries > 0 and not ghostTrap == true then


                    local select = pseudorandom_element(validEntries, pseudoseed("unik_impoundSelect"))
                    --If its targeting itself, then retry until it hits a non-cursed Joker or no non-cursed jokers exist
                    local successful = true
                    --Fallback: If it happened to target a cursed joker, retry until it hits another one or no non cursed exist to avoid debuffing a non cursed joker or itself
                    if select.config.center.rarity == 'unik_detrimental' then
                        print(#validEntries) 
                        successful = false
                        print("Uh oh, looks like it tried to debuff a cursed joker or itself... fallback")
                    end
                    if select and successful == true and not ghostTrap == true then
                        card.ability.extra.impoundedSeed = pseudoseed('impounded_ID_unik') --used to track which joker is impounded, in case of multiple impound notices
                        card_eval_status_text(select, 'extra', nil, nil, nil, {message = localize('k_unik_impounded'), colour = G.C.BLACK})
                        G.E_MANAGER:add_event(Event({
                            func = function() 

                                select.ability.unik_impounded = true
                                --Scale logarithmically, so cheaper jokers would proportionately cost more, while exotics proportinately cost less, but still always increasing.
                                if select.sell_cost then
                                    card.ability.extra.cost = -math.ceil(card.ability.extra.multiplier * 100 * math.log(select.sell_cost+1,math.exp(1)))/100
                                end
                                
                                if not select.sell_cost or select.sell_cost <= 1 then
                                    card.ability.extra.cost = -1 * card.ability.extra.fallback_cost
                                end
                                select.sell_cost = 0
                                select.ability.eternal = true
                                select.ability.rental = true
                                select.ability.unik_impounded_seed = card.ability.extra.impoundedSeed
                                SMODS.debuff_card(select,true,card.ability.extra.impoundedSeed)
                                card:set_cost()
                                return true
                            end
                        }))
                    elseif successful == false and not ghostTrap == true then
                        card.ability.extra.cost = -1 * card.ability.extra.fallback_cost
                        card:set_cost()
                    end
                else
                    card.ability.extra.cost = -1 * card.ability.extra.fallback_cost
                    card:set_cost()
                end
                return true
            end
        }))
    end,
    --remove debuffs
    remove_from_deck = function(self, card, from_debuff)
        for i,v in pairs(G.jokers.cards) do
            
            if v.ability.unik_impounded and v.ability.unik_impounded_seed == card.ability.extra.impoundedSeed then
                --avoid softlock if it debuffs itself (somehow)
                SMODS.debuff_card(v,false,card.ability.extra.impoundedSeed)
                v.ability.unik_impounded = false
                v.ability.unik_impounded_seed = nil
                v.ability.eternal = false
                v.ability.rental= false
            end
        end
    end,
    calculate = function(self, card, context)
        --calculate Xmult
		if context.final_scoring_step then
			return {
				message = localize({ type = "variable", key = "a_xmult", vars = { card.ability.extra.x_mult } }),
				Xmult_mod = card.ability.extra.x_mult,
			}
		end
    end
}
--Hook to prevent selling Impounded if you're in debt.
local sellPrevention = Card.can_sell_card
function Card:can_sell_card(context)
    local lockpick = next(find_joker("j_unik_lockpick"))
    if (G.play and #G.play.cards > 0) or
        (G.CONTROLLER.locked) or 
        (G.GAME.STOP_USE and G.GAME.STOP_USE > 0) --or 
        --G.STATE == G.STATES.BLIND_SELECT 
        then return false end
    --ALWAYS make it unsellable if detrimental.
    if self.config.center.rarity == 'unik_detrimental' and not self.config.center.sellable then
        return false
    end
    if (G.SETTINGS.tutorial_complete or G.GAME.pseudorandom.seed ~= 'TUTORIAL' or G.GAME.round_resets.ante > 1) and
        self.area and
        self.area.config.type == 'joker' and
        (not SMODS.is_eternal(self, {from_sell = true}) or ( SMODS.is_eternal(self, {from_sell = true}) and lockpick and not self.config.center.dissolve_immune and not self.ability.dissolve_immune)) then
            if self.config.center.key == "j_unik_impounded" or self.config.center.key == "j_buf_afan_spc"  then
                --Takes in factor credit card
                if to_big((G.GAME.dollars-G.GAME.bankrupt_at) + self.ability.extra.cost) < to_big(0) then
                    return false
                end
            else
                return true
            end
    end
    
    local vaz = sellPrevention(self,context)
    return vaz
end

--Simple EChips display
-- if JokerDisplay then
-- 	JokerDisplay.Definitions["j_unik_impounded"] = {
-- 		text = {
-- 			{
-- 				border_nodes = {
-- 					{ text = "X" },
-- 					{
-- 						ref_table = "card.ability.extra",
-- 						ref_value = "x_mult",
-- 						retrigger_type = "exp"
-- 					},
-- 				},
-- 				border_colour = G.C.MULT,
-- 			},
-- 		},
--         reminder_text = {
--             { text = "(" },
--             { text = "$",         colour = G.C.GOLD },
--             { ref_table = "card", ref_value = "sell_cost", colour = G.C.GOLD },
--             { text = ")" },
--         },
--         reminder_text_config = { scale = 0.35 }
-- 	}
-- end