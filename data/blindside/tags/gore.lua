--each hand banishes the leftmost owned Trinket
SMODS.Tag {
    key = "unik_blindside_gore",
    hide_ability = false,
    atlas = 'unik_tags',
    pos = {x = 6, y = 5},
    pools = {["bld_obj_blindside"] = true},
    config = {chancefail = 1, chance = 2,
        extra = {
            hex = true,
        }
    },
    in_pool = function(self, args)
        return false
    end,
    loc_vars = function(self, info_queue,tag)
        info_queue[#info_queue + 1] = { set = "Other", key = "unik_banishing" }
	end,
    apply = function(self, tag, context)
        if context.type == 'shop_start' and not (next(SMODS.find_card("j_bld_taglock")) and not (G.GAME.blind.boss or G.GAME.last_joker)) then
            tag:yep('+', G.C.SUITS["unik_Noughts"], function() 
                return true end)
            tag.triggered = true
        end
        if context.type == 'unik_before_play' then
            if G.jokers and G.jokers.cards and #G.jokers.cards > 0 then
                local neck_banish =  G.jokers.cards[1]
                --neck_banish.banished_by_goblin = true
                tag:juice_up(3,3)
                neck_banish:gore6_break()
                if not G.GAME.banned_keys then
                G.GAME.banned_keys = {}
                end
                if not G.GAME.cry_banished_keys then
                    G.GAME.cry_banished_keys = {}
                end
                G.GAME.cry_banished_keys[neck_banish.config.center.key] = true
               
            end
        end
    end,
}