return {
    descriptions = {
        Back={
            b_ghost = {
                name="Ghost Deck",
                text={
                    "Start with {C:dark_edition,T:v_unik_spectral_merchant}Spectral Merchant",
                    "and a {C:spectral,T:c_hex}Hex{} card",
                },
            },
            b_unik_polychrome = {
                name = "Polychrome Deck",
                text = {
                    "Start with a",
                    "{C:dark_edition,T:c_unik_prism}Prism{} and {C:spectral,T:c_deja_vu}Deja Vu",
                }
            },
            b_unik_steel = {
                name = "Steel Deck",
                text = {
                    "Start with a",
                    "{C:dark_edition,T:c_unik_foundry}Foundry{} and {C:spectral,T:c_deja_vu}Deja Vu",
                }
            },
            --Earn $2 per hand lost, earn $1 per discard lost. Earn no interest
            b_unik_greed = {
                name = "Greed Deck",
                text = {
                    "{C:money}$#1#{s:0.85} per {C:blue}Hand lost",
                    "{C:money}$#2#{s:0.85} per {C:red}Discard lost",
                    "Earn no {C:attention}Interest",
                }
            },
            --+3 hands, -1 joker slot
            b_unik_white = {
                name = "White Deck",
                text = {
                    "{C:blue}+#2#{} hands",
                    "every round",
                    "{C:attention}-#1#{} Joker slot",
                }
            },
            b_unik_pink = {
                name = "Pink Deck",
                text = {
                    "Start with two {C:purple,T:c_unik_crossdresser}Crossdressers{}",
                    "All 7s are replaced with",
                    "Pink Cards",
                }                
            },
            -- +1 Hand Size
            b_unik_tricolor = {
                name = "Tricolor Deck",
                text = {
                    "{C:attention}+#1#{} Hand Size",
                }
            },
            
        },
        BlindEdition={
            ble_unik_steel={
                name = "Steel",
                text = {
                    "Each held card increases",
                    "blind size by #1#x",
                }
            },
            ble_unik_positive={
                name = "Positive",
                text = {
                    "+x#1# Requirements per",
                    "Joker owned,",
                    "x#2# Requirements per",
                    "Joker above max slots"
                }
            },
            ble_unik_fuzzy={
                name = "Fuzzy",
                text = {
                    "Base chips and mult",
                    "reduced by 25%",
                }
            },
            ble_unik_corrupted={
                name = "Corrupted",
                text = {
                    "Final chips and mult",
                    "Set randomly between",
                    "#1#x and #2#x",
                }
            },
            ble_unik_half={
                name = "Half",
                text = {
                    "Debuff a random played card if",
                    "more than #2# cards are played",
                }
            },
            ble_unik_bloated={
                name = "Bloated",
                text = {
                    "Destroy rightmost played",
                    "card before play",
                }
            }
        },
        Blind={
            bl_unik_xchips_hater = {
                name = "The Hater",
                text = {
                    "Xchips and higher operations",
                    "become lower Mult operations", --in reference to "Xchips already exists, it's called mult", hence the effect.
                }
            },

            bl_cry_chromatic_fixed = {
                name = "The Chromatic",
                text = {
                    "First hand is added",
                    "to Blind Size",
                    "instead of score",
                }
            },
            bl_cry_vermillion_virus_fixed = {
                name = "Vermillion Virus",
                text = {
                    "Leftmost Joker",
                    "then next one to",
                    "it's right",
                    "replaced every hand",
                },
            },
            bl_cry_box_fixed = {
                name = "The Box",
				text = {
					"Leftmost Common Joker",
					"is debuffed",
				},
            },
            bl_cry_landlord_fixed = {
				name = "The Landlord",
				text = {
					"Lose $1",
					"per Joker owned",
					"when hand played",
				},
			},
            bl_cry_shackle_fixed = {
				name = "The Shackle",
				text = {
					"Leftmost Negative Joker",
					"is debuffed",
				},
			},
            bl_cry_lavender_loop_fixed = {
				name = "Lavender Loop",
				text = {
					"1.1X blind requirements every",
					"6 seconds spent this round,",
					"multiplied by game speed",
				},
			},
            bl_cry_pin_fixed = {
				name = "The Pin",
				text = {
					"Leftmost Joker with Epic",
					"or higher rarity are debuffed",
				},
			},
            bl_cry_windmill_fixed = {
				name = "The Windmill",
				text = {
					"Leftmost Uncommon Joker",
					"is debuffed",
				},
			},
            bl_cry_striker_fixed = {
				name = "The Striker",
				text = {
					"Leftmost Rare Joker",
					"is debuffed",
				},
			},

            bl_unik_purple_pentagram={
                name = "Purple Pentagram",
				text = {
					"Create 5 Disposable Detrimental Jokers",
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
            bl_unik_persimmon_placard={
                name = "Persimmon Placard",
				text = {
					"All cards are debuffed",
				},
            },
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
            bl_unik_green_goalpost_anticheat={ --Only appears if you somehow managed to avoid activating straddle and you have not won yet for lots of rounds. Has a (number of Green goalpost encounters)/10 to replace green goalpost, regardless of current round.
                name = "Pakotettumaalilinja", --Forced finishline: Activates straddle, sets victory requirements every1 ante (aka all blinds become finisher blinds) and increases ante by ^(number of Green goalpost encounters).
                text = {
                    "Activates Straddle,",
                    "set victory requirements",
                    "to ante 1 and increases ante",
                    "by ^#1#"
                }
            },
            --Rework:
            --You need to be in tension 33 to survive
            --Or must reroll total rerolls done this run^1.05 before this ante
            bl_unik_epic_artisan={
                name = "Artesialainenrakentaa", --literally artesian builds
				text = {
                    "Shop rerolls this ante increase",
                    "Blind requirements by ^#1#",
                    "If less than #2# rerolls are done this ante,", --"If done < 10 rerolls this ante,",
                    "On Blind Select, die", --"on Blind select, die",
                    "(Currently #3#)",
				},
            },
            bl_unik_epic_collapse={ --only appears if you have at least 5 stone cards in the deck
                name = "Romahtavatorni", --the collapsing tower
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
                name = "Tartunnanruoko", --Reed of infestation
				text = {
                    "If hand does not contain",
                    "#1#, die", --2 random ranks accoring to your deck composition
				},
            },
            bl_unik_epic_decision={ -- Mortoninhaarukka: Morton's Fork, cause no matter what, all choices are bad. Created last due to the effort needed to create the entire "lartceps" set (baneful spectrals)
                name = "Mortoninhaarukka", -- Morton's Fork (Epic Decision)
                text = {
                    "On Blind Select,",
                    "Open an unskippable", 
                    "Lartceps Bundle Pack",
                },
            },
            bl_unik_epic_sand={
                name = "Juoksuhiekka", --quicksand
                text = {
                    "^2 Blind Size ",
                    "per tag held", 
                    "(Currently #1# Tag(s))"
                },
            },
            bl_unik_epic_height = {
                name = "Huipunkorkeus", --Height of the Summit
                text = {
                    "All scoring is",
                    "added to the Blind Size",
                    "instead of Score until",
                    "the final hand",
                    "+1 Hand if score is <= 0",
                }
            },
            bl_unik_epic_miser={
                name = "Loputonahne",
                text = {
                    "Next #1# Blinds must",
                    "be beaten back-to-back"
                }
            },
            bl_unik_epic_steel={
                name = "Teräksinenterrori", --Steel Terror, exactly functions like the steel, but unrerollable. This is cause its one of the few bosses to greatly be detrimental in the long run which is why its unchanged.
                text = {
                    "Set Chips or Mult",
                    "to lower value",
                },
            },
            bl_unik_epic_beach_that_makes_you_old = {
                name = "Tuhlaamisenranta", --beach of wasting
                text = {
                    "Increase requirements by",
                    "2x per second spent this ante",
                    "Skipping blinds are banned",
                    "Every second, increase the rank of",
                    "a random held card by 1,",
                    "Aces are destroyed",
                    "Must play only Aces",
                }
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
                name = "Telekineettinentyranni", --Telikinetic Tyrant (darth vader)
                text = {
                    "Set all statistics",
                    "of all mutable",
                    "Jokers to 0",
                } --Better get immutables going on.
            },
            bl_unik_epic_xenomorph_queen={ --1 in 4 chance drawn card is debuffed. If card contains undebuffed cards, die. --HARD COUNTERS DANDY --Balatro goes kino
                name = "Syövyttävämuukalainen", --Corrosive Alien
                text = {
                    "#1# in #2# chance",
                    "card is drawn debuffed",
                    "If played hand contains",
                    "undebuffed cards, die"
                }
            },
            bl_unik_epic_shackle={ --Reduce hand size by (number of empty joker slots x negative jokers owned) and destroy all negative jokers, cards and consumeables.
                name = "Kärsimyksenkahle", --Shackle of Suffering
                text = {
                    "Reduce hand size",
                    "and Joker slots by",
                    "(Empty Joker slots) + (Negative Jokers)", --LOLOLOLOLOLOL!
                    "then destroy all negative",
                    "Jokers and playing cards",
                    "including eternals",
                }
            },
            bl_unik_epic_nostalgic_pillar_flint = {
                name = "Epäpyhäfuusio", --The unholy fusion
                text = {
                    "Must play Straight Flushes",
                     --the hardest hand type to build, cannot force it as well.
                },
            },
            bl_unik_epic_confrontation = {
                name = "Uhankohtaaminen", --Confronting the menace (Epic Confrontation)
                text = {
                    "If any card held in hand",
                    "is not a face card, die",
                }
            },
            bl_unik_epic_jollyless = {
                name = "Ilotonmasennus",
                text = {
                    "Destroy all Jolly and M Jokers", --that includes jolly edition cards
                    "then destroy all cards in deck",
                    "that lack another with the",
                    "same rank and suit",
                }
            },
            bl_unik_epic_nemesis = { 
                name = "Äkillinen kuolema", --Sudden death; multiplayer exclusive "epic blind", only appears when both you and your opponent have 1 life each and it takes the place of Your Nemesis.
                text = {
                    "Play only 1 Hand",
                    "with 0 Discards",
                    "The loser dies",
                }
            },



            bl_unik_jaundice_jack = {
                name = "Jaundice Jack",
                text = {
                    "If a Jack is not",
                    "discarded before hand,",
                    "convert a random Joker",
                    "into Hit the Road",
				},
            },
            bl_unik_septic_seance = {
                name = "Septic Séance",
                text = {
					"Create an eternal Séance", 
                    "on Blind Selection",
                    "If hand is not a Straight Flush,",
                    "convert adjacent Jokers",
                    "into Séances",
				},
            },
            bl_unik_salmon_steps = { --literally the descending.
                name = "Salmon Steps",
                text = {
                    "Set Chips and Mult",
                    "operator to Addition",
                }
            },
            bl_unik_burgundy_brain = {
                name = "Burgundy Brain",
                text = {
                    "Must play #1# cards",
                    "All cards must score",
                }
            },
            bl_unik_epic_whole = {
                name = "Syödäänkokonaisena", --Eaten Whole
                text = {
                    "If a hand contains a",
                    "rank not previously scored",
                    "in last hand, die",
                }
            },
            bl_unik_epic_sink={
                name = "Uppokaivo", --Sinkhole
                text = {
                    "Half of Digits in Score is",
                    "added to Ante instead of Score",
                    "until #1# hand#<s>1# containing",
                    "a Flush are discarded",
                }
            },
            bl_unik_epic_bellows = {
                name = "Karjuvakuilu", --Bellowing abyss --+1 ante per card held in hand
                text = {
                    "+4 Hand Size",
                    "+1 ante per card",
                    "on play",
                },
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
            --All chips are added to ante for (Joker rarities owned)
            bl_unik_legendary_chamber={
                name = "Kidutuskammio", --The torture chamber (Legendary Chartreuse Chamber) (pokermon)
                text = {
                    "Multiply ante by",
                    "(Joker rarities owned)^0.5 per hand,",
                    "All scoring is added to",
                    "the Blind size instead of score",
                    "for the next (Joker rarities owned) hands",
                    "(Currently #1#, #2# hands)",
                },
            },
            bl_unik_legendary_horn = {
                name = "Kauhujensarvi", --Horn of horrors
                text = {
                    "All cards are",
                    "drawn face down",
                    "Hand must contain",
                    "a 3-of-a-Kind",
                }
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
					"Set money to -$666 per hand", --you gonna need lucky cards, wario or gold seals
                    "Hand will not score if money is",
                    "less than $666",
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
                name = "Kostonhimoinenvartija", --Vengeful Vigilante, blind size = 1
				text = {
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
            --rework: Must only play the last (Current hands + 1) cards  from deck, none hand banned (currently 1), since turns out luck based tornado type is bad practice
            bl_unik_legendary_tornado={
                name = "Ylihuomenna", --Day after tomorrow
				text = {
                    "Must only play the last",
                    "(Current discards) cards", --+1 is a pity system designed to make it possible if you decide to do burgular. Very difficult but still possible.
                    "drawn from deck",
                    "Must play at least 1 card",
                    "(Currently #1#)",
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
                    "Set hands to 1 per attempt",
                    "Deck and discards not replenished",
                    "Per defeat, rescale blind to",
                    "(best hand this run)#3#",
                    "If Max Hands = 1, increase",
                    "requirements by #4#",
                }
            },
            --just like the actual gambling machine - Jacks or better
            bl_unik_video_poker={
                name = "Video Poker",
				text = {
                    "Hand Size fixed to 5",
					"Only 1 Discard per Hand",
                    "Must play all cards, High card is banned",
                    "Pairs must have scoring Jacks or better",
				},
            },
            --Edition related blinds
            bl_unik_bloon={
                name = "The Bloon",
                text = {
                    "Add Bloated to 2",
                    "random played cards and",
                    "rightmost Joker on play",
                }
            },
            bl_unik_smiley={
                name = "The Smiley",
                text = {
                    "All drawn cards",
                    "after first hand",
                    "become Positive",
                }
            },
            bl_unik_halved={
                name = "The Halved",
                text = {
                    "If hand contains >3 cards",
                    "add Half to a random Joker",
                    "and played card",
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
                    "and cards in hand",
                    "are Corrupted after discard",
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
					"If blind disabled, die",
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
 
            --beast blinds? Around epic blind difficulty, although the art will resemble, but become more distinct from epic blinds.
            --Spawns same time as epic blinds.
            bl_unik_beast_shadow_milk={
                name = "Kauheapetos", --Dreadful Deception if this appears, all blinds appear as big blinds.
                text = {
                    "Disguised as a random Blind", -- can occupy small, big or boss slot, but all blinds are unskippable/unrerollable.
                    "On play, deselect and select",
                    "(Number of selected cards)",
                    "random cards in hand",
                    "High card banned",
                }
            },
            bl_unik_beast_shadow_milk_fakeout={
                name = "Big Blind?"
            },
            bl_unik_beast_burning_spice={
                name = "Maailmojentuhoaja", --Destroyer of worlds
                text = {
                    "Destroy all cards",
                    "in first drawn hand",
                    "+#2# ante per card", --+1 ante
                    "destroyed",
                }
            },
            bl_unik_beast_mystic_flour={
                name = "Rappeutumisenpöly", --Dust of Decay
                text = {
                    "Joker values are multiplied",
                    "by 0.95x every second spent",
                    "in this round", --excluding scoring, resets joker values upon defeat.. unless its almanac
                }
            },
            bl_unik_beast_eternal_sugar={
                name = "Ikuinenkuilu", --Eternal Abyss
                text = {
                    "^1.03 Blind size",
                    "per trigger",
                }
            },
            bl_unik_beast_silent_salt = {
                name = "Suolaamaa", --Salt the earth
                text = {
                    'Add Namta Cards equal',
                    'to half your deck size',
                    'Must hold at least 2', --at least not play them
                    'Namta cards in hand', --hidden interaction, white lily will permanently lose her self duping ability.
                }
            },
            
        },
        --akioyoris shennanngians
        DescriptionDummy={
            dd_akyrs_unskippable_blind={
                name = "Unskippable Blind",
                text={
                    "Cannot be skipped"
                }
            },
            dd_akyrs_all_unskippable_blinds={
                name = "Unskippable Ante",
                text={
                    "All blinds this ante",
                    "are unskippable",
                }
            },
            dd_akyrs_epic_blind={
                name = "Epic Blind",
                text={
                    "{C:red}You've should not",
                    "{C:red}have overscored...",
                    "{C:red}It escaped Almanac...",
                }
            },
           dd_akyrs_legendary_blind={
                name = "Legendary Blind",
                text = {
                    "{C:red}The demons",
                    "{C:red}await your demise..."
                }
            },
            -- dd_akyrs_instant_death_risk={
            --     name = "Instant Death Risk",
            --     text = {
            --         "{C:red}You could straight",
            --         "{C:red}up die immediately",
            --     }
            -- }
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
            e_cry_fragile_fixed = {
				name = "Fragile",
				label = "Fragile",
				text = {
					"{C:white,X:mult} X#3# {} Mult",
					"{C:green}#1# in #2#{} chance this",
					"card is {C:red}destroyed",
					"when triggered",
					"{C:inactive}Unriggable{}",
				},
			},
        },
        Enhanced={
            m_unik_namta = {
                name = "Namta",
                text = {
                    "Has no rank or suit",
                    "{X:unik_void_color,E:2,C:red}^#3#{} Blind Size if held",
                    "Create a {X:unik_lartceps_inverse,C:unik_lartceps1}Lartceps{} card",
                    "when scored, then",
                    "{C:red,E:2}Self Destruct{}",
                }
            },
            m_unik_pink = {
                name = "Pink",
                text = {
                    "{X:dark_edition,C:white}^#1#{} chips", --^1.07 Chips, considered a 7 and it's own suit. Destroyed if played with anything rank other than a 7.
                    "Considered a {C:attention}7{}",
                    "and it's {C:attention}own suit{}",
                    "{C:red,E:2}Destroyed{} if played",
                    "with anything",
                    "other than {C:attention}7s{}",
                }
            },
            m_unik_dollar = { --dollar cards. Earn +$2 when scored
                name = "Dollar",
                text = {
                    "{C:money}+$#1#{} when scored"
                }
            }
        },
        Rotarot = {
            c_unik_rot_crossdresser={
                name = 'The Crossdresser!',
                text = {
                    'Select {C:attention}#1#{} card#<s>1# to',
                    'convert to {C:attention}7s{}',
                },
            },
            c_unik_rot_wheel_of_misfortune={ --3 in 4 chance to add a detrimental edition and banana to a joker, otherwise add a random modded edition.
                name = 'The Evocation!',
                text = {
                    "{C:green}#1# in #2#{} chance to add a",
                    "{C:red}detrimental{} {C:unik_shitty_edition}edition{} to",
                    "a random Joker",
                    "otherwise apply a {C:attention}modded{}",
                    "{C:edition}edition{} to a random Joker",
                }
            }
        },
        Colour = {
            c_unik_spectral_blue={
                name = "Spectral Blue",
                text = {
                    "Create a random {C:dark_edition}Negative{}",
                    "{C:spectral}Spectral{} card for every",
                    "{C:attention}#4#{} rounds this has been held",
                    "{C:inactive}(Currently {C:attention}#1#{C:inactive}, {}[{C:attention}#2#{C:inactive}#3#{}]{C:inactive})",
                }
            },
            --uniks mod, morefluff and paperback
            c_unik_lavender={
                name = "Lavender",
                text = {
                    "Create a random {C:dark_edition}Negative{}",
                    "{C:paperback_minor_arcana}Minor Arcana{} card for every",
                    "{C:attention}#4#{} rounds this has been held",
                    "{C:inactive}(Currently {C:attention}#1#{C:inactive}, {}[{C:attention}#2#{C:inactive}#3#{}]{C:inactive})",
                }
            },
            --Lartceps color card
            c_unik_zzzzzz={
                name = "#ZZZZZZ",
                text = {
                    "Create a random",
                    "{X:unik_lartceps_inverse,C:unik_lartceps1}Lartceps{} card after",
                    "{C:attention}#4#{} rounds while held", --after 5 rounds
                    "{C:inactive}(Currently {C:attention}#1#{C:inactive}, {}[{C:attention}#2#{C:inactive}#3#{}]{C:inactive})",
                }
            },
            c_unik_stone_grey={
                name = "Stone Gray",
                text = {
                    "Create a random",
                    "{C:unik_ancient}Ancient{} joker after",
                    "{C:attention}#4#{} rounds while held", --after 200 rounds
                    "{C:inactive}(Must have room)",
                    "{C:inactive}(Currently {C:attention}#1#{C:inactive}, {}[{C:attention}#2#{C:inactive}#3#{}]{C:inactive})",
                }
            },
        },
        Joker={
            j_unik_lucky_seven = {
                name = 'Lucky 7',
                text = {
                    "Each played {C:attention}7{} has a", 
                    "{C:green}#1# in #2#{} chance",
                    "for {C:mult}+#3#{} Mult and a",
                    "{C:green}#4# in #5#{} chance",
                    "to win {C:money}$#6#",
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
            j_unik_yes_nothing = {
                name = 'Yes! Nothing',
                text={
                    "Sets all {C:green,E:1,S:1.1}listed{}",
                    "{C:green,E:1,S:1.1}probabilities{} to {C:attention}0{}",
                    "{C:inactive}(ex: {C:green}2 in 3{C:inactive} -> {C:green}0 in 3{C:inactive})",
                },
            },
            j_unik_yes_nothing_modest = {
                name = 'Yes! Nothing*',
                text={
                    "Halves all {C:green,E:1,S:1.1}listed{}",
                    "{C:green,E:1,S:1.1}probabilities{}",
                    "{C:inactive}(ex: {C:green}2 in 3{C:inactive} -> {C:green}1 in 3{C:inactive})",
                },
            },
            --buffed it since I dont tend to use it due to spawn conditions and cost of cramming joker slots
            j_unik_711 = {
                name = '7/11',
                text = {
                    "Scored {C:attention}7s{} and {C:attention}Aces{}", 
                    "give {X:chips,C:white}X#1#{} Chips",
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
                unlock = {
                    "Own {C:attention}Baseball Card",
                    "while only having",
                    "{C:blue}Common{} Jokers"
                }
            },
            j_unik_recycler = {
                name = 'Recycle Bin',
                text={
					"This Joker gains",
					"{X:mult,C:white} X#2# {} Mult per",
					"card {C:attention}discarded{}",
					"{C:inactive}(Currently {X:mult,C:white} X#1# {C:inactive} Mult)",
                },
                unlock = {
                    "Have {C:attention}Ramen{} get eaten",
                }
            },
            j_unik_happiness = {
                name = 'Happiness is Mandatory',
                text = {
                    "On spawn, turn the {C:attention}leftmost{} Joker", 
                    "and {C:attention}all{} equipped consumables {C:unik_shitty_edition}Positive{}", 
                    "Turns a {C:attention} random{} played card {C:unik_shitty_edition}Positive{} and creates a", 
                    "{C:unik_shitty_edition}Positive{} {C:attention}Eternal Banana Smiley Face{} every hand",   
                    "{C:red}Self destructs{} after Joker slots becomes {C:attention}#1#{}" ,
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
                    "{C:unik_ancient,s:0.7,E:2}Origin : Super Mario Bros.{}",
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
                    "{C:attention}Poker Hands{} give",
                    "{X:chips,C:white}X#1#{} Chips and {X:mult,C:white}X#1#{} Mult",
                    "for their corresponding {C:planet}Planet{} card", 
                    "{C:attention}in your consumable area{}",
                    "{C:unik_caption,s:0.7,E:1}#2#{}",
                    "{C:dark_edition,s:0.7,E:2}Floating Sprite by : 70UNIK{}",
                    "{C:unik_ancient,s:0.7,E:2}Origin : Cookie Run{}",
                },
            },
            j_unik_scratch = { 
                name = 'Scratch',
                text = {
                    "{C:cry_code}Code{} cards {C:attention}in your consumable area{}", 
                    "each give {C:mult}+#1#{} Mult",
                }
            },
            j_unik_unik = { --mainline: ^0.03 chips
                name = '{C:unik_unik_color}UNIK',
                text = {
                    "This Joker gains {X:dark_edition,C:white}^#1#{} Chips", 
                    "for each {C:attention}7{} scored",
                    "{C:inactive}(Currently {X:dark_edition,C:white}^#2#{C:inactive} Chips)",
                    "{C:unik_caption,s:0.7,E:1}#3#{}",
                    "{C:dark_edition,s:0.7,E:2}Character and Floating Sprite by : 70UNIK{}",
                    "{C:unik_ancient,s:0.7,E:2}Origin : Just Shapes and Beats{}",
                },
                unlock = {
                    "Play {C:attention}5 7s in a hand",
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
                    "{X:chips,C:white}X#1#{} Chips for every",
                    "{C:attention}Joker{} triggered",
                    --"{C:inactive,s:0.8}If {C:unik_chelsea_color,s:0.8}Chelsea{C:inactive,s:0.8} and {C:unik_maya_color,s:0.8}Maya{C:inactive,s:0.8} are present, increase this by {X:chips,C:white,s:0.8}#2#X{}",
                    "{C:unik_caption,s:0.7,E:1}I'll always be there for you and my family.{}",
                    "{C:dark_edition,s:0.7,E:2}Character and Floating Sprite by : 70UNIK{}",
                    "{C:unik_ancient,s:0.7,E:2}Origin : Just Shapes and Beats{}",
                },
            },
            j_unik_jsab_maya = { --epic: each non-face card played gains 0.75x chips, each non-face card held gains 0.25x chips
            --Increases by 1.3x chips if maya and chelsea are present
            --Her triggering does not trigger yokana and chelsea, but does help but providing more Xchips and more triggers for them (xchips + chips = double trigger)
            --Basically provided its not face cards, she's a souped up hiker
                name="{C:unik_maya_color}Maya Ramirez{}",
                text={
                    "{C:attention}Scored{} cards permanently gain {X:chips,C:white}X#1#{} Chips", --values will be exponented by ^0.3
                    --"{C:inactive,s:0.8}If {C:unik_chelsea_color,s:0.8}Chelsea{C:inactive,s:0.8} and {C:unik_yokana_color,s:0.8}Yokana{C:inactive,s:0.8} are present, increase this by {X:chips,C:white,s:0.8}#3#X{}",
                    "{C:unik_caption,s:0.7,E:1}I'm here to help, but PLEASE be careful.{}",
                    "{C:dark_edition,s:0.7,E:2}Character and Floating Sprite by : 70UNIK{}",
                    "{C:unik_ancient,s:0.7,E:2}Origin : Just Shapes and Beats{}",
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
                    "{C:unik_caption,s:0.7,E:1}#3#{}",
                    "{C:dark_edition,s:0.7,E:2}Character and Floating Sprite by : 70UNIK{}",
                    "{C:unik_ancient,s:0.7,E:2}Origin : Just Shapes and Beats{}",
                },
            },
            j_unik_ghost_trap = {
                name="Ghost Trap",
                text={
					"This Joker {C:red}destroys{} all {X:unik_detrimental,C:white}Detrimental{} Jokers",
                    "and gains {X:mult,C:white}X#2#{} Mult per Joker",
                    "destroyed that way",
					"{C:inactive}(Currently {X:mult,C:white}X#1#{C:inactive} Mult){}",
                },
            },
            j_unik_lily_sprunki = {
                name="Lily",
                text={
                    "{C:red,E:2}Destroy{} selected cards",
                    "{C:attention}anytime{} {C:inactive}(once until next cashout)",
                    "{C:inactive}(#1#)",
                    "{C:unik_caption,s:0.7,E:1}#2#{}",
                    "{C:dark_edition,s:0.7,E:2}Floating Sprite by : 70UNIK{}",
                    "{C:dark_edition,s:0.7,E:2}Character by : Kaeofthekae{}",
                    "{C:unik_ancient,s:0.7,E:2}Origin : SPRUNKI{}",
                },    
                unlock = {
                    "Have {C:attention}100{} cards in your deck",
                }             
            },
            --modest is a reusable hanged man
            j_unik_lily_sprunki_modest = {
                name="Lily",
                text={
                    "{C:red,E:2}Destroy{} up to {C:attention}#3#{} selected cards",
                    "{C:attention}anytime{} {C:inactive}(once until next cashout)",
                    "{C:inactive}(#1#)",
                    "{C:unik_caption,s:0.7,E:1}#2#{}",
                    "{C:dark_edition,s:0.7,E:2}Floating Sprite by : 70UNIK{}",
                    "{C:dark_edition,s:0.7,E:2}Character by : Kaeofthekae{}",
                    "{C:unik_ancient,s:0.7,E:2}Origin : SPRUNKI{}",
                },    
                unlock = {
                    "Have {C:attention}100{} cards in your deck",
                }
            },
            j_unik_1_5_joker = {
                name="One-and-a-Half Joker",
                text={
                    "{C:mult}+#1#{} Mult if played hand contains",
                    "{C:attention}#3#{} or more cards",
                    "Each played card above {C:attention}#3#{} cards",
                    "increases this by {C:mult}+#2#{} Mult",
                },
                unlock = {
                    "Own {C:attention}Half Joker",
                    "while in",
                    "{C:attention}The Psychic{} Boss"
                }
            },
            j_unik_no_standing_zone = {
                name="No Standing Zone",
                text={
                    "{X:mult,C:white}X#1#{} Mult, decreases by",
                    "{X:mult,C:white}X#2#{} every {C:attention}second{}",
                    "Becomes {C:red}Impound Notice{} at {X:mult,C:white}X1{} mult",
                    "or when {C:attention}sold{} in Blind",
                    "Resets at {X:mult,C:white}X#3#{} Mult at",
                    "start and end of {C:attention}Round{}",
                    "{C:inactive,s:0.7}(Hover off and on again to see the new Xmult){}",
                }, 
            },
            j_unik_impounded = {
                name="Impound Notice",
                text={
                    "{X:mult,C:white}X#1#{} Mult {C:attention}after scoring{}",
                    "{C:red}Impounds{} a random Joker on spawn",
                    "{C:attention}Sell{} to remove {C:red}Impounded{} from Joker",
                    "Selling costs {X:money,C:white}X#2#ln(x+1){} the total",
                    "{C:attention}selling price{} of {C:red}Impounded{} Joker",
                    "{C:inactive,s:0.7}(Costs {C:money,s:0.7}$#3#{C:inactive,s:0.7} if no valid Joker owned){}",
                }
            },
            j_unik_impounded_modest = {
                name="Impound Notice",
                text={
                    "{C:red}Impounds{} a random Joker on spawn",
                    "{C:attention}Sell{} to remove Impounded from Joker",
                    "Selling costs {X:money,C:white}X#2#{} the total",
                    "{C:attention}selling price{} of Impounded Joker",
                    "{C:inactive,s:0.7}(Costs {C:money,s:0.7}$#3#{C:inactive,s:0.7} if no valid Joker owned){}",
                }
            },
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
                    "Create {C:attention}1{} {X:unik_detrimental,C:white}Detrimental{} Joker",
                    "at end of Boss Blind", 
                    "{C:red}Self destructs{} after",
                    "creating {C:attention}#1#{} {X:unik_detrimental,C:white}Detrimental{} Jokers",
                    "{C:inactive}(Currently {C:attention}#2#{C:inactive} {X:unik_detrimental,C:white}Detrimental{C:inactive} Joker(s))",
                }               
            },
            j_unik_soul_fragment = {
                name="Soul Fragment",
                text={
                    "Sell this card to create a random",
                    "{C:attention}Perishable{} {C:legendary}Legendary{} ", 
                    "Joker with {C:money}$0{} sell value",
                    "{C:inactive}(Can overflow){}",
                }               
            },
            --almanac version will create wonderous, transdescendant and ritualistic jokers (except kosmos)
            j_unik_a_taste_of_power = {
                name="A Taste of Power",
                text={
                    "Sell this card to create a random",
                    "{C:purple}Absolute {C:red}Niko{}", 
                    "{C:unik_ancient}Ancient{} Joker",
                    "{C:inactive}(Can overflow){}",
                }             
            },
            -- Upgrades on destruction, making her very resilient and synegises with dagger, ankh
            j_unik_white_lily_cookie = {
                name = 'White Lily Cookie',
                text = {
                    "Gains {X:dark_edition,C:white}^#2#{} Mult when a",
                    "{C:attention}Joker{} is {C:red}destroyed {C:inactive}(itself included)",
                    "Copies itself with {C:money}$0{}",
                    "sell value if {C:red}destroyed",
                    "{C:inactive}(Currently {X:dark_edition,C:white}^#1#{C:inactive} Mult)",
                    "{C:red,s:0.7}(Cannot copy if destroyed by Disposable)",        
                    "{C:unik_caption,s:0.7,E:1}All I wanted was for everyone to be happy...{}", --TODO: adjustable quotes, for 
                    "{C:dark_edition,s:0.7,E:2}Floating Sprite by : 70UNIK{}",
                    "{C:unik_ancient,s:0.7,E:2}Origin : Cookie Run{}",
                },
                unlock = {
                    "Destroy an {C:unik_ancient}Ancient{} Joker",
                }
            },
            j_unik_coupon_codes = {
                name="Coupon Codes",
                text={
                    "Redeem {C:attention}#1#{} random",
                    "{C:attention}disposable{} Voucher#<s>1#",
                    "at the end of round",
                }         
            },
            j_unik_vessel_kiln = { --overrides get tag function to instead generate Violet vessel, negating the benefit of this Joker. It's chips cause ceramic.
                name="Vessel Kiln",
                text={
                    "{X:chips,C:white}X#1#{} Chips",
                    "All skip Tags",
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
                    "{C:white,X:dark_edition}^#1#{} Mult if played",
                    "hand contains a scoring",
                    "{C:attention}Odd{} and {C:attention}Even{} card",
                    "{C:unik_caption,s:0.7,E:1}Teehee! It's time I join in on the fun!{}",
                    "{C:dark_edition,s:0.7,E:2}Floating Sprite by : 70UNIK{}",
                    "{C:dark_edition,s:0.7,E:2}Character by : KittyKnight{}",
                    "{C:unik_ancient,s:0.7,E:2}Origin : Balatro - Extra Credit{}",
                }
            }, 
            j_ExtraCredit_averagealice = { --overriding loc to include a 0.6% chance to get Alice on purchase
                name = 'Average Alice',
                text = {
                    "{C:white,X:mult}X#1#{} Mult if played",
                    "hand contains a scoring",
                    "{C:attention}Odd{} and {C:attention}Even{} card",
                    "{C:inactive,s:0.7}If obtained, fixed {C:green,s:0.7}0.8%{C:inactive,s:0.7} chance",
                    "{C:inactive,s:0.7}to obtain {C:unik_ancient,s:0.7,E:1}Alice {C:inactive,s:0.7}instead",
                }
            },
            j_unik_foundation = {
                name = 'Foundation',
                text = {
                    "After playing {C:attention}#2#{}hands",
                    "sell this card to create",
                    "a {C:attention}random{} {C:unik_ancient}Ancient{} Joker",
					"{C:inactive}(Currently #1#/#2#){}",
                    "{C:inactive,E:1,s:0.7}It will be worth it in the end!{}",
                },
                unlock = {
                    "Use {C:spectral}Gateway{} and",
                    "{C:red}lose{} in 1 round",
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
            j_unik_lockpick = {
                name = 'Lockpick',
                text = {
                    "You can now {C:red}banish",
                    "{C:purple}Eternal{} Jokers for",
                    "{E:2,C:red}negative{} sell value",
                },
                unlock = {
                    "Fill your Joker slots",
                    "with {C:purple}Eternal{} Jokers",
                }
            },
            j_unik_double_container = {
                name = "Double Container",
                text = {
                    "{C:attention}Retrigger{} all {C:attention}held{} in",
                    "consumable effects {C:attention}#1#{} time(s)",
                },
            },
            j_unik_pibby={
                name = "Pibby",
                text = {
                    "This Joker gains {X:mult,C:white}Xmult{}",
                    "equal to the {C:attention}sum of{}",
                    "scoring ranks divided by {C:attention}#1#{},",
                    "{C:inactive}(Currently {X:mult,C:white}X#2#{C:inactive} Mult)",
                    "{C:unik_caption,s:0.7,E:1}#3#{}",
                    "{C:dark_edition,s:0.7,E:2}Floating Sprite by : 70UNIK{}",
                    "{C:unik_ancient,s:0.7,E:2}Origin : Learning with Pibby{}",
                }
            },
            j_unik_lone_despot={
                name = "Lone Despot",
                text = {
                    "Scored card gives {X:dark_edition,C:white}^#1#{} Mult",
                    "if played hand {C:attention}only contains{} a",
                    "single {C:attention}King{} of {C:spades}#2#",
                },
                unlock = {
                    "Play {C:attention}High Card",
                    "with a single scoring {C:attention}King",
                }
            },
            j_unik_epic_blind_sauce = {
                name = "Epic Blind Sauce",
                text = {
                    "{C:mult}+#1#{} Mult, {C:chips}+#2#{} Chips, {X:dark_edition,C:white}^#3#{} Mult",
                    "If {C:attention}blueprinted{}, {C:attention}retriggered{} or",
                    "Blind beaten in",
                    "{C:attention}#4#{} hands or less,",
                    "{E:2,C:red}Self destruct{} and",
                    "next blind becomes",
                    "an {E:2,C:red}Epic Blind{}"
                },
                unlock = {
                    "Die to an {C:red}Epic Blind"
                }
            },
            j_unik_epic_blind_sauce_notalisman = { --no talisman, yes epic blinds
                name = "Epic Blind Sauce",
                text = {
                    "{C:mult}+#1#{} Mult, {C:chips}+#2#{} Chips, {X:dark_edition,C:white}^#3#{} Mult",
                    "If {C:attention}copied{}, {C:attention}retriggered{} or",
                    "Blind beaten in",
                    "{C:attention}#4#{} hands or less,",
                    "{E:2,C:red}Self destruct{} and",
                    "next blind becomes",
                    "an {E:2,C:red}Epic Blind{}"
                },
                unlock = {
                    "Die to a {C:attention}Finisher Blind"
                }
            },
            j_unik_epic_blind_sauce_no_epic = {
                name = "Epic Blind Sauce",
                text = {
                    "{C:mult}+#1#{} Mult, {C:chips}+#2#{} Chips, {X:dark_edition,C:white}^#3#{} Mult",
                    "If {C:attention}copied{}, {C:attention}retriggered{} or",
                    "Blind beaten in",
                    "{C:attention}#4#{} hands or less,",
                    "{E:2,C:red}Self destruct{} and",
                    "next blind becomes",
                    "a {E:2,C:red}Finisher Blind{}"
                },
                unlock = {
                    "Die to a {C:attention}Finisher Blind"
                }
            },
            j_unik_cobblestone = {
                name = "Cobblestone",
                text = {
                    "{C:attention}Rankless and suitless",
                    "cards each give",
                    "{X:chips,C:white}X#1#{} Chips"
                },
            },
            j_unik_epic_riffin = {
                name = "Epic Riffin'",
                text = {
                    "When {C:attention}Boss Blind{} is selected,",
                    "create an {C:cry_epic}Epic{} {C:attention}Joker",
                    "{C:inactive}(Must have room)",
                },
                unlock = {
                    "Gain an {C:cry_epic}Epic{} Joker",
                    "from {C:attention}Judgement",
                }
            },
            j_unik_riff_rare = {
                name = "Riff Rare",
                text = {
                    "When {C:attention}Big Blind{} or",
                    "{C:attention}Boss Blind{} is selected,",
                    "create a {C:red}Rare{} {C:attention}Joker",
                    "{C:inactive}(Must have room)",
                },
                unlock = {
                    "Gain a {C:red}Rare{} Joker",
                    "from {C:attention}Judgement",
                }
            },
            j_unik_borg_cube = {
                name = "Borg Cube",
                text = {
                    "Other {C:dark_edition}Steel Editioned",
                    "cards give {X:mult,C:white}X#1#{} mult",
                }
            },
            j_unik_shitty_joker = {
                name = "Shitty Joker",
                text = {
					"Gain {C:red}+#1#{} Discard#<s>1# when",
					"{C:attention}Blind{} is selected",
                },
                unlock = {
                    "Discard while",
                    "in {C:attention}The Water{} boss}",
                }
            },
            j_unik_invisible_card = {
                name = "Invisible Card",
                text = {
                    "{C:green}#1# in #2#{} chance to not",
                    "gain {C:dark_edition}+#3#{} Joker slot#<s>3#",
                    "when a {C:attention}booster pack{}",
                    "is skipped",
                    "{C:inactive}(Currently {C:dark_edition}+#4#{C:inactive} slots)",
                    "{C:inactive,s:0.8s}(Capped at {C:dark_edition}+#5#{C:inactive} slots)",
                },
                unlock = {
					"Skip {C:attention}30",
					"Booster Packs in",
                    "1 run",
				},
            },
            --next batch of 8 base jokers
            j_unik_fat_joker = { --+2 Mult per card above (starting deck size*0.5) full deck (uncommon) [CODE DONE]
                name = "Fat Joker",
                text = {
                    "{C:mult}+#1#{} Mult per",
                    "card above {C:attention}#2#",
                    "in your full deck",
                    "{C:inactive}(Currently {C:mult}+#3#{C:inactive} Mult)"
                }
            },
            -- j_unik_notifications = { --common --too janky
            --     name = "Notifications",
            --     text = {
            --         "Gain {C:chips}+#1#{} Chip#<s>1#",
            --         "per card {C:attention}status trigger{}",
            --         "{C:inactive}(Currently {C:chips}+#2#{C:inactive} Chips)"
            --     }
            -- },
            j_unik_copycat = { --rare, immutable. Acts as a slightly buffed blueprint. [CODE DONE]
                name = "Copycat",
                text = {
                    "Retrigger the",
                    "rightmost {C:attention}Joker{}",
                    "{C:inactive,s:0.7}(Cannot retrigger Joker retriggers)", --important notice
                },
                unlock = {
                    "Discard a {C:attention}Flush Five",
                }
            },
            j_unik_skipping_stones = { --skipping stones (common) [CODE DONE]
                name = "Skipping Stones",
                text = {
                    "Retrigger all scored",
                    "{C:attention}Rankless and",
                    "{C:attention}Suitless{} cards",
                    "{C:attention}#1#{} time#<s>1#",
                },
                unlock = {
                    "Play a {C:attention}Bulwark",
                }
            },
            j_unik_skipping_stones_modest = {
                name = "Skipping Stones",
                text = {
                    "Retrigger all scored",
                    "{C:attention}Rankless and",
                    "{C:attention}Suitless{} cards",
                    "if played hand is",
                    "not a {C:attention}Bulwark",
                },
                unlock = {
                    "Play a {C:attention}Bulwark",
                }
            },
            j_unik_chipzel = {  -- [CODE DONE]
                name = "Chipzel", --every bonus card triggered gives X1.15 chips, then increase this by 0.15 (Uncommon). Becomes rare and 0.1 in modest (literally chain lightning from extra credit)
                text = {
                    "Scored {C:attention}Bonus Cards",
                    "give {X:chips,C:white}X#1#{} Chips,",
                    "then increase this",
                    "by {X:chips,C:white}X#2#{} Chips",
                    "{C:inactive}(Resets after hand)",
                },
                unlock = {
                    "Play a hand with",
                    "{C:attention}5 bonus Cards",
                }
            },
            j_unik_minimized = { --rare 
                name = "Minimized",
                text = {
                    "All {C:attention}Face{} cards",
                    "are considered {C:attention}Jacks",
                    "All {C:attention}numbered{} cards",
                    "are considered {C:attention}2s",
                    "{C:inactive}(Cancels out Maximized)",
                },
                unlock = {
					"Play a {C:attention}Flush Five{}",
					"of {C:attention}2s",
				},
            },
            j_cry_maximized_alt = { 
				name = "Maximized",
				text = {
					"All {C:attention}face{} cards",
					"are considered {C:attention}Kings{},",
					"all {C:attention}numbered{} cards",
					"are considered {C:attention}10s{}",
                    "{C:inactive}(Cancels out Minimized)",
				},
				unlock = {
					"Play a {C:attention}Flush Five{}",
					"of {C:attention}Kings",
				},
			},
            j_unik_joker_dollar = { --uncommon
                name = "Joker Dollars",
                text = {
                    "Earn {C:money}$#1#{} at", --earn $0
                    "end of round",
                    "Increase payout by {C:money}$#2#{}", --+$3 per dollar card held.
                    "for each {C:attention}Dollar Card",
                    "held after round",
                }
            },
            j_unik_poppy = {
                name = "Poppy", --Retrigger rightmost card for every hand or discard used
                text = {
                    "Retrigger {C:attention}rightmost",
                    "scored card for",
                    "every {C:blue}Hand{} or {C:attention}2{} {C:red}discards{}",
                    "lost in round", --that means the needle and the water will give an instant (hands - 1 or discards) triggers.
                    "{C:inactive}(Currently {C:attention}#1#{C:inactive} retriggers)", --#max 1000 retriggers.
                    "{C:unik_caption,s:0.7,E:1}#2#{}",
                    "{C:dark_edition,s:0.7,E:2}Floating Sprite by : 70UNIK{}",
                    "{C:unik_ancient,s:0.7,E:2}Origin : Dandy's World{}",
                },
                unlock = {
                    "Retrigger {C:attention}1{} card {C:attention}8{} times"
                }
            },
            j_unik_kouign_amann_cookie = { --Retrigger all light cards and reduce their requirements by 10% per trigger. (RARE)
                name = "Kouign Amann Cookie",
                text = {
                    "Retrigger all",
                    "{C:attention}Light Cards #1#{} time#<s>1#",
                    "and reduce their",
                    "requirements by {X:dark_edition,C:white}X#2#",
                    "{C:inactive,s:0.8}(Requirement reduction cannot be copied)",
                    "{C:unik_caption,s:0.7,E:1}#3#{}",
                    "{C:dark_edition,s:0.7,E:2}Floating Sprite by : 70UNIK{}",
                    "{C:unik_ancient,s:0.7,E:2}Origin : Cookie Run{}",
                },
                unlock = {
                    "Play a {C:attention}Flush Five",
                    "with only {C:attention}Light Cards",
                }
            },
            j_unik_hacker = {
                name = "Hacker",
                text = {
                    "{C:green}#1# in #2#{} chance for each played",
                    "{C:attention}2{}, {C:attention}3{}, {C:attention}4{} or {C:attention}5{} to not",
                    "create a {C:cry_code}Code Card",
                    "{C:inactive}(Must have room)"
                }
            },
            j_unik_tax_haven={
                name = "Tax Haven",
                text = {
                    "{C:attention}Remove{} all {C:attention}Rental{} Stickers",
                    "on all owned",
                    "Jokers and cards",
                    "{C:red}Lose{} {C:money}$#1#{} per Sticker removed",
                }
            },

            j_unik_instant_gratification={
                name = "Instant Gratification",
                text = {
                    "Earn {C:money}$#1#{} per {C:red}Discard",
                    "lost in round",
                },
            },
            j_unik_golden_glove={
                name = "Golden Glove",
                text = {
                    "Earn {C:money}$#1#{} per {C:blue}hand",
                    "lost in round",
                }
            },
            j_unik_last_tile={
                name = "Last Tile",
                text = {
                    "Add {C:dark_edition}Mosaic{} to scored cards",
                    "on {C:attention}final{} hand",
                    "{E:2,C:red}Self Destructs{}"
                }
            },
            j_unik_xchips_hater={
                name = "XCHIPS IS NOT VANILLA!!!!!",
                text = {
                    "{X:chips,C:white}XChips{}, {X:dark_edition,C:white}^Chips{}, etc... cards and Jokers",
                    "will {C:red}not trigger{} and are {C:red}destroyed{} instead",
                    "{C:red}Self destructs{} after {C:attention}#1#",
                    "{C:attention}consecutive{} rounds without",
                    "attempted {X:chips,C:white}XChips{}, {X:dark_edition,C:white}^Chips{}, etc... triggers",
                    "{C:inactive}(Currently {C:attention}#2#{C:inactive})",
                },
            },
            j_unik_robert={
                name = "Robert",
                text = {
                    "{C:green}#1# in #2#{} chance card is",
                    "drawn {C:red}face-down{}",
                    "{C:red}Self destructs{} when a hand", 
                    "containing {C:attention}#3#{} or more scoring",
                    "{C:red}face-down{} cards is played",
                    "or {C:unik_wheel_color}The Wheel{} is triggered",
                    "{C:inactive,s:0.7,E:2}It now targets you, for no reason.{}",   
                    "{C:dark_edition,s:0.7,E:2}Floating Sprite by : 70UNIK{}",
                    "{C:unik_ancient,s:0.7,E:2}Origin : Rubber{}",   
                }
            },
            j_unik_abandoned_house={
                name = "Boarded-Up House",
                text = {
                    "{C:attention}First drawn{} hand is",
                    "drawn {C:red}face-down{}",
                    "{C:red}Self destructs{} when a hand", 
                    "containing {C:attention}#3# all scoring",
                    "{C:red}face-down{} cards is played",
                    "or {C:unik_house_color}The House{} is triggered",
                }
            },
            j_unik_decaying_tooth={
                name = "Decaying Tooth",
                text = {
                    "{C:red}Lose {C:gold}$#1#{} per card played",
                    "{C:red}Self destructs{} after earning",
                    "at least {C:gold}$#2#{} per hand or",
                    "{C:unik_tooth_color}The Tooth{} is triggered",
                }
            },
            j_unik_astral_bottle = {
                name = "Nostalgic Astral in a Bottle",
                text = {
                    "{X:dark_edition,C:white}^#1#{} Mult after scoring",
                    "Sell to add {C:dark_edition}Astral{} and",
                    "{C:red}Perishable{} to a {C:attention}random{} Joker",
                },
            },
            

            --NEW JOKERS
            j_unik_earthmover = {
                name = "1000-THR \"Earthmover\"",
                 text = {
                    "When {C:attention}Boss Blind{} is selected",
                    "{X:unik_void_color,C:unik_eye_searing_red}^#1#{} Blind Size",
                    "After defeat, create an",
                    "{C:unik_ancient}Awakening{} and {C:red,E:2}Self Destruct",
                },
            },
            j_unik_euclid = {
                name = "Euclid",
                text = {
                    "Each scored {C:attention}2{}, {C:attention}3{}, {C:attention}5{}, {C:attention}7{} or {C:attention}Ace{}",
                    "gives {C:chips}+#1#{} Chips",
                }
            },

            --spectrum shit
            j_unik_the_dynasty = {
                name = "The Dynasty",
                text = {
                "{X:mult,C:white}X#1#{} Mult if played",
                "hand contains",
                "a {C:attention}#2#"
                }
            },
            j_unik_lurid_joker = {
                name = "Lurid Joker",
                text = {
                "{C:chips}+#1#{} Chips if played",
                "hand contains",
                "a {C:attention}#2#"
                }
            },
            j_unik_zealous_joker = {
                name = "Zealous Joker",
                text = {
                "{C:mult}+#1#{} Mult if played",
                "hand contains",
                "a {C:attention}#2#"
                }
            },



            --Cult card crossmod
            j_unik_cult_of_xmult = {
                name = "Cult of Xmult",
                text = {
                    "Scored {C:attention}Cult Cards{} give",
                    "{X:mult,C:white}Xmult{} equal to",
                    "{C:attention}1 + level of played hand x 0.1{}",
                }
            },

            --END NEW

            --crossmod
            j_unik_weetomancer={ --rare, paperback
                name = "Weetomancer",
                text = {
                    "Create a {C:paperback_minor_arcana}Minor Arcana{} card",
                    "when {C:attention}Blind{} is selected",
                    "{C:inactive}(Must have room)",
                }
            },
            --dichrome celestial
            j_unik_binary_asteroid={
                name = "Binary Asteroid",
                text = {
                    "When {C:attention}Blind{} is selected,",
                    "other {C:dark_edition}Dichrome{} cards",
                    "give {C:attention}+#1#{C:chips} Hand#<s>1#{} or {C:mult}Discard#<s>1#",
                    "{C:inactive}(Whichever is lower)",
                }
            },




            --Finity boss blinds
            j_unik_indigo_icbm={
                name = "Indigo ICBM",
                text = {
                    "Gains {X:dark_edition,C:white}^#1# Mult{} when hand played", --gains 0.1
                    "{C:red}Resets{} if hand score exceeds",
                    "{C:attention}#1#", --3x requirements
                    "{C:inactive}(Currently {X:dark_edition,C:white}^#2#{C:inactive} Mult)", --hard to use unless you spam the tax.
                }
            },
            j_unik_maroon_magnet={
                name = "Maroon Magnet",
                text = {
                    "Unenhanced cards become",
                    "Steel Cards",
                    "Held Steel Cards give",
                    "{X:mult,C:white}X#1#{} Mult", --X2 mult
                }
            },
            j_unik_green_goalpost={
                name = "Green Goalpost",
                text = {
                    "Gains {X:mult,C:white}X#1#{} Mult if hand",
                    "is {C:attention}not{} the winning hand",
                    "{C:unik_caption,s:0.7,E:1}HEY! THAT'S A FOUL!{}",
                    "{C:dark_edition,s:0.7,E:2}Floating Sprite by : 70UNIK{}",
                }
            },
            j_unik_septic_seance={
                name = "Septic Seance",
                text = {
                    "Create a {C:dark_edition}negative {C:attention}Seance",
                    "on Blind Select",
                    "Seances can {C:attention}overflow",
                    "Create a {C:dark_edition}negative {C:cry_code}://EXPLOIT",
                    "If played hand is",
                    "{C:red}not{} a {C:attention}Straight Flush",
                    "{C:unik_caption,s:0.7,E:1}Here's your fucking Seance, dumbass.{}",
                    "{C:dark_edition,s:0.7,E:2}Floating Sprite by : 70UNIK{}",
                }
            },
            j_unik_epic_xenomorph_queen={
                name = "Syövyttävämuukalainen",
                text = {
                    "First drawn hand",
                    "is {C:red}debuffed",
                    "Scored {C:red}debuffed{} cards give",
                    "{X:dark_edition,C:white}^#1#{} Mult", --^1.4 Mult
                    "{C:unik_caption,s:0.7,E:1}SCRREEEEEECCHH!!!!! SCRAAAARRRCCHH!!!{}",
                    "{C:dark_edition,s:0.7,E:2}Floating Sprite by : 70UNIK{}",
                    "{C:unik_ancient,s:0.7,E:2}Origin : Alien{}",
                },
            },
            j_unik_legendary_crown={
                name = "Korruptionkruunu",
                text = {
                    "Gains {X:dark_edition,C:white}^#1#{} Mult", --gains ^1 Mult.
                    "if hand is {C:attention}at least{}",
                    "your {C:attention}best hand{} this run",
                    "{C:inactive}({C:attention}#2#{C:inactive})",
                    "{C:inactive}(Currently {X:dark_edition,C:white}^#3#{C:inactive} Mult)",
                    "{C:unik_caption,s:0.7,E:1}#4#{}",
                    "{C:dark_edition,s:0.7,E:2}Floating Sprite by : 70UNIK{}",
                    "{C:unik_ancient,s:0.7,E:2}Origin : Celeste{}",
                }
            },


            --Grab bag jokers

            j_unik_smiley = {
                name = "The Smiley",
                text = {
                    "{C:attention}First{} Played Hand",
                    "becomes {C:unik_shitty_edition}Positive",
                    "{C:unik_shitty_edition}Positive{} cards give",
                    "{X:mult,C:white}X#1#{} Mult when scored",
                    "Decrease this by {X:mult,C:white}X#2#{}",
                    "per card held",
                }
            },
            j_unik_halved = {
                name = "The Halved",
                text = {
                    "{X:mult,C:white}X#1#{} Mult",
                    "if played hand contains",
                    "{C:attention}#2#{} or less cards"
                }
            },
            j_unik_artesian = {
                name = "The Artesian",
                text = {
                    "This Joker gains {X:mult,C:white}X#1#{} Mult",
                    "per {C:attention}reroll{} in the shop",
                    "{C:inactive}(Currently {X:mult,C:white}X#2#{C:inactive} Mult)"
                }
            },
            j_unik_collapse = {
                name = "The Collapse",
                text = {
                    "This Joker gains {C:chips}+#1#{} Chips",
                    "per {C:attention}Rankless and",
                    "{C:attention}Suitless{} card {C:red}destroyed",
                    "{C:red}Destroy{} all played",
                    "{C:attention}rankless and suitless{} cards",
                    "{C:inactive}(Currently {C:chips}+#2#{C:inactive} Chips)"
                }
            },
            j_unik_bloon = {
                name = "The Bloon",
                text = {
                    "{C:attention}First{} Played Hand",
                    "becomes {C:unik_shitty_edition}Bloated",
                    "{C:unik_shitty_edition}Bloated{} cards give",
                    "{X:mult,C:white}X#1#{} Mult when scored",
                }
            },
            j_unik_poppy_gb = {
                name = "The Poppy",
                text = {
                    "Gain {X:mult,C:white}X#1#{} Mult",
                    "per hand played",
                    "{C:red}Lose{} {X:mult,C:white}X#2#{} Mult if",
                    "hand exceeds {C:attention}X3{} requirements",
                    "{C:inactive}({C:attention}#3#{C:inactive})",
                    "{C:inactive}(Currently {X:mult,C:white}X#4#{C:inactive} Mult)",
                }
            },
            j_unik_fuzzy = {
                name = "The Fuzzy",
                text = {
                    "Scored Cards each give",
                    "{C:mult}#1#-+#2#{} Mult",
                    "{C:chips}#3#-+#4#{} Chips",
                    "and {C:gold}$#5#-+$#6#{}",
                }
            },
            j_unik_jollyless = {
                name = "The Jollyless",
                text = {
                    "{C:red}Destroy{} all {C:cry_jolly}Jolly{} and {C:cry_jolly}M{} Jokers",
                    "when Blind is selected",
                    "{C:inactive}(The Jollyless Excluded)",
                    "Gain {X:mult,C:white}X#1#{} Mult per Joker",
                    "{C:red}destroyed{} this way",
                    "{C:inactive}(Currently {X:mult,C:white}X#2#{C:inactive} Mult)",
                }
            },
            j_cry_astral_in_a_bottle_but_not_cursed = {
                name = "Astral in a Bottle",
				text = {
					"When sold, apply {C:dark_edition}Astral{}",
					"and {C:purple}Limited Edition{} to",
					"a random {C:attention}Joker{}",
				},
            },
            

            -- j_cry_oldinvisible = {
			-- 	name = "Nostalgic Invisible Joker",
			-- 	text = {
			-- 		"{C:attention}Duplicate{} a random",
			-- 		"{C:attention}Joker{} every {C:attention}4",
			-- 		"Joker cards sold",
			-- 		"{s:0.8}Nostalgic Invisible Joker and{}",
            --         "{s:0.8}Joker slot adding Jokers Excluded{}", --Motebook, invisible card, negative joker
			-- 		"{C:inactive}(Currently #1#/4){}",
			-- 	},
			-- },



            ---OVERRIDES
            -- j_cry_oil_lamp = {
			-- 	name = "Oil Lamp",
			-- 	text = {
			-- 		"Increase values of {C:attention}Joker{} to the right",
			-- 		"by {C:attention}+#1#x{} at end of round",
			-- 	},
			-- },
            -- j_cry_tropical_smoothie = {
			-- 	name = "Tropical Smoothie",
			-- 	text = {
			-- 		"Sell this card",
			-- 		"to {C:attention}add to{} values",
			-- 		"of owned jokers by {C:attention}+#1#x{}",
			-- 	},
			-- },
            j_cry_oil_lamp_reworked = {
				name = "Oil Lamp",
				text = {
					"Increase values of {C:attention}Joker{} to the right",
					"by {C:attention}X#1#{} at end of round",
                    "{C:inactive}(Reverts after {C:attention}#2#{C:inactive} Rounds)",
				},
            },
            j_cry_jawbreaker_balanced = {
				name = "Jawbreaker",
				text = {
					"When {C:attention}Boss Blind{} defeated,",
					"increase values of ",
                    "adjcent {C:attention}Jokers{} by {C:attention}X#1#{}",
                    "{E:2,C:red}self destructs{}",
                    "{C:inactive}(Only applys once per Joker)",
				},
			},
            j_cry_tropical_smoothie_reworked = {
				name = "Tropical Smoothie",
				text = {
					"Sell this card",
					"to {C:attention}multiply{} values",
					"of owned Jokers by {C:attention}X#1#{}",
                    "{C:inactive}(Reverts after {C:attention}#2#{C:inactive} Rounds)",
				},
			},
            j_cry_gemini_reworked= {
                name = "Gemini",
				text = {
					"{C:attention}Increase{} values",
					"of leftmost {C:attention}Joker",
					"by {C:attention}X#1#{} at end of round",
                    "{C:inactive}(Capped at {C:attention}X#2#{}{C:inactive})",
				},
            },
            j_paperback_deadringer = {
                name = "Deadringer",
                text = {
                "Retrigger scored {C:attention}#1#s{} and {C:attention}#2#s",
                "{C:attention}#4#{} time#<s>4#, and scored {C:attention}#3#s{} {C:attention}#5#{} time#<s>5#"
                }
            },

            j_cry_notebook_balanced = {
				name = "Motebook",
				text = {
					"{C:green} #1# in #2#{} chance to gain {C:dark_edition}+#6#{} Joker",
					"slot#<s>6# per {C:attention}reroll{} in the shop",
					"{C:green}Always triggers{} if there are",
					"{C:attention}#5#{} or more {C:attention}Jolly Jokers{}",
					"{C:red}Works once per round{}",
					"{C:inactive}(Currently {C:dark_edition}+#3#{}{C:inactive} and #4#){}",
                    "{C:inactive}(Capped at {C:dark_edition}+#7#{}{C:inactive} slots){}",
				},
			},

            j_unik_cloneman = {
                name = "Clone man",
				text = {
					"Each owned {C:attention}Jokers{} and {C:attention}Consumables{}",
					"appear multiple times at {C:attention}X#1#{}",
                    "the usual rate for their rarity",
					"{C:inactive}(Stacks additively)",
                    "{C:inactive,s:0.8}(Clone man excluded)",
				}, 
                unlock = {
                    "Own {C:attention}2 Showmen{} at once"
                }
            },

            j_cry_canvas_mainline = {
				name = "Canvas",
				text = {
					"{C:attention}Retrigger{} all {C:attention}Jokers{} to the left",
					"once for {C:attention}every{} unique non-{C:blue}Common{C:attention} Joker{}",
					"to the right of this Joker",
                    "{C:inactive}(Up to #2# retrigger#<s>2#)",
                    "{C:inactive}(Currently {C:attention}#1#{C:inactive})",
				},
				unlock = {
					"Retrigger a {C:attention}Joker",
					"{C:attention}114{} times",
					"in one hand",
				},
			},
			j_cry_canvas_modest = {
				name = "Canvas",
				text = {
					"{C:attention}Retrigger{} all {C:attention}Jokers{} to the left",
					"once for {C:attention}every{} unique non-{C:blue}Common{C:attention} Joker{}",
					"to the right of this Joker",
                    "{C:inactive}(Up to #2# retrigger#<s>2#)",
                    "{C:inactive}(Currently {C:attention}#1#{C:inactive})",
				},
				unlock = {
					"Retrigger a {C:attention}Joker",
					"{C:attention}114{} times",
					"in one hand",
				},
			},

            j_cry_pirate_dagger_balanced = {
				name = "Pirate Dagger",
				text = {
					"When {C:attention}Blind{} is selected,",
					"destroy Joker to the right",
					"and gain {C:attention}one-fifth{} of",
					"its sell value as {X:chips,C:white} XChips {}",
					"{C:inactive}(Currently {X:chips,C:white} X#1# {C:inactive} Chips)",
				},
			},

            
            j_cry_cotton_candy_balanced = {
				name = "Cotton Candy",
				text = {
					"When sold, {C:attention}Joker{} to",
					"it's right becomes {C:dark_edition}Negative{}",
				},
			},

            j_cry_mstack_balanced = {
				name = "M Stack",
				text = {
					"Retrigger all cards played",
					"once for every",
					"{C:attention}#2#{} {C:inactive}[#3#]{} {C:attention}Jolly Joker#<s>2#{} sold",
                    "{s:0.7,C:inactive}(Requirements increase by {s:0.7,X:red,C:white}X#4#{s:0.7,C:inactive} per upgrade){}",
                    "{C:inactive}(Capped at {C:attention:}#5#{}{C:inactive} retriggers){}",
					"{C:inactive}(Currently{}{C:attention:} #1#{}{C:inactive} retriggers){}",
				},
			},
            --create 4 random disposable copies, randomly selecting a joker owned.
            j_cry_speculo_balanced = {
                name = "Speculo",
				text = {
					"Creates #1# {C:red}Niko{} {C:dark_edition}Negative{} copies",
					"of any random {C:attention}Jokers{} owned",
					"at the end of the {C:attention}shop",
					"{C:inactive,s:0.8}Does not copy other Speculo{}",
				},
            },
            j_cry_equilib_balanced = {
				name = "Ace Aequilibrium",
				text = {
					"Jokers appear using the",
					"order from the {C:attention}Collection{}",
					"Create {C:attention}#1#{} Joker#<s>1#",
					"when hand is played",
                    "{C:inactive}(Must have room)",
					"{C:cry_exotic,s:0.8}Exotic {C:inactive,s:0.8}or better Jokers cannot appear",
					"{s:0.8}Last Joker Generated: {C:attention,s:0.8}#2#",
				},
			},

            --Proper depleted loc
            --Clicked cookie
            j_cry_clicked_cookie2 = {
				name = "Clicked Cookie",
				text = {
					"{C:chips}#1##2#{} Chip#<s>2#",
					"{C:chips}-#3#{} Chip#<s>3# when",
					"you {C:attention}click",
				},
			},
            j_cry_clicked_cookie_depleted = {
				name = "Clicked Cookie",
				text = {
					"{C:chips}#1##2#{} Chip#<s>2#",
					"{C:chips}-#3#{} Chip#<s>3# when",
					"you {C:attention}click",
                    "{E:2,C:red}Self destructs{} at",
                    "{C:chips}#4#{} Chip#<s>4#",
				},
			},
            --turtle bean
            j_turtle_bean={
                name="Turtle Bean",
                text={
                    "{C:attention}#3##1#{} hand size,",
                    "reduces by",
                    "{C:red}#2#{} every round",
                },
            },
            j_turtle_bean_depleted = {
                name="Turtle Bean",
                text={
                    "{C:attention}#3##1#{} hand size,",
                    "reduces by",
                    "{C:red}#2#{} every round",
                    "{E:2,C:red}Self destructs{} at",
                    "{C:attention}#4#{} hand size",
                },
            },
            --Popcorn
            j_popcorn={
                name="Popcorn",
                text={
                    "{C:mult}#3##1#{} Mult",
                    "{C:mult}-#2#{} Mult per",
                    "round played",
                },
            },
            j_popcorn_depleted={
                name="Popcorn",
                text={
                    "{C:mult}#3##1#{} Mult",
                    "{C:mult}-#2#{} Mult per",
                    "round played",
                    "{E:2,C:red}Self destructs{} at",
                    "{C:mult}#4#{} Mult",
                },
            },
            --Ice cream
            j_ice_cream={
                name="Ice Cream",
                text={
                    "{C:chips}#3##1#{} Chips",
                    "{C:chips}-#2#{} Chips for",
                    "every hand played",
                },
            },
            j_ice_cream_depleted={
                name="Ice Cream",
                text={
                    "{C:chips}#3##1#{} Chips",
                    "{C:chips}-#2#{} Chips for",
                    "every hand played",
                    "{E:2,C:red}Self destructs{} at",
                    "{C:chips}#4#{} Chips",
                },
            },
            --Ramen
            j_ramen={
                name="Ramen",
                text={
                    "{X:mult,C:white} X#1# {} Mult,",
                    "loses {X:mult,C:white} X#2# {} Mult",
                    "per {C:attention}card{} discarded",
                },
            },
            j_ramen_depleted={
                name="Ramen",
                text={
                    "{X:mult,C:white} X#1# {} Mult,",
                    "loses {X:mult,C:white} X#2# {} Mult",
                    "per {C:attention}card{} discarded",
                    "{E:2,C:red}Self destructs{} at",
                    "{X:mult,C:white} X#3# {} Mult",
                },
            },
            --Nachos
            j_paperback_nachos_depleted = {
                name = "Nachos",
                text = {
                    "{X:chips,C:white}X#1#{} Chips,",
                    "loses {X:chips,C:white}X#2#{} Chips",
                    "per {C:attention}card{} discarded",
                    "{E:2,C:red}Self destructs{} at",
                    "{X:chips,C:white}X#3#{} Chips",
                },
            },
            --Lollipop
            j_mf_lollipop_depleted = {
                name = "Lollipop",
                text = {
                "{X:mult,C:white} X#1# {} Mult",
                "{X:mult,C:white} -X#2# {} Mult per",
                "round played",
                "{E:2,C:red}Self destructs{} at",
                "{X:mult,C:white} X#3# {} Mult",
                }
            },
            j_cry_starfruit_depleted = {
				name = "Starfruit",
				text = {
					"{X:dark_edition,C:white}^#1#{} Mult,",
					"loses {X:dark_edition,C:white}^#2#{} Mult per",
					"{C:attention}reroll{} in the shop",
                    "{E:2,C:red}Self destructs{} at",
                    "{X:dark_edition,C:white}^0{} Mult",
				},
			},
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
                    "until at specified negative values",
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
            },
            unik_baseless_playing_card = {
                name = "Baseless",
                text = {
                    "If {C:attention}played{}, will",
                    "{C:red}reset{} Foundation",
                }
            },
            unik_baseless = {
                name = "Baseless",
                text = {
                    "{C:inactive}Does nothing",
                }
            },
            unik_limited_edition = {
                name = "Limited Edition",
                text = {
                    "Strips edition",
                    "after {C:attention}#1#{} rounds",
                    "{C:inactive}({C:attention}#2#{C:inactive} remaining)",
                }
            },
            unik_status_trigger={
                name = "Status Trigger",
                text = {
                    "Messages that appear",
                    "on trigger",
                    "{C:inactive,s:0.75}({C:mult,s:0.75}+Mult{C:inactive,s:0.75}, {X:chips,C:white,s:0.75}XChips{C:inactive,s:0.75}, {C:purple,s:0.75}Nope!{C:inactive,s:0.75}, {C:attention,s:0.75}Extinct!{C:inactive,s:0.75}, etc...)"
                },
            },
            --sticker stakes
            unik_shitty_sticker = {
                name = "Shitty Sticker",
                text = {
                    "Used this Joker",
                    "to win on {C:attention}Shitty",
                    '{C:attention}Stake{} difficulty',
                }
            },
            unik_persimmon_sticker = {
                name = "Persimmon Sticker",
                text = {
                    "Used this Joker",
                    "to win on {C:attention}Persimmon",
                    '{C:attention}Stake{} difficulty',
                }
            },

            cry_hooked_balanced = {
				name = "Hooked",
				text = {
					"When this Joker is {C:cry_code}triggered{},",
					"trigger {C:cry_code}#1#",
					"{C:inactive}Not all cards can be triggered this way{}",
					"{C:inactive}but all Jokers can trigger the other{}",
                    "{C:inactive}(Sticker removed after {C:cry_code}#2#{C:inactive} trigger#<s>2#){}",
				},
			},
            --To better inform people on poppy's mechanics.
            unik_hands_lost = {
                name = "Hands/Discards lost",
                text = {
                    "{C:blue}Hands{}/{C:red}Discards{C:attention} lost{} is",
                    "almost the same as ",
                    "{C:blue}Hands{}/{C:red}Discards {C:attention}used",
                    "but also triggers when",
                    "Blinds {C:attention}remove{} {C:blue}Hands{} or {C:red}Discards",
                }
            },

            unik_light_suits = {
                name = "Light Suits",
                text = {
                "{C:diamonds}Diamonds{}, {C:hearts}Hearts{}"
                }
            },
            unik_dark_suits = {
                name = "Dark Suits",
                text = {
                "{C:spades}Spades{}, {C:clubs}Clubs{}"
                }
            },
            
        },
        Planet={
            c_unik_asteroid_belt = {
				name = "Asteroid Belt",
				text = {
					"{S:0.8}({S:0.8,V:1}lvl.#1#{S:0.8}){} Level up",
					"{C:attention}#2#",
					"{C:mult}+#3#{} Mult and",
					"{C:chips}+#4#{} chip#<s>4#",
				},
			},
            c_unik_quaoar = {
				name = "Quaoar",
				text = {
					"{S:0.8}({S:0.8,V:1}lvl.#1#{S:0.8}){} Level up",
					"{C:attention}#2#",
					"{C:mult}+#3#{} Mult and",
					"{C:chips}+#4#{} chip#<s>4#",
				},
			},
            c_unik_haumea = {
				name = "Haumea",
				text = {
					"{S:0.8}({S:0.8,V:1}lvl.#1#{S:0.8}){} Level up",
					"{C:attention}#2#",
					"{C:mult}+#3#{} Mult and",
					"{C:chips}+#4#{} chip#<s>4#",
				},
			},
            c_unik_sedna = {
				name = "Asteroid Belt",
				text = {
					"{S:0.8}({S:0.8,V:1}lvl.#1#{S:0.8}){} Level up",
					"{C:attention}#2#",
					"{C:mult}+#3#{} Mult and",
					"{C:chips}+#4#{} chip#<s>4#",
				},
			},
            c_unik_makemake = {
				name = "Asteroid Belt",
				text = {
					"{S:0.8}({S:0.8,V:1}lvl.#1#{S:0.8}){} Level up",
					"{C:attention}#2#",
					"{C:mult}+#3#{} Mult and",
					"{C:chips}+#4#{} chip#<s>4#",
				},
			},
        },
        Spectral={
            --only appears with a 0.3 chance in the cube booster pack. It's basically a gateway, but exclusively creating UNIK 
            --THIS SHALL BE REPLACED WITH AWAKENING: Destroy 2 leftmost non eternals, create an ancient joker. The ancient will be created FIRST before the jokers are destroyed, for WL synergy.
            c_unik_gateway = {
				name = "Awakening",
				text = {
					"Create an {C:unik_ancient,E:1}Ancient{} Joker",
					"{C:red}destroy{} the {C:attention}#1#",
					"leftmost Joker#<s>1#",
                    "{C:inactive}(Eternals skipped){}"
				},
			},
            c_unik_foundry = {
                name = "Foundry",
                text = {
                    "Add {C:dark_edition}Steel{} to {C:attention}#1#",
                    "selected playing card#<s>1#",
                    "Add {C:attention}#2#{} random",
                    "unmodified card#<s>2#",
                }
            },
            c_cry_pointer_no_dupe = {
				name = "POINTER://",
				text = {
					"Create a card",
					"of {C:cry_code}your choice",
					"{C:inactive,s:0.8}(Exotic Jokers excluded)",
                    "{C:inactive,s:0.8}Becomes {{C:spectral,s:0.8}The Soul {C:inactive,s:0.8}if",
                    "{C:cry_code,s:0.8}POINTER:// {C:inactive,s:0.8}is already held"
				},
			},
            c_unik_prism = { --polychrome deck exclusive.
                name = "Prism",
                text = {
                     "Add {C:dark_edition}Polychrome{} to {C:attention}#1#",
                    "selected playing card#<s>1#",
                    "Add {C:attention}#2#{} random",
                    "unmodified card#<s>2#",
                }
            },
            c_unik_bloater ={
                name = "Overcapacity",
                text = {
                    "{C:attention}+#1#{} Hand Size",
                    "Add {C:attention}#2#{} random",
                    "unmodified card#<s>2#",
                }
            },
        },
        Stake={
            stake_unik_shitty = {
				name = "Shitty Stake",
				colour = "Shitty", --this is used for auto-generated sticker localization
				text = {
					"{C:attention}Perishable{} Jokers can be {C:attention}Disposable{}",
					"{s:0.8,C:inactive}({s:0.8,C:red}Destroyed {s:0.8,C:inactive}after round){}",
                    "{C:attention}Perishable{} Jokers are {C:red}destroyed{} instead of being {C:red}debuffed",
                    '{s:0.8}Applies all previous stakes',
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
                    '{s:0.8}Applies all previous stakes',
				},
			},
            stake_blue = {
                name = "Blue Stake",
                colour = "Blue",
                text = {
                    "Ante victory requirements",
                    "increased by {C:attention}X1.3",
                    '{s:0.8}Applies all previous stakes',
                }
            },
        },
        Sleeve = {
            sleeve_casl_ghost = {
                name = "Ghost Sleeve",
                text = {
                    "Start with {C:dark_edition,T:v_unik_spectral_merchant}Spectral Merchant",
                    "and a {C:spectral,T:c_hex}Hex{} card",
                    }
            },
            sleeve_casl_ghost_alt = {
                name = "Ghost Sleeve",
                text = {
                    "Start with {C:dark_edition,T:v_unik_spectral_tycoon}Spectral Tycoon",
                    "{C:spectral}Spectral Packs{} have {C:attention}#1#{}",
                    "extra options to choose from",
                }
            },
        },
        Tag={			
            --to even be remotely safe to use, you need yes nothing! Yes I am making more stuff that reles on yes nothing since there isnt enough stuff that needs it (wheel, tornado, glass cards,cavendish,banana tag)
            tag_unik_demon = {
                name = "Demon Tag",
                text = {
                    "{C:green}#1# in #2#{} chance to either",
                    "create a {X:unik_detrimental,C:white}Detrimental{} Joker,",
                    "{C:red}destroy{} a {C:attention}random{} Joker,",
                    "create a {C:unik_manacle_color}Handcuffs Tag{},",
                    "add {C:unik_shitty_edition}Positive{} to a {C:attention}random{} Joker,",
                    "or create a {C:purple}Vessel Tag",
                    "Otherwise, create an",
                    "{C:cry_ancient,E:1}Extended Empowered Tag",
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
					"with {C:legendary,E:1}The Soul{}, {C:cry_epic,E:1}Foundation{} and {C:unik_ancient,E:1}Awakening{}",
				},
			},
        },
        Tarot={
            c_unik_wheel_of_misfortune = {
                name = "The Evocation",
                text = {
                    "{C:green}#1# in #2#{} chance to create ",
                    "a {X:unik_detrimental,C:white}Detrimental{} Joker",
                    "otherwise apply {C:dark_edition}Negative{}, {C:dark_edition}Mosaic{},",
                    "or {C:dark_edition}Astral{} to a {C:attention}random{} Joker",
                }
            },
            c_unik_crossdresser = {
                name = "The Crossdresser",
                text = {
                    "Enhances {C:attention}#1#{} selected",
                    "card into a",
                    "{C:unik_unik_color}Pink Card",
                }
            },
            c_unik_oligarch = {
                name = "The Oligarch",
                text = {
                    "Enhances {C:attention}#1#{} selected",
                    "card#<s>1# into a",
                    "{C:attention}Dollar Card",
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
                    "{E:2,C:red}Add #1#{} {X:unik_detrimental,C:white}Detrimental{} Jokers",
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
        Voucher={
            v_unik_spectral_merchant = {
				name = "Spectral Merchant",
				text = {
					"{C:spectral}Spectral{} cards",
					"may appear",
					"in the shop",
				},
			},
            v_unik_spectral_tycoon = {
				name = "Spectral Tycoon",
				text = {
					"{C:spectral}Spectral{} cards appear",
					"{C:attention}X#1#{} more frequently",
					"in the shop",
				},
			},
            v_unik_spectral_acclimator = {
				name = "Spectral Acclimator",
				text = {
					"{C:spectral}Spectral{} cards appear",
					"{C:attention}X#1#{} more frequently",
					"in the shop",
                    "Allows control of the",
					"shop's {C:spectral}Spectral Rate{}",
					"{C:inactive}(Check {C:attention}Run Info{C:inactive})",
				},
			},

        },
    },
    misc = {
        poker_hands = {
        ['unik_spectrum'] = "Spectrum",
        ['unik_straight_spectrum'] = "Straight Spectrum",
        ['unik_spectrumfuck'] = "Spectrumfuck",
        ['unik_straight_spectrum_royal'] = "Royal Spectrum",
        ['unik_spectrum_house'] = "Spectrum House",
        ['unik_spectrum-five'] = "Spectrum Five",
        },
        poker_hand_descriptions = {
        ['unik_spectrum'] = {
            "5 cards with different suits"
        },
        ['unik_spectrumfuck'] = {
            "8 cards with different suits and ranks",
            "without containing a Straight",
        },
        ['unik_straight_spectrum'] = {
            "5 cards in a row (consecutive ranks),",
            "each with a different suit"
        },
        ['unik_spectrum_house'] = {
            "A Three of a Kind and a Pair with",
            "each card having a different suit"
        },
        ['unik_spectrum_five'] = {
            "5 cards with the same rank,",
            "each with a different suit"
        },
        },
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
            c_unik_singleton="Singleton",
            c_unik_learning_with_pibby="Learning With Pibby",
        },
        collabs={},
        dictionary={
            k_planet_disc = "Circumstellar Disc",
            unik_hand_bulwark = "Bulwark",
            unik_hand_spectrum = "Spectrum",
            unik_hand_straight_spectrum = "Straight Spectrum",
            unik_hand_spectrumfuck = "Spectrumfuck",
            unik_hand_spectrum_house = "Spectrum House",
            unik_hand_spectrum_five = "Spectrum Five",


            overshoot_unik = "Overshoot Effect",
            overshoot_unik_0 = {
                "No effects",
                "Make sure to not score",
                "too high too many times...",
            },
            overshoot_unik_1 = {
                "+1 Ante every 5 Overshoot",
            },
            overshoot_unik_2 = {
                "+1 Ante every 5 Overshoot",
                "Epic Blinds can spawn",
                "after round 40",
            },
            overshoot_unik_3 = {
                "+1 Ante every 5 Overshoot",
                "Epic Blinds can spawn anytime",
                "Legendary Blinds can spawn",
                "after round 40",
            },
            overshoot_unik_4 = {
                "+1 Ante every 5 Overshoot",
                "Epic Blinds can spawn anytime",
                "Legendary Blinds can spawn anytime",
                "+1 ante per overshoot over 20",
                "All Boss Blinds are Finishers"
            },
            overshoot_unik_5 = {
                "+1 Ante every 5 Overshoot",
                "Epic Blinds can spawn anytime",
                "Legendary Blinds can spawn anytime",
                "+1 ante per overshoot over 20",
                "All Blinds are Epic+ Blinds"
            },

            k_unik_lartceps="Lartceps",
            b_unik_lartceps_cards = "Lartceps Cards",
            unik_legendary_blinds_option = "Epic and Legendary Blinds (Restart Required)",
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
            k_unik_artisan_builds_epic_placeholder="If less than (rerolls this run)^0.8 rerolls are done this ante,",
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
            k_unik_blind_start_tooth="The Tooth",
            k_unik_blind_start_wheel="The Wheel",
            k_unik_blind_start_house="The House",
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
            k_unik_lily_sprunki_tired="I need to rest a while...",
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
            k_unik_high_score = "=Best hand in Run",
            k_unik_legendary_crown_start="",
            k_unik_legendary_crown_defeat_x_times1="Defeat this blind ",
            k_unik_legendary_crown_defeat_x_times2=" time(s)",
            k_unik_legendary_crown_placeholder="(Max Hands)",
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
            k_unik_reed_placeholder="(3 random ranks from deck)",
            k_unik_reed_part1 = "a",
            k_unik_reed_part2 = "or",
            k_unik_epic_sand_placeholder = "(Tags held)",
            k_unik_half = "Half",
            k_defeated_by = "Killed By",
            k_unik_none_hand_banned = "None hand is banned",
            k_unik_jaundice_jack = "If a Jack not discarded before hand, convert random Joker to Hit the Road",
            k_unik_septic_seance = "If hand is not Straight Flush, convert adjacent Jokers to Seance",
            k_unik_jackshit = "JACKSHIT!",
            k_unik_seance_or_else="SEANCE OR ELSE!",
            k_unik_chamber_placeholder="(Joker rarities owned)",
            k_unik_chamber_placeholder2="(Joker rarities owned)",
            k_unik_chamber_warning1="Next ",
            k_unik_chamber_warning2=" hands will add to the blind size",
            b_unik_devour = "DEVOUR",
            b_spectral_rate = "Spectral Rate",
            cry_good_luck_ex = "Good luck!",
            --Almanac Quotes:

            --Moonlight Cookie: She will be the first Joker with full almanac functionality (has a fusion, different quotes)
            ---Normal:
            k_unik_moonlight_normal1 = "May I wish you happy dreams...",
            k_unik_moonlight_normal2 = "The stars dance and the dreams flow...",
            k_unik_moonlight_normal3 = "It will be nice to dream for a while...",

            --Unik
            ---Normal:
            k_unik_unik_normal1 = "Maybe you don't mind I'm crossdressing here...",
            k_unik_unik_normal2 = "I'll help out here, although I'll take my time.",
            k_unik_unik_normal3 = "Quite an experience, wearing this here...",
            k_unik_unik_normal4 = "I can admittedly be a bit dreary at times...",
            k_unik_unik_normal5 = "Let me know what I can help out with.",
            k_unik_unik_normal6 = "Umm, hi... Can't believe I'm here now...",
            --Chelsea
            ---Normal:
            k_unik_chelsea_normal1 = "Hola! Maybe I can help out?",
            k_unik_chelsea_normal2 = "What is all this? Everything is quite different...",
            k_unik_chelsea_normal3 = "Hey, is it alright if I do something here?",
            k_unik_chelsea_normal4 = "I miss being with my family...",
            k_unik_chelsea_normal_1member = "Mom! It's nice to not be alone for once...",
            k_unik_chelsea_normal_family = "Oh! Maya, Yokana! I'm glad you two are here!",

            k_unik_pibby_normal1 = "Learning is so much fun!",
            k_unik_pibby_normal2 = "Well what shall we learn today?",
            k_unik_pibby_normal3 = "I believe it's counting time!",
            k_unik_pibby_darkness1 = "Oh no... That thing is here!",
            k_unik_pibby_darkness2 = "After all this time? How did it get here?...",
            k_unik_pibby_scared1 = "Aah! Those numbers! Too much to learn!",
            k_unik_pibby_scared2 = "Please, please be ok, it's getting too much!",
            k_inactive_ex = "Inactive",

            --Kouign amann cookie:
            k_k_amann_normal1="I am reliable AND sweet!",
            k_k_amann_normal2="I'm strong! That's what makes me so lovely!",
            k_k_amann_normal3="I am cute as I am diligent!",
            k_k_amann_normal4="The Light is in my dough!",
            k_k_amann_normal5="Working hard makes a Cookie so much sweeter!",
            
            k_k_amann_trigger1="Justice be served!",
            k_k_amann_trigger2="The light shall show the way!",
            k_k_amann_trigger3="My Paladin's Spirit!",
            k_k_amann_trigger4="Sweet and strong, here I come!",

            --Poppy
            k_poppy_normal1="Oh! It's nice seeing you here!",
            k_poppy_normal2="Hi! HIIIII!!!",
            k_poppy_normal3="Lets go hang out one day!",
            k_poppy_normal4="Ooh! How's it going everyone?!",
            k_poppy_normal5="I bet this run will go well!",
            
            k_poppy_trigger1="Yippee!",
            k_poppy_trigger2="Let's go Poppy!",
            k_poppy_trigger3="I did it!",
            k_poppy_trigger4="Yay!",

            unik_plus_lartceps = "+1 Lartceps...",
            k_unik_copied = "Copied...",
            k_unik_epic_sand_cry_1 = "^2 Blind size",
            k_unik_epic_sand_cry_2 = "per tag held",
            k_unik_tag="tags",
            k_unik_epic_sand_almanac_1 = "Increase blind size",
            k_unik_epic_sand_almanac_2 = "by {Tags held}1.1",
            k_unik_epic_vice_placeholder = "(4, increase by ^1.05 per Tukehtumisenpahe)",
            ph_game_over="YOU ARE DEAD",
            k_unik_leg_tornado_warn_1 = "Must only play the last ",
            k_unik_leg_tornado_warn_2 = " cards in deck",
            k_unik_tornado_placeholder = "(Current Discards)",
            k_chips = "Chips",
            k_unik_must_select_four="Must select at least 4 cards to skip",

            k_akyrs_all_unskippable_blinds = "All Blinds this Ante are unskippable",
            k_akyrs_unskippable_blind = "Cannot be skipped",
            k_akyrs_blind_difficult_epic = "Epic Blind",
            k_akyrs_blind_difficult_legendary = "Legendary Blind",
            k_unik_legendary_blind_finity = "Legendary Blind",
            k_unik_detrimental = "Detrimental",
            k_unik_ancient = "Ancient",

            k_legendary_crown_normal1 = "I tried to climb the mountain...",
            k_legendary_crown_normal2 = "I should've listened to her...",
            k_legendary_crown_normal3 = "I should've known better...",
            k_legendary_crown_normal4 = "Please don't make the same mistake as I did...",

            k_plus_code = "+1 Code",

            cry_tax_placeholder_fixed = "(X0.8 blind requirements)",
            k_unik_back_to_back1="Must defeat ",
            k_unik_back_to_back2=" Blind(s) back-to-back",
            k_unik_miser_placeholder="15 x (1+(Loputonahnes encountered x 0.1))",
            unik_the_descending = "The Descending",
            k_overshoot = "Overshoot",
            k_unik_brain_placeholder = "math.min(Card Selection Limit,Hand Size)",
            k_unik_perished="Perished!",
            k_unik_last_tile="LAST TILE 海底撈月",
            k_unik_wheel_burst="Bursted!",
            k_unik_xchips_not_vanilla1="XCHIPS IS NOT VANILLA!1!!1!!",
            k_unik_xchips_not_vanilla2="XCHIPS ALREADY EXISTS!!1!! IT'S CALLED MULT!1!!1",
            k_unik_xchips_not_vanilla3="THINK! THINK! YOUR DEPENDENCE ON XCHIPS IS DISGUSTING!!11!!!",
            k_unik_xchips_not_vanilla4="BUNCO IS NOT VANILLA CAUSE IT USES XCHIPS!!!!11!!!",
            cry_unredeemed = "Unredeemed...",
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
            unik_baseless = "Baseless",
            unik_limited_edition = "Limited Edition",
        },
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
                "Maybe not having too",
                "much cards could help?",
            },
            special_lose_unik_sword_legendary={
                "Huh, your weapon",
                "wasn't sharp enough.",
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
                "Oh wait, it no longer exists!",
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
            },
            special_lose_unik_jaundice_jack={
                "YOU JACKSHIT!",
            },
            special_lose_unik_seance={
                "Bruh, seance is the BEST",
                "card, you shitass!",
            },
            special_lose_torture_chamber={
                "Good luck in your eternal",
                "stay at a CIA Black Site!",
            },
            special_lose_unik_fuzzy={
                "Touch Fuzzy,",
                "GET DIZZY!",
            },
            special_lose_unik_half={
                "Too late to beg for",
                "a half joker now!",
            },
            special_lose_unik_darkness={
                "P L A Y",
                "W I T H",
                "M E",
                "A S S H O L E",
            },
            special_lose_unik_bloon={
                "You're leaking!",
                "Oh wait, you've",
                "already popped."
            },
            special_lose_unik_positive={
                "Big brother is",
                "always watching!",
            },
            special_lose_salmon_steps={
                "This seems familar...",
                "Too bad you fell",
                "down the stairs!"
            },
            special_lose_xchips_hater={
                "XCHIPS. IS.",
                "NOT. VANILLA!!!!!",
            },
            --finity quips:
            lq_legendary_crown_1={
                "Why did you",
                "try to climb?...",
            },
            lq_legendary_crown_2={
                "I cannot make it...",
                "Why did you go still?..."
            },
            lq_legendary_crown_3={
                "I was so foolish",
                "trying to climb",
                "that mountain...",
            },
            lq_legendary_crown_4={
                "Don't make the same",
                "mistake as I did...",
            },
        },
        ranks={},
        suits_plural={},
        suits_singular={},
        tutorial={},
        v_dictionary={
            a_eblindsize = {"^#1# Blind Size"},
            a_EEmult = {"^^#1# Mult"},
            a_EEchips = { "^^#1# Chips" },
            a_hyper_three_chips = { "^^^#1# Chips" },
            a_hyper_three_mult = { "^^^#1# Mult" },
            a_hyper_four_mult = { "^^^^#1# Mult" },
            a_hyper_five_mult = { "^^^^^#1# Mult" },
            a_hyper_hyper_mult = { "#1##2# Mult" },
            a_unik_hands_1={"#1# hands"},
            a_unik_discards_1={"#1# discards"},
            a_unik_reed_construct={"ranks #1# or #2#"},
            a_unik_celestial_triggers = {"#1# Triggers"},
            a_unik_discards = {"+#1# Discards"},
            a_factorial_mult = {"!Mult^#1#"},
            a_factorial_chips = {"!Chips^#1#"},
            --Cryptlib borrowing
            a_xchips = { "X#1# Chips" },
			a_powmult = { "^#1# Mult" },
			a_powchips = { "^#1# Chips" },
			a_powmultchips = { "^#1# Mult+Chips" },
			a_round = { "+#1# Round" },
			a_xchips_minus = { "-X#1# Chips" },
			a_powmult_minus = { "-^#1# Mult" },
			a_powchips_minus = { "-^#1# Chips" },
			a_powmultchips_minus = { "-^#1# Mult+Chips" },
			a_round_minus = { "-#1# Round" },
			a_tag_minus = { "-#1# Tag" },
			a_tags_minus = { "-#1# Tags" },
			a_tag = { "+#1# Tag" },
			a_tags = { "+#1# Tags" },
        },
        v_text={			
            ch_c_unik_mult_set_to_one = { "{C:mult}Mult{} is added to {C:chips}Chips{} and {C:attention}set{} to {C:red}<=1{}" },
            ch_c_unik_chips_set_to_one = { "{C:chips}Chips{} are added to {C:mult}Mult{} and {C:attention}set{} to {C:red}<=1{}" },
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
            ch_c_unik_single_select_limit = {"{C:red}1{} Card {C:attention}Selection Limit"},
            ch_c_unik_the_darkness_spreads1 = {"Leftmost Joker become {C:unik_shitty_edition}Corrupted{} on Blind Select"},
            ch_c_unik_the_darkness_spreads2 = {"1 Random Card in Hand becomes {C:unik_shitty_edition}Corrupted{} on play"},
            ch_c_unik_the_darkness_spreads3 = {"Adjacent Jokers to {C:unik_shitty_edition}Corrupted{} Jokers become {C:unik_shitty_edition}Corrupted{} on Blind Select"},
            ch_c_unik_the_darkness_spreads4 = {"All Editions are {C:unik_shitty_edition}Corrupted"},
            ch_c_unik_protect_pibby = {"If {C:attention}Pibby{} is {C:unik_shitty_edition}Corrupted{} or destroyed, {X:unik_void_Color, C:unik_eye_searing_red}Die"},

        },
    },
}