--start with riff raff, better riffin and riff rare, start with magic trick and jokers no longer appear in the shop
SMODS.Challenge{
    key = "unik_riff_riff",
	rules = {
        custom = {
                {id = 'no_shop_jokers'},
                {id = 'unik_super_magic_trick'},
            },
        modifiers = {
            {id = 'joker_slots', value = 5},
        }
	},
	jokers = {
        { id = "j_riff_raff", edition = "negative", extra_stickers = {'unik_taw'}},
        { id = "j_unik_better_riffin", edition = "negative", extra_stickers = {'unik_taw'}},
        { id = "j_unik_riff_rare", edition = "negative", extra_stickers = {'unik_taw'}},
    },
	deck = {
		type = "Challenge Deck",
       
	},
    vouchers = {
        {id = 'v_magic_trick'},
    },
    apply = function(self) 
         G.E_MANAGER:add_event(Event({
                                trigger = "after",
                                delay = 0,
                                func = function()
                                    G.GAME.playing_card_rate = G.GAME.playing_card_rate * 5
                                    return true
                                end,
                            }))
    end,
    restrictions = {
            banned_cards = function(self)
                local bannedCards = {}
                bannedCards[#bannedCards+1] = {id = 'c_judgement'}
                bannedCards[#bannedCards+1] = {id = 'c_wraith'}
                bannedCards[#bannedCards+1] = {id = 'c_unik_expel'}
                bannedCards[#bannedCards+1] = {id = 'p_unik_character'}
                bannedCards[#bannedCards+1] = {id = 'p_unik_extended_empowered'}
                bannedCards[#bannedCards+1] = {id = 'p_buffoon_normal_1', ids = {
                    'p_buffoon_normal_1','p_buffoon_normal_2','p_buffoon_jumbo_1','p_buffoon_mega_1',
                }}
                
                for i,v in pairs(G.P_CENTERS) do
                    if SMODS.has_attribute(v, "joker") and (SMODS.has_attribute(v, "generation") or (v.set == 'Booster'))
                    and v.key ~= 'j_riff_raff' and v.key ~= 'j_unik_better_riffin' and v.key ~= 'j_riff_rare' and v.key ~= 'c_soul' and v.key ~= 'c_unik_gateway' and v.key ~= 'j_unik_white_lily_cookie'
                    then
                        bannedCards[#bannedCards+1] = {id = v.key}
                    end
                end
                if All_in_Jest then
                    bannedCards[#bannedCards+1] = {id = 'v_aij_common_caste'}
                    bannedCards[#bannedCards+1] = {id = 'v_aij_upper_class'}
                end

                return bannedCards
            end,
            banned_tags = function(self)
                local bannedCards = {}
                bannedCards[#bannedCards+1] = {id = 'tag_rare'}
                bannedCards[#bannedCards+1] = {id = 'tag_uncommon'}
                bannedCards[#bannedCards+1] = {id = 'tag_holo'}
                bannedCards[#bannedCards+1] = {id = 'tag_polychrome'}
                bannedCards[#bannedCards+1] = {id = 'tag_negative'}
                bannedCards[#bannedCards+1] = {id = 'tag_foil'}
                bannedCards[#bannedCards+1] = {id = 'tag_buffoon'}
                bannedCards[#bannedCards+1] = {id = 'tag_top_up'}
                 bannedCards[#bannedCards+1] = {id = 'tag_unik_steel'}
                  bannedCards[#bannedCards+1] = {id = 'tag_unik_shining_glitter'}
                  bannedCards[#bannedCards+1] = {id = 'tag_unik_demon'}
                for i,v in pairs(G.P_TAGS) do
                    if SMODS.has_attribute(v, "joker") and SMODS.has_attribute(v, "editions")  then
                        bannedCards[#bannedCards+1] = {id = v.key}
                    end
                end
                if All_in_Jest then
                    bannedCards[#bannedCards+1] = {id = 'tag_aij_soulbound'}
                end

                return bannedCards
            end,
            banned_other = {
                {id = 'bl_unik_magician', type = 'blind'},
                {id = 'bl_unik_abyss', type = 'blind'},
                {id = 'bl_unik_crater', type = 'blind'},
                {id = 'bl_unik_ravine', type = 'blind'},
            }
        },

}