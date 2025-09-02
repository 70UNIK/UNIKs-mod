SMODS.Challenge{
    key = "unik_common_muck",
	rules = {
		custom = {
			{ id = "unik_common_only" },
		},
		modifiers = {},
	},
    jokers = {
	},
	deck = {
		type = "Challenge Deck",
	},
    apply = function(self)
        
    end,
    restrictions = {
        --Ban all jokers except commons (Riif roof is the only uncommon)
        banned_cards = function(self)
            local banList = {}
            banList[#banList+1] = { id = "p_unik_cube_1", ids = { "p_unik_cube_1", "p_unik_cube_two", "p_unik_cube_three" } }
            banList[#banList+1] = {id = 'c_soul'}
            banList[#banList+1] = {id = 'c_wraith'}
            banList[#banList+1] = {id = 'c_unik_gateway'}
            for k, v in pairs(G.P_CENTERS) do
            -- Check if its a joker
            --also nil check to avoid registring banned jokers (almanac)
                if v.set == "Joker" and v ~= nil then
                    --check if its not a common (cursed jokers will still appear, cause Bigger Boo and Purple Pentagram)
                    if v.rarity ~= 1 and v.rarity ~= 'unik_detrimental' and v.rarity ~= 'cry_cursed' then
                        banList[#banList+1] = {id = k}
                    end
                end
            end
            if Cryptid then
                banList[#banList+1] = { id = "p_cry_meme_1", ids = { "p_cry_meme_1", "p_cry_meme_two", "p_cry_meme_three" } }        
                banList[#banList+1] = {id = 'c_cry_gateway'}
                banList[#banList+1] = {id = 'c_cry_summoning'}
            end
            return banList
        end,
        banned_tags = function(self)
            local banList = {}
            --Ban empowered and gamblers tag, as well as rare, uncommon and epic tags

            banList[#banList+1] = {id = 'tag_unik_demon'}
            banList[#banList+1] = {id = 'tag_unik_extended_empowered'}
            banList[#banList+1] = {id = 'tag_rare'}
            banList[#banList+1] =  {id = 'tag_uncommon'}
            if Cryptid then
                banList[#banList+1] = {id = 'tag_cry_epic'}
                banList[#banList+1] = {id = 'tag_cry_bettertop_up'}
                banList[#banList+1] = {id = 'tag_cry_loss'}
                banList[#banList+1] = {id = 'tag_cry_epic'}
                banList[#banList+1] = {id = 'tag_cry_bettertop_up'}
                banList[#banList+1] = {id = 'tag_cry_loss'}
            end
            
            return banList
        end,
        --The box is banned
        banned_other = function(self)
            local banList = {}
            if Cryptid then
                banList[#banList+1] = {id = 'bl_cry_box', type = 'blind'}
                banList[#banList+1] = {id = 'bl_cry_striker', type = 'blind'}
                banList[#banList+1] = {id = 'bl_cry_windmill', type = 'blind'}
                banList[#banList+1] = {id = 'bl_cry_pin', type = 'blind'}
            end
            return banList
                
        end,
    },

}