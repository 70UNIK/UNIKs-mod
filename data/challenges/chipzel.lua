SMODS.Challenge{
    key = "unik_chips_only",
	rules = {
		custom = {
			{ id = "unik_mult_set_to_one" },
            { id = "unik_mult_ban" }, --just to laconically explain the huge banlist
            { id = "unik_mult_ban2" }, --just to laconically explain the huge banlist
		},
		modifiers = {},
	},
    jokers = {
        { id = "j_unik_jsab_chelsea", stickers = {"cry_absolute" }},
	},
	deck = {
		type = "Challenge Deck",
	},
    restrictions = {
        --Ban all solely +mult, xMult and ^Mult jokers; they would be worthless against this
        --Also ban all jokers that generate Jolly Jokers, jolly jokers would be worthless
        banned_cards = {
            --My cards
            { id = "j_unik_moonlight_cookie" },    
            { id = "j_unik_riif_roof" }, 
            --Cryptid cards
            --Commented out = removed
            { id = "j_cry_apjoker"},
            { id = "j_cry_astral_bottle"},
            { id = "j_cry_biggestm"},     
            { id = "j_cry_bonkers"},  
            { id = "j_cry_bubblem"}, 
            { id = "j_cry_busdriver"}, 
            { id = "j_cry_caramel"},
            { id = "j_cry_chili_pepper"},  
            { id = "j_cry_circus"}, 
            { id = "j_cry_clash"}, 
            { id = "j_cry_cut"},
            { id = "j_cry_curse_sob"}, 
            { id = "j_cry_delirious"},
            { id = "j_cry_discreet"}, 
            { id = "j_cry_doodlem"}, 
            { id = "j_cry_dropshot"}, 
            { id = "j_cry_duos"}, 
            { id = "j_cry_duplicare"}, 
            { id = "j_cry_equilib"}, 
            { id = "j_cry_eternalflame"}, 
            { id = "j_cry_exoplanet"}, 
            { id = "j_cry_exponentia"},
            { id = "j_cry_facile"},
            { id = "j_cry_filler"},
            { id = "j_cry_foodm"}, 
            { id = "j_cry_foolhardy"},
            { id = "j_cry_fuckedup"},
            { id = "j_cry_giggly"},
            { id = "j_cry_googol_play"},
            { id = "j_cry_happyhouse"},
            { id = "j_cry_home"},
            { id = "j_cry_jimball"},
            { id = "j_cry_jollysus"},
            { id = "j_cry_kooky"},
            { id = "j_cry_krustytheclown"},
            { id = "j_cry_kscope"},
            { id = "j_cry_lightupthenight"},
            { id = "j_cry_longboi"},
            { id = "j_cry_loopy"},
            -- { id = "j_cry_luigi"},
            { id = "j_cry_m"},
            { id = "j_cry_M"},
            { id = "j_cry_macabre"},
            { id = "j_cry_manic"},
            { id = "j_cry_Megg"},
            { id = "j_cry_membershipcard"},
            { id = "j_cry_mondrian"},
            { id = "j_cry_mprime"},
            { id = "j_cry_mstack"},
            { id = "j_cry_night"},
            { id = "j_cry_nuts"},
            { id = "j_cry_nutty"},
            { id = "j_cry_primus"},
            { id = "j_cry_python"},
            { id = "j_cry_quintet"},
            { id = "j_cry_reverse"},
            { id = "j_cry_sacrifice"},
            { id = "j_cry_silly"},
            { id = "j_cry_smallestm"},
            { id = "j_cry_stardust"},
            { id = "j_cry_stella_mortis"},
            { id = "j_cry_stronghold"},
            { id = "j_cry_swarm"},
            { id = "j_cry_sync_catalyst"},
            { id = "j_cry_triplet_rhythm"},
            { id = "j_cry_unity"},
            { id = "j_cry_universe"},
            { id = "j_cry_unjust_dagger"},
            -- { id = "j_cry_verisimile"},
            { id = "j_cry_virgo"},
            { id = "j_cry_wacky"},
            { id = "j_cry_waluigi"},
            { id = "j_cry_wee_fib"},
            { id = "j_cry_wheelhope"},
            { id = "j_cry_whip"},
            { id = "j_cry_wtf"},
            { id = "j_cry_zooble"},
            
            --Default jokers
            { id = "j_joker" },
            { id = "j_abstract" },
            { id = "j_acrobat" },
            { id = "j_ancient" },
            { id = "j_baron" },
            { id = "j_baseball" },
            { id = "j_blackboard" },
            { id = "j_bloodstone" },
            { id = "j_bootstraps" },
            { id = "j_caino" },
            { id = "j_campfire" },
            { id = "j_card_sharp" },
            { id = "j_cavendish" },
            { id = "j_ceremonial" },
            { id = "j_constellation" },
            { id = "j_crazy" },
            { id = "j_drivers_license" },
            { id = "j_droll" },
            { id = "j_duo" },
            { id = "j_erosion" },
            { id = "j_even_steven" },
            { id = "j_family" },
            { id = "j_fibonacci" },
            { id = "j_flash" },
            { id = "j_flower_pot" },
            { id = "j_fortune_teller" },
            { id = "j_glass" },
            { id = "j_gluttenous_joker" },
            { id = "j_greedy_joker" },
            { id = "j_green_joker" },
            { id = "j_gros_michel" },
            { id = "j_half" },
            { id = "j_hit_the_road" },
            { id = "j_hologram" },
            { id = "j_idol" },
            { id = "j_jolly" },
            { id = "j_loyalty_card" },
            { id = "j_lucky_cat" },
            { id = "j_lusty_joker" },
            { id = "j_mad" },
            { id = "j_madness" },
            { id = "j_misprint" },
            { id = "j_mystic_summit" },
            { id = "j_obelisk" },
            { id = "j_odd_todd" },
            { id = "j_onyx_agate" },
            { id = "j_order" },
            { id = "j_photograph" },
            { id = "j_popcorn" },
            { id = "j_raised_fist" },
            { id = "j_ramen" },
            { id = "j_red_card" },
            { id = "j_ride_the_bus" },
            { id = "j_seeing_double" },
            { id = "j_shoot_the_moon" },
            { id = "j_smiley" },
            { id = "j_steel_joker" },
            { id = "j_stencil" },
            { id = "j_supernova" },
            { id = "j_swashbuckler" },
            { id = "j_throwback" },
            { id = "j_tribe" },
            { id = "j_triboulet" },
            { id = "j_trio" },
            { id = "j_trousers" },
            { id = "j_vampire" },
            { id = "j_wrathful_joker" },
            { id = "j_yorick" },
            { id = "j_zany" },  

            -- --Default consumables
            -- { id = "c_justice" },
            -- { id = "c_chariot" },
            -- { id = "c_empress" },
            -- { id = "v_observatory" },
            -- { id = "c_cry_seraph" },
        },
        banned_tags = {
            --Disincourage holgraphic, polychrome, astral, fragile, jolly 
            {id = 'tag_holo'},
            {id = 'tag_polychrome'},
            --Cryptid 
            {id = 'tag_cry_astral'},
            {id = 'tag_cry_banana'},
            {id = 'tag_cry_double_m'},
            {id = 'tag_cry_glass'},
            {id = 'tag_cry_m'},
            {id = 'tag_cry_double_m'},
        },
        --The trophy would be an absolute joke, hence its disabled 
        banned_other = {
            {id = 'bl_cry_trophy', type = 'blind'},
            
        },
    },

}
for i = 1, #G.CHALLENGES do
    if G.CHALLENGES[i].id == 'c_unik_chips_only' and #G.CHALLENGES[i].restrictions.banned_cards <=146 then

        G.CHALLENGES[i].restrictions.banned_cards[#G.CHALLENGES[i].restrictions.banned_cards+1] = {id = 'j_unik_recycler'}
        G.CHALLENGES[i].restrictions.banned_cards[#G.CHALLENGES[i].restrictions.banned_cards+1] = {id = 'j_unik_ghost_trap'}
                -- Add buffoonery and extra credit Jokers to banlist
        if (SMODS.Mods["Buffoonery"] or {}).can_load then
            G.CHALLENGES[i].restrictions.banned_cards[#G.CHALLENGES[i].restrictions.banned_cards+1] = {id = 'j_buf_laidback'}
            G.CHALLENGES[i].restrictions.banned_cards[#G.CHALLENGES[i].restrictions.banned_cards+1] = {id = 'j_buf_fivefingers'}
            G.CHALLENGES[i].restrictions.banned_cards[#G.CHALLENGES[i].restrictions.banned_cards+1] = {id = 'j_buf_afan'}
            G.CHALLENGES[i].restrictions.banned_cards[#G.CHALLENGES[i].restrictions.banned_cards+1] = {id = 'j_buf_whitepony'}
            G.CHALLENGES[i].restrictions.banned_cards[#G.CHALLENGES[i].restrictions.banned_cards+1] = {id = 'j_buf_blackstallion'}
            G.CHALLENGES[i].restrictions.banned_cards[#G.CHALLENGES[i].restrictions.banned_cards+1] = {id = 'j_buf_kerman'}
            G.CHALLENGES[i].restrictions.banned_cards[#G.CHALLENGES[i].restrictions.banned_cards+1] = {id = 'j_buf_maggit'}
            --G.CHALLENGES[i].restrictions.banned_cards[#G.CHALLENGES[i].restrictions.banned_cards+1] = {id = 'j_buf_maggit_alt'}
            G.CHALLENGES[i].restrictions.banned_cards[#G.CHALLENGES[i].restrictions.banned_cards+1] = {id = 'j_buf_camarosa'}
        end
        if (SMODS.Mods["extracredit"] or {}).can_load then
            G.CHALLENGES[i].restrictions.banned_cards[#G.CHALLENGES[i].restrictions.banned_cards+1] = {id = 'j_ExtraCredit_shipoftheseus'}
            G.CHALLENGES[i].restrictions.banned_cards[#G.CHALLENGES[i].restrictions.banned_cards+1] = {id = 'j_ExtraCredit_clowncar'}
            G.CHALLENGES[i].restrictions.banned_cards[#G.CHALLENGES[i].restrictions.banned_cards+1] = {id = 'j_ExtraCredit_pridefuljoker'}
            G.CHALLENGES[i].restrictions.banned_cards[#G.CHALLENGES[i].restrictions.banned_cards+1] = {id = 'j_ExtraCredit_corgi'}
            G.CHALLENGES[i].restrictions.banned_cards[#G.CHALLENGES[i].restrictions.banned_cards+1] = {id = 'j_ExtraCredit_trafficlight'}
            G.CHALLENGES[i].restrictions.banned_cards[#G.CHALLENGES[i].restrictions.banned_cards+1] = {id = 'j_ExtraCredit_tengallon'}
            G.CHALLENGES[i].restrictions.banned_cards[#G.CHALLENGES[i].restrictions.banned_cards+1] = {id = 'j_ExtraCredit_turtle'}
            G.CHALLENGES[i].restrictions.banned_cards[#G.CHALLENGES[i].restrictions.banned_cards+1] = {id = 'j_ExtraCredit_compost'}
            G.CHALLENGES[i].restrictions.banned_cards[#G.CHALLENGES[i].restrictions.banned_cards+1] = {id = 'j_ExtraCredit_pyromancer'}
            G.CHALLENGES[i].restrictions.banned_cards[#G.CHALLENGES[i].restrictions.banned_cards+1] = {id = 'j_ExtraCredit_blackjack'}
            G.CHALLENGES[i].restrictions.banned_cards[#G.CHALLENGES[i].restrictions.banned_cards+1] = {id = 'j_ExtraCredit_averagealice'}
            G.CHALLENGES[i].restrictions.banned_cards[#G.CHALLENGES[i].restrictions.banned_cards+1] = {id = 'j_ExtraCredit_chainlightning'}
            G.CHALLENGES[i].restrictions.banned_cards[#G.CHALLENGES[i].restrictions.banned_cards+1] = {id = 'j_ExtraCredit_jokalisa'}
        end
        -- When Jen's almanac is updated, also add them
        if (SMODS.Mods["jen"] or {}).can_load then
            
        end
        -- Add justice, chariot, express, observatory and light cards to the list

        G.CHALLENGES[i].restrictions.banned_cards[#G.CHALLENGES[i].restrictions.banned_cards+1] = {id = 'c_justice'}
        G.CHALLENGES[i].restrictions.banned_cards[#G.CHALLENGES[i].restrictions.banned_cards+1] = {id = 'c_empress'}
        G.CHALLENGES[i].restrictions.banned_cards[#G.CHALLENGES[i].restrictions.banned_cards+1] = {id = 'c_chariot'}
        G.CHALLENGES[i].restrictions.banned_cards[#G.CHALLENGES[i].restrictions.banned_cards+1] = {id = 'v_observatory'}
        G.CHALLENGES[i].restrictions.banned_cards[#G.CHALLENGES[i].restrictions.banned_cards+1] = {id = 'c_cry_seraph'}
    --Ban Pirahna plant from Mad World
    elseif G.CHALLENGES[i].id == 'c_mad_world_1' and #G.CHALLENGES[i].restrictions.banned_cards <=0 then
        G.CHALLENGES[i].restrictions.banned_cards[#G.CHALLENGES[i].restrictions.banned_cards+1] = {id = 'j_unik_the_plant'}
    --Ban Persimmon PLacard and batman
    elseif G.CHALLENGES[i].id == 'c_jokerless_1' and #G.CHALLENGES[i].restrictions.banned_other <= 3 then
        G.CHALLENGES[i].restrictions.banned_other[#G.CHALLENGES[i].restrictions.banned_other+1] = {id = 'bl_unik_persimmon_placard',type='blind'}
        G.CHALLENGES[i].restrictions.banned_other[#G.CHALLENGES[i].restrictions.banned_other+1] = {id = 'bl_unik_black_bat',type='blind'}
        G.CHALLENGES[i].restrictions.banned_other[#G.CHALLENGES[i].restrictions.banned_other+1] = {id = 'bl_unik_bigger_boo',type='blind'}
    --ban collapse in jimball
    elseif G.CHALLENGES[i].id == 'c_cry_ballin' and #G.CHALLENGES[i].restrictions.banned_other <= 0 then
        G.CHALLENGES[i].restrictions.banned_other[#G.CHALLENGES[i].restrictions.banned_other+1] = {id = 'bl_unik_collapse',type='blind'}
    end


end

-- Chipzel's effect
local chipzel_mod_mult = mod_mult
function mod_mult(_mult)
	hand_chips = hand_chips or 0
    --Trophy effect first
	if G.GAME.trophymod then
		_mult = math.min(_mult, math.max(hand_chips, 0))
	end
    --Then chipzel's effect
    if G.GAME.modifiers.unik_mult_set_to_one then
        _mult = math.min(_mult, 1)
    end
	return chipzel_mod_mult(_mult)
end
