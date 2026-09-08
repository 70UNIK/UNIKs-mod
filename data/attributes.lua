--copper cards, blossom, reggie, as well as sundae cookie recently
SMODS.Attribute {
    key = 'rescore'
}
-- despot, white lily
SMODS.Attribute {
    key = 'emult'
}
--ME!
SMODS.Attribute {
    key = 'echips'
}

SMODS.Attribute {
    key = 'xlogchips'
}
SMODS.Attribute {
    key = 'xlogmult'
}
--sticker interacting jokers
SMODS.Attribute {
    key = 'stickers'
}
--stuff involving permanently removing stuff from the pool (gros micael and d16 self banish, expel and lockpick banishes)
SMODS.Attribute {
    key = 'banishing'
}
--noughts suit stuff
SMODS.Attribute {
    key = 'unik_noughts'
}
--crosses suit stuff
SMODS.Attribute {
    key = 'unik_crosses'
}

SMODS.Attribute {
    key = 'eblindsize'
}

SMODS.Attribute {
    key = 'unik_summit_card'
}
--no standign zone, clock (cryptid)
SMODS.Attribute {
    key = 'time_based'
}

SMODS.Attribute {
    key = 'unik_ancient'
}

SMODS.Attribute {
    key = 'detrimental'
}

function UNIK.is_mult_joker(center)
    if SMODS.has_attribute(center, "mult") or SMODS.has_attribute(center, "xmult") or SMODS.has_attribute(center, "xlogmult") 
    or SMODS.has_attribute(center, "emult") or SMODS.has_attribute(center, "eemult") or SMODS.has_attribute(center, "eeemult") 
    or SMODS.has_attribute(center, "hypermult") or SMODS.has_attribute(center, "eqmult")
    then
        return true
    end
end

function UNIK.is_chips_joker(center)
    if SMODS.has_attribute(center, "chips") or SMODS.has_attribute(center, "xchips") or SMODS.has_attribute(center, "xlogchips") 
    or SMODS.has_attribute(center, "echips") or SMODS.has_attribute(center, "eechips") or SMODS.has_attribute(center, "eeechips") 
    or SMODS.has_attribute(center, "hyperchips") or SMODS.has_attribute(center, "eqchips")
    then
        return true
    end
end