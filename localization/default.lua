return {
    descriptions = {
        Back={},
        Blind={
            bl_unik_purple_pentagram={
                name = "Purple Pentagram",
				text = {
					"Create 5 Cursed Jokers",
                    "on Blind Selection",
				},
            },
            bl_unik_indigo_icbm={
                name = "Indigo ICBM",
				text = {
					"If score is >3X requirements,",
                    "cause instant death",
				},
            },
            bl_unik_harlequin_hurricane={
                name = "Harlequin Hurricane",
				text = {
					"#1# in #2# chance for",
					"played hand to be negative,",
				},
            },
            bl_unik_persimmon_placard={
                name = "Persimmon Placard",
				text = {
					"All cards are debuffed",
				},
            },
            bl_unik_black_bat={
                name = "Black Bat",
				text = {
					"All Jokers are debuffed",
				},
            },
            bl_unik_bigger_boo={
                name = "Bigger Boo",
				text = {
					"Create an eternal Ghost",
                    "on Blind Selection",
                    "and before each hand",
                    "convert Jokers adjacent",
                    "to each Ghost into Ghosts",
				},
            },
            bl_unik_raspberry_racket={
                name = "Raspberry Racket",
				text = {
					"Spend $#1# before",
                    "each hand,",
                    "if entering debt",
                    "hand will not score",
				},
            },
            bl_unik_white_wire={
                name = "White Wire",
				text = {
					"Play 1 hand with",
                    "no discards and",
                    "all discard and hand",
                    "modifiers debuffed",
				},
            },
            bl_unik_the_lily={
                name = "The Lily",
				text = {
					"Destroy all played cards,",
                    "+0.04x blind size for",
                    "each destroyed card",
				},
            },
            bl_unik_the_replay={
                name = "The Replay",
				text = {
					"Repeats the previous",
                    "defeated blind",
				},
            },
            bl_unik_the_petard={
                name = "The Petard",
				text = {
					"Disabling this blind",
                    "causes instant death",
				},
            },
            bl_unik_the_jollyless={
                name = "The Jollyless",
				text = {
					"All M Jokers and Jolly",
                    "Cards are debuffed",
				},
            },
            bl_unik_the_poppy={
                name = "The Poppy",
				text = {
					"Played hands exceeding",
                    "2X requirements will",
                    "not score",
				},
            },
            bl_unik_the_wind={
                name = "The Wind",
				text = {
					"Each played card has",
					"a #1# in #2# chance",
                    "to be debuffed before scoring",
				},
            },
            bl_unik_the_gale={
                name = "The Gale",
				text = {
					"#1# in #2# chance for",
					"played hand to not score",
				},
            }
        },
        Edition={            
            e_unik_positive={
                name="Positive",
                text={
                    "{C:red}#1#{} Joker slot",
                },
            },
            e_unik_positive_consumable={
                name="Positive",
                text={
                    "{C:red}#1#{} consumable slot",
                },
            },
            e_unik_positive_playing_card={
                name="Positive",
                text={
                    "{C:red}#1#{} hand size",
                },
            },
        },
        Enhanced={},
        Joker={
            j_unik_lucky_seven = {
                name = 'Lucky 7',
                text = {
                    "{C:attention}Each played 7{} has a", 
                    "{C:green}#1# in #3#{} chance",
                    "for {C:mult}+#2#{} Mult and a",
                    "{C:green}#1# in #5#{} chance",
                    "to win {C:money}$#4#",
                }
            },
            j_unik_yes_nothing = {
                name = 'Yes! Nothing*',
                text={
                    "Multiplies all {C:attention}listed{}",
                    "{C:green,E:1,S:1.1}probabilities{} by {C:green}1e-100{}",
                    "{C:inactive,s:0.6}(As low as possible to 0){}",
                    "{C:inactive}(ex: {C:green}2 in 3{C:inactive} -> {C:green}~0 in 3{C:inactive})",
                },
            },
            j_unik_711 = {
                name = '7/11',
                text = {
                    "Once per round, if hand contains", 
                    "a scoring {C:attention}7{} and {C:attention}Ace{},",
                    "create a {C:attention}random{} Food Joker",
                    "{C:inactive}(Can overflow){}",
                }
            },
            j_unik_riif_roof = {
                name = 'Riif-Roof',
                text={
                    "{C:blue}Common{} Jokers",
                    "each give {X:mult,C:white} X#1# {} Mult",
                    "{C:inactive,s:0.7}ROOF! ROOF!{}",
                },
            },
            j_unik_happiness = {
                name = 'Happiness is Mandatory',
                text = {
                    "On spawn, turn the {C:attention}leftmost{} Joker", 
                    "and {C:attention}all{} equipped consumables {C:unik_shitty_edition}Positive{}", 
                    "Each hand played creates a",
                    "{C:unik_shitty_edition}Positive{} {C:attention}Eternal Banana Smiley Face{}",
                    "and turns the {C:attention} leftmost{} played card {C:unik_shitty_edition}Positive{}", 
                    "{C:red}Self destructs{} after maximum Joker slots becomes {C:attention}#1#{}" ,
                    "{C:red}On destruction{}, remove {C:attention}Eternal{} from {C:attention}all Smiley Faces.{}" ,
                    "{C:inactive,s:0.7}Happiness is mandatory. Failure to be happy is treason.{}",
                }
            },
            j_unik_the_plant = {
                name = 'Piranha Plant',
                text = {
                    "{C:attention}All face cards{} are {C:red}debuffed{}", 
                    "{C:red}Self destructs{} when {C:attention}no{} face", 
                    "cards remain in deck or",
                    "{C:unik_plant_color}The Plant{} is triggered",
                    "{C:inactive,s:0.9}Grawr Charble Grawr!{}",
                    "{C:dark_edition,s:0.6,E:2}Face art by : 70UNIK{}",
                    "{C:cry_exotic,s:0.6,E:2}Origin : Super Mario Bros.{}",
                }                
            },
            j_unik_handcuffs = {
                name = 'Handcuffs',
                text={
                    "{C:red}#2#{} hand size",
                    "{C:red}Self destructs{} when hand", 
                    "size is {C:attention}above #3#{}, {C:attention}below #4#{} or",
                    "{C:unik_manacle_color}The Manacle{} is triggered",                    
                },                 
            },
            j_unik_border_wall = {
                name = 'Border Wall',
                text={
                    "{C:red}#2#x{} Blind size",
                    "{C:red}Self destructs{} when scoring", 
                    "{C:attention}#3#x{} Blind requirements or",
                    "{C:unik_wall_color}The Wall{} is triggered",                    
                },                 
            },
            j_unik_goading_joker = {
                name = 'Goading Joker',
                text={
                    "{C:attention}All Spade cards{} are {C:red}debuffed{}", 
                    "{C:red}Self destructs{} when number of Spade", 
                    "cards in deck fall below {C:attention}#2#{} or",
                    "{C:unik_goad_color}The Goad{} is triggered",      
                    "{C:inactive}(Currently #1# Spade(s))",
                },                 
            },
            j_unik_headless_joker = {
                name = 'Headless Joker',
                text={
                    "{C:attention}All Heart cards{} are {C:red}debuffed{}", 
                    "{C:red}Self destructs{} when number of Heart", 
                    "cards in deck fall below {C:attention}#2#{} or",
                    "{C:unik_head_color}The Head{} is triggered",      
                    "{C:inactive}(Currently #1# Hearts(s))",
                },                 
            },
            j_unik_broken_window = {
                name = 'Broken Window',
                text={
                    "{C:attention}All Diamond cards{} are {C:red}debuffed{}", 
                    "{C:red}Self destructs{} when number of Diamond", 
                    "cards in deck fall below {C:attention}#2#{} or",
                    "{C:unik_window_color}The Window{} is triggered",      
                    "{C:inactive}(Currently #1# Diamonds(s))",
                },                 
            },
            j_unik_caveman_club = {
                name = 'Caveman Club',
                text={
                    "{C:attention}All Club cards{} are {C:red}debuffed{}", 
                    "{C:red}Self destructs{} when number of Club", 
                    "cards in deck fall below {C:attention}#2#{} or",
                    "{C:unik_club_color}The Club{} is triggered",      
                    "{C:inactive}(Currently #1# Clubs(s))",
                },                 
            },
            --Basically instead of being "eaten", popcorn and ice cream become negative, ramen becomes < 1.0X, Turtle bean reduces hand size.
            -- Right now it only supports those 4, since they self destruct at a certain value (1 or 0)
            j_unik_autocannibalism = {
                name = 'Autocannibalism',
                text={
                    "Create an {C:attention}Eternal Depleted{}", 
                    "{C:attention}Popcorn, Ramen, Ice Cream or Turtle Bean{}", 
                    "Add {C:attention}Eternal and Depleted{} to all new and existing",
                    "{C:attention}Popcorn, Ramen, Ice Cream and Turtle Beans{}",      
                    "{C:red}Self destructs{} if none of above Jokers are owned",
                },                 
            },
            j_unik_moonlight_cookie = {
                name = 'Moonlight Cookie',
                text = {
                    "{C:planet}Planet{} cards {C:attention}in your consumable area{}", 
                    "each give {X:dark_edition,C:white}^#1#{} Mult",
                    "{C:inactive,s:0.9}May I wish you happy dreams...{}",
                    "{C:dark_edition,s:0.6,E:2}Face art by : 70UNIK{}",
                    "{C:cry_exotic,s:0.6,E:2}Origin : Cookie Run{}",
                }
            },
            j_unik_unik = {
                name = 'UNIK',
                text = {
                    "This Joker gains {X:dark_edition,C:white}^#1#{} Chips", 
                    "for each {C:attention}7{} scored",
                    "{C:inactive}(Currently {X:dark_edition,C:white}^#2#{C:inactive} Chips)",
                    "{C:inactive,s:0.9}I basically just inserted myself here.{}",
                    "{C:dark_edition,s:0.6,E:2}Character and face art by : 70UNIK{}",
                    "{C:cry_exotic,s:0.6,E:2}Origin : Just Shapes and Beats{}",
                }
            },
            --Cube jokers
            j_unik_cube_joker = {
                name="Cube Joker",
                text={
                    "This Joker gains {X:chips,C:white}X#2#{} Chips",
                    "if played hand has",
                    "exactly {C:attention}3{} cards",
                    "{C:inactive}(Currently {C:chips}#1#{C:inactive} Chips)",
                },
            },
            j_unik_jsab_cube = {
                name="The Cube",
                text={
                    "This Joker gains {X:chips,C:white}X#2#{} Chips",
                    "if played hand has",
                    "exactly {C:attention}3{} cards",
                    "{C:inactive}(Currently {X:chips,C:white}X#1#{C:inactive} Chips)",
                    "{C:inactive,s:0.9}They want to be beside you in your journey.{}",
                    "{C:dark_edition,s:0.6,E:2}Face art by : 70UNIK{}",
                    "{C:cry_exotic,s:0.6,E:2}Origin : Just Shapes and Beats{}",
                },
            },
            j_unik_jsab_yokana = {
                name="Yokana Ramirez",
                text={
                    "This Joker gains {X:chips,C:white}X#1#{} Chips for each", 
                    "played, {C:attention}unscoring Queens{}",
                    "{C:inactive}(Currently {X:chips,C:white}X#2#{C:inactive} Chips)",
                    "{C:inactive,s:0.9}Quite strange being here, but I'll try to help out as much as I can.{}",
                    "{C:dark_edition,s:0.6,E:2}Character and face art by : 70UNIK{}",
                    "{C:cry_exotic,s:0.6,E:2}Origin : Just Shapes and Beats{}",
                },
            },
            j_unik_jsab_maya = {
                name="Maya Ramirez",
                text={
                    "This Joker gains {X:chips,C:white}X#1#{} Chips when", 
                    "a card is destroyed",
                    "{C:inactive}(Currently {X:chips,C:white}X#2#{C:inactive} Chips)",
                    "{C:inactive,s:0.9}I'm doubtful if all this will succeed, but I'll still contribute.{}",
                    "{C:dark_edition,s:0.6,E:2}Character and face art by : 70UNIK{}",
                    "{C:cry_exotic,s:0.6,E:2}Origin : Just Shapes and Beats{}",
                },
            },
            j_unik_jsab_chelsea = {
                name="Chelsea Ramirez",
                text={
                    "This Joker gains {X:chips,C:white}X#1#{} Chips", 
                    "for each type {C:chips}Chips{} or {X:chips,C:white}XChips{} joker triggered",
                    "{C:inactive}(Currently {X:dark_edition,C:white}^#2#{C:inactive} Chips)",
                    "{C:inactive,s:0.9}Owo what is this? Kind of feels strange but nice that I'm a card...{}",
                    "{C:dark_edition,s:0.6,E:2}Character and face art by : 70UNIK{}",
                    "{C:cry_exotic,s:0.6,E:2}Origin : Just Shapes and Beats{}",
                },
            },
            
        },
        Other={			
            unik_depleted = {
                name = "Depleted",
                text = {
                    "Set values to self-destruct values",
                    "Decrementing values {C:red}do{}",
                    "{C:red}not{} cause {C:red}self destruction{}",
                    "until at {C:attention}negative max{} value",
                },
            },
        },
        Planet={},
        Spectral={},
        Stake={},
        Tag={},
        Tarot={},
        Voucher={},
    },
    misc = {
        achievement_descriptions={},
        achievement_names={},
        blind_states={},
        challenge_names={
            c_unik_chips_only="ChipZel",
            c_unik_common_muck="Common Muck",
        },
        collabs={},
        dictionary={
            k_unik_711="7-Eleven!",
            k_unik_happiness1="HAPPINESS.",
            k_unik_happiness2="HAPPINESS IS MANDATORY.",
            k_unik_happiness3="TREASON!",
            k_unik_nuked="DIE.          NOW.",
            k_unik_pentagram_start="Hell's Legion is coming...",
            k_unik_pentagram_purified="Sent to hell!",
            k_unik_batman_start='"You WILL ALL be forgotten, Jokers. Because of me."',
            k_unik_nuke_start="Nuclear war is coming...",
            k_unik_placard_start="NO PLACARDED LOADS IN PLAY",
            k_unik_boo_start="Bigger Boo wants to know your location",
            k_unik_boo_disabled="Exorcised!",
            k_unik_boo_possessed="Possessed!",
            k_unik_boo_eternal_bypass="Eternal Bypassed!",
            k_unik_the_plant_debuffed="OMNOMNOMNOMNOMNOM!",
            k_unik_plant_no_face="Wilted!",
            k_unik_blind_start_plant="The Plant",
            k_unik_blind_start_manacle="The Manacle",
            k_unik_manacle_small="Slipped out!",
            k_unik_manacle_big="Broken out!",    
            k_unik_blind_start_wall="The Wall",   
            k_unik_wall_jumped="Jumped over!",   
            k_unik_weapon_destroyed="Broke!",
            k_unik_goading_fuck_you="FUCK YOU!",
            k_unik_window_fixed="Fixed!",
            k_unik_headless_rotted="Rotted!",
            k_unik_house_demolished="Demolished!",
            k_unik_arm_healed="Healed!",
            k_unik_water_burgular="Drained!",
            k_unik_boss_blind_joker="Boss Blind",
        },
        high_scores={},
        labels={
            unik_positive="Positive",
            unik_depleted = "Depleted",
        },
        poker_hand_descriptions={},
        poker_hands={},
        quips={
            --Getting killed when you go over 3x score in Indigo ICBM
            special_lose_unik_get_nuked={
                "I'm sure you're happy",
                "getting nuked after",
                "flying too high!",
            },
            --Getting killed by raspberry racket
            special_lose_unik_racket={
                "Should've known that",
                "messing around with",
                "protection rackets is",
                "a bad idea!"
            },
            --Getting killed by bigger boo
            special_lose_unik_bigger_boo={
                "Maybe play Yoshi's Island",
                "W2-4 to practice fighting",
                "ghosts before your next revive!",
            },
            --Turquoise tornado, harlequin hurricane,
            special_lose_unik_F5={
                "Maybe we could've gotten",
                "the storm-chasing clown car!",
            },
            --Lily
            special_lose_unik_sprunki_lily={
                "Be careful around Sprunkis,",
                "they bite... some literally!",
            },
            --Tall poppy syndrome
            special_lose_unik_tall_poppy_syndrome={
                "Jeez, people these days...",
                "They like to cut down",
                "poppies like us..."
            },
            --the joyless
            special_lose_unik_jollyless={
                "[DATA EXPUNGED]",
            },
            --white wire
            special_lose_unik_white_wire={
                "Maybe practice high cards",
                "and no discards",
                "against the Needle!",
            },
            --getting killed when you disable the petard
            special_lose_unik_hoist_by_his_own_petard={
                "Oh the saying goes...",
                "Hoist by his own petard!",
            },
            --getting killed by batman
            special_lose_unik_defeated_by_batman={
                "Maybe if we go to",
                "Arkham asylum, we may",
                "have a chance to escape!",
            },
            --getting killed by purple pentagram
            special_lose_unik_killed_by_pentagram={
                "Nothing's worse than",
                "dying to a bunch of",
                "cursed entities!",
            },         
            --getting killed by persimmon placard
            special_lose_unik_killed_by_placard={
                "It looks like you",
                "did not invest in",
                "your jokers. Maybe",
                "do that next time!"
            },      
        },
        ranks={},
        suits_plural={},
        suits_singular={},
        tutorial={},
        v_dictionary={},
        v_text={			
            ch_c_unik_mult_set_to_one = { "Mult is {C:attention}set{} to {C:red}<=1{}" },
            ch_c_unik_mult_ban = { "{C:mult}Mult{}, {X:mult,C:white}XMult{} and {X:dark_edition,C:white}^Mult{} Jokers and cards are {C:red}banned{}"},
            ch_c_unik_mult_ban2 = {"{C:inactive}(As much as possible){}"},
            ch_c_unik_common_only = {"Only {C:Blue}Common{} Jokers can spawn"},
        },
    },
}