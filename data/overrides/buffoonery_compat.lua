--Various buffoonery fixes.

--Overriding buffoonery's stakes so it works with vice_squeeze and comes after shitty stake and before pink stake
SMODS.Stake:take_ownership('stake_buf_spinel', {
    unlocked_stake = 'cry_pink',
})
SMODS.Stake:take_ownership('cry_pink', {
    applied_stakes = { "buf_spinel" },
    above_stake = "buf_spinel",
    prefix_config = { above_stake = {mod = false}, applied_stakes = {mod = false} },
})

SMODS.Stake:take_ownership('stake_buf_palladium', {
        applied_stakes = {"unik_shitty"},
    above_stake = "unik_shitty",
    prefix_config = {above_stake = {mod = false}, applied_stakes = {mod = false}},
    modifiers = function()
		G.GAME.modifiers.buf_halfstep_bosses = true --dummy variable
        G.GAME.unik_vice_squeeze = 2
    end,
})
--The must win at ante 10 stake becomes ANTE 16 HAHAHAHAHAHAHHAHAHAHAHAHAHAH!!! 

-- SMODS.Stake:take_ownership('stake_unik_shitty', {
--     unlocked_stake = 'buf_palladium',
-- })

--increase win ante by 1.25X
SMODS.Stake:take_ownership('stake_cry_diamond', {
    modifiers = function()
		G.GAME.win_ante = math.ceil(G.GAME.win_ante * 1.25)
	end,
})

--Rejected fan becomes cursed Joker.
SMODS.Joker:take_ownership('j_buf_afan_spc', {
    rarity = 'cry_cursed',
},true)
