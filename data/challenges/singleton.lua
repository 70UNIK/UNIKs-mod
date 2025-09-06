--Start with Poppy, 7 hands, 7 discards
--Card selection limit = 1.
SMODS.Challenge{
    key = "unik_singleton",
	rules = {
		custom = {
            { id = "unik_single_select_limit"},
		},
        modifiers = {
            {id = 'hands', value = 4},
            {id = 'discards', value = 4},
        }
	},
	jokers = {
        { id = "j_hanging_chad"},
        { id = "j_unik_poppy", eternal = true},
        
    },
    consumeables = {

    },
	deck = {
		type = "Challenge Deck",
	},
	restrictions = {
		banned_tags = {

		},
		banned_cards = function(self)
            local bannedCards = {}
            for k, v in pairs(G.P_CENTERS) do
                -- Check if its a joker
                --also nil check to avoid registring banned jokers (almanac)
                if v.set == "Joker" and v ~= nil then
                    --ban all but high card and none type jokers
                    if Cryptid then
                        if k ~= 'j_cry_giggly' and k ~= 'j_cry_dubious' and k ~= 'j_cry_undefined' and k ~= 'j_cry_nebulous' then
                            if G.P_CENTERS[k].effect and (G.P_CENTERS[k].effect == "Cry Type Mult" or G.P_CENTERS[k].effect == "Cry Type Chips") then
                                 bannedCards[#bannedCards+1] = {id = k}
                            end
                        end
                    end
                end
                if v.set == "Planet" and v ~= nil then
                    if k ~= 'c_pluto' and k ~= 'c_cry_nibiru' and k ~= 'c_cry_Timantti' and k ~= 'c_cry_ruutu' and k ~= 'c_cry_voxel' then
                         bannedCards[#bannedCards+1] = {id = k}
                    end
                end
            end
            if Cryptid then
                bannedCards[#bannedCards+1] = { id = "j_cry_wonka_bar" }
                bannedCards[#bannedCards+1] = { id = "j_cry_fractal" }
                bannedCards[#bannedCards+1] = { id = "v_cry_stickyhand" }
                bannedCards[#bannedCards+1] = { id = "v_cry_grapplinghook" }
                bannedCards[#bannedCards+1] = { id = "v_cry_hyperspacetether" }
                bannedCards[#bannedCards+1] = {id = 'j_cry_biggestm'}
                bannedCards[#bannedCards+1] = {id = 'j_cry_effarcire'}
                bannedCards[#bannedCards+1] = {id = 'j_cry_huntingseason'}

                bannedCards[#bannedCards+1] = {id = 'j_cry_duos'}
                bannedCards[#bannedCards+1] ={id = 'j_cry_nuts'}
                bannedCards[#bannedCards+1] = {id = 'j_cry_quintet'}
                bannedCards[#bannedCards+1] ={id = 'j_cry_unity'}
                bannedCards[#bannedCards+1] ={id = 'j_cry_swarm'}
                bannedCards[#bannedCards+1] = {id = 'j_cry_stronghold'}
                bannedCards[#bannedCards+1] = {id = 'j_cry_wtf'}
                bannedCards[#bannedCards+1] = {id = 'j_cry_clash'}
                bannedCards[#bannedCards+1] = {id = 'j_cry_annihalation'}
            end
            bannedCards[#bannedCards+1] = {id = 'j_jolly'}
            bannedCards[#bannedCards+1] =  {id = 'j_zany'}
            bannedCards[#bannedCards+1] =  {id = 'j_mad'}
            bannedCards[#bannedCards+1] =  {id = 'j_crazy'}
            bannedCards[#bannedCards+1] =  {id = 'j_droll'}

            bannedCards[#bannedCards+1] =  {id = 'j_sly'}
            bannedCards[#bannedCards+1] = {id = 'j_wily'}
            bannedCards[#bannedCards+1] = {id = 'j_clever'}
            bannedCards[#bannedCards+1] = {id = 'j_devious'}
            bannedCards[#bannedCards+1] = {id = 'j_crafty'}
            bannedCards[#bannedCards+1] = {id = 'j_trousers'}
            bannedCards[#bannedCards+1] = {id = 'j_square'}
            bannedCards[#bannedCards+1] = {id = 'j_unik_cube_joker'}

            bannedCards[#bannedCards+1] = {id = 'j_duo'}
            bannedCards[#bannedCards+1] = {id = 'j_trio'}
            bannedCards[#bannedCards+1] = {id = 'j_family'}
            bannedCards[#bannedCards+1] = {id = 'j_order'}
            bannedCards[#bannedCards+1] = {id = 'j_tribe'}
             bannedCards[#bannedCards+1] = {id = 'c_death'}

            return bannedCards
        end,
        banned_other = {
            {id = 'bl_psychic', type = 'blind'},
            {id = 'bl_unik_burgundy_brain', type = 'blind'},
            {id = 'bl_unik_video_poker', type = 'blind'},
        },
	},
}

local additionalConfig = Game.start_run
function Game:start_run(args)
    additionalConfig(self,args) 
    if args.challenge then
        local _ch = args.challenge
        if _ch.rules and _ch.rules.custom then
            for k, v in ipairs(_ch.rules.custom) do
                if v.id == "unik_single_select_limit" then
                    SMODS.change_play_limit(-4)
                    SMODS.change_discard_limit(-4)
                    G.hand.config.highlighted_limit = 1
                end
            end
        end
    end

end