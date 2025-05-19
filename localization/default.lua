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
					"Hands exceeding #1#",
                    "will not score",
				},
            },
            bl_unik_harlequin_hurricane={
                name = "Harlequin Hurricane",
				text = {
					"#1# in #2# chance for",
					"scored hand to be negative,",
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
					"#1# Jokers from the right",
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
            bl_unik_red_rot={ --Almanac replacement for Bigger Boo, maybe have the hunter instantly explode when entering this blind as a secret.
                name = "Red Rot",
				text = {
					"Create an absolute Rot",
                    "on Blind Selection",
                    "and before each hand",
                    "convert Jokers adjacent",
                    "to each Rot into The Rot",
				},
            },
            bl_unik_raspberry_racket={
                name = "Raspberry Racket",
				text = {
					"Lose $40 per hand",
                    "if money below $40",
                    "hand will not score",
				},
            },
            bl_unik_white_wire={
                name = "White Wire",
				text = {
					"Play 1 hand with",
                    "0 discards",
				},
            },
            bl_unik_green_goalpost={
                name = "Green Goalpost",
				text = {
                    "Defeating this blind",
                    "will increase victory",
                    "requirements by 3 antes",
				},
            },
            --Rework:
            --You need to be in tension 33 to survive
            --Or must reroll total rerolls done this run^1.05 before this ante
            bl_unik_epic_artisan={
                name = "Arteesisetrakenteet", --literally artesian builds
				text = {
                    "Shop rerolls this ante increase",
                    "Blind requirements by ^#1#",
                    "#2#", --"If done < 10 rerolls this ante,",
                    "#3#", --"on Blind select, die",
				},
            },
            bl_unik_epic_collapse={ --only appears if you have at least 5 stone cards in the deck
                name = "Kaatuvatorni", --the collapsing tower
				text = {
                    "If played hand",
                    "contains a suit",
                    "or a rank, die",
				},
            },
            bl_unik_epic_box={
                name = "Murskauslaatikko", --the crushing box
				text = {
                    "Hand will not score",
                    "without having at least 60% of",
                    "owned Jokers be Common rarity",
				},
            },
            bl_unik_epic_cookie={
                name = "Pimeydenkeksi", --the cookie of darkness
                text = {
					"^#1# requirements every",
                    "click in this Ante",
                    "Skipping Blinds are banned",
                    "Destroy a random card per click,",
                    "-1 hand size every 8 clicks",
				},
                --maybe have a special interaction with White Lily Cookie (hmm dark enchantress)
            },
            bl_unik_epic_reed={
                name = "Haitallinenruoko", --the infestive reed (the reed from ortalab)
				text = {
                    "If hand does not contain",
                    "#1#, die", --2 random ranks accoring to your deck composition
				},
            },
            bl_unik_epic_decision={ -- Mortoninhaarukka: Morton's Fork, cause no matter what, all choices are bad. Created last due to the effort needed to create the entire "lartceps" set (baneful spectrals)
                name = "Mortoninhaarukka", --Epic Decision
                text = {
                    "On Blind Select,",
                    "Open an unskippable", 
                    "Lartceps Bundle Pack",
                },
            },
            bl_unik_epic_sand={
                name = "Juoksuhiekka", --quicksand
                text = {
                    "#1#",
                    "#2#", 
                    "(Currently #3##4##5#)"
                },
            },
            bl_unik_epic_hannibal = { --Always draw 3 cards after play and discard. If any cards are held in hand after blind defeat, die
                name = "Nälkäinenkannibaali", --The hungry cannibal
                text = {
                    "After Play or Discard,",
                    "always draw 3 cards",
                    "If any card is held after",
                    "Blind Defeat, die"
                },
            },
            bl_unik_epic_vice={ --The next 5 boss blinds become Epic+ Blinds (Vice excluded legendary blind restrictions still apply), increases by ^1.1, rounded up per each epic vice encountered.
                name = "Tukehtumisenpahe", --vice of suffocation
                text = {
                    "The next #1# Blinds",
                    "become Epic+ Blinds",
                    "(Tukehtumisenpahe Excluded)",
                }
            },
            bl_unik_epic_vader={ --Balatro goes kino
                name = "Telekineettinentyranni", --Telikinetic Tyrant
                text = {
                    "Set all statistics",
                    "of all Jokers to 0",
                } --Better get immutables going on.
            },
            bl_unik_epic_xenomorph_queen={ --1 in 4 chance drawn card is permanently debuffed. If card contains undebuffed cards, die. --HARD COUNTERS DANDY --Balatro goes kino
                name = "Syövyttäväulkomaalainen", --Corrosive Alien
                text = {
                    "#1# in #2# chance",
                    "card is drawn permanently debuffed",
                    "If played hand contains",
                    "undebuffed cards, die"
                }
            },
            bl_unik_epic_shackle={ --Reduce hand size by (number of empty joker slots x negative jokers owned) and destroy all negative jokers, cards and consumeables.
                name = "Bifurkaationkahle", --Shackle of bifrication
                text = {
                    "#1# hand size",
                    "and Joker slots by",
                    "(Empty Joker slots) x (Negative Jokers)",
                    "then destroy all negative",
                    "Jokers, cards and consumeables,",
                    "including eternals",
                }
            },
            bl_cry_cube={ --I don't like cube being worse than lemon trophy. So I'll just nerf it to reduce mult by ^0.5 and blind size to be ^0.33. Still severe, but can be brute forced 
                name = "The Cube",
                text = {
                    "Mult is reduced",
                    "by ^0.33",
                },
            },
            bl_unik_epic_cube={ --an effect of this caliber should be an epic blind instead (literally chipzel challenge)
                name = "Kaaoksenkuutio", --Cube of chaos
                text = {
                    "Mult is set to <1",
                },
            },
            bl_unik_bigger_blind={
                name = "Bigger Blind", --no description, it does nothing
            },
            bl_unik_boring_blank={
                name = "Boring Blank",
                text = {
                    "Does nothing?", --yes, it really does nothing. To the point where chicot and luchador will sleep
				},
            },
            bl_unik_maroon_magnet={
                name = "Maroon Magnet",
				text = {
                    "+2 Hand Size",
					"Convert #1# in #2# unenhanced cards",
					"in deck to Steel cards",
                    "hand must not hold Steel cards",
				},
            },
            bl_unik_legendary_magnet={
                name = "Murhaavamagneetti", --Murderous Magnet --nerfed to just not score to give more control
				text = {
                    "+6 Hand Size",
					"Add Red Seal Steel Kings",
					"equal to 3x cards in deck",
                    "Hand must not hold",
                    "or play Steel Cards",
				},
            },
            bl_unik_legendary_nuke={ --aka old nuke
                name = "Tuomiopäivänlaite", --doomsday device
                text = {
                    "If score exceeds",
                    "#1#, die",
                },
            },
            --Kiristysmaila: Extortion Racket
            bl_unik_legendary_racket={
                name = "Kiristysmaila", --Extortion Racket
				text = {
                    "Scored hand capped at #1#", --50%
					"Set money to -$66 per hand", --you gonna need lucky cards, wario or gold seals
                    "Hand will not score if money is",
                    "less than $#2#", --less than the amount you entered the blind in
                    "If in debt after a hand, die",
				},
            },
            bl_unik_legendary_vessel={
                name = "Väkivaltainenalus", --Violent Vessel
				text = {
					"If requirements reached",
                    "before last hand, die",
				},
            },
            bl_unik_legendary_trophy={
                name = "Häpeänpalkinto", --Trophy of Dishonor
				text = {
                    "If Mult, XMult or ^Mult",
					"is triggered during scoring",
                    "hand will not score",
				},  
            },            
            bl_unik_legendary_batman={
                name = "Kostonhimoinenvartija", --Vengeful Vigilante
				text = {
                    "^0.00666 blind size",
                    "Hand will not score until",
                    "no jokers remain",
				},                  
            },
            bl_unik_legendary_sword={ --ortalab's silver sword on CRACK. X66.6 blind requirements as well and all burgulars are debuffed
                name = "Sadistinenmiekka", --Sadistic Sword
				text = {
                    "Hand Size set to 1",
                    "Play only 1 hand,",
                    "with 0 discards",
				},  

            },
            bl_unik_legendary_tornado={
                name = "Ylihuomenna", --Day after tomorrow
				text = {
                    "Set hands to 66", -- set hands to 66, only 23 hands will score. This requires joker power, a lot of high card spam. Run out of scoring hands and you die instantly
                    "only 2 random hands", --now there's a pity system that every 33 hands, 1 will score and the probabilities increases as it gets closer to pity. Maybe remove the pity in almanac!
                    "will score",
				},                  
            },
            bl_unik_legendary_leaf={
                name = "Palavalehti", --Burning Leaf
				text = {
                    "Destroy all but 1", 
                    "random Joker",
                    "including eternals",
				},  
            },
            bl_unik_legendary_pentagram={
                name = "Kaaoksenvaltakunta",--WARHAMMER 40K WARP!
                text ={
                    "Convert 66.6% of owned Jokers",
                    "into Cursed Jokers, including",
                    "eternals and permaeternals",
                    "Every Joker has a 6 in 10 chance", 
                    "to convert into a Cursed Joker",
                    "before every hand",
                }
            },
            bl_unik_legendary_crown={ --Celeste's golden crown, but WORSE. Set requirements to highest score this run. Defeat this blind (number of hands) times, increase reqs by 2x after each defeat. If hands < 2, blind size is ^2 reqs.
                name = "Korruptionkruunu", --Corrupted Crown
                text ={
                    "Defeat this blind #1# time#2#",
                    "Set hands to 1, only replenish",
                    "per blind defeat",
                    "Per defeat, rescale blind to",
                    "(best hand this run)#3#",
                    "If hands = 1, increase",
                    "requirements by #4#",
                }
            },
            --just like the actual gambling machine - Jacks or better
            bl_unik_video_poker={
                name = "Video Poker",
				text = {
                    "Hand Size fixed to 5 (Efficinare debuffed)",
					"Only 1 Discard per Hand",
                    "Must play all cards, High cards are banned",
                    "Pairs must have scoring Jacks or better",
				},
            },
            bl_unik_the_lily={ --rename to the consumer -- all consumeables are debuffed (only spawn if you have perkeo, moonlight, observatory, >15 consumeables (cough cough almanac) or >5 ccd cards)
                name = "The Lily",
				text = {
					"Destroy all played cards",
				},
            },
            --Edition related blinds
            bl_unik_bloon={
                name = "The Bloon",
                text = {
                    "Add Bloated to 2",
                    "random played cards and",
                    "leftmost Joker on play",
                }
            },
            bl_unik_smiley={
                name = "The Smiley",
                text = {
                    "First drawn hand",
                    "becomes Positive",
                }
            },
            bl_unik_halved={
                name = "The Halved",
                text = {
                    "If hand contains >3 cards",
                    "add Half to 2 random Jokers",
                    "and played cards",
                }
            },
            bl_unik_fuzzy={
                name = "The Fuzzy",
                text = {
                    "#1# in #2# played", --3 in 5
                    "cards become Fuzzy",
                }
            },
            bl_unik_darkness={
                name = "The Darkness", --All uneditioned drawn cards become Corrupted; All owned Jokers become corrupted. Only appears if at least 2 jokers are editioned and at least 5 cards are editioned and endless only
                text = {
                    "All uneditioned Jokers", --Has legendary blind glitch FX cause pibby
                    "and cards in hand are Corrupted",
                    "after play or discard",
                }
            },
            bl_unik_the_replay={
                name = "The Replay",
				text = {
					"Repeats the previous",
                    "defeated blind",
				},
            },
            bl_unik_cookie={
                name = "The Cookie",
				text = {
					"+0.025x requirements every",
                    "click in this Ante",
				},
            },
            --If score exceeds 3x requirements, final boss blinds appear twice as often 
            bl_unik_vice={ --placeholder: manacle
                name = "The Vice",
				text = {
					"If score exceeds #1#",
                    "Final Boss Blinds",
                    "will appear every #2#",
				},
            },
            --All consumeables and CCD cards are debuffed
            --Appears if you own at least 2 consumeables and
            --have >17 consumeables (almanac *cough*)
            --Perkeo
            --Moonlight Cookie
            --Scratch
            --Observatory
            --At least 5 CCD cards in deck
            --All consumeables are debuffed

            --Epic consumer:
            --Turn 90% of cards in deck to CCD
            --Must use or all consumeables in inventory slot and no CCDs remain in deck/hand for hand to score (Excluding stuff like fusion, swabbie, artificer, etc...)
            bl_unik_consumer={
                name = "The Consumer",
				text = {
					"All consumeables",
                    "are debuffed",
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
                    "No pairs",
				},
            },
            bl_unik_the_poppy={
                name = "The Poppy",
				text = {
					"Hands exceeding #1#",
                    "will be multiplied",
                    "by 0.03x",
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
            bl_unik_artisan_builds={
                name = "The Artesian",
				text = {
					"Shop rerolls in this ante",
					"increase blind requirements",
                    "by +1x",
				},
            },
            --weather themed blinds:
            --Wind, Gale, Tornado, Typhoon, Hurricane ()
            bl_unik_the_wind={
                name = "The Wind",
				text = {
					"Each played card has",
					"a #1# in #2# chance",
                    "to be debuffed before scoring", --likely utilising cry_before_play
				},
            },
            bl_unik_the_gale={
                name = "The Gale",
				text = {
					"#1# in #2# chance",
                    "a single hand", --this means each hand has a set chance of fail, but once said hand fails, rest are free (a lenient version of tornado)
					"will not score",
                    "for this round",
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
            e_unik_bloated={
                name="Bloated",
                text={
                    "{C:green}#1# in #2#{} chance card is",
                    "{E:2,C:red}destroyed{} on trigger",
                    "{C:attention}bypassing{} {C:purple}Eternals{}",
                }
            },
            e_unik_bloated_consumeable={
                name="Bloated",
                text={
                    "{C:green}#1# in #2#{} chance card",
                    "does {E:2,C:red}nothing{} on use",
                }
            },
            e_unik_fuzzy = {
				name = "Fuzzy",
				text = {
					"{E:2,C:red}??????{}",
				},
			},
            e_unik_corrupted = {
				name = "Corrupted",
				text = {
					"All values on this card",
					"are {C:dark_edition}randomized{}",
					"between {C:red}X0.75{} and {C:red}X0.1{}",
					"{C:inactive}(If possible){}",
				},
			},
            e_unik_halfjoker = {
                name = "Half",
                text = {
                    "Card is {E:2,C:red}debuffed{}",
                    "when {C:attention}4 or more{}",
                    "cards are played",
                    "or selected",
                }
            },
            e_unik_steel = {
				name = "Steel",
				text = {
					"{X:mult,C:white}X#1#{} Mult",
					"when held in hand",
				},
			},
            e_unik_steel_consumeable = {
				name = "Steel",
				text = {
					"{X:mult,C:white}X#1#{} Mult",
					"when held in",
                    "consumeables",
				},
			},
            e_unik_steel_joker = {
				name = "Steel",
				text = {
					"{X:mult,C:white}X#1#{} Mult",
                    "then {X:mult,C:white}X#2#{} Mult",
                    "if Joker has {C:attention}triggered{}",
				},
			},
        },
        Enhanced={
            --ALMANAC + BUFFOONERY EXCLUSIVE ENHANCEMENTS--
            m_unik_buf_jen_tainted_ceramic = {
                name = "Tainted Ceramic",
				text = {
						"{X:unik_void_color,C:unik_eye_searing_red}^^^#1#{} Chips", --jen logic, complete with 6 ^s!
						"{C:green}#2# in #3#{} chance card is", --glass card properties (4 in 6 chance)
                        "{C:red,E:2}destroyed{} when scored",
                        "{C:red,E:2}Guaranteed chance{} if",
                        "not played with {C:attention}exactly{}", --porcelain card properties
                        "{C:attention}#4#{} cards, {C:attention}held{} or {C:attention}unscored{}",
                        "{C:inactive,s:0.7}(Numerator cannot fall below 3)",
                        "{C:inactive,s:0.7}(Denominator cannot go above 6)",
				}
            },
            m_unik_namta = {
                name = "Namta",
                text = {
                    "Has no rank or suit",
                    "{X:unik_void_color,E:2,C:red}^#3#{} Blind Size if held",
                    "Create a {X:unik_lartceps_inverse,C:unik_lartceps1}Lartceps{} card",
                    "when {C:attention}scored, then{}",
                    "{C:red,E:2}Self Destruct{}",
                }
            }
        },
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
            --Disable if extracredit is installed
            j_unik_lucky_seven_modest = {
                name = 'Lucky 7',
                text = {
                    "{C:attention}7s{} are considered", 
                    "{C:attention}Lucky Cards{}",
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
            j_unik_yes_nothing_modest = {
                name = 'Yes! Nothing*',
                text={
                    "Halves all {C:attention}listed{}",
                    "{C:green,E:1,S:1.1}probabilities{}",
                    "{C:inactive}(ex: {C:green}2 in 3{C:inactive} -> {C:green}1 in 3{C:inactive})",
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
            j_unik_711_modest = {
                name = '7/11',
                text = {
                    "Once per round, if hand contains", 
                    "a scoring {C:attention}7{} and {C:attention}Ace{},",
                    "create a {C:attention}random{} Food Joker",
                    "{C:inactive}(Must have room){}",
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
                    "and turns a {C:attention} random{} played card {C:unik_shitty_edition}Positive{}", 
                    "{C:red}Self destructs{} after maximum Joker slots becomes {C:attention}#1#{}" ,
                    "{C:red}On destruction{}, remove {C:attention}Eternal{} from {C:attention}all Smiley Faces.{}" ,
                    "{C:inactive,s:0.7,E:1}Happiness is mandatory. Failure to be happy is treason.{}",
                }
            },
            j_unik_happiness_modest = {
                name = 'Happiness is Mandatory',
                text = {
                    "On spawn, turn the {C:attention}leftmost{} Joker", 
                    "and {C:attention}all{} equipped consumables {C:unik_shitty_edition}Positive{}", 
                    "Each hand played creates a",
                    "{C:unik_shitty_edition}Positive{} {C:attention}Eternal Banana Smiley Face{}",
                    "{C:red}Self destructs{} after maximum Joker slots becomes {C:attention}#1#{}" ,
                    "{C:red}On destruction{}, remove {C:attention}Eternal{} from {C:attention}all Smiley Faces.{}" ,
                    "{C:inactive,s:0.7,E:1}Happiness is mandatory. Failure to be happy is treason.{}",
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
                    "{C:unik_caption,s:0.7,E:1}Grawr Charble Grawr!{}",
                    "{C:dark_edition,s:0.7,E:2}Floating Sprite by : 70UNIK{}",
                    "{C:cry_exotic,s:0.7,E:2}Origin : Super Mario Bros.{}",
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
                    " above {C:attention}#3#x{} Blind requirements or",
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
            --1 in 4 chance to make it in line with Space Joker in modest
            j_unik_broken_arm_modest = {
                name = 'Broken Arm',
                text={
                    "{C:green}#4# in #5#{} chance to {C:red}Level down{}", 
                    "played {C:attention}poker hand{} by", 
                    "{C:attention}#1#{} level {C:attention}before{} each hand",
                    "{C:red}Self destructs{} when a level 1", 
                    "hand is played {C:attention}#2#{} times",
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
            j_unik_moonlight_cookie = { --unconditional ^1.25 mult per planet
                name = 'Moonlight Cookie',
                text = {
                    "{C:planet}Planet{} cards {C:attention}in your consumable area{}", 
                    "each give {X:dark_edition,C:white}^#1#{} Mult",
                    "Add {C:dark_edition}Negative{} to a random {C:planet}planet{}",
                    "in your possession per {C:attention}Blind Refresh{}", --Consistent while being a bit reasonable
                    "{C:unik_caption,s:0.7,E:1}#4#{}",
                    "{C:dark_edition,s:0.7,E:2}Floating Sprite by : 70UNIK{}",
                    "{C:cry_exotic,s:0.7,E:2}Origin : Cookie Run{}",
                }
            },
            j_unik_scratch = { 
                name = 'Scratch',
                text = {
                    "{C:cry_code}Code{} cards {C:attention}in your consumable area{}", 
                    "each give {C:mult}+#1#{} Mult",
                }
            },
            j_unik_moonlight_cookie_modest = { --^1.15 mult for specified poker hand
                name = 'Moonlight Cookie',
                text = {
                    "{C:planet}Planet{} cards {C:attention}in your consumable area{}", 
                    "each give {X:dark_edition,C:white}^#1#{} Mult for",
                    "their specified {C:attention}poker hand",
                    "{C:unik_caption,s:0.7,E:1}#4#{}",
                    "{C:dark_edition,s:0.7,E:2}Floating Sprite by : 70UNIK{}",
                    "{C:cry_exotic,s:0.7,E:2}Origin : Cookie Run{}",
                }
            },
            -- j_unik_moonlight_cookie_madness = { --^same as modest, but with an extra consumable slot
            --     name = 'Moonlight Cookie',
            --     text = {
            --         "{C:planet}Planet{} cards {C:attention}in your consumable area{}", 
            --         "each give {X:dark_edition,C:white}^#1#{} Mult",
            --         "{C:attention}+#2#{} Consumable Slot(s)",
            --         "{C:unik_caption,s:0.7,E:1}#3#{}",
            --         "{C:dark_edition,s:0.7,E:2}Floating Sprite by : 70UNIK{}",
            --         "{C:cry_exotic,s:0.7,E:2}Origin : Cookie Run{}",
            --     }
            -- },
            j_unik_celestial_of_chaos = { --^same as modest, but with an extra consumable slot
                name = 'The Celestial of Chaos',
                text = {
                    "{C:jen_RGB,E:1}Omega {C:planet}Planet{} cards {C:attention}in your consumable area{}", 
                    "each give {X:unik_void_color,C:unik_eye_searing_red}^^^#1#{} Mult",
                    "{C:attention}+#2#{} Consumable Slot(s)",
                    "{C:unik_caption,s:0.7,E:1}#3#{}",
                    "{C:dark_edition,s:0.7,E:2}Floating Sprite by : 70UNIK{}",
                }
            },
            j_unik_unik = { --mainline: ^0.03 chips
                name = 'UNIK',
                text = {
                    "This Joker gains {X:dark_edition,C:white}^#1#{} Chips", 
                    "for each {C:attention}7{} scored",
                    "{C:inactive}(Currently {X:dark_edition,C:white}^#2#{C:inactive} Chips)",
                    "{C:unik_caption,s:0.7,E:1}#3#{}",
                    "{C:dark_edition,s:0.7,E:2}Character and Floating Sprite by : 70UNIK{}",
                    "{C:cry_exotic,s:0.7,E:2}Origin : Just Shapes and Beats{}",
                }
            },
            j_unik_cube_of_calamity = { --mainline: ^0.03 chips
            name = 'The Cube of Calamity',
            text = {
                "This Joker gains {X:unik_void_color,C:unik_eye_searing_red}^^^#1#{} Chips", 
                "for each {C:attention}7{} scored",
                "{C:inactive}(Currently {X:unik_void_color,C:unik_eye_searing_red}^^^#2#{C:inactive} Chips)",
                "{C:unik_caption,s:0.7,E:1}#3#{}",
                "{C:dark_edition,s:0.7,E:2}Character and Floating Sprite by : 70UNIK{}",
            }
        },
            j_unik_unik_modest = { --modest: ^0.02 chips, ONLY once if a 7 is scored
                name = '{C:unik_unik_color}UNIK',
                text = {
                    "This Joker gains {X:dark_edition,C:white}^#1#{} Chips", 
                    "if played hand contains a scoring {C:attention}7{}",
                    "{C:inactive}(Currently {X:dark_edition,C:white}^#2#{C:inactive} Chips)",
                    "{C:unik_caption,s:0.7,E:1}#3#{}",
                    "{C:dark_edition,s:0.7,E:2}Character and Floating Sprite by : 70UNIK{}",
                    "{C:cry_exotic,s:0.7,E:2}Origin : Just Shapes and Beats{}",
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
                    "{C:unik_caption,s:0.7,E:1}I'll always be there for you and my family.{}",
                    "{C:dark_edition,s:0.7,E:2}Character and Floating Sprite by : 70UNIK{}",
                    "{C:cry_exotic,s:0.7,E:2}Origin : Just Shapes and Beats{}",
                },
            },
            j_unik_jsab_maya = { --epic: each non-face card played gains 0.75x chips, each non-face card held gains 0.25x chips
            --Increases by 1.3x chips if maya and chelsea are present
            --Her triggering does not trigger yokana and chelsea, but does help but providing more Xchips and more triggers for them (xchips + chips = double trigger)
            --Basically provided its not face cards, she's a souped up hiker
                name="{C:unik_maya_color}Maya Ramirez{}",
                text={
                    "{C:attention}Scored{} cards permanently gain {X:chips,C:white}X#1#{} Chips", --values will be exponented by ^0.3
                    "{C:attention}Held{} cards permanently gain {X:chips,C:white}X#2#{} Chips",
                    --"{C:inactive,s:0.8}If {C:unik_chelsea_color,s:0.8}Chelsea{C:inactive,s:0.8} and {C:unik_yokana_color,s:0.8}Yokana{C:inactive,s:0.8} are present, increase this by {X:chips,C:white,s:0.8}#3#X{}",
                    "{C:unik_caption,s:0.7,E:1}I'm here to help, but PLEASE be careful.{}",
                    "{C:dark_edition,s:0.7,E:2}Character and Floating Sprite by : 70UNIK{}",
                    "{C:cry_exotic,s:0.7,E:2}Origin : Just Shapes and Beats{}",
                },
            },
            
            j_unik_jsab_chelsea = { --epic: gains x0.07 chips for EVERY chips, xchips or ^chips trigger (pentationals and tettrati0onals included)
            --Increases by 1.3x if maya and yokana are present
                name="{C:unik_chelsea_color}Chelsea Ramirez{}",
                text={
                    "This Joker gains {X:chips,C:white}X#2#{} Chips when", --gain will become exponented by ^0.4 (around Exponentia)
                    "{C:chips}Chips{}, {X:chips,C:white}XChips{} or {X:dark_edition,C:white}^Chips{}, etc... trigger",
                    --"{C:inactive,s:0.8}If {C:unik_maya_color,s:0.8}Maya{C:inactive,s:0.8} and {C:unik_yokana_color,s:0.8}Yokana{C:inactive,s:0.8} are present, increase this by {X:chips,C:white,s:0.8}#3#X{}",
                    "{C:inactive}(Currently {X:chips,C:white}X#1#{C:inactive} Chips)",
                    "{C:unik_caption,s:0.7,E:1}#4#{}",
                    "{C:dark_edition,s:0.7,E:2}Character and Floating Sprite by : 70UNIK{}",
                    "{C:cry_exotic,s:0.7,E:2}Origin : Just Shapes and Beats{}",
                },
            },
            j_unik_jsab_chelsea_debuffed = { --godsmarble her family members, she will NOT help you anymore
                name="{C:unik_chelsea_color}Chelsea Ramirez{}",
                text={
                    "{C:red}All abilities are disabled... You monster.",
                    "{C:unik_caption,s:0.7,E:1}#4#{}",
                    "{C:dark_edition,s:0.7,E:2}Character and Floating Sprite by : 70UNIK{}",
                    "{C:cry_exotic,s:0.7,E:2}Origin : Just Shapes and Beats{}",
                },
            },
            j_unik_mutilated_mess = { --epic: gains x0.07 chips for EVERY chips, xchips or ^chips trigger (pentationals and tettrati0onals included)
            --Increases by 1.3x if maya and yokana are present
                name="The Mutilated Mess",
                text={
                    "This Joker gains {X:jen_RGB,C:white}^^#2#{} Chips when", --gain will become exponented by ^0.4 (around Exponentia)
                    "{C:chips}Chips{}, {X:chips,C:white}XChips{} or {X:dark_edition,C:white}^Chips{}, etc... trigger",
                    --"{C:inactive,s:0.8}If {C:unik_maya_color,s:0.8}Maya{C:inactive,s:0.8} and {C:unik_yokana_color,s:0.8}Yokana{C:inactive,s:0.8} are present, increase this by {X:chips,C:white,s:0.8}#3#X{}",
                    "{C:inactive}(Currently {X:jen_RGB,C:white}^^#1#{C:inactive} Chips)",
                    "{C:unik_caption,s:0.7,E:1}#3#{}",
                    "{C:dark_edition,s:0.7,E:2}Character and Floating Sprite by : 70UNIK{}",
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
                    "{C:red}Destroy{} {C:attention}all{} played cards except the", 
                    "{C:attention}leftmost{} played card after scoring",
                    "{C:unik_caption,s:0.7,E:1}#1#{}",
                    "{C:dark_edition,s:0.7,E:2}Floating Sprite by : 70UNIK{}",
                    "{C:dark_edition,s:0.7,E:2}Character by : Kaeofthekae{}",
                    "{C:cry_exotic,s:0.7,E:2}Origin : SPRUNKI{}",
                },                
            },
            j_unik_lily_sprunki_modest = {
                name="Lily",
                text={
                    "{C:red}Destroy{} played cards except the", 
                    "{C:attention}3 leftmost{} played cards after scoring",
                    "{C:unik_caption,s:0.7,E:1}#1#{}",
                    "{C:dark_edition,s:0.7,E:2}Floating Sprite by : 70UNIK{}",
                    "{C:dark_edition,s:0.7,E:2}Character by : Kaeofthekae{}",
                    "{C:cry_exotic,s:0.7,E:2}Origin : SPRUNKI{}",
                },                
            },
            j_unik_1_5_joker = {
                name="One-and-a-Half Joker",
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
                    "if Mult becomes {X:mult,C:white}X1{} or {C:attention}sold{} in Blind",
                    "Resets to {X:mult,C:white}X#3#{} Mult",
                    "at the start and end of {C:attention}Round{}",
                    "{C:inactive,s:0.7}(Hover off and on again to see the new Xmult){}",
                }, 
            },
            j_unik_no_standing_zone_modest = {
                name="No Standing Zone",
                text={
                    "{X:mult,C:white}X#1#{} Mult, decreases by ",
                    "{X:mult,C:white}X#4#{} every {C:attention}second{} in Blinds",
                    "and {X:mult,C:white}X#5#{} every {C:attention}second{} elsewhere",
                    "{C:red}Self destructs{} if Mult becomes {X:mult,C:white}X1{}.",
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
            },
            j_unik_impounded_modest = {
                name="Impound Notice",
                text={
                    "{C:red}Debuffs{} and adds {C:attention}Eternal and Rental{}",
                    " to a random Joker on spawn",
                    "{C:attention}Sell{} to remove debuff, Eternal and Rental",
                    "Selling costs {X:money,C:white}X#2#{} the total",
                    "{C:attention}selling price{} of debuffed Joker",
                    "{C:inactive,s:0.7}(Costs {C:money,s:0.7}$#3#{C:inactive,s:0.7} if no valid Joker owned){}",
                }
            },
            --this will not be disabled in almanac, since its a cursed joker that permanently makes values WORSE
            j_unik_rancid_smoothie = {
                name="Rancid Smoothie",
                text={
                    "{X:dark_edition,C:white}^#1#{} Mult {C:attention}after scoring{}",
                    "Selling will {C:red}divide{} values",
					"of owned jokers by {C:attention}#2#{}",
                }
            },
            j_unik_hook_n_discard = {
                name="Hook n' Discard",
                text={
                    "Discards {C:attention}2{} {C:attention}random{} cards per hand",
                    "{C:red}Self destructs{} after {C:attention}#1#{} {C:attention}consecutive{}",
					"discards with only {C:attention}2{} cards",
                    "or {C:unik_hook_color}The Hook{} is triggered",      
                    "{C:inactive}(Currently {C:attention}#3#{C:inactive} discards)",
                }
            },
            j_unik_vampiric_hammer = {
                name="Vampiric Hammer",
                text={
                    "{C:red}Remove{} card {C:attention}enhancements{} after scoring",
                    "{C:red}Self destructs{} when less than", 
                    "{C:attention}#1#{} {C:attention}Enhanced{} card(s) remain in deck or",
                    "{C:unik_orta_hammer_color}The Hammer (Ortalab){} is triggered",      
                    "{C:inactive}(Currently {C:attention}#2#{C:inactive} enhanced cards)",
                }
            },
            j_unik_monster_spawner = {
                name="Monster Spawner",
                text={
                    "Create {C:attention}1{} {X:cry_cursed,C:white}Cursed{} Joker",
                    "at end of Boss Blind", 
                    "{C:red}Self destructs{} after",
                    "creating {C:attention}#1#{} {X:cry_cursed,C:white}Cursed{} Jokers",
                    "{C:inactive}(Currently {C:attention}#2#{C:inactive} {X:cry_cursed,C:white}Cursed{C:inactive} Joker(s))",
                }               
            },
            --almanac version will create exotics
            j_unik_soul_fragment = {
                name="Soul Fragment",
                text={
                    "Sell this card to create a random",
                    "{C:attention}Eternal Disposable{}", 
                    "{C:legendary}Legendary{} Joker",
                    "{C:inactive}(Can overflow){}",
                }               
            },
            --almanac version will create wonderous, transdescendant and ritualistic jokers (except kosmos)
            j_unik_a_taste_of_power = {
                name="A Taste of Power",
                text={
                    "Sell this card to create a random",
                    "{C:attention}Absolute Niko{}", 
                    "{C:cry_exotic}Exotic{} Joker",
                    "{C:inactive}(Can overflow){}",
                }               
            },
            -- Upgrades on self destruction and destruciton, making her very resilient and synegises with dagger, ankh and additional gateways
            j_unik_white_lily_cookie = {
                name = 'White Lily Cookie',
                text = {
                    "This Joker creates a copy with {X:dark_edition,C:white}",
                    "an additional {X:dark_edition,C:white}^#2#{} Mult on {E:2,C:red}destruction{}",
                    "{E:2,C:red}Self destructs{} at the end of round",
                    "{C:inactive}(Currently {X:dark_edition,C:white}^#1#{C:inactive} Mult)",
                    "{C:inactive,s:0.7}(Removes stickers from copy){}",
                    "{C:red,s:0.7}(Cannot copy if destroyed by sticker effects, {C:cry_code,s:0.7}://COMMIT{C:red,s:0.7} or {C:cry_code,s:0.7}://REWORK{C:red,s:0.7}){}",        
                    "{C:red,s:0.4}(Cannot exceed {X:dark_edition,C:white,s:0.4}^e300{C:red,s:0.4} due to bignum copy bug){}",   
                    "{C:unik_caption,s:0.7,E:1}All I wanted was for everyone to be happy...{}", --TODO: adjustable quotes, for 
                    "{C:dark_edition,s:0.7,E:2}Floating Sprite by : 70UNIK{}",
                    "{C:cry_exotic,s:0.7,E:2}Origin : Cookie Run{}",
                }
            },
            j_unik_white_lily_cookie_modest = { --instead of +^1.1 per destruction, becomes +x1.25 Mult 
                name = 'White Lily Cookie',
                text = {
                    "This Joker creates a copy with {X:mult,C:white}",
                    "an additional {X:mult,C:white}X#4#{} Mult on {E:2,C:red}destruction{}",
                    "{E:2,C:red}Self destructs{} at the end of the {C:attention}shop{}",
                    "{C:inactive}(Currently {X:mult,C:white}X#3#{C:inactive} Mult)",
                    "{C:inactive,s:0.7}(Removes stickers from copy){}",
                    "{C:red,s:0.7}(Cannot copy if destroyed by sticker effects, {C:cry_code,s:0.7}://COMMIT{C:red,s:0.7} or {C:cry_code,s:0.7}://REWORK{C:red,s:0.7}){}",        
                    "{C:unik_caption,s:0.7,E:1}All I wanted was for everyone to be happy...{}",
                    "{C:dark_edition,s:0.7,E:2}Floating Sprite by : 70UNIK{}",
                    "{C:cry_exotic,s:0.7,E:2}Origin : Cookie Run{}",
                }
            },
            --banned in almanac due to persistent voucher bug when unredeeming
            j_unik_coupon_codes = {
                name="Coupon Codes",
                text={
                    "Redeem a {C:attention}random{} {C:attention}disposable{} Voucher",
                    "at the end of round",
                    "{C:green}#1# in #2#{} chance not to redeem another", 
                    "{C:attention}disposable{} Voucher",
                }         
            },
            -- there may already be a Dawn image in cryptid, so maybe dont add it?
            -- j_unik_dawn = {
            --     name="Dawn",
            --     text={
            --         "{X:mult,C:white}X#1#{} Mult",
            --         "only on {C:attention}first hand{}",
            --     }         
            -- },
            j_unik_vessel_kiln = { --overrides get tag function to instead generate Violet vessel, negating the benefit of this Joker. It's chips cause ceramic.
                name="Vessel Kiln",
                text={
                    "{X:chips,C:white}X#1#{} Chips",
                    "All future Tags",
                    "become {C:purple}Vessel Tags{}",
                }    
            },
            j_unik_noon = { --this would suck on black deck or with 3 hands...
                name="Noon",
                text={
                    "{X:mult,C:white}X#1#{} Mult",
                    "if {C:red}not{} the {C:attention}first{}",
                    " or {C:attention}last{} hand",
                }    
            },
            j_unik_extra_credit_alice = { 
                name = 'Alice',
                text = {
                    "{X:dark_edition,C:white}^#1#{} Mult and {X:dark_edition,C:white}^#2#{} Chips",
                    "if hand contains a scoring",
                    "{C:attention}Odd{} and {C:attention}Even{} card",
                    "{C:unik_caption,s:0.7,E:1}Teehee! It's time I join in on the fun!{}",
                    "{C:dark_edition,s:0.7,E:2}Floating Sprite by : 70UNIK{}",
                    "{C:dark_edition,s:0.7,E:2}Character by : KittyKnight{}",
                    "{C:cry_exotic,s:0.7,E:2}Origin : Balatro - Extra Credit{}",
                }
            }, 
            j_ExtraCredit_averagealice = { --overriding loc to include a 0.6% chance to get Alice on purchase
                name = 'Average Alice',
                text = {
                    "{C:white,X:mult}X#1#{} Mult if played",
                    "hand contains a scoring",
                    "{C:attention}Odd{} and {C:attention}Even{} card",
                    "{C:inactive,s:0.7}If obtained, fixed {C:green,s:0.7}0.8%{C:inactive,s:0.7} chance",
                    "{C:inactive,s:0.7}to obtain {C:cry_exotic,s:0.7,E:1}Alice {C:inactive,s:0.7}instead",
                }
            },
            j_unik_foundation = {
                name = 'Foundation',
                text = {
                    "After playing {C:attention}#2#{} {C:attention}consecutive{} hands",
                    "each containing at least 4 modified cards",
                    "with different ranks and suits",
                    "to cards in last hand,",
                    "sell this card to create",
                    "a {C:attention}random{} {C:cry_exotic,E:1}Exotic{} Joker",
					"{C:inactive}(Currently #1#/#2#){}",
                    "{C:inactive,E:1,s:0.7}It will be worth it in the end!{}",
                }
            },
            j_unik_broken_scale = {
                name = 'Broken Scale',
                text = {
                    "Scaling {C:attention}Jokers",
                    "scale {C:red}1/3 as fast{}",
                    "{E:2,C:red}Self destructs{}",
					"after {C:attention}#2#{} rounds",
                    "{C:inactive}(Currently {C:attention}#1#/#2#{C:inactive} rounds){}",
                }
            },
            j_unik_broken_scale_modest = {
                name = 'Broken Scale',
                text = {
                    "Scaling {C:attention}Jokers",
                    "scale {C:red}3/4 as fast{}",
                    "{E:2,C:red}Self destructs{}",
					"after {C:attention}#2#{} rounds",
                    "{C:inactive}(Currently {C:attention}#1#/#2#{C:inactive} rounds){}",
                }
            },

            --Override hunter loc to include "Red Rot"
            j_jen_hunter = {
                name = 'The Hunter',
                text = {
                    'Whenever {C:blue}current hands{} are below your {C:blue}maximum hands{},',
                    '{C:attention}refill{} your {C:blue}hands{} to the maximum',
                    '{C:red,s,E:1}Succumbs to the Rot after #1#, or selecting Red Rot Blind',
                    'When this Joker {C:red}dies to the Rot{},',
                    '{C:attention}create random {C:spectral}Spirits',
                    'equal to the {C:attention}cumulative number of',
                    '{C:blue}hands{} that this Joker has replenished',
                    '{C:inactive}(Currently #2#)',
                    '{C:inactive}(Selling this card at 7 rounds remaining creates Rot, but gives {C:red}no rewards{C:inactive})',
                    '{C:dark_edition,s:0.7,E:2}Floating sprite by : jenwalter666',
                    '{C:cry_exotic,s:0.7,E:2}Origin : Rain World',
                }
            },
            --override saint loc to allow foundations to produce exotics after 5 hands
            j_jen_saint = {
                name = 'The Saint',
                text = {
                    '{C:spectral}Gateway{} will {C:attention}not destroy Jokers{} when used',
                    '{C:cry_epic}Foundation{} requires only {C:attention}5{} hands played to activate',
                    'After using {C:attention}10 {C:spectral}Gateways{}, {C:jen_RGB}attune{} this Joker',
                    '{C:inactive,s:1.5}[{C:attention,s:1.5}#1#{C:inactive,s:1.5}/10]',
                    '{C:dark_edition,s:0.7,E:2}Floating sprite by : jenwalter666',
                    '{C:cry_exotic,s:0.7,E:2}Origin : Rain World',
                }
            },
            j_jen_saint_attuned = {
                name = 'The Saint {C:jen_RGB}(Attuned)',
                text = {
                    '{C:spectral}Gateway{} will {C:attention}not destroy Jokers{} when used',
                    '{C:cry_epic}Foundation{} is always {C:dark_edition}negative{} and activated {C:attention}immediately{}',
                    '{C:cry_ascendant}Yawetag{} also has {C:attention}no negative effect{} when used',
                    '{X:black,C:red,s:3}^^^3{C:purple} Chips & Mult',
                    '{C:dark_edition,s:0.7,E:2}Floating sprite by : jenwalter666',
                    '{C:cry_exotic,s:0.7,E:2}Origin : Rain World',
                }
            },
            --override attuned saint loc to force foundations to be negative and to produce exotics immediately.

            --ALMANAC + BUFFOONERY EXCLUSIVES--
            j_unik_buf_jen_kosmos_tea = { --godsmarble dorkshire tea from buffoonery, cause thats funny
                name = 'Kosmos\' Tea',
                text = {
                    "If hand contains exactly 6 cards",
                    "All scored cards become Tainted Ceramic",
                }
            },
            j_unik_double_container = {
                name = "Double Container",
                text = {
                    "{C:attention}Retrigger{} all {C:attention}held{} in",
                    "consumable effects {C:attention}#1#{} time(s)",
                    "{C:inactive,s:0.7}(Does not count for using consumables)",
                }
            }

        },
        Other={			
			undiscovered_unik_lartceps = {
				name = "Not Discovered",
				text = {
					"Use this card in an",
					"unseeded run to",
					"learn what it does",
				},
			},
            unik_depleted = {
                name = "Depleted",
                text = {
                    "Decrementing values {C:red}do{}",
                    "{C:red}not{} cause {C:red}self destruction{}",
                    "until at {C:attention}negative max{} value",
                    "or {C:attention}0{} for {X:mult,C:white}XMult{}",
                },
            },
            unik_impounded = {
                name = "Impounded",
                text = {
                    "Card is {C:red}debuffed{}",
                    "and has {C:purple}eternal{} and {C:attention}rental{}",
                    "until {C:red}Impound Notice{} is sold",
                    "{C:red}Unremovable{}",
                },
            },
            p_unik_cube_1 = {
				name = "Jumbo Cube Pack",
				text = {
					"Choose {C:attention}#1#{} of",
					"up to {C:attention}#2# Cube/Square Jokers{}",
				},
			},
            p_unik_cube_2 = {
				name = "Jumbo Cube Pack",
				text = {
					"Choose {C:attention}#1#{} of",
					"up to {C:attention}#2# Cube/Square Jokers{}",
				},
			},
            p_unik_extended_empowered = {
				name = "Spectral Pack [Extended Empowered Tag]",
				text = {
					"Choose {C:attention}#1#{} of up to",
					"{C:attention}#2#{C:spectral} Spectral{} card#<s>2#",
					"{s:0.8,C:inactive}(Generated by Extended Empowered Tag)",
				},
			},
            p_unik_cube_3 = {
				name = "Mega Cube Pack",
				text = {
					"Choose {C:attention}#1#{} of",
					"up to {C:attention}#2# Cube/Square Jokers{}",
				},
			},
            p_unik_lartceps_bundle = {
                name = "Lartceps Bundle",
				text = {
					"Choose {C:attention}#1#{} of",
					"up to {C:attention}#2# {X:unik_lartceps_inverse,C:unik_lartceps1}Lartceps{} Card#<s>2#{}",
					"{C:red}Unskippable{}",
				},
            },
            unik_decrementing_food_jokers = {
				name = "Decrementing Food Jokers",
				text = {
					"{s:0.8}Turtle Bean, Popcorn, Ramen,",
					"{s:0.8}Ice Cream and Clicked Cookie",
				},
			},
            unik_banned_ranks_foundation = {
                name = "Banned Cards",
				text = {
					"{C:red}Must not play",
					"{C:attention}#1#",
				},
            },
            unik_disposable = {
				name = "Disposable",
				text = {
					"{C:red}Destroys{} itself after",
					"{C:attention}each{} round",
				},
            },
            unik_niko = {
				name = "Niko",
				text = {
					"{C:red}Destroys{} itself after",
					"{C:attention}each{} round",
                    "{C:red}Unremovable{}",
				},
            },
            unik_disposable_consumable = {
                name = "Disposable",
				text = {
                    "{C:green}#1# in #2#{} chance to do",
                     "nothing on use",
					"{C:red}Destroys{} itself after",
					"{C:attention}each{} round",
				},
            },
            unik_disposable_voucher = {
				name = "Disposable",
				text = {
					"{C:red}Unredeems{} itself after",
					"{C:attention}each{} round",
				},
            },
            unik_disposable_booster = {
				name = "Disposable",
				text = {
					"All cards in pack",
					"are {C:attention}Disposable{}",
				},
            },
            unik_niko_consumable = {
                name = "Niko",
				text = {
                    "{C:green}#1# in #2#{} chance to do",
                     "nothing on use",
					"{C:red}Destroys{} itself after",
					"{C:attention}each{} round",
                    "{C:red}Unremovable{}",
				},
            },
            unik_niko_voucher = {
				name = "Niko",
				text = {
					"{C:red}Unredeems{} itself after",
					"{C:attention}each{} round",
                    "{C:red}Unremovable{}",
				},
            },
            unik_niko_booster = {
				name = "Niko",
				text = {
					"All cards in pack",
					"are {C:attention}Niko{}",
                    "{C:red}Unremovable{}",
				},
            },
            unik_triggering = {
                name = "Triggering",
                text = {
                    "{C:inactive}Does nothing...",
					"{C:inactive}for now",
                }
            },
            unik_triggering_playing_card = {
                name = "Triggering",
                text = {
                    "{C:green}#1# in #2#{} chance to {C:attention}play{}",
					"selected cards when {C:attention}selected{}",
                }
            },
            unik_triggering_joker = {
                name = "Triggering",
                text = {
                    "{C:attention}Automatically{} {C:red}sold{}",
					"when {C:attention}selected{}",
                }
            },
            unik_triggering_consumeable = {
                name = "Triggering",
                text = {
                    "{C:attention}Automatically used{} when",
					"possible (left to right)",
                }
            },
            unik_triggering_booster = {
                name = "Triggering",
                text = {
                    "All cards in pack",
					"are {C:attention}Triggering{}",
                }
            },
            unik_triggering_voucher = {
                name = "Triggering",
                text = {
                    "{C:inactive}Does nothing...",
					"{C:inactive}for now",
                }
            },
            unik_ultradebuffed = { --exclusively produced by placard; immune to patch or dandy
                name = "Ultradebuffed",
                text = {
                    "Card is {C:red}debuffed{}",
                    "{C:red}permanently{}, {C:attention}regardless{}",
                    "of Jokers or other modifiers",
					"{C:red}Unremovable{}",
                }
            }

        },
        Planet={},
        Spectral={
            --only appears with a 0.3 chance in the cube booster pack. It's basically a gateway, but exclusively creating UNIK 
            c_unik_gateway = {
				name = "Hypercube",
				text = {
					"Create {C:cry_exotic,E:1}UNIK{}",
					"{C:red}destroy{} all",
					"other Jokers",
				},
			},
        },
        Stake={
            stake_unik_shitty = {
				name = "Shitty Stake",
				colour = "Shitty", --this is used for auto-generated sticker localization
				text = {
					"Jokers can be {C:attention}Disposable{}",
					"{s:0.8,C:inactive}({s:0.8,C:red}Destroyed {s:0.8,C:inactive}after round){}",
				},
			},
            stake_unik_persimmon = {
				name = "Persimmon Stake",
				colour = "Persimmon", --this is used for auto-generated sticker localization
				text = {
					"All cards can be {C:attention}Triggering{}",
					"{s:0.8,C:inactive}({s:0.8,C:green}1 in 8{s:0.8,C:inactive} chance to {s:0.8,C:attention}play{s:0.8,C:inactive} cards when selected){}",
                    "{s:0.8,C:inactive}(Consumeables automatically {s:0.8,C:attention}trigger{s:0.8,C:inactive} when possible){}",
                    "{s:0.8,C:inactive}(Jokers automatically {s:0.8,C:red}sell {s:0.8,C:inactive}when selected){}",
				},
			},
        },
        Tag={			
            --to even be remotely safe to use, you need yes nothing! Yes I am making more stuff that reles on yes nothing since there isnt enough stuff that needs it (wheel, tornado, glass cards,cavendish,banana tag)
            tag_unik_demon = {
                name = "Demon Tag",
                text = {
                    "{C:green}#1# in #2#{} chance to either",
                    "create a {X:cry_cursed,C:white}Cursed{} Joker,",
                    "{C:red}destroy{} a {C:attention}random{} Joker,",
                    "create a {C:unik_manacle_color}Handcuffs Tag{},",
                    "add {C:unik_shitty_edition}Positive{} to a {C:attention}random{} Joker,",
                    "or create a {C:purple}Vessel Tag",
                    "Otherwise, create an",
                    "{C:cry_exotic,E:1}Extended Empowered Tag",
                },
            },
            tag_unik_vessel = {
                name = "Vessel Tag",
                text={
                    "{C:red}#1#x{} Requirements",
                    "next round",
                },
            },
            tag_unik_manacle = {
                name = "Handcuffs Tag",
                text = {
                    "{C:red}#1#{} hand size",
                    "next round",
                }
            },
            tag_unik_positive = {
                name = "Positive Tag",
                text = {
                    "Next base edition shop",
                    "Joker is free and",
                    "becomes {C:unik_shitty_edition}Positive",
                }
            },
			tag_unik_extended_empowered = {
				name = "Extended Empowered Tag",
				text = {
					"Gives a free {C:spectral}Spectral Pack",
					"with {C:legendary,E:1}The Soul{}, {C:cry_epic,E:1}Foundation{} and {C:cry_exotic,E:1}Gateway{}",
				},
			},
        },
        Tarot={
            c_unik_wheel_of_misfortune = {
                name = "The Evocation",
                text = {
                    "{C:green}#1# in #2#{} chance to create ",
                    "a {X:cry_cursed,C:white}Cursed{} Joker",
                    "otherwise apply {C:dark_edition}Negative{}, {C:dark_edition}Mosaic{},",
                    "or {C:dark_edition}Astral{} to a {C:attention}random{} Joker",
                }
            }
        },
        unik_lartceps = {
            c_unik_rip_girlfriend = {
                name = "Powerdown",
                text = {
                    "{C:attention}Randomly{} {E:2,C:red}Destroy 50%{} of",
                    "Jokers, Consumables and Cards",
                    "{C:attention}including{} {C:purple}Eternals{},",
                    "then {E:2,C:red}halve{} {C:attention}all{} hand statistics",
                }
            },
            c_unik_placard = {
                name = "Placard",
                text = {
                    "Add {C:purple}Absolute{} and {E:2,C:red}Ultradebuffed{}", --Brute force counters dandy (through update functions) and patch
                    "to all cards in deck",
                }
            },
            c_unik_brethren_moon = { --worse than epic arm; Note that mult will always remain zero (otherwise the negatives cancel each other out)
                name = "Brethren Moon",
                text = {
                    "For {C:attention}all{} hands, set {C:mult}mult{} to {E:2,C:red}0{}",
                    "{C:chips}chips{} to {E:2,C:red}negative{} and",
                    "all levels to {E:2,C:red}0{}"
                }
            },
            c_unik_trim = {
                name = "://TRIM",
                text = {
                    "{E:2,C:red}Remove{} {C:attention}all{} empty",
                    "Joker slots, then",
                    "{E:2,C:red}halve{} remaining",
                    "Joker slots",
                }
            },
            c_unik_escalation_cryptid = {
                name = "Escalation",
                text = {
                    "{X:unik_void_color,E:2,C:red}^#1#{} {C:attention}ante{}",
                }
            },
            c_unik_escalation_almanac = {
                name = "Escalation",
                text = {
                    "{X:unik_void_color,E:2,C:red}X#1#{} {C:attention}ante{},",
                    "{X:unik_void_color,E:2,C:red}^#2#{} {C:cry_ember}Tension{},",
                    "Activates {C:attention}Straddle{}",
                }
            },
            c_unik_expiry = {
                name = "Expiry",
                text = {
                    "{E:2,C:red}Unredeem{} and {E:2,C:red}Banish{}",
                    "{C:attention}all{} owned vouchers",
                }
            },
            c_unik_extortion = {
                name = "Extortion",
                text = {
                    "Set {C:gold}money{} to {E:2,C:red}-$#1#{}", -- -$6666
                }
            },
            c_unik_single = {
                name = "The Single",
                text = {
                    "Set hand size to {E:2,C:red}1{}", -- 1
                }
            },
            c_unik_garbage = {
                name = "Garbage",
                text = {
                    "{C:attention}Add{} {E:2,C:red}#1#{} {E:2,C:red}random{}",
                    "cards to deck", 
                }
            },
            c_unik_reeducation = {
                name = "Reeducation",
                text = {
                    "{C:attention}All{} Jokers, Consumeables",
                    "and cards become {C:unik_shitty_edition}Positive{},",
                    "{C:unik_shitty_edition}Bloated{}, {C:unik_shitty_edition}Half{},",
                    "{C:unik_shitty_edition}Fuzzy{} or {C:unik_shitty_edition}Corrupted{}",
                }
            },
            c_unik_hellspawn = {
                name = "Hellspawn", -- DEFAULT
                text = {
                    "{E:2,C:red}Add #1#{} {X:cry_cursed,C:white}Cursed{} Jokers",
                    "{C:inactive,s:0.5}(Temporarily create a showman in the process)", 
                }
            },
            c_unik_blank_lartceps = {
                name = "Blank Lartceps",
                text = {
                    "{C:attention}Copies{} the last used",
                    "{X:unik_lartceps_inverse,C:unik_lartceps1}Lartceps{} card", 
                }
            },
            c_unik_sauron = {
                name = "The Sauron",
                text = {
                    "Convert {C:green}#1# in #2#{} cards",
                    "in deck to {X:unik_lartceps_inverse,C:unik_lartceps1}Namta{} cards", 
                }
            }
        },
        Voucher={},
    },
    misc = {
        achievement_descriptions={

            ach_unik_royal_poker="Score a Royal Flush against Video Poker",
            ach_unik_space="Own Satellite, Space Joker, Observatory, Perkeo and Moonlight Cookie at the same time",
            ach_unik_magnet_full_deck="Defeat Maroon Magnet while owning Efficinare",
            ach_unik_unik="Gain UNIK outside of DoE, Antimatter or Wormhole deck",
            ach_unik_rng_ii="Beat the RNG II challenge",
            ach_unik_average_alice="Gain Alice from obtaining Average Alice",
            ach_unik_legendary_blinds="Survive against a Legendary Blind",
            ach_unik_stupid_summoning="Rig an Evocation and use it",
            ach_unik_bloodbath="Have an Oops! All 6s and gain a Demon Tag",
            ach_unik_all_cursed_jokers="Own every Cursed Joker in the collection",
            ach_unik_all_debuffs="Have all your cards and Jokers become debuffed",
            ach_unik_turtle_beaned="Die from 0 hand size due to Depleted Turtle Beans",
            ach_unik_epic_fail="Score under -1.79e308 chips in a single hand",
            ach_unik_royal_fail="Score a Royal Flush against Video Poker and die anyway",
            ach_unik_death_star_moonlight="Own Stella Mortis and Moonlight Cookie without Perkeo at the same time",
            ach_unik_abyss="Die to a Legendary Blind",
        },
        achievement_names={
            ach_unik_royal_poker="Jackpot!",
            ach_unik_space="Spacefarer",
            ach_unik_magnet_full_deck="Big Hand, Iron Fist",
            ach_unik_unik="Self-Insert",
            ach_unik_rng_ii="Dicey",
            ach_unik_average_alice="Alice in Wonderland",
            ach_unik_legendary_blinds="Dante's Inferno",
            ach_unik_stupid_summoning="Stupid Summoning", --done
            ach_unik_bloodbath="Bloodbath 1%", --done
            ach_unik_all_cursed_jokers="Dial 666 to see your UAC spokesperson",
            ach_unik_all_debuffs="Debuffs, Debuffs Everywhere",
            ach_unik_turtle_beaned="Turtle Beaned",
            ach_unik_epic_fail="Epic Fail", --done
            ach_unik_royal_fail="Royal Fuck",
            ach_unik_death_star_moonlight="That's No Moon Light!", --done
            ach_unik_abyss="The Abyss", --done
        },
        blind_states={},
        challenge_names={
            c_unik_lily_goes_fucking_berserk="Devourer",
            c_unik_chips_only="ChipZel",
            c_unik_mult_only="Multiplication",
            c_unik_common_muck="Common Muck",
            c_unik_boss_rush_2="Enter the Gungeon II",
            c_unik_boss_rush_3="Enter the Gungeon III", --
            c_unik_rng_2="RNG II",
            c_unik_video_poker_1="Jacks or Better",
            c_unik_video_poker_2="Jacks or Better II",
            c_unik_rush_hour_4="Rush Hour IV",
            c_unik_coupon_codes_only="TEMU Vouchers", --No vouchers spawn, start with 4 negative absolute coupon codes and 2 negative KEYGENs. AKA: Vouchers become temporary powerups that cycle per round
            c_unik_monsters="Monsters",
        },
        collabs={},
        dictionary={
            k_unik_lartceps="Lartceps",
            b_unik_lartceps_cards = "Lartceps Cards",
            unik_legendary_blinds_option = "Legendary Blinds (Restart Required)",
            unik_almanac_fusions_in_cryptid_option = "Enable Almanac Fusions in Base Cryptid (Restart Required)",
            k_unik_711="7-Eleven!",
            k_unik_happiness1="HAPPINESS.",
            k_unik_happiness2="HAPPINESS IS MANDATORY.",
            k_unik_happiness3="TREASON!",
            k_unik_nuked="DIE.          NOW.",
            k_unik_common_jokers="At least 60% of owned Jokers must be Common",
            k_unik_artisan_builds="aNd ThErE\'s ThE ReRoLlLl!!!!111!!!!",
            k_unik_artisan_builds_epic='"GIVE ME THE F-CKING COMPUTER, JIMBO!!!!"',
            k_unik_artisan_builds_epic_lose='"FINE, YOU F-CKING COWARD, NOW DIE!!!!"',
            k_unik_artisan_builds_epic_line2="If tension is < 23,", --aka you're forced to progress straddle with this. This will be bumped up to 33 in v0.0.9
            k_unik_artisan_builds_epic_line3="On Blind Select, die",
            k_unik_artisan_builds_epic_line2alt="If less than ", 
            k_unik_artisan_builds_epic_line2alt2=" rerolls are done this ante,", 
            k_unik_artisan_builds_epic_placeholder="If less than (rerolls this run)^1.1 rerolls are done this ante,",
            k_unik_pentagram_start="Hell's Legion is coming...",
            k_unik_pentagram_purified="Sent to hell!",
            k_unik_batman_start='"You WILL ALL be forgotten, Jokers. Because of me."',
            k_unik_legendary_batman_start='"I\'m doing what YOU won\'t! I\'m taking them out."', -- red hood
            k_unik_magnet_start='The age of steel is over...',
            k_unik_magnet_legendary_start='Torture and agony baked in iron.',
            k_unik_nuke_start="Nuclear war is coming...",
            k_unik_legendary_nuke_start='"Jesus Christ! They\'ve done it... They\'ve done it!"', --threads 1984
            k_unik_placard_start="NO PLACARDED LOADS IN PLAY",
            k_unik_boo_start="Bigger Boo wants to know your location",
            k_unik_rot_start='"I cannot help you. I cannot even help myself."', --Five Pebbles
            k_unik_goalpost_start= '"I am altering the deal. Pray I don’t alter it any further."', -- darth vader, moving the goalposts
            k_unik_protection_racket_start='"The government has organized a protection racket."',
            k_unik_video_poker_start='#1 Classic Video Poker Games Worldwide!',
            k_unik_epic_cookie_start='"Cookies are mean\'t to be eaten!"',
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
            k_unik_blind_start_hook="The Hook",
            k_unik_blind_start_orta_hammer="The Hammer (Ortalab)",
            k_unik_orta_hammer_stripped="Stripped!",
            k_unik_arm_downgrade="Downgrade!",
            k_unik_hooked="Discarding!",
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
            k_unik_white_lily_not_committed="(Not committed)",
            k_unik_white_lily_committed="(Committed)",
            k_unik_lily_sprunki_after="oh... oh... god...",
            k_unik_no_standing_towed="Towed Away!",
            k_unik_impounded="Impounded!",
            k_unik_debt="Not Enough Money!",
            k_unik_poppy_placeholder="(2.5x requirements)",
            k_unik_nuke_placeholder="(3x requirements)",
            k_unik_legendary_nuke_placeholder="(^1.666 requirements)",
            k_unik_vice_placeholder ="(halved Final Boss spawn ante requirements)",
            k_unik_vice_placeholder2 ="(2x requirements)",
            k_unik_batman_placeholder="(80% of)",
            k_unik_epic_box_placeholder="(60%)",
            k_unik_magnet_placeholder="(50% of)",
            k_unik_racket_warning="Must have at least $40",
            k_unik_magnet_warning="Must not hold any Steel Cards",
            k_unik_magnet_legendary_warning="Must not hold or play any Steel Cards",
            k_unik_legendary_pentagram_start='"Dial 666 to see your UAC representative!"',
            k_unik_legendary_pentagram_die="YOU CAN'T DO THAT",
            k_unik_video_poker_warning="High cards are banned and pairs must have scoring Jacks or Better",
            k_unik_spawned="Spawned!",
            k_unik_disposed="Disposed!",
            k_unik_you_killed_niko="You Killed Niko.",
            k_unik_taste_of_power="Enjoy it while it lasts!",
            ph_unik_instakill_hand="YOU WILL DIE.",
            k_unik_die="DIE.",
            k_unik_only_stone="Must not play cards with ranks or suits",
            k_unik_boss_immune="YOU CANNOT STOP IT",
            k_unik_boss_reroll_nope="YOU CANNOT CHANGE YOUR FATE",
            unik_debuff_no_pairs="No Pairs",
            k_unik_average_alice="Average!",
            k_unik_active="Active!",
            k_unik_viced="Final Bosses now appear twice as often",
            k_unik_cube_pack = "Cube Pack",
            k_unik_lartceps_bundle = "Lartceps Bundle",
            k_unik_lartceps_pack = "Lartceps Pack",
            k_unik_hands_remaining = " scoring hands remaining",
            k_unik_base = " base",
            k_unik_high_score = " = Best hand in Run",
            k_unik_legendary_crown_start="",
            k_unik_legendary_crown_defeat_x_times1="Defeat this blind ",
            k_unik_legendary_crown_defeat_x_times2=" time(s)",
            k_unik_legendary_crown_placeholder="(Current hands)",
            k_unik_odd_and_even = "(Scoring odd and even)",
            k_unik_cards="cards",
            k_unik_debuffed_card_only="Must only play debuffed cards",
            k_unik_xenomorph_start='"Get away from her, you bitch!"',
            k_unik_darth_vader_start='"Be careful not to choke on your aspirations, Director."',
            --placeholder fusion rarities
            k_unik_transcendent_placeholder = "Transcendent",
            k_unik_ritualistic_placeholder = "Ritualistic",
            k_unik_hurry_up="IMPOUNDMENT SOON",
            k_unik_hurry_up2="IMPOUNDMENT IMMINENT",
            k_unik_shackle1="Permanently reduce", --jen
            k_unik_shackle2="Reduce", --jenless
            k_unik_reed_placeholder="(3 random ranks from deck)",
            k_unik_reed_part1 = "a",
            k_unik_reed_part2 = "or",
            k_unik_epic_sand_placeholder = "(Tags held)",
            k_unik_half = "Half",
            

            --Godsmarble ramirez family members
            k_unik_family_disabled = "All abilities are disabled...",
            k_unik_family_disabled2 = "...you monster.",
            k_unik_family_disabled3 = "(They are no longer willing to help, after what you did.)",
            --Almanac Quotes:

            --Moonlight Cookie: She will be the first Joker with full almanac functionality (has a fusion, different quotes)
            ---Normal:
            k_unik_moonlight_normal1 = "May I wish you happy dreams...",
            k_unik_moonlight_normal2 = "The stars dance and the dreams flow...",
            k_unik_moonlight_normal3 = "It will be nice to dream for a while...",
            ---Scared:
            k_unik_moonlight_scared1 = "Is this is what nightmares are made of...?",
            ---Godsmarble Near:
            k_unik_moonlight_godsmarble1 = "Oh god... What are those thoughts...?",
            k_unik_moonlight_godsmarble2 = "Get this thing away from me...!",
            k_unik_moonlight_godsmarble3 = "I... something is happening to me...!",
            ---Godsmarbled: The Celesial of Chaos
            k_unik_celestial_of_chaos1 = "DARKNESS SHALL COVER THE UNIVERSE...",
            k_unik_celestial_of_chaos2 = "I'LL PLUNGE THE WORLD INTO THE VOID...",
            k_unik_celestial_of_chaos3 = "IT DOESN'T MATTER DOESN'T IT?",

            --Unik
            ---Normal:
            k_unik_unik_normal1 = "Maybe you don't mind I'm crossdressing here...",
            k_unik_unik_normal2 = "I'll help out here, although I'll take my time.",
            k_unik_unik_normal3 = "Quite an experience, wearing this here...",
            k_unik_unik_normal4 = "I can admittedly be a bit dreary at times...",
            k_unik_unik_normal5 = "Let me know what I can help out with.",
            k_unik_unik_normal6 = "Umm, hi... Can't believe I'm here now...",
            ---Scared:
            k_unik_unik_scared1 = "Wh... IT'S TOO MUCH!!!",
            k_unik_unik_scared2 = "PLEASE STOP! I can't handle this!",
            k_unik_unik_scared3 = "The fuck is all this?!",
            ---Godsmarble Near:
            k_unik_unik_godsmarble1 = "I... I... am.... F A L L I N G...",
            k_unik_unik_godsmarble2 = "WHAT IS HAPPENING TO ME?!",
            k_unik_unik_godsmarble3 = "That thing is doing... Something to me!...",
            k_unik_unik_godsmarble4 = "WHY DID YOU PUT THAT HERE?! IT... MY MIND...!",
            k_unik_unik_godsmarble5 = "IT HURTS SO MUCH... IT HURTS...",
            k_unik_unik_godsmarble6 = "It hurts... Why are you... doing... this...",
            k_unik_unik_godsmarble7 = "*sobbing* *sob*",
            ---Godsmarbled: Cube of Calamity (basically I lose myself into mindlessness similar to Giygas)
            k_unik_cube_of_calamity1 = "I   F E E L...    B A D...",
            k_unik_cube_of_calamity2 = "I   C A N ' T...",
            k_unik_cube_of_calamity3 = "F A L L I N G...",
            k_unik_cube_of_calamity4 = "ITHURTSITHURTSITHURTSI T H U R T S...",
            k_unik_cube_of_calamity5 = "G E T O U T G E T O U T...",
            k_unik_cube_of_calamity6 = "I M S O R R Y I M S O R R Y...",
            k_unik_cube_of_calamity7 = "Y O U...",
            k_unik_cube_of_calamity8 = "A A A A A A A A A A A A A A A A A A...",
            k_unik_cube_of_calamity9 = "N O T H I N G...   L E F T...",
            --Chelsea
            ---Normal:
            k_unik_chelsea_normal1 = "Hola! Maybe I can help out?",
            k_unik_chelsea_normal2 = "What is all this? Everything is quite different...",
            k_unik_chelsea_normal3 = "Hey, is it alright if I do something here?",
            k_unik_chelsea_normal4 = "I miss being with my family...",
            k_unik_chelsea_normal_1member = "Mom! It's nice to not be alone for once...",
            k_unik_chelsea_normal_family = "Oh! Maya, Yokana! I'm glad you two are here!",

            --godsmarble maya
            k_unik_chelsea_normal_maya_god1 = "Mom! Maya! What happened to you?!",
            k_unik_chelsea_normal_maya_god2 = "Oh god… Why did you do this to her?!",
            
            --godsmarble yokana
            k_unik_chelsea_normal_yokana_god1 = "Mom! Can you hear me? Please?!",
            k_unik_chelsea_normal_yokana_god2 = "I don't want to hurt you… Please are you still here?...",

            --both parents godsmarbled
            k_unik_chelsea_normal_family_god1 = "You... Monster...",
            k_unik_chelsea_normal_family_god2 = "Get... Out...",
            k_unik_chelsea_normal_family_god3 = "*Sob* *Sob*",
            k_unik_chelsea_normal_family_god4 = "Why did you do this to us...",
            ---Scared:
            k_unik_chelsea_scared1 = "It's getting too much for me!",
            k_unik_chelsea_scared2 = "¡Dios mío! What is going on??!",
            ---Godsmarble Near:
            k_unik_chelsea_godsmarble1 = "My arms are pulling apart!... It hurts...!",
            k_unik_chelsea_godsmarble2 = "I feel so tight... My body is burning up...!",
            k_unik_chelsea_godsmarble3 = "AAAAaaaaAAAARRRGHHH!!",
            k_unik_chelsea_godsmarble4 = "IT HURTS SO MUCH!!!!",
            k_unik_chelsea_godsmarble5 = "WAAAHHH!... aaarrgghhh...",
            k_unik_chelsea_godsmarble6 = "(Uncontrollable crying)",
            k_unik_chelsea_godsmarble_parents = "Mommy! Please... Help... Me...",
            k_unik_chelsea_godsmarble_parents_gods = "Why..........",
            ---Godsmarbled: mutilated mess (chelsea gets her limbs, wings, ears ripped out, horrifically burned. Think like Curly from Mouthwashing)
            k_unik_mutilated_mess1 = "AAAAAAAAAAAAAAAAAA…A.AA.A..A.A.A.AAAAAAAAHHHH...",
            k_unik_mutilated_mess2 = "Uuurggh... aarrrghh... AAAAAAA...arrgghh...",
            k_unik_mutilated_mess3 = "*Sob* *Sob* *Sob* *Sob*",
            k_unik_mutilated_mess4 = "H.....H—hurts.....",
            k_unik_mutilated_mess5 = "(Nothing but uncontrollable crying)",

            --
            unik_plus_lartceps = "+1 Lartceps...",
            k_unik_copied = "Copied...",
            k_unik_epic_sand_cry_1 = "^2 Blind size",
            k_unik_epic_sand_cry_2 = "per tag held",
            k_unik_tag="tags",
            k_unik_epic_sand_almanac_1 = "Increase blind size",
            k_unik_epic_sand_almanac_2 = "by {Tags held}1.1",
            k_unik_epic_vice_placeholder = "(5, increase by ^1.05 per Tukehtumisenpahe)"

        },
        high_scores={},
        labels={
            unik_steel="Steel",
            unik_positive="Positive",
            unik_halfjoker = "Half",
            unik_bloated="Bloated",
            unik_fuzzy="Fuzzy",
            unik_corrupted="Corrupted",
            unik_depleted = "Depleted",
            unik_impounded = "Impounded",
            unik_niko = "Niko",
            unik_disposable = "Disposable",
            unik_lartceps = "Lartceps",
            unik_triggering = "Triggering",
            unik_ultradebuffed = "Ultradebuffed",
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
            special_lose_unik_red_rot={ --red rot
                "I do suggest not",
                "entering Five Pebbles",
                "with the condition he has!",
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
            --getting killed by magnet
            special_lose_unik_magnet={
                "Seems like you lack",
                "balls of steel!",
            }, 
            special_lose_unik_magnet_legendary={
                "Maybe try holding",
                "onto a vacuum!",
            }, 
            special_lose_unik_vessel_legendary={
                "The panopicon would",
                "help with this...",
            },
            special_lose_unik_nuke_legendary={
                "Maybe don't score above",
                "^1.666 requirements...",
            },
            special_lose_unik_tornado_legendary={
                "Keep your scoring consistent",
                "and have a blank die next time...",
            },
            special_lose_unik_sword_legendary={
                "Maybe practice single",
                "high card scoring...",
            },
            special_lose_unik_pentagram_legendary1={
                "Some monsters",
                "can't be killed...",
            },
            special_lose_unik_pentagram_legendary2={
                "You should've invested",
                "in a Gellar Field",
            },
            --getting killed by video poker
            special_lose_unik_video_poker={
                "Maybe try playing the",
                "actual Video Poker game!",
            }, 
            special_lose_bigger_blind={
                "It does nothing and",
                "you just died. Wow.",
            },
            special_lose_unik_artisan_builds_epic={
                "Wow, given that Noah Katz",
                "is now an international criminal", --not really, just saying that as part of the blind, but yeah, he is still shitty
                "you should've armed yourself here...",
            },
            special_lose_unik_epic_collapse={
                "Hmm, maybe that other",
                "Epic Blind could've",
                "helped out here...",
            },
            special_lose_unik_epic_box={
                "Have you've forgotten",
                "about me and Jimbo?",
            },
            special_lose_unik_cookie={
                "Don't get addicted",
                "to Cookie Clicker!",
            },
            special_lose_unik_epic_cookie={
                "What? Are you a fucking",
                "liar like Gingerbrave?",
                "Don't be like him.",
            },
            special_lose_unik_legendary_crown={
                "Over 322 people have died",
                "on this summit.",
                "You're now one of them.",
            },
            special_lose_unik_epic_xenomorph={
                "Game over man!",
                "Game Over!",
            },
            special_lose_unik_epic_darth_vader={
                "He isn't the most feared",
                "Sith lord for nothing...",
            },
            special_lose_unik_epic_shackle={
                "Better fill up your",
                "Joker slots!",
            }
        },
        ranks={},
        suits_plural={},
        suits_singular={},
        tutorial={},
        v_dictionary={
            a_eblindsize = {"^#1# Blind Size"},
            a_EEchips = { "^^#1# Chips" },
            a_hyper_three_chips = { "^^^#1# Chips" },
            a_hyper_three_mult = { "^^^#1# Mult" },
            a_unik_hands_1={"#1# hands"},
            a_unik_discards_1={"#1# discards"},
            a_unik_reed_construct={"ranks #1# or #2#"}
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
            --ITS ALL HELL FROM HERE
            ch_c_unik_obsidian_swarm = {"{C:attention}Final{} blind of {C:attention}each ante{} is always the {C:red}Obsidian Orb{}"},
            ch_c_unik_ante_12_victory = {"Must beat Ante {C:attention}10{} to win"},
            ch_c_unik_ante_13_victory = {"Must beat Ante {C:attention}13{} to win"},
            ch_c_unik_vermillion_pandemic = {"One {C:attention}random{} Joker {C:red}replaced{} after every hand"},
            ch_c_unik_all_video_poker = {"All Boss Blinds are {X:unik_eye_searing_blue,C:money}Video {X:unik_eye_searing_blue,C:money}Poker{}"},
            ch_c_unik_purple_scaling = {"Required score {C:attention}scales{} fast as {C:purple}Purple Stake{}"},
            ch_c_unik_legendary_at_any_time = {"{X:unik_void_color,C:unik_eye_searing_red}LEGENDARY{X:unik_void_color,C:unik_eye_searing_red} BLINDS{X:unik_void_color,C:unik_eye_searing_red} {X:unik_void_color,C:unik_eye_searing_red}CAN {X:unik_void_color,C:unik_eye_searing_red}SPAWN {X:unik_void_color,C:unik_eye_searing_red}ANY {X:unik_void_color,C:unik_eye_searing_red}TIME.{}"},
            ch_c_unik_cursed_only = {"All boss blinds are {C:attention}The Decision{} and {C:attention}Purple Pentagram{}"},
        },
    },
}