--The inverse of Chipzel, this time Chips is set to 1!
SMODS.Challenge{
    key = "unik_mult_only",
	rules = {
		custom = {
			{ id = "unik_chips_set_to_one" },
            { id = "unik_chips_ban" }, --just to laconically explain the huge banlist
            { id = "unik_mult_ban2" }, --just to laconically explain the huge banlist
		},
		modifiers = {},
	},
    jokers = {
        { id = "j_popcorn", stickers = {"banana" }, edition = "negative" }, 
        { id = "j_cry_wee_fib", stickers = {"cry_absolute" }},    
        { id = "j_cavendish" },    
	},
	deck = {
		type = "Challenge Deck",
	},
    restrictions = {
        --Ban all solely +chips, xChips and ^chips jokers; they would be worthless against this
        banned_cards = {
            --My cards
            { id = "j_unik_cube_joker" },    
            { id = "j_unik_jsab_chelsea" }, 
            { id = "j_unik_jsab_yokana" }, 
            --{ id = "j_unik_jsab_maya" }, 
            { id = "j_unik_unik" }, 

            --Default jokers
            { id = "j_sly" }, 
            { id = "j_wily" }, 
            { id = "j_clever" }, 
            { id = "j_devious" }, 
            { id = "j_crafty" }, 
            { id = "j_banner" }, 
            { id = "j_scary_face" }, 
            { id = "j_odd_todd" }, 
            { id = "j_runner" }, 
            { id = "j_ice_cream" }, 
            { id = "j_blue_joker" }, 
            { id = "j_hiker" }, 
            { id = "j_square" }, 
            { id = "j_stone" }, 
            { id = "j_castle" }, 
            { id = "j_arrowhead" }, 
            { id = "j_stuntman" }, 
            { id = "j_wee" }, 
            { id = "j_bull" },

            --Cryptid Jokers
            { id = "j_cry_cube" }, 
            { id = "j_cry_big_cube" },
            { id = "j_cry_antennastoheaven" },
            { id = "j_cry_spaceglobe" },
            { id = "j_cry_pirate_dagger"},
            { id = "j_cry_cursor"},
            { id = "j_cry_dubious"},
            { id = "j_cry_shrewd"},
            { id = "j_cry_tricksy"},
            { id = "j_cry_foxy"},
            { id = "j_cry_savvy"},
            { id = "j_cry_subtle"},
            { id = "j_cry_discreet"},
            { id = "j_cry_meteor"},
            { id = "j_cry_shrewd"},
            { id = "j_cry_monkey_dagger"},
            { id= "j_cry_membershipcardtwo"},
            { id= "j_cry_fspinner"},
            { id= "j_cry_nice"},    
            { id= "j_cry_adroit"},    
            { id= "j_cry_penetrating"},    
            { id= "j_cry_treacherous"},    
            { id= "j_cry_clicked_cookie"},  
            { id= "j_cry_bonk"},
            -- --Default consumables
            -- { id = "c_chariot" },
            -- { id = "c_empress" },
            -- { id = "v_observatory" },
            -- { id = "c_cry_seraph" },
        },
        banned_tags = {
            --Disincourage foil and mosaic
            {id = 'tag_foil'},
            --Cryptid 
            {id = 'tag_cry_mosaic'},
        },
        --The trophy would make this unplayable, hence its banned
        banned_other = {
            {id = 'bl_cry_trophy', type = 'blind'},
            
        },
    },

}

for i = 1, #G.CHALLENGES do
    if G.CHALLENGES[i].id == 'c_unik_mult_only' and #G.CHALLENGES[i].restrictions.banned_cards <=47 then

                -- Add buffoonery and extra credit Jokers to banlist
        if (SMODS.Mods["Buffoonery"] or {}).can_load then
            G.CHALLENGES[i].restrictions.banned_cards[#G.CHALLENGES[i].restrictions.banned_cards+1] = {id = 'j_buf_dorkshire_g'}
            G.CHALLENGES[i].restrictions.banned_cards[#G.CHALLENGES[i].restrictions.banned_cards+1] = {id = 'j_buf_dorkshire'}
            G.CHALLENGES[i].restrictions.banned_cards[#G.CHALLENGES[i].restrictions.banned_cards+1] = {id = 'j_buf_korny'}
            G.CHALLENGES[i].restrictions.banned_cards[#G.CHALLENGES[i].restrictions.banned_cards+1] = {id = 'j_buf_clown'}
            G.CHALLENGES[i].restrictions.banned_cards[#G.CHALLENGES[i].restrictions.banned_cards+1] = {id = 'j_buf_porcelainj'}
            G.CHALLENGES[i].restrictions.banned_cards[#G.CHALLENGES[i].restrictions.banned_cards+1] = {id = 'j_buf_patronizing'}
            G.CHALLENGES[i].restrictions.banned_cards[#G.CHALLENGES[i].restrictions.banned_cards+1] = {id = 'c_buf_nobility'}
        end
        if (SMODS.Mods["extracredit"] or {}).can_load then
            G.CHALLENGES[i].restrictions.banned_cards[#G.CHALLENGES[i].restrictions.banned_cards+1] = {id = 'j_ExtraCredit_holdyourbreath'}
            G.CHALLENGES[i].restrictions.banned_cards[#G.CHALLENGES[i].restrictions.banned_cards+1] = {id = 'j_ExtraCredit_handbook'}
            G.CHALLENGES[i].restrictions.banned_cards[#G.CHALLENGES[i].restrictions.banned_cards+1] = {id = 'j_ExtraCredit_rubberducky'}
            G.CHALLENGES[i].restrictions.banned_cards[#G.CHALLENGES[i].restrictions.banned_cards+1] = {id = 'j_ExtraCredit_eclipse'}
            G.CHALLENGES[i].restrictions.banned_cards[#G.CHALLENGES[i].restrictions.banned_cards+1] = {id = 'j_ExtraCredit_plushie'}
            G.CHALLENGES[i].restrictions.banned_cards[#G.CHALLENGES[i].restrictions.banned_cards+1] = {id = 'j_ExtraCredit_badapple'}
            
        end
        if (SMODS.Mods["Neato_Jokers"] or {}).can_load then
            G.CHALLENGES[i].restrictions.banned_cards[#G.CHALLENGES[i].restrictions.banned_cards+1] = {id = 'j_neat_unpaidintern'}
            G.CHALLENGES[i].restrictions.banned_cards[#G.CHALLENGES[i].restrictions.banned_cards+1] = {id = 'j_neat_sparecutoffs'}
            G.CHALLENGES[i].restrictions.banned_cards[#G.CHALLENGES[i].restrictions.banned_cards+1] = {id = 'j_neat_blueyourself'}
        end
        -- When Jen's almanac is updated, also add them
        if (SMODS.Mods["jen"] or {}).can_load then
            
        end
        G.CHALLENGES[i].restrictions.banned_cards[#G.CHALLENGES[i].restrictions.banned_cards+1] = { id = "c_heirophant" }
        G.CHALLENGES[i].restrictions.banned_cards[#G.CHALLENGES[i].restrictions.banned_cards+1] = { id = "c_tower" }
        G.CHALLENGES[i].restrictions.banned_cards[#G.CHALLENGES[i].restrictions.banned_cards+1] = { id = "j_marble" }
    end
end
--Multiplication's effect
local multiChips = mod_chips
function mod_chips(_chips)
    if G.GAME.modifiers.chips_dollar_cap then
      _chips = math.min(_chips, math.max(G.GAME.dollars, 0))
    end
    if G.GAME.modifiers.unik_chips_set_to_one then
        _chips = math.min(_chips, 1)
    end
    return multiChips(_chips)
  end