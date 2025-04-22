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
    rarity = "cry_cursed",
	pos = { x = 4, y = 1 },
    cost = 0,
	blueprint_compat = false,
    no_dbl = true,
    perishable_compat = false,
	eternal_compat = false,
    config = { extra = {x_mult = 0.5,multiplier = 20,cost = -15,fallback_cost = 20} },
    loc_vars = function(self, info_queue, center)
        return { 
            key = Cryptid.gameset_loc(self, { modest = "modest"}),
            vars = { center.ability.extra.x_mult,center.ability.extra.multiplier,center.ability.extra.fallback_cost} }
	end,
    gameset_config = {
		modest = { extra = {x_mult = 1.0,multiplier = 2.5,cost = -15,fallback_cost = 10} },
	},
    immutable = true,
    --add debuffs
    add_to_deck = function(self, card, from_debuff)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            func = function()
                local validEntries = {}
                local ghostTrap = false
                --Stop impounding if it detects a ghost trap to avoid infinite loops
                for i = 1,#G.jokers.cards do
                    if G.jokers.cards[i].config.center.rarity ~= "cry_cursed" and G.jokers.cards[i].config.center.key ~= "j_unik_impounded" and not G.jokers.cards[i].ability.unik_impounded then
                        table.insert(validEntries,i)
                    end
                    if G.jokers.cards[i].config.center.key == "j_unik_ghost_trap" or G.jokers.cards[i].config.center.key == "j_cry_formidiulosus" then
                        ghostTrap = true
                        validEntries = {}
                        break
                    end
                end
                if #validEntries > 0 and not ghostTrap == true then


                    local select = pseudorandom(pseudoseed("unik_impoundSelect"), 1, #validEntries)
                    --If its targeting itself, then retry until it hits a non-cursed Joker or no non-cursed jokers exist
                    local retry = false
                    local successful = true
                    --Fallback: If it happened to target a cursed joker, retry until it hits another one or no non cursed exist to avoid debuffing a non cursed joker or itself
                    if G.jokers.cards[select].config.center.rarity == "cry_cursed" then
                        print(#validEntries) 
                        retry = true
                        successful = false
                    print("Uh oh, looks like it tried to debuff a cursed joker or itself... fallback")
                        -- while retry == true do
                        --     validEntries = {}
                        --     for i = 1,#G.jokers.cards do
                        --         if G.jokers.cards[i].config.center.rarity ~= "cry_cursed" and G.jokers.cards[i].config.center.key ~= "j_unik_impounded" then
                        --             table.insert(validEntries,i)
                        --            print(i)
                        --         end
                        --     end
                        --     if #validEntries > 0 then
                        --         local select = pseudorandom(pseudoseed("unik_impoundSelect"), 1, #validEntries)
                        --         if G.jokers.cards[select].config.center.rarity ~= "cry_cursed" then
                        --             retry = false
                        --             successful = true
                        --             break
                        --         end
                        --     else
                        --         --No valid jokers exist (somehow at this point)
                        --         successful = false
                        --         retry = false
                        --         break
                        --     end
                        -- end
                    end
                    if successful == true and not ghostTrap == true then
                        card_eval_status_text(G.jokers.cards[select], 'extra', nil, nil, nil, {message = localize('k_unik_impounded'), colour = G.C.BLACK})
                        G.E_MANAGER:add_event(Event({
                            func = function() 

                                G.jokers.cards[select].ability.unik_impounded = true
                                --Scale logarithmically, so cheaper jokers would proportionately cost more, while exotics proportinately cost less, but still always increasing.
                                if Card.get_gameset(card) ~= "modest" then
                                    card.ability.extra.cost = -math.ceil(card.ability.extra.multiplier * 100 * math.log(G.jokers.cards[select].sell_cost+1))/100
                                else
                                    card.ability.extra.cost = -math.ceil(card.ability.extra.multiplier * 100 * G.jokers.cards[select].sell_cost)/100
                                end
                                G.jokers.cards[select].sell_cost = 0
                                G.jokers.cards[select].ability.eternal = true
                                G.jokers.cards[select].ability.rental = true
                                SMODS.debuff_card(G.jokers.cards[select],true,"unik_impounded")
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
        for i = 1,#G.jokers.cards do
            if G.jokers.cards[i].ability.unik_impounded then
                --avoid softlock if it debuffs itself (somehow)
                SMODS.debuff_card(G.jokers.cards[i],false,"unik_impounded")
                G.jokers.cards[i].ability.unik_impounded = false
                G.jokers.cards[i].ability.eternal = false
                G.jokers.cards[i].ability.rental= false
            end
        end
    end,
    calculate = function(self, card, context)
        --calculate Xmult
		if context.final_scoring_step and Card.get_gameset(card) ~= "modest" then
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
    if (G.SETTINGS.tutorial_complete or G.GAME.pseudorandom.seed ~= 'TUTORIAL' or G.GAME.round_resets.ante > 1) and
        self.area and
        self.area.config.type == 'joker' and
        not self.ability.eternal then
            if self.config.center.key == "j_unik_impounded" then
                --Takes in factor credit card
                if to_big((G.GAME.dollars-G.GAME.bankrupt_at) + self.ability.extra.cost) < to_big(0) then
                    return false
                end
            end
    end
    
    local vaz = sellPrevention(self,context)
    return vaz
end

--Simple EChips display
if JokerDisplay then
	JokerDisplay.Definitions["j_unik_impounded"] = {
		text = {
			{
				border_nodes = {
					{ text = "X" },
					{
						ref_table = "card.ability.extra",
						ref_value = "x_mult",
						retrigger_type = "exp"
					},
				},
				border_colour = G.C.MULT,
			},
		},
	}
end