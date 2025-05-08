--destroy all but the rightmost card played after scoring
SMODS.Atlas {
	key = "unik_lily_sprunki",
	path = "unik_lily_sprunki.png",
	px = 71,
	py = 95
}

SMODS.Joker {
	-- How the code refers to the joker.
	key = 'unik_lily_sprunki',
    atlas = 'unik_lily_sprunki',
    rarity = 3,
	pos = { x = 0, y = 0 },
	-- soul_pos sets the soul sprite, used for legendary jokers and basically all of Jen's Jokers
	soul_pos = { x = 1, y = 0 },
    cost = 8,
    config = {extra = {triggered = false,feral = false}},
    loc_vars = function(self, info_queue, center)
        return { 
            key = Cryptid.gameset_loc(self, { modest = "modest"}), 
            vars = { localize(G.GAME.sprunki_lily_quote) } }
    end,
    blueprint_compat = false,
	perishable_compat = true,
	eternal_compat = false,
    pools = {["unik_copyrighted"] = true },
    add_to_deck = function(self, card, context)
        --return to normal sprite
        card.children.center:set_sprite_pos({x = 0, y = 0})
        card.children.floating_sprite:set_sprite_pos({x = 1, y = 0})
        G.GAME.sprunki_lily_quote = "k_unik_lily_sprunki_normal"
    end,
    calculate = function(self, card, context)
        --destroy cards and have her "eat" cards
		if
			(context.cardarea == G.play or context.cardarea == "unscored")
			and context.destroy_card ~= context.full_hand[1] and ((Card.get_gameset(card) ~= "modest") or (context.destroy_card ~= context.full_hand[2] and context.destroy_card ~= context.full_hand[3] and Card.get_gameset(card) == "modest"))
			and ((#context.full_hand > 1 and Card.get_gameset(card) ~= "modest") or (#context.full_hand > 3 and Card.get_gameset(card) == "modest")) -- 3 cards in played hand
			and not context.blueprint
			and not context.retrigger_joker 
            and card.ability.extra.feral == true
        then
           -- print("nom mom")
            if (context.destroy_card) then
                if not context.destroy_card.ability.eternal then
                    context.destroy_card.ability.gore_6_destruction = true
                end
                return{
                    remove = not context.destroy_card.ability.eternal,
                    func = function()
                        if card.ability.extra.triggered == false then
                            card.ability.extra.triggered = true
                            -- card_eval_status_text(card, "extra", nil, nil, nil, {
                            --     message = localize("k_eaten_ex"),
                            --     colour = HEX("d377dc"),
                            --     card = card
                            -- })
                            G.E_MANAGER:add_event(Event({
                                trigger='immediate',
                                func = function()
                                    card:juice_up(0.5, 0.5)
                                    card.children.center:set_sprite_pos({x = 0, y = 1})
                                    card.children.floating_sprite:set_sprite_pos({x = 2, y = 1})
                                    G.GAME.sprunki_lily_quote = "k_unik_lily_sprunki_monster"
                                    G.ROOM.jiggle = G.ROOM.jiggle + 5
                                    --play_sound("unik_gore6") --thats funny
                                    return not context.destroy_card.ability.eternal
                                end
                            }))
                        end
                    end
                }
            end
        end
        if context.after and context.cardarea == G.jokers and ((#context.full_hand > 1 and Card.get_gameset(card) ~= "modest") or (#context.full_hand > 3 and Card.get_gameset(card) == "modest")) and card.ability.extra.feral == true then
            --return to normal sprite
            G.E_MANAGER:add_event(Event({
                func = function()
                    card:juice_up(0.5, 0.5)
                    card.children.center:set_sprite_pos({x = 0, y = 0})
                    card.children.floating_sprite:set_sprite_pos({x = 1, y = 0})
                    G.GAME.sprunki_lily_quote = "k_unik_lily_sprunki_normal"
                    card.ability.extra.triggered = false
                    card.ability.extra.feral = false
                    return true
                end
            }))
            return{
                message = localize("k_unik_lily_sprunki_after"),
                colour = HEX("d377dc"),
            }
        end
        if context.before and context.cardarea == G.jokers and ((#context.full_hand > 1 and Card.get_gameset(card) ~= "modest") or (#context.full_hand > 3 and Card.get_gameset(card) == "modest")) then
            --only turn feral if theres any valid card
            for i, w in pairs(context.full_hand) do
                if not w.ability.eternal then
                    valid = true
                end
            end
            if valid == true then
                card.ability.extra.feral = true
                --print("turn them happy")
                G.E_MANAGER:add_event(Event({
                    func = function()
                        card:juice_up(0.5, 0.5)
                        card.children.center:set_sprite_pos({x = 0, y = 1})
                        card.children.floating_sprite:set_sprite_pos({x = 1, y = 1})
                        G.GAME.sprunki_lily_quote = "k_unik_lily_sprunki_monster"
                        return true
                    end
                }))
                return{
                    message = localize("k_unik_lily_sprunki_monster"),
                    colour = HEX("d377dc"),
                }
            end
        end
	end
}

local igo2 = Game.init_game_object
function Game:init_game_object()
	local ret = igo2(self)
	ret.sprunki_lily_quote = "k_unik_lily_sprunki_normal"
	return ret
end

if JokerDisplay then
	JokerDisplay.Definitions["j_unik_lily_sprunki"] = {
    }
end

--Gore6 (custom card destruction animation)
function Card:gore6_break()
    local dissolve_time = 0.7
    self.shattered = true
    self.dissolve = 0
    self.dissolve_colours = {{0.5,0,0,0.8}}
    self:juice_up()
    local childParts = Particles(0, 0, 0,0, {
        timer_type = 'TOTAL',
        timer = 0.007*dissolve_time,
        scale = 0.3,
        speed = 4,
        lifespan = 0.5*dissolve_time,
        attach = self,
        colours = self.dissolve_colours,
        fill = true
    })
    G.E_MANAGER:add_event(Event({
        trigger = 'after',
        blockable = false,
        delay =  0.5*dissolve_time,
        func = (function() childParts:fade(0.15*dissolve_time) return true end)
    }))
    G.E_MANAGER:add_event(Event({
        blockable = false,
        func = (function()
                play_sound("unik_gore6", math.random()*0.2 + 0.9,0.5)
                play_sound('generic1', math.random()*0.2 + 0.9,0.5)
            return true end)
    }))
    G.E_MANAGER:add_event(Event({
        trigger = 'ease',
        blockable = false,
        ref_table = self,
        ref_value = 'dissolve',
        ease_to = 1,
        delay =  0.5*dissolve_time,
        func = (function(t) return t end)
    }))
    G.E_MANAGER:add_event(Event({
        trigger = 'after',
        blockable = false,
        delay =  0.55*dissolve_time,
        func = (function() self:remove() return true end)
    }))
    G.E_MANAGER:add_event(Event({
        trigger = 'after',
        blockable = false,
        delay =  0.51*dissolve_time,
    }))
end