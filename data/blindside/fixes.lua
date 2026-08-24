-- local groupHook = has_group_of
-- function has_group_of(num, hands)
--     if not hands then return false end

--     return groupHook(num,hands)
-- end
--scaling blinds will use scale_card instead so its easier to block from being copied
--The Snow (/)
--The Line (/)
--The Trench (/)
--Monolith (/)

 --exclude cursed tags
 SMODS.Joker:take_ownership("j_bld_matryoshka",{
    calculate = function(self, card, context)
            if context.setting_blind and card.ability.extra.last_tag then
                G.E_MANAGER:add_event(Event({
                    func = function ()
                        add_tag(Tag(card.ability.extra.last_tag))
                        card:juice_up(0.65, 0.65)
                        play_sound('generic1', 0.9 + math.random()*0.1, 0.8)
                        play_sound('holo1', 1.2 + math.random()*0.1, 0.4)
                        return true
                    end
                }))
                delay(0.4)
                G.E_MANAGER:add_event(Event({
                    func = function ()
                        add_tag(Tag(card.ability.extra.last_tag))
                        card:juice_up(0.65, 0.65)
                        play_sound('generic1', 0.9 + math.random()*0.1, 0.8)
                        play_sound('holo1', 1.2 + math.random()*0.1, 0.4)
                        return true
                    end
                }))
                return {

                }
            end
            if context.tag_triggered and not (context.tag_triggered.config and context.tag_triggered.config.extra and (context.tag_triggered.config.extra.hex or context.tag_triggered.config.extra.cannot_copy)) then
                print(inspect(context.tag_triggered))
                card.ability.extra.last_tag = context.tag_triggered.key
            end
        end,
        loc_vars = function (self, info_queue, card)
            info_queue[#info_queue+1] = card.ability.extra.last_tag and {key = card.ability.extra.last_tag, set = 'Tag'} or nil
            info_queue[#info_queue+1] = {key = 'tag_unik_blindside_cursed', set = 'Tag'}
            return {
                vars = {
                    card.ability.extra.last_tag and localize({key = card.ability.extra.last_tag, type = 'name_text', set = 'Tag'}) or localize("matryoshka_none")
                }
            }
        end
 },true)

--exquisite blinds:
--epic rarity equivalent
--stronger than premiums, weaker than legendaries
--examples include Pit Blinds and Hyperblinds

--quip override to only say cursed ones
for i=1,8 do
    SMODS.JimboQuip:take_ownership("bld_blindside_flippy_lose"..tostring(i),{
        filter = function(quip, type) 
            if type == "bld_loss" and not G.GAME.blind.config.blind.cursed then return true, {override_base_checks = true} end
        end
    },true)
end