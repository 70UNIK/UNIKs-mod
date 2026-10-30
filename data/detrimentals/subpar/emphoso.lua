--Face cards give -4 Mult, self destructs after holding at least 7 face cards when playing a hand
UNIK.detriment{
    key = "unik_emphoso",
    atlas = "unik_detriments",
	pos = { x = 0, y = 6 },
    config = { extra = { mult = -4, face_cards = 7} }, --why emult? 
    severity = 1,
    immutable = true,
    dongtong_compat = false,
    blueprint_compat = true,
    attributes = { 'detrimental','mult','face','detriment'},
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult,card.ability.extra.face_cards} }
	end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and context.other_card:is_face() then
            return {
                mult = card.ability.extra.mult
            }
        end
        if context.end_of_round and context.cardarea == G.unik_detriment_area and not context.blueprint then
            local faces = 0
            for i,v in pairs(G.hand.cards) do
                local id = v:get_id()
                if id == 11 or id == 12 or id == 13 then
                    faces = faces + 1
                end
            end
            if faces >= card.ability.extra.face_cards then
                 selfDestruction(card,"k_unik_melted",G.C.BLACK)
            end
        end
    end,
}