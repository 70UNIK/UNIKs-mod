--other jokers that only need value changes and thus dont deserve their own files
--skipping blinds is shite, throwback needs to be X1 to compensate
SMODS.Joker:take_ownership("j_throwback",{
    config = {extra = 1}
},true)
SMODS.Joker:take_ownership("j_tribe",{
    config = {Xmult = 2.5, type = 'Flush'}
},true)
--sixth sense is now bluepritn compat
SMODS.Joker:take_ownership("j_sixth_sense",{
    blueprint_compat = true,
},true)
SMODS.Joker:take_ownership("j_gift",{
    blueprint_compat = true,
},true)

SMODS.Joker:take_ownership("j_gros_michel",{
    loc_vars = function(self, info_queue, center)
        info_queue[#info_queue + 1] = { set = "Other", key = "unik_banishing" }
        local num,denom = SMODS.get_probability_vars(center, 1, center.ability.extra.odds, 'gros_michel')
		return { vars = {center.ability.extra.mult,num,denom} }
	end,
},true)
