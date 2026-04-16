--3 in 4 chance to not add a random edition to played blinds
SMODS.Tag {
    key = "unik_blindside_multiplicative",
    config = {
        chance = 3,
        trigger = 4,
    },
    hide_ability = false,
    atlas = 'unik_tags',
    pos = {x = 8, y = 1},
        in_pool = function(self, args)
            if G.GAME.selected_back.effect.center.config.extra then
                if not G.GAME.selected_back.effect.center.config.extra.blindside then return false end
                return true
            else
            return false
            end
        end,
    loc_vars = function(self, info_queue, tag)
        local chance, trigger = SMODS.get_probability_vars(tag, self.config.chance, self.config.trigger, 'multiplicative_unik')
		return { vars = { chance,trigger } }
    end,
    apply = function(self, tag, context)
        if context.type == 'shop_start' and not (next(SMODS.find_card("j_bld_taglock")) and not (G.GAME.blind.boss or G.GAME.last_joker)) then
                tag:yep('+', G.C.GREEN, function() 
                    return true end)
                tag.triggered = true
        end
        if context.type == 'before' then
            local converts = {}
                for k, v in ipairs(context.scoring_hand) do
                    if not v.edition and not SMODS.pseudorandom_probability(tag, pseudoseed("multiplicative_unik"), tag.ability.chance, tag.ability.trigger, 'multiplicative_unik') then 
                        local edition = poll_edition(pseudoseed('"multiplicative_unik2'), nil, true, true, {'e_bld_enameled', 'e_bld_finish', 'e_bld_mint', 'e_bld_shiny'})
                        v:set_edition(edition, true)
                        G.E_MANAGER:add_event(Event({
                            func = function()
                                v:juice_up()
                                tag:juice_up()
                                return true
                            end
                        }))
                    end
                end
                if #converts > 0 then 
                    tag_area_status_text(tag, 'Shine!', G.C.DARK_EDITION, false, 0)
                end
        end
    end,
    set_ability = function(self, tag) 
        tag.ability.chance = tag.config.chance
        tag.ability.trigger = tag.config.trigger
    end
}