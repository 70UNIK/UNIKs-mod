--Trinkets and keepstakes:
--one for halving listed probabilities (trinket) and X2 Mult, (blank die)
--pink bow - X3 Chips if all scoring blinds contain purple hue. (YE)
--Cat Hat - First scored faded, yellow or red hue gives X2 Mult, (YE)
--Sundae Hat - First scored purple, blue or green hue gives X2 Mult, (YE)
-- Faerie Tiara - X3 mult if a trinket was destroyed this ante, Trinkets are copied if destroyed (must have room), (YE)
-- Celestial Nightcap - +1 Mult and +8 Chips to Poker hands whenevr they are levelled up. (YE)
-- Cat Biscuit - X2 Mult, destroyed if hand contains red hue (Trinket)
-- Microwave - Destroy 1 selected card anytime (once before cashout) (keepsake) (YE)
-- Antivirus: Create a shield tag for every 2 ritual cards used (trinket)
-- ???: Prevents death, self destructs (keepsake)
-- Tic Tac Toe Board: Create a circles tag when deck is reshuffled (YE)
-- 3D Printer: Copies the effect of the leftmost Trinket
-- pistol: X3 Mult, 1 in 12 chance to play selected blinds when a blind is selected
-- Floppy Disk: Use to Save up to 1 selected shop item, then use it to spawn it in shop (trinket), useful for trinkets, price tags, etc...
-- 

--Monkey Paws: Detrimental trinkets
--The Decision creates 1 negative monkey paw then burns
--

SMODS.Joker({
    key = 'unik_blindside_pink_bow',
    atlas = 'unik_trinkets',
    pos = {x = 1, y = 0},
    rarity = 'bld_keepsake',
    cost = 15,
    blueprint_compat = true,
    eternal_compat = true,
    config = {
            extra = {
                xchips = 3.27,
                min = 4,
            }
        },
    in_pool = function(self, args)
        return UNIK.hasBlindside()
    end,
    loc_vars = function (self, info_queue, card)
            return {
                vars = {
                    card.ability.extra.xchips,
                    card.ability.extra.min,
            }
        }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local purples = 0
            for i,v in pairs(context.scoring_hand) do
                if v:is_color("Purple", true, false) then
                    purples = purples + 1
                end
            end
            if purples >= card.ability.extra.min then
                return {
                    x_chips = card.ability.extra.xchips
                }
            end
            
            
        end
    end
})