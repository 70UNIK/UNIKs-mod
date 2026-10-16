SMODS.Back {
    key = 'unik_mountain',
    atlas = 'unik_decks',
    pos = { x = 2, y = 0 },
    config = {
		consumables = {
			'c_unik_everest',
			-- 'c_unik_everest',
		}
    },
    order = 15,

    loc_vars = function(self, info_queue)
		return {
			vars = {
			localize { type = 'name_text', key = 'c_unik_everest', set = 'unik_summit' },
			}
		}
    end,
    apply = function(self, back)
        G.GAME.unik_summit_rate = 2
    end,
    check_for_unlock = function(self, args)
        --Referenced Cryptid for unlock condition
        if G.P_CENTER_POOLS["unik_summit"] then
            local count = 0
            local count2 = 0
            for k, v in pairs(G.P_CENTER_POOLS["unik_summit"]) do
                count2 = count2 + 1
                if v.discovered == true then
                    count = count + 1
                end
            end
            return count == count2 
        end
    end,
    unlocked = false,
}