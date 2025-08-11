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
        { id = "j_unik_poppy", stickers = { "cry_absolute" }},
        { id = "j_hanging_chad"},
    },
    consumeables = {
        {id = 'c_pluto', edition = "negative"},
    },
	deck = {
		type = "Challenge Deck",
	},
	restrictions = {
		banned_tags = {

		},
		banned_cards = {
            { id = "j_cry_wonka_bar" },
            { id = "j_cry_fractal" },
            { id = "v_cry_stickyhand" },
            { id = "v_cry_grapplinghook" },
            { id = "v_cry_hyperspacetether" },
		},
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
        if _ch.rules then
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