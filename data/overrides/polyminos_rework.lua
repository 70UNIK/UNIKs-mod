--Polymino rework:
---You can individually select each card, allowing them to be modified within.
---Cards will still be played and discarded together
---Selecting cards becomes janky. If you select 1 card in a linked group:
---Ignores selection limit within the group, but still counts up outside the group
---If you select another group while one card inside a group is selected and exceeds selection limit, cannot be selected
---A tarot appears that allows you to remove groups and earn $20 in the process
---
---
---
---Properly add linked cards to highlighted when played or discarded
-- Allows for a group of over 5 cards to be played/discarded

local highlightHook = CardArea.can_highlight
function CardArea:can_highlight(card)
    -- Anything is selectable with The 8 active

    if card and self == G.hand and G.GAME and (G.GAME.THE_8_BYPASS or G.GAME.unik_excommunication) then
        return true
    end
    
    --How this works:
    --Gathers all highlighted cards with groups and adds potentially unhighlighted cards.
    --Gathers all groupless cards
    --Checks if selected card is in a group.

    local highlightedGroupedList = {}
    local highlightedGroups = {}
    local nonGroupedList = {}
    for i,v in pairs(G.hand.highlighted) do
        if v and v.ability and v.ability.group then
            local id = v.ability.group.id
            --Prevent repeat
            if not highlightedGroups[id] then
                --Factors in already selected cards
                for j,w in pairs(G.hand.cards) do
                    if w.ability and w.ability.group and w.ability.group.id == id then
                        highlightedGroupedList[#highlightedGroupedList+1] = {card = w, id = id}
                        highlightedGroups[id] = true
                    end
                    
                end
            end
        else
            nonGroupedList[#nonGroupedList+1] = {card = v}
        end
    end
    local cardsAdded = 0
    --If highlighted card is in a group...
    if card  and card.ability and card.ability.group then
        --If inside a group already, then always return true (it assumes that it already fulfils limits prior)
        if highlightedGroups[card.ability.group.id] then
            return true
        end
        for j,w in pairs(G.hand.cards) do
            if w.ability and w.ability.group and w.ability.group.id == card.ability.group.id then
                cardsAdded = cardsAdded + 1
            end
        end
    else
        cardsAdded = 1
    end
    if not card.highlighted and not G.GAME.unik_video_poker_rules and #nonGroupedList + #highlightedGroupedList > 0 and cardsAdded + #nonGroupedList + #highlightedGroupedList > self.config.highlighted_limit then
        return false
    end


    return highlightHook(self,card)
end

function CardArea:brute_force_highlight(card,silent)
    self.highlighted[#self.highlighted+1] = card
    card:highlight(true)
    if not silent then play_sound('cardSlide1') end
end

--Still allow for the 8's bypass
local bunc_original_add_to_highlighted = CardArea.add_to_highlighted
function CardArea:add_to_highlighted(card, silent)
    if G.STATE ~= G.STATES.DRAW_TO_HAND and not G.DRAWING_CARDS then
        local original_highlited_limit = self.config.highlighted_limit
        self.config.highlighted_limit = G.GAME.THE_8_BYPASS and self.config.type == "hand" and math.huge or self.config.highlighted_limit
        bunc_original_add_to_highlighted(self, card, silent)
        self.config.highlighted_limit = original_highlited_limit
    else
      --  print(self.config.highlighted_limit)
        bunc_original_add_to_highlighted(self, card, silent)
    end
end

--Discard all linked groups, regardless if all are selected
local linked_discarded = G.FUNCS.discard_cards_from_highlighted
G.FUNCS.discard_cards_from_highlighted = function(e, hook)
    --Polymino autoselect
    local id = nil
    local source = nil

    if G.hand and G.hand.highlighted then
        for i = 1, #G.hand.highlighted do
            if G.hand.highlighted[i] and G.hand.highlighted[i].ability and G.hand.highlighted[i].ability.group then
                id = G.hand.highlighted[i].ability.group.id
                source = G.hand.highlighted[i].ability.group.source
            end
        end
    end
    -- print(id)
    -- print(source)
    if id then
        for i,v in pairs(G.hand.cards) do
            if v and v.ability and v.ability.group and v.ability.group.id == id and not v.highlighted then
                -- print("LINK IT!!")
                G.hand:brute_force_highlight(v)
            end
        end
    end
    --end
    local ret = linked_discarded(e,hook)
    return ret
end

--Unlink cards and gro
function unlink_cards_and_groups(cards)
    for i = 1, #cards do
        local card = cards[i]
        if card.ability and card.ability.group then
            local id = card.ability.group.id
            local source = card.ability.group.source
            for i,v in pairs(G.playing_cards) do
                if v.ability.group and v.ability.group.id == id and v.ability.group.source == source then
                    v.ability.group.source = nil
                    v.ability.group.id = nil
                    v.ability.group = nil
                end
            end
            card.ability.group = nil
        end

    end
end

function unlink_cards(cards)
    for i = 1, #cards do
        local card = cards[i]
        if card.ability and card.ability.group then
            card.ability.group = nil
        end

    end
end
