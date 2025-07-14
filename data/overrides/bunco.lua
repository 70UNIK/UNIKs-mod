--Bunco fixes
--stake fix
SMODS.Stake:take_ownership('stake_bunc_cyan', {
    unlocked_stake = 'bunc_pink',
    applied_stakes = {'unik_persimmon'},
    above_stake = 'unik_persimmon',
    order = 2,
})

SMODS.Stake:take_ownership('stake_bunc_pink', {
    unlocked_stake = 'bunc_pink',
    applied_stakes = {'bunc_cyan'},
    above_stake = 'bunc_cyan',
    order = 3,
    prefix_config = {above_stake = {mod = false}, applied_stakes = {mod = false}},
})

SMODS.Stake:take_ownership('stake_bunc_magenta', {
    unlocked_stake = 'gold',
    applied_stakes = {'bunc_pink'},
    above_stake = 'bunc_pink',
    order = 4,
    prefix_config = {above_stake = {mod = false}, applied_stakes = {mod = false}},
})

print("DO IT")