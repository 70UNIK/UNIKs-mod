--dethroning tag: disables the current joker for 1 hand
SMODS.Tag {
    key = "unik_blindside_dethroning",
    hide_ability = false,
    atlas = 'unik_tags',
    pos = {x = 3, y = 0},
    in_pool = function(self, args)
        return false
    end,
    pools = {["bld_obj_blindside"] = true},
    config = {hands = 1},
    loc_vars = function(self, info_queue)

		return { vars = { self.config.hands } }
	end,
    apply = function(self, tag, context)
        if not G.GAME.imprisonment_buffer and (context.type == 'round_start_bonus') and not G.GAME.unik_override_prince and G.GAME.unik_can_trigger_prince then
           -- print("remaining at time:" .. G.GAME.unik_prince_hands_remaining )
            G.GAME.unik_prince_hands_remaining =  G.GAME.unik_prince_hands_remaining or 0
            if G.GAME.unik_prince_hands_remaining < 1 then
                G.GAME.imprisonment_buffer = true
                G.GAME.unik_prince_hands_remaining = G.GAME.unik_prince_hands_remaining or 0
                G.GAME.unik_prince_hands_remaining = G.GAME.unik_prince_hands_remaining + self.config.hands
                G.E_MANAGER:add_event(Event({
                    func = function ()
                        if G.GAME.blind and not G.GAME.blind.disabled then
                            G.GAME.unik_saved_blind = G.GAME.blind:save()
                            G.GAME.blind:disable()
                            G.GAME.blindassist:disable()
                        end
                        G.GAME.unik_override_prince = false
                        G.GAME.imprisonment_buffer = false
                        tag:yep('+', HEX('c13b77'), function()
                        return true end)
                        tag.triggered = true
                        return true
                    end
                }))
            end
            
        end
    end,
}


--blindside disabling tag fixes to synchronize with dethroning
SMODS.Tag:take_ownership('tag_bld_heartbreak',{
apply = function(self, tag, context)
    if context.type == 'real_round_before_start' then
        G.GAME.blind:disable()
        G.GAME.blindassist:disable()
    end
    if not G.GAME.imprisonment_buffer and context.type == 'real_round_start' then
        G.GAME.imprisonment_buffer = true
        G.E_MANAGER:add_event(Event({
            func = function ()
                if G.GAME.blind and not G.GAME.blind.disabled then
                    G.GAME.blind:disable()
                    G.GAME.blindassist:disable()
                end
                G.GAME.unik_override_prince = true
                G.GAME.imprisonment_buffer = false
                tag:yep('+', G.C.RED, function()
                return true end)
                tag.triggered = true
                return true
            end
        }))
    end
end,
},true)

SMODS.Tag:take_ownership('tag_bld_imprisonment',{
apply = function(self, tag, context)
    if context.type == 'real_round_before_start' and not (next(SMODS.find_card("j_bld_taglock")) and not (G.GAME.blind.boss or G.GAME.last_joker)) and G.GAME.blind.boss then
        G.GAME.blind:disable()
        G.GAME.blindassist:disable()
    end
    if not G.GAME.imprisonment_buffer and context.type == 'real_round_start' and not (next(SMODS.find_card("j_bld_taglock")) and not (G.GAME.blind.boss or G.GAME.last_joker)) and G.GAME.blind.boss then
        G.GAME.imprisonment_buffer = true
        G.E_MANAGER:add_event(Event({
            func = function ()
                if G.GAME.blind and not G.GAME.blind.disabled then
                    G.GAME.blind:disable()
                    G.GAME.blindassist:disable()
                end
                G.GAME.unik_override_prince = true
                G.GAME.imprisonment_buffer = false
                tag:yep('+', G.C.RED, function()
                return true end)
                tag.triggered = true
                return true
            end
        }))
    end
end,
},true)

function UNIK.summon_blind()
    if G.GAME.blind.disabled and G.GAME.unik_saved_blind then
        G.GAME.blind:wiggle()
        G.GAME.blind:load(G.GAME.unik_saved_blind)
    end
end

local defeatHook = Blind.defeat
function Blind:defeat(silent)
    local ret = defeatHook(self,silent)
    G.GAME.unik_saved_blind = nil
    G.GAME.unik_prince_hands_remaining = 0
    G.GAME.unik_override_prince = nil
    G.GAME.unik_can_trigger_prince = true
    return ret
end