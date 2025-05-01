SMODS.Blind	{
    key = 'unik_epic_reed',
    config = {},
	showdown = true,
    boss = {min = 1, showdown = true, hardcore = true, epic = true,no_orb = tue},
    boss_colour = HEX("1a1aac"),
    atlas = 'unik_legendary_blinds',
    pos = {x = 0, y = 10},
    vars = {},
    dollars = 13,
    jen_dollars = 25, --dollar change with almanac
    mult = 2,
    jen_blind_resize = 1e9,
	ignore_showdown_check = true,
    loc_vars = function(self)
		return { vars = {G.GAME.unik_reed_ranks[1].rank .. 's, '  .. G.GAME.unik_reed_ranks[2].rank .. 's '.. localize('k_unik_reed_part2') .. ' ' .. G.GAME.unik_reed_ranks[3].rank .. 's'} }
	end,
	collection_loc_vars = function(self)
		return { vars = { localize('k_unik_reed_placeholder')} }
	end,
	in_pool = function(self)
        --maybe its funnier to have it spawn even without stone hands in deck in almanac
        if G.GAME.modifiers.unik_legendary_at_any_time then
            return true
        end
        if (SMODS.Mods["jen"] or {}).can_load then
            return G.GAME.round > Jen.config.ante_threshold * 2
        else

            local hasExotic = false
            if not G.jokers or not G.jokers.cards then
                return false
            end
            
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i].config.center.rarity == "cry_exotic" then
                    hasExotic = true
                end
            end
            return (G.GAME.round > 50 and hasExotic and Cryptid.gameset() ~= "modest") --only appear after round 50 in mainline cryptid, and you have an exotic at hand
        end
	end,
	unik_kill_hand = function(self, cards, hand, handname, check)
		for k, v in ipairs(cards) do
            if v:get_id() == G.GAME.unik_reed_ranks[1].id or v:get_id() == G.GAME.unik_reed_ranks[2].id or v:get_id() == G.GAME.unik_reed_ranks[3].id then
                return false
            end
		end
        return true
	end
}

local function reset_ranks()
    G.GAME.unik_reed_ranks[1].rank = 'Ace'
    G.GAME.unik_reed_ranks[2].rank = '7'
    G.GAME.unik_reed_ranks[3].rank = '10'
    G.GAME.unik_reed_ranks[1].id = 14
    G.GAME.unik_reed_ranks[2].id = 7
    G.GAME.unik_reed_ranks[3].id = 10
    local usedRanks = {}
    local valid_reed_cards = {}
    --print("d")
    for i = 1, 3 do
        for k, v in ipairs(G.playing_cards) do
            if v.ability.effect ~= 'Stone Card' and v.config.center.key ~= 'm_cry_abstract' then
                if not SMODS.has_no_rank(v) then
                    local alreadyExists = false
                    for j = 1, #usedRanks do
                        if v.base.id == usedRanks[j] then
                            alreadyExists = true
                        end
                    end
                    if not alreadyExists then
                        valid_reed_cards[#valid_reed_cards+1] = v
                    end
                end
            end
        end
        if valid_reed_cards[1] then 
            local reed_card = pseudorandom_element(valid_reed_cards, pseudoseed('the_reed'..G.GAME.round_resets.ante))
            G.GAME.unik_reed_ranks[i].rank = reed_card.base.value
            G.GAME.unik_reed_ranks[i].id = reed_card.base.id
            usedRanks[#usedRanks + 1] = reed_card.base.id
        end
        valid_reed_cards = {}
    end
end
--After defeating the final boss blind (ignoring ante) or at start, reset the ranks
local resetReedRanks = reset_blinds
function reset_blinds()
    if G.GAME.round_resets.blind_states.Boss == "Defeated" then
        reset_ranks()
        --Epic artesian; if tension is disabled, then you must reroll (total shop rerolls this run)^1.1 or die on blind select
        G.GAME.global_rerolls_pause_val = G.GAME.global_rerolls
        --print( G.GAME.global_rerolls_pause_val)
        --If rerolls < 15, set to 15^1.1.
    end
    resetReedRanks()
end

local gameStart = Game.start_run
function Game:start_run(args)
    local vars = gameStart(self,args)
    reset_ranks()
    return vars
end