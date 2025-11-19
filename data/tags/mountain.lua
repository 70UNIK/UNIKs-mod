SMODS.Tag{
    key = 'unik_mountain',
    loc_vars = function(self, info_queue)
        info_queue[#info_queue + 1] = {key = 'p_unik_summit_3', set = 'Other', vars = {G.P_CENTERS.p_unik_summit_3.config.choose, G.P_CENTERS.p_unik_summit_3.config.extra}}
        return {}
    end,

    config = {type = 'new_blind_choice'},

    apply = function(self, tag, context)
        if context.type == self.config.type then
            G.CONTROLLER.locks[tag.ID] = true
            tag:yep('+', G.C.UNIK_SUMMIT, function()
                local key = 'p_unik_summit_3'
                local card = Card(G.play.T.x + G.play.T.w/2 - G.CARD_W*1.27/2,
                G.play.T.y + G.play.T.h/2-G.CARD_H*1.27/2, G.CARD_W*1.27, G.CARD_H*1.27, G.P_CARDS.empty, G.P_CENTERS[key], {bypass_discovery_center = true, bypass_discovery_ui = true})
                card.cost = 0
                card.from_tag = true
                G.FUNCS.use_card({config = {ref_table = card}})
                card:start_materialize()
                G.CONTROLLER.locks[tag.ID] = nil
                return true
            end)
            tag.triggered = true
            return true
        end
    end,

    pos = { x = 2, y = 4 },
    atlas = 'unik_tags',
}