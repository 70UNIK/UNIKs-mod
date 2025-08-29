SMODS.Joker {
    key = 'unik_yes_nothing',
    atlas = 'unik_uncommon',
    rarity = 1, --Abstract cards make this rare now.
    -- The wheel
    -- Turquoise tornado
    -- Maroon Magnet (unik)
    -- Coupon codes (dont redeem another) (unik)
    -- Cavendish
    -- glass cards breaking
    --banana stickers
    -- evocation (unik)
    -- demon tag (unik)
    -- disposable/niko consumeables (unik)
    -- broken arm (modest only) (unik)
    -- Ghost (albeit being unable to break)
    -- Monopoly money
    -- old blueprint breaking
    -- critical misses
    -- chocolate die's flickering chance
    -- chocolate die's lunar abyss
    -- chocolate die's bloodsucker
    -- (maybe in the future also abstracted cards breaking)
    -- its likely uncommon for now
	pos = { x = 2, y = 0 },
    cost = 4,
    blueprint_compat = false,
    perishable_compat = true,
	eternal_compat = true,
    immutable = true,
    loc_vars = function(self, info_queue, center)
	end,
    calculate = function(self, card, context)
        if context.fix_probability then
            return {
                numerator = 0,
            }
        end
    end
}