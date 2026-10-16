--+4 joker slots, final boss blinds appear every 4 antes, must win at ante 16
SMODS.Back {
    key = 'unik_endless',
    atlas = 'unik_decks',
    pos = { x = 0, y = 1 },
    config = {joker_slot = 3,extra = {ante_multiplier = 1.5,finisher_multiplier = 2},dollars = 2},
    order = 15,

    loc_vars = function(self, info_queue,card)
    local ante = 8 * self.config.extra.ante_multiplier
        return {
            vars = {
            self.config.joker_slot,ante,self.config.extra.finisher_multiplier,0,self.config.dollars
            }
        }
    end,
    apply = function(self, back)
        -- G.GAME.unik_vice_squeeze = G.GAME.unik_vice_squeeze * back.effect.config.extra.finisher_multiplier
        G.GAME.win_ante = math.ceil(G.GAME.win_ante * back.effect.config.extra.ante_multiplier)
         G.E_MANAGER:add_event(Event({
            func = function()
                ease_ante(-1)
                G.GAME.round_resets.blind_ante = G.GAME.round_resets.blind_ante or G.GAME.round_resets.ante
                G.GAME.round_resets.blind_ante = G.GAME.round_resets.blind_ante - 1
                return true
            end
        }))
        
    end,
    locked_loc_vars = function(self,args)
        return {
            vars = {
                localize { type = 'name_text', set = 'Stake', key = 'stake_gold' },14,
                colours = { get_stake_col(8) }
            }
        }
    end,
    check_for_unlock = function(self, args)
        return args.type == 'ante_up' and args.ante == 14 and get_deck_win_stake() >= 8
    end,
    unlocked = false,
}