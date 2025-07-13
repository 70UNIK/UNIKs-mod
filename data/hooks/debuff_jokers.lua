--global function to check boss blind cursed joker stuff
--This would instead be centralized here instead of spread out across jokers for coding and performance reasons
--These will make use of global variables involving debuff suits
--TODO: This will need heavy optimisation:
--Add flags if the plant/goad cursed jokers exist, then they should be enabled.
--Global suit variables and stuff for global functions
--Two seperate functions for debuff checkers:
---a wholistic check everything (laggy). Used for adding cursed jokers to the deck, sigil 
---An optimised check a specific card (safe). Used for viewing the deck, changing certain cards, etc...


local function ShouldBeDebuffed(card,suit,faceCard,debuffed,ignore_debuff)
    if not card.removed and not ignore_debuff and ((suit and card:is_suit(suit,true)) or (faceCard == true and card:is_face(true))) then
        SMODS.debuff_card(card,debuffed,"unik_cursed_debuff")
        --print("d")
        return true
    end
    return false
end
local function DebuffCheck(card,plant,goad,head,window,club)
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
local function CheckDebuffSuits()
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
            if h.ability.name == "j_unik_the_plant" and not h.debuff and not h.removed then
                plant = true
            end
            if h.ability.name == "j_unik_caveman_club"  and not h.debuff and not h.removed then
                club = true
            end
            if h.ability.name == "j_unik_broken_window"  and not h.debuff and not h.removed then
                window = true
            end
            if h.ability.name == "j_unik_goading_joker" and not h.debuff and not h.removed then
                goad = true
            end
            if h.ability.name == "j_unik_headless_joker"  and not h.debuff and not h.removed then
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

--since set_debuff is already addressed for death, suit tarots and wild cards,
-- local bossDebuffHook = G.GAME.blind.debuff_card
-- function G.GAME.blind:debuff_card(card,from_blind)
--This causes lag when bringing up the deck
-- end
--Strength, sigil, ouija
local sigilHook = Card.set_base
function Card:set_base(card, initial,stop_check)
    local vars = sigilHook(self,card,initial)
    if not G.GAME.unik_stop_repeat then
        if not initial and not stop_check then 
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                func = function()
                    --print("fff")
                    CheckDebuffSuits()
                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        func = function()
                            G.GAME.unik_stop_repeat = nil
                            return true
                        end
                    }))
                    return true
                end
            }))
        end
    end
    return vars
end

--Death. This causes lag when bringing up the deck
local deathDebuffCopy = copy_card
function copy_card(other, new_card, card_scale, playing_card, strip_edition,stop_check)
    local res = deathDebuffCopy(other, new_card, card_scale, playing_card, strip_edition)
    
    if not stop_check then
       ----print("deathhook")
      --print("4")
        if not G.GAME.unik_stop_repeat then
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                func = function()
                   -- print("fff")
                    CheckDebuffSuits()
                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        func = function()
                            G.GAME.unik_stop_repeat = nil
                            return true
                        end
                    }))
                    return true
                end
            }))
        end
    end
    return res
end
--Suit tarots
local change_suitHook = Card.change_suit
function Card:change_suit(new_suit)
    local res = change_suitHook(self,new_suit)
       --print("3")
    --print("suitchange")
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            func = function()
                CheckDebuffSuits()
                G.GAME.unik_stop_repeat = nil
                return true
            end
        }))
    --end
    return res
end
--WIld cards,  This causes lag when bringing up the deck as its linked to copy_card
local setAbilityHook = Card.set_ability
function Card:set_ability(center, initial, delay_sprites,from_deck)
    -- if not initial then
    --    --print(center)
    -- end
    --print(center == G.P_CENTERS.m_wild)
    if center == G.P_CENTERS.m_wild and not initial and not from_deck then 
        --print("2")
        -- --print("setabilityhook")
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            func = function()
                CheckDebuffSuits()
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
--     if self == G.jokers and card.ability and
--     (card.ability.name == "j_unik_the_plant" or 
--     card.ability.name == "j_unik_caveman_club" or
--     card.ability.name == "j_unik_headless_joker" or
--     card.ability.name == "j_unik_goading_joker" or
--     card.ability.name == "j_unik_broken_window"
-- )then
--    --print("5")

    if not G.GAME.unik_stop_repeat then 
       -- print("3")
    --print("suitchange")
        CheckDebuffSuits()
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            func = function()
                
                G.GAME.unik_stop_repeat = nil
                return true
            end
        }))
    end


    -- end
end
local add_to_deckHook = Card.add_to_deck
function Card:add_to_deck(from_debuff)
    local res = add_to_deckHook(self,from_debuff)
    if self.added_to_deck and self.ability and
    (self.ability.name == "j_unik_the_plant" or 
    self.ability.name == "j_unik_caveman_club" or
    self.ability.name == "j_unik_headless_joker" or
    self.ability.name == "j_unik_goading_joker" or
    self.ability.name == "j_unik_broken_window"
)then
   --print("6")

                CheckDebuffSuits()
                G.GAME.unik_stop_repeat = nil

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
--    --print("removechjeck2")
--     return ret
-- end

--Only triggers for when jokers are removed
local removeHook3 = Card.remove_from_deck
function Card:remove_from_deck(from_debuff)

    if (self.added_to_deck and self.ability and
    (self.ability.name == "j_unik_the_plant" or 
    self.ability.name == "j_unik_caveman_club" or
    self.ability.name == "j_unik_headless_joker" or
    self.ability.name == "j_unik_goading_joker" or
    self.ability.name == "j_unik_broken_window"
)) then
       --print("7")
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            func = function()
                CheckDebuffSuits()
                G.GAME.unik_stop_repeat = nil
                return true
            end
        }))
    end
    
    local ret = removeHook3(self,from_debuff)
    local plant = false
    local goad = false
    local head = false
    local window = false
    local club = false
    if G.jokers then
        for x, h in pairs(G.jokers.cards) do
            if h.ability.name == "j_unik_the_plant" and not h.debuff and not h.removed then
                plant = true
            end
            if h.ability.name == "j_unik_caveman_club"  and not h.debuff and not h.removed then
                club = true
            end
            if h.ability.name == "j_unik_broken_window"  and not h.debuff and not h.removed then
                window = true
            end
            if h.ability.name == "j_unik_goading_joker" and not h.debuff and not h.removed then
                goad = true
            end
            if h.ability.name == "j_unik_headless_joker"  and not h.debuff and not h.removed then
                head = true
            end
        end
    end
    --print("ddd")
    --print( G.GAME.unik_stop_repeat)
    --print((plant == true or goad == true or head == true or window == true or club== true))
    if self.playing_card and G.deck and G.GAME and (plant == true or goad == true or head == true or window == true or club== true) and not G.GAME.unik_stop_repeat then
      -- --print("removeCheck2")
     --print("8")
        G.E_MANAGER:add_event(Event({
            trigger = 'immediate',
            func = function()
                CheckDebuffSuits()
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    func = function()
                        G.GAME.unik_stop_repeat = nil
                        return true
                    end
                }))
                return true
            end
        }))
        
    end
    G.GAME.unik_stop_repeat = nil
    -- G.E_MANAGER:add_event(Event({
    --     trigger = 'after',
    --     func = function()
            
    --         return true
    --     end
    -- }))
    return ret
end
