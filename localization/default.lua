return {
    descriptions = {
        Back={},
        Blind={
            bl_unik_purple_pentagram={
                name = "Purple Pentagram",
				text = {
					"Create 4 Cursed Jokers",
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
            --In cryptid where jokers are key, debuffing all jokers is bound for disaster
            --So I'll nerf it to debuff 4/5 of all Jokers (and also have a min 1 Joker remaining)
            bl_unik_black_bat={
                name = "Black Bat",
				text = {
					"~80% of Jokers from the right",
                    "are debuffed"
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
                    "+0.03x blind size for",
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
                    "No hands containing pairs",
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
            bl_unik_collapse={
                name = "The Collapse",
				text = {
					"All Rankless and Suitless",
					"cards are debuffed",
				},
            },
            --exclusive to plasma deck or if you have sync catalyst
            bl_unik_sync_catalyst_fail={
                name = "The Leak",
				text = {
					"Chips and Mult are",
					"no longer balanced",
				},
            },
            bl_unik_evil_pc_building_company={
                name = "The Artisan",
				text = {
					"Shop rerolls multiply",
					"blind requirements by 2x",
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
					"1 random hand",
					"will not score",
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
            j_unik_holepunched_card = {
                name = 'Holepunched Card',
                text={
                    "Retrigger {C:attention}last{} played",
                    "card used in scoring",
                    "{C:attention}#1#{} additional times",
                },
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
            j_unik_gt710 = {
                name = 'GT 710',
                text = {
                    "If hand contains", 
                    "a scoring {C:attention}7{} and {C:attention}10{},",
                    "earn {C:money}$#1#{}",
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
            j_unik_recycler = {
                name = 'Recycle Bin',
                text={
					"This Joker gains",
					"{X:mult,C:white} X#2# {} Mult per",
					"{C:attention}card{} discarded",
					"{C:inactive}(Currently {X:mult,C:white} X#1# {C:inactive} Mult)",
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
                    "All {C:attention}face{} cards are {C:red}debuffed{}", 
                    "{C:red}Self destructs{} when less than", 
                    "{C:attention}#1# face{} card(s) remain in deck or",
                    "{C:unik_plant_color}The Plant{} is triggered",
                    "{C:inactive}(Currently {C:attention}#2#{C:inactive} Face Card(s))",
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
            --Patronizing joker, but way more crass and ragged
            j_unik_goading_joker = {
                name = 'Goading Joker',
                text={
                    "{C:attention}All {C:spades}Spade{} cards are {C:red}debuffed{}", 
                    "{C:red}Self destructs{} when less than", 
                    "{C:attention}#1#{} {C:spades}Spade{} card(s) remain in deck or",
                    "{C:unik_goad_color}The Goad{} is triggered",      
                    "{C:inactive}(Currently {C:attention}#2#{C:inactive} {C:spades}Spade(s){C:inactive})",
                },                 
            },
            j_unik_headless_joker = {
                name = 'Headless Joker',
                text={
                    "{C:attention}All {C:hearts}Heart{} cards are {C:red}debuffed{}", 
                    "{C:red}Self destructs{} when less than", 
                    "{C:attention}#1#{} {C:hearts}Heart{} card(s) remain in deck or",
                    "{C:unik_head_color}The Head{} is triggered",      
                    "{C:inactive}(Currently {C:attention}#2#{C:inactive} {C:hearts}Heart(s){C:inactive})",
                },                 
            },
            j_unik_broken_window = {
                name = 'Broken Window',
                text={
                    "{C:attention}All {C:diamonds}Diamond{} cards are {C:red}debuffed{}", 
                    "{C:red}Self destructs{} when less than", 
                    "{C:attention}#1#{} {C:diamonds}Diamond{} card(s) remain in deck or",
                    "{C:unik_window_color}The Window{} is triggered",      
                    "{C:inactive}(Currently {C:attention}#2#{C:inactive} {C:diamonds}Diamond(s){C:inactive})",
                },                 
            },
            --a caveman club smashing a club ace
            j_unik_caveman_club = {
                name = 'Caveman Club',
                text={
                    "{C:attention}All {C:clubs}Club{} cards are {C:red}debuffed{}", 
                    "{C:red}Self destructs{} when less than", 
                    "{C:attention}#1#{} {C:clubs}Club{} card(s) remain in deck or",
                    "{C:unik_club_color}The Club{} is triggered",      
                    "{C:inactive}(Currently {C:attention}#2#{C:inactive} {C:clubs}Club(s){C:inactive})",
                    "{C:inactive,s:0.6}We are going to beat you to death.{}",
                },                 
            },
            --Space joker but has a broken arm, fitting the theme
            j_unik_broken_arm = {
                name = 'Broken Arm',
                text={
                    "{C:red}Levels down{} played {C:attention}poker hand{}", 
                    "by {C:attention}#1#{} level {C:attention}before{} each hand",
                    "{C:red}Self destructs{} when a level 1", 
                    "hand is played {C:attention}#2#{} times {C:attention}consecutively{}",
                    "or {C:unik_arm_color}The Arm{} is triggered",   
                    "{C:inactive}(Currently {C:attention}#3#{C:inactive} Hand(s))",
                },                 
            },
            --Basically instead of being "eaten", popcorn and ice cream become negative, ramen becomes < 1.0X, Turtle bean reduces hand size.
            -- Right now it only supports those 4, since they self destruct at a certain value (1 or 0)
            j_unik_autocannibalism = {
                name = 'Esophagus Now',
                text={
                    "Create an {C:attention}Eternal Depleted{} decrementing food Joker", 
                    "Add {C:attention}Eternal and Depleted{} to new and",
                    "existing decrementing food Jokers and",
                    "set values to {C:attention}self destruct values{}",      
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
            j_unik_cube_joker = {  -- uncommon: gains x0.09 chips
                name="Cube Joker",
                text={
                    "This Joker gains {X:chips,C:white}X#2#{} Chips",
                    "if played hand has",
                    "exactly {C:attention}4{} cards",
                    "{C:inactive}(Currently {X:chips,C:white}X#1#{C:inactive} Chips)",
                },
            },
            j_unik_jsab_yokana = { --epic: 1.25x chips for EVERY chips, xchips or ^chips trigger (pentationals and tettrati0onals included), excluding herself (otherwise infinite loop)
            --Increases by 1.3x chips if maya and chelsea are present
                name="{C:unik_yokana_color}Yokana Ramirez{}",
                text={
                    "{X:chips,C:white}X#1#{} Chips for every {C:attention}scored{} Card",
                    "or {C:attention}Joker{} triggered during play",
                    --"{C:inactive,s:0.8}If {C:unik_chelsea_color,s:0.8}Chelsea{C:inactive,s:0.8} and {C:unik_maya_color,s:0.8}Maya{C:inactive,s:0.8} are present, increase this by {X:chips,C:white,s:0.8}#2#X{}",
                    "{C:inactive,s:0.9}Quite strange being here,{}",
                    "{C:inactive,s:0.9}but I'll try to help out as much as I can.{}",
                    "{C:dark_edition,s:0.6,E:2}Character and face art by : 70UNIK{}",
                    "{C:cry_exotic,s:0.6,E:2}Origin : Just Shapes and Beats{}",
                },
            },
            j_unik_jsab_maya = { --epic: each non-face card played gains 0.75x chips, each non-face card held gains 0.25x chips
            --Increases by 1.3x chips if maya and chelsea are present
            --Her triggering does not trigger yokana and chelsea, but does help but providing more Xchips and more triggers for them (xchips + chips = double trigger)
            --Basically provided its not face cards, she's a souped up hiker
                name="{C:unik_maya_color}Maya Ramirez{}",
                text={
                    "{C:attention}Scored{} non-face cards permanently gain {X:chips,C:white}X#1#{} Chips",
                    "{C:attention}Held{} non-face cards permanently gain {X:chips,C:white}X#2#{} Chips",
                    --"{C:inactive,s:0.8}If {C:unik_chelsea_color,s:0.8}Chelsea{C:inactive,s:0.8} and {C:unik_yokana_color,s:0.8}Yokana{C:inactive,s:0.8} are present, increase this by {X:chips,C:white,s:0.8}#3#X{}",
                    "{C:inactive,s:0.9}I'm doubtful if all this will succeed, but I'll still contribute.{}",
                    "{C:dark_edition,s:0.6,E:2}Character and face art by : 70UNIK{}",
                    "{C:cry_exotic,s:0.6,E:2}Origin : Just Shapes and Beats{}",
                },
            },
            j_unik_jsab_chelsea = { --epic: gains x0.07 chips for EVERY chips, xchips or ^chips trigger (pentationals and tettrati0onals included)
            --Increases by 1.3x if maya and yokana are present
                name="{C:unik_chelsea_color}Chelsea Ramirez{}",
                text={
                    "This Joker gains {X:chips,C:white}X#2#{} Chips when", 
                    "{C:chips}Chips{}, {X:chips,C:white}XChips{} or {X:dark_edition,C:white}^Chips{} trigger",
                    --"{C:inactive,s:0.8}If {C:unik_maya_color,s:0.8}Maya{C:inactive,s:0.8} and {C:unik_yokana_color,s:0.8}Yokana{C:inactive,s:0.8} are present, increase this by {X:chips,C:white,s:0.8}#3#X{}",
                    "{C:inactive}(Currently {X:chips,C:white}X#1#{C:inactive} Chips)",
                    "{C:inactive,s:0.9}OwO what's all this? Maybe I can help!{}",
                    "{C:dark_edition,s:0.6,E:2}Character and face art by : 70UNIK{}",
                    "{C:cry_exotic,s:0.6,E:2}Origin : Just Shapes and Beats{}",
                },
            },
            --rare: x1.5x mult from destroying cursed jokers, but only up to 8, the 9th one will cause self destruciton and release ALL cursed jokers
            j_unik_ghost_trap = {
                name="Ghost Trap",
                text={
					"This Joker {C:attention}captures{} all {X:cry_cursed,C:white}Cursed{} Jokers",
                    "and gains {X:mult,C:white}X#2#{} Mult per Joker captured",
					"{C:red}Self destructs{} if exceeds {C:attention}#4#{} {X:cry_cursed,C:white}Cursed{} Jokers",
					"and {C:red}releases all captured{} {X:cry_cursed,C:white}Cursed{} {C:red}Jokers{}",
                    "{C:red}if sold or destroyed{}",   
					"{C:inactive}(Currently {X:mult,C:white}X#1#{C:inactive} Mult, {C:attention}#3# {X:cry_cursed,C:white}Cursed{C:inactive} Jokers){}",
                    "{C:inactive,s:0.9}(The {C:attention}leftmost{C:inactive} Ghost Trap will capture first){}",
                },
            },
            j_unik_lily_sprunki = {
                name="Lily",
                text={
                    "{C:red}Destroy{} {C:attention}all{} played cards except the ", 
                    "{C:attention}leftmost{} played card after scoring",
                    "{C:inactive,s:0.9}#1#{}",
                    "{C:dark_edition,s:0.6,E:2}Face art by : 70UNIK{}",
                    "{C:dark_edition,s:0.6,E:2}Character by : Kaeofthekae{}",
                    "{C:cry_exotic,s:0.6,E:2}Origin : SPRUNKI{}",
                },                
            },
            j_unik_big_joker = {
                name="Big Joker",
                text={
                    "{C:mult}+#1#{} Mult if played hand contains",
                    "{C:attention}#3#{} or more cards",
                    "Each played card above {C:attention}#3#{} cards",
                    "increases this by {C:mult}+#2#{} Mult",
                },
            },
            j_unik_no_standing_zone = {
                name="No Standing Zone",
                text={
                    "{X:mult,C:white}X#1#{} Mult, decreases by ",
                    "{X:mult,C:white}X#4#{} every {C:attention}second{} in Blinds",
                    "and {X:mult,C:white}X#5#{} every {C:attention}second{} elsewhere",
                    "Turns into {C:red}Impound Notice{}",
                    "if Mult becomes {X:mult,C:white}X1{}.",
                    "Resets to {X:mult,C:white}X#3#{} Mult",
                    "at the start and end of {C:attention}Round{}",
                    "{C:inactive,s:0.7}(Hover off and on again to see the new Xmult){}",
                }, 
            },
            --0.5x Mult, Debuff up to 2 random non-cursed Jokers, sells for double the total of debuffed Jokers to remove debuff and itself. Destruction will remove debuffs. Selling Jokers wi
            j_unik_impounded = {
                name="Impound Notice",
                text={
                    "{X:mult,C:white}X#1#{} Mult {C:attention}after scoring{}",
                    "{C:red}Debuffs{} and adds {C:attention}Eternal and Rental{}",
                    " to a random Joker on spawn",
                    "{C:attention}Sell{} to remove debuff, Eternal and Rental",
                    "Selling costs {X:money,C:white}X#2#ln(x+1){} the total",
                    "{C:attention}selling price{} of debuffed Joker",
                    "{C:inactive,s:0.7}(Costs {C:money,s:0.7}$#3#{C:inactive,s:0.7} if no valid Joker owned){}",
                }
            }
        },
        Other={			
            unik_depleted = {
                name = "Depleted",
                text = {
                    "Decrementing values {C:red}do{}",
                    "{C:red}not{} cause {C:red}self destruction{}",
                    "until at {C:attention}negative max{} value",
                    "or {C:attention}0{} for {X:mult,C:white}XMult{}",
                },
            },
            p_unik_cube_1 = {
				name = "Square Pack",
				text = {
					"Choose {C:attention}#1#{} of",
					"up to {C:attention}#2# Square Joker#s2#{}",
				},
			},
            p_unik_cube_2 = {
				name = "Square Pack",
				text = {
					"Choose {C:attention}#1#{} of",
					"up to {C:attention}#2# Square Joker#s2#{}",
				},
			},
            unik_decrementing_food_jokers = {
				name = "Decrementing Food Jokers",
				text = {
					"{s:0.8}Turtle Bean, Popcorn, Ramen,",
					"{s:0.8}Ice Cream and Clicked Cookie",
				},
			},
        },
        Planet={},
        Spectral={},
        Stake={},
        Tag={},
        Tarot={c_unik_wheel_of_misfortune = {
            name = "The Evocation",
            text = {
                "{C:green}#1# in #2#{} chance to create ",
                "a {X:cry_cursed,C:white}Cursed{} Joker",
                "otherwise apply {C:dark_edition}Negative{}, {C:dark_edition}Mosaic{},",
                "or {C:dark_edition}Astral{} to a {C:attention}random{} Joker",
            }
        }},
        Voucher={},
    },
    misc = {
        achievement_descriptions={},
        achievement_names={},
        blind_states={},
        challenge_names={
            c_unik_chips_only="ChipZel",
            c_unik_mult_only="Multiplication",
            c_unik_common_muck="Common Muck",
            c_unik_boss_rush_2="Enter the Gungeon II",
            c_unik_boss_rush_3="Enter the Gungeon III",
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
            k_unik_goading_f_u_family_friendly="GET OUT!",
            k_unik_window_fixed="Fixed!",
            k_unik_blind_start_window="The Window",
            k_unik_blind_start_head="The Head",
            k_unik_blind_start_club="The Club",
            k_unik_blind_start_goad="The Goad",
            k_unik_arm_downgrade="Downgrade!",
            k_unik_headless_rotted="Rotted!",
            k_unik_house_demolished="Demolished!",
            k_unik_arm_healed="Healed!",
            k_unik_blind_start_arm="The Arm",
            k_unik_water_burgular="Drained!",
            k_unik_boss_blind_joker="Boss Blind",
            k_unik_too_bad="Too Bad!",
            k_unik_ghost_trap_captured="Captured!",
            k_unik_ghost_trap_explode="Too much!",
            k_unik_plasma_deck_fail="Not Balanced!",
            k_unik_lily_sprunki_normal="*Microwave Sounds* How did I get here?",
            k_unik_lily_sprunki_monster="RRRAGGRAAGRGRGRHHHH!!!",
            k_unik_lily_sprunki_after="oh... oh... god...",
            k_unik_no_standing_towed="Towed Away!",
            k_unik_impounded="Impounded!",
            k_unik_debt="Not Enough Money!"
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
            --getting killed by the leak
            special_lose_unik_the_leak={
                "Damn! You need to get",
                "a better Sync Catalyst",
                "next time!",
            },   
            --getting killed by artisan builds
            special_lose_unik_artisan_builds={
                "Maybe watch Gamers Nexus's",
                "video on the Artisan Builds",
                "scandal!",
            },   
        },
        ranks={},
        suits_plural={},
        suits_singular={},
        tutorial={},
        v_dictionary={
            a_unik_hands_1={"#1# hands"}
        },
        v_text={			
            ch_c_unik_mult_set_to_one = { "{C:mult}Mult{} is {C:attention}set{} to {C:red}<=1{}" },
            ch_c_unik_mult_ban = { "Solely {C:mult}Mult{}, {X:mult,C:white}XMult{} and {X:dark_edition,C:white}^Mult{} Jokers and cards are {C:red}banned{}"},
            ch_c_unik_mult_ban2 = {"{C:inactive}(As much as possible){}"},
            ch_c_unik_chips_set_to_one = { "{C:chips}Chips{} are {C:attention}set{} to {C:red}<=1{}" },
            ch_c_unik_chips_ban = { "Solely {C:chips}Chips{}, {X:chips,C:white}XChips{} and {X:dark_edition,C:white}^Chips{} Jokers and cards are {C:red}banned{}"},
            ch_c_unik_common_only = {"Only {C:Blue}Common{} Jokers can spawn"},
            ch_c_cry_big_showdown = {"{C:attention}Final{} Boss Blinds can appear in {C:attention}any{} Ante"},
            --DO YOU WANT TO SUFFER?
            ch_c_unik_obsidian_showdown = {"{C:attention}Final{} blind is always the {C:red}Obsidian Orb{}"},
            ch_c_unik_obsidian_swarm = {"{C:attention}Final{} blind of {C:attention}each ante{} is always the {C:red}Obsidian Orb{}"},
            ch_c_unik_ante_12_victory = {"Must beat Ante {C:attention}10{} to win"},
            ch_c_unik_ante_13_victory = {"Must beat Ante {C:attention}13{} to win"},
        },
    },
}