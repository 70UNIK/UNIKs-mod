SMODS.Back {
    key = 'unik_greed',
    atlas = 'unik_decks',
    pos = { x = 1, y = 1 },
    config = {extra_hand_bonus = 0, extra_discard_bonus = 0, no_interest = true,extra = {lost_hand_bonus = 2, lost_discard_bonus = 1}},
    order = 15,

    loc_vars = function(self, info_queue, card)
      return {
        vars = {
            self.config.extra.lost_hand_bonus,self.config.extra.lost_discard_bonus
        }
      }
    end,
    calculate = function(self, card, context)
        if not context.blueprint and not context.retrigger_joker and not context.repetition and (context.hand_mod and context.hand_mod_val < 0) then
            return {
                dollars = card.effect.config.extra.lost_hand_bonus * math.abs(context.hand_mod_val)
            }
        end
        if not context.blueprint and not context.retrigger_joker and not context.repetition and (context.discard_mod and context.discard_mod_val < 0) then
            return {
                dollars = card.effect.config.extra.lost_discard_bonus * math.abs(context.discard_mod_val)
            }
        end
    end
}