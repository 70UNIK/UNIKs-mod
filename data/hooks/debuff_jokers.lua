--global function to check boss blind cursed joker stuff
--This would instead be centralized here instead of spread out across jokers for coding and performance reasons
--These will make use of global variables involving debuff suits
function ShouldBeDebuffed(card,suit,faceCard,debuffed,ignore_debuff)
    if not card.removed and not ignore_debuff and ((suit and card:is_suit(suit,true)) or (faceCard == true and card:is_face(true))) then
        SMODS.debuff_card(card,debuffed,"unik_cursed_debuff")
        return true
    end
    return false
end
function DebuffCheck(card,plant,goad,head,window,club)
    if plant == true then
        if ShouldBeDebuffed(card,nil,true,true) then
            G.GAME.unik_face_cards = G.GAME.unik_face_cards + 1
        end
    end
    if goad == true then
        if ShouldBeDebuffed(card,"Spades",false,true) then
            G.GAME.unik_spades = G.GAME.unik_spades + 1
        end
    end
    if  head == true then
        if ShouldBeDebuffed(card,"Hearts",false,true) then
            G.GAME.unik_hearts = G.GAME.unik_hearts + 1
        end
    end
    if  window == true then
        if ShouldBeDebuffed(card,"Diamonds",false,true) then
            G.GAME.unik_diamonds = G.GAME.unik_diamonds + 1
        end
    end
    if  club == true then
        if ShouldBeDebuffed(card,"Clubs",false,true) then
            G.GAME.unik_clubs = G.GAME.unik_clubs + 1
        end
    --wild cards
    end
    --If others dont exist, then cleanse them of debuffs]
    if plant == false then
        if (card:is_suit("Spades",true) and not goad and not SMODS.has_enhancement(card,"m_wild"))
        or (card:is_suit("Hearts",true) and not head and not SMODS.has_enhancement(card,"m_wild"))
        or (card:is_suit("Diamonds",true) and not window and not SMODS.has_enhancement(card,"m_wild"))
        or (card:is_suit("Clubs",true) and not club and not SMODS.has_enhancement(card,"m_wild"))
        or (SMODS.has_enhancement(card,"m_wild") and goad == false and head == false and window == false and club == false)
        then
            ShouldBeDebuffed(card,nil,true,false)
        end
    end
    if goad == false and not SMODS.has_enhancement(card,"m_wild") and (plant == false or (plant == true and not card:is_face(true))) then
        ShouldBeDebuffed(card,"Spades",false,false)
    end
    if head == false and not SMODS.has_enhancement(card,"m_wild") and (plant == false or (plant == true and not card:is_face(true)))  then
        ShouldBeDebuffed(card,"Hearts",false,false)
    end
    if window == false and not SMODS.has_enhancement(card,"m_wild") and (plant == false or (plant == true and not card:is_face(true)))  then
        ShouldBeDebuffed(card,"Diamonds",false,false)
    end
    if club == false and not SMODS.has_enhancement(card,"m_wild") and (plant == false or (plant == true and not card:is_face(true)))  then
        ShouldBeDebuffed(card,"Clubs",false,false)
    end
    --wild cards last
    if SMODS.has_enhancement(card,"m_wild") and goad == false and head == false and window == false and club == false and (plant == false or (plant == true and not card:is_face(true))) then
        ShouldBeDebuffed(card,"Spades",false,false)
    end
end
function CheckDebuffSuits()
    --print("Checking")
    local plant = false
    local goad = false
    local head = false
    local window = false
    local club = false
    G.GAME.unik_stop_repeat = true
    G.GAME.unik_spades = 0
    G.GAME.unik_hearts = 0
    G.GAME.unik_diamonds = 0
    G.GAME.unik_clubs = 0
    G.GAME.unik_face_cards = 0
    if G.jokers then
        for x, h in pairs(G.jokers.cards) do
            if h.ability.name == "j_unik_the_plant" and not h.debuff then
                plant = true
            end
            if h.ability.name == "j_unik_caveman_club"  and not h.debuff then
                club = true
            end
            if h.ability.name == "j_unik_broken_window"  and not h.debuff then
                window = true
            end
            if h.ability.name == "j_unik_goading_joker" and not h.debuff  then
                goad = true
            end
            if h.ability.name == "j_unik_headless_joker"  and not h.debuff then
                head = true
            end
        end
    end
    if G.deck then 
        for i, w in pairs(G.deck.cards) do
            DebuffCheck(w,plant,goad,head,window,club)
        end
    end

    if G.hand then 
        for i, w in pairs(G.hand.cards) do
            DebuffCheck(w,plant,goad,head,window,club)
        end
    end    

    if G.play then 
        for i, w in pairs(G.play.cards) do
            DebuffCheck(w,plant,goad,head,window,club)
        end
    end         

    if G.discard  then 
        for i, w in pairs(G.discard.cards) do
            DebuffCheck(w,plant,goad,head,window,club)
        end
    end 


end
--Death. This causes lag when bringing up the deck
local deathDebuffCopy = copy_card
function copy_card(other, new_card, card_scale, playing_card, strip_edition)
    local res = deathDebuffCopy(other, new_card, card_scale, playing_card, strip_edition)
    
    if new_card ~= nil then
       -- print("deathhook")
        CheckDebuffSuits()
    end
    return res
end
--Suit tarots
local change_suitHook = Card.change_suit
function Card:change_suit(new_suit)
    local res = change_suitHook(self,new_suit)
    --print("suitchange")
        CheckDebuffSuits()
    return res
end
--WIld cards,  This causes lag when bringing up the deck as its linked to copy_card
local setAbilityHook = Card.set_ability
function Card:set_ability(center, initial, delay_sprites)
    if not initial and not G.GAME.unik_stop_repeat then 
      --  print("setabilityhook")
        CheckDebuffSuits() 
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            func = function()
                G.GAME.unik_stop_repeat = nil
                return true
            end
        }))
    end
    local rest = setAbilityHook(self,center,initial,delay_sprites)
    return rest
end
--adding cursed
local emplaceHook2 = CardArea.emplace
function CardArea:emplace(card, location, stay_flipped)
    emplaceHook2(self,card, location, stay_flipped)
    if self == G.jokers then
        CheckDebuffSuits()
    end
end
local add_to_deckHook = Card.add_to_deck
function Card:add_to_deck(from_debuff)
    local res = add_to_deckHook(self,from_debuff)
    if self.added_to_deck then
      --  print("addCheck")
        CheckDebuffSuits()
    end
    return res
end
--removing a playing card or joker. Needs to be this in case of stuff like Niko/Disposable/Banana cards 
-- local removeHook2 = Card.remove
-- function Card:remove()
--     --do not trigger when deck menu is brought down
--     if cardArea 
--     local ret = removeHook2(self)
--     CheckDebuffSuits()
--     print("removechjeck2")
--     return ret
-- end

--Only triggers for when jokers are removed
local removeHook3 = Card.remove_from_deck
function Card:remove_from_deck(from_debuff)
    
    if (self.added_to_deck) then
       -- print("removeCheck")
        CheckDebuffSuits()
    end
    local ret = removeHook3(self,from_debuff)
    if self.playing_card and G.deck and G.GAME then
      --  print("removeCheck2")
        CheckDebuffSuits()
    end
    return ret
end
