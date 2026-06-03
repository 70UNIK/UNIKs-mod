--Trinkets and keepstakes:
--one for halving listed probabilities (trinket) and X2 Mult, (blank die)
--pink bow - X3 Chips if all scoring blinds contain purple hue. (YE)
--Cat Hat - First scored faded, yellow or red hue gives X2 Mult, (YE)
--Sundae Hat - First scored purple, blue or green hue gives X2 Mult,
-- Faerie Tiara - X3 mult if a trinket was destroyed this ante, Trinkets are copied if destroyed (must have room), 
-- Celestial Nightcap - +1 Mult and +8 Chips to Poker hands whenevr they are levelled up. (YE)
-- Cat Biscuit - X2 Mult, destroyed if hand contains red hue (Trinket)
-- Microwave - Destroy 1 selected card anytime (once before cashout) (keepsake)
-- Antivirus: Create a shield tag for every 2 ritual cards used (trinket)
-- Mountain Boots: Create a summit card whenever deck is reshuffled
-- ???: Prevents death, self destructs (keepsake)
-- Tic Tac Toe Board: Create a circles tag when blind is reshuffled
-- 3D Printer: Copies the effect of the leftmost Trinket

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
                xchips = 3.17,
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
            local success = true
            if #context.scoring_hand >= card.ability.extra.min then
                for i,v in pairs(context.full_hand) do
                    if not v:is_color("Purple") then
                        success = false
                        break
                    end
                end
                if success then
                    return {
                        xchips = card.ability.extra.xchips
                    }
                end
            end
            
            
        end
    end
})