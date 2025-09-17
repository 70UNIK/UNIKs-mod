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

--Ban discarding while selecting excommunicaiton
local excommunicationHighlight = G.FUNCS.can_discard
G.FUNCS.can_discard = function(e)
    if not can_play_multilink() then
        e.config.colour = G.C.UI.BACKGROUND_INACTIVE
        e.config.button = nil
    else
        excommunicationHighlight(e)
    end
end

---Portable function
---Similar to below but:
---If 1 link exceeds 5, it can play
---If a sum of 2 links exceed 5, cannot be played
---If all highlighted cards are forced and its across 2 groups (cerulean bell DX), allow cards to be played regardless.
function can_play_multilink(card)
    local highlightedGroupedList = {}
    local highlightedGroups = {}
    local forcedGroups = {}
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
                        if w.ability.forced_selection then
                            forcedGroups[id] = true
                        end
                        
                    end
                    highlightedGroups[id] = true
                end
            end
        else
            nonGroupedList[#nonGroupedList+1] = {card = v}
        end
    end
    local realGroups = 0
    for k,v in pairs(highlightedGroups) do
        realGroups = realGroups + 1
    end
    local realForcedGroups = 0
    if not card then
        for k,v in pairs(forcedGroups) do
            realForcedGroups = realForcedGroups + 1
        end
    end
    
    local cardsAdded = 0
    local inGroup = false
    --If highlighted card is in a group...
    if card  and card.ability and card.ability.group then
        --If inside a group already, then always return true (it assumes that it already fulfils limits prior)
        
        if highlightedGroups[card.ability.group.id] then
            inGroup = true
        else
            for j,w in pairs(G.hand.cards) do
                if w.ability and w.ability.group and w.ability.group.id == card.ability.group.id then
                    cardsAdded = cardsAdded + 1
                end
            end
        end
    elseif card then
        cardsAdded = 1
    end

    -- if card then
    --     print("existing cards:" .. #nonGroupedList + #highlightedGroupedList)
    --     print("new cards:" ..cardsAdded + #nonGroupedList + #highlightedGroupedList)
    --     print("groups:".. realGroups)
    --     print("groupless cards:" .. #nonGroupedList)
    --     print(inGroup)
    --     print("limit:" ..G.hand.config.highlighted_limit)
    -- else
    --     print("22222existing cards:" .. #nonGroupedList + #highlightedGroupedList)
    --     print("22222groups:".. realGroups)
    --     print("22222groupless cards:" .. #nonGroupedList)
    --     print("groups:".. realGroups)
    --     print("groupless cards:" .. #nonGroupedList)
    --     print(inGroup)
    --     print("limit:" ..G.hand.config.highlighted_limit)
    --     print("FORCED cards:" .. realForcedGroups)
    --     print("-----------------------------------")
    -- end

    --Only check if highlighted groups are greater than 1 and no other non grouped items are inside.
    if #nonGroupedList > 0 or realGroups > 1 or inGroup == false then
        if card then
             if G.hand and not card.highlighted and not G.GAME.unik_video_poker_rules and #nonGroupedList + #highlightedGroupedList > 0 and cardsAdded + #nonGroupedList + #highlightedGroupedList > G.hand.config.highlighted_limit then
                return false
            end
        --Still allow play if forced groups equal (or somehow succeed) selected groups, to avoid softlock in blinds such as cerulean DX
        elseif (#nonGroupedList > 0 or realGroups > 1) and realForcedGroups < realGroups then
             if G.hand and not G.GAME.unik_video_poker_rules and #nonGroupedList + #highlightedGroupedList > 0 and cardsAdded + #nonGroupedList + #highlightedGroupedList > G.hand.config.highlighted_limit then
                return false
            end
        end
       
    end
    
    if inGroup then
        return true
    end
    if card then
        return 'bypass'
    else
        return true
    end
    
end

local highlightHook = CardArea.can_highlight
function CardArea:can_highlight(card)
    -- Anything is selectable with The 8 active

    if card and self == G.hand and G.GAME and (G.GAME.THE_8_BYPASS) then
        return true
    end
    --normal selection if a consumable is highlighted
    if (G.consumeables and G.consumeables.highlighted) or (G.pack_cards and G.pack_cards.highlighted) then
        if (G.consumeables and #G.consumeables.highlighted > 0) or (G.pack_cards and #G.pack_cards.highlighted > 0) then
            if G.CONTROLLER.HID.controller then 
                if  self.config.type == 'hand'
                then
                        return true
                end
            else
                if  self.config.type == 'hand' or
                    self.config.type == 'joker' or
                    self.config.type == 'consumeable' or
                    (self.config.type == 'shop' and self.config.highlighted_limit > 0)
                then
                        return true
                end
            end
            return false
        end
    end

    if self == G.hand then
        local val = can_play_multilink(card)
        if type(val) ~= 'string' then
            return val
        end
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
    local id = {}

    if G.hand and G.hand.highlighted then
        for i = 1, #G.hand.highlighted do
            if G.hand.highlighted[i] and G.hand.highlighted[i].ability and G.hand.highlighted[i].ability.group then
                id[G.hand.highlighted[i].ability.group.id] = true
            end
        end
    end
    if id and #id > 0 then
        for i,v in pairs(G.hand.cards) do
            for j,x in pairs(id) do
                if v and v.ability and v.ability.group and v.ability.group.id == j and not v.highlighted then
                    G.hand:brute_force_highlight(v)
                end
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
