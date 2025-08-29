--Blind hooks


--Debuffs after scoring.
function Blind:unik_debuff_after_hand(poker_hands, scoring_hand,cards, check,sum)
	if not self.disabled then
		local obj = self.config.blind
		if obj.unik_debuff_after_hand and type(obj.unik_debuff_after_hand) == "function" then
			return obj:unik_debuff_after_hand(poker_hands, scoring_hand,cards, check,sum)
		end
	end
	return nil
end

function Blind:unik_cap_score(score)
	if not self.disabled then
		local obj = self.config.blind
		if obj.unik_cap_score and type(obj.unik_cap_score) == "function" then
			return obj:unik_cap_score(score)
		end
	end
	return nil
end


--Instead of merely debuffing a hand, it will KILL you if you play that hand
function Blind:unik_kill_hand(cards, hand, handname, check)
	if not self.disabled then
		local obj = self.config.blind
		if obj.unik_kill_hand and type(obj.unik_kill_hand) == "function" then
			return obj:unik_kill_hand(cards, hand, handname, check)
		end
	end
end

--Effects for after defeating a blind. Return true to kill the player. Return false to not do that
function Blind:unik_after_defeat(score,blind_size)
    if not self.disabled then
		local obj = self.config.blind
		if obj.unik_after_defeat and type(obj.unik_after_defeat) == "function" then
			return obj:unik_after_defeat(score,blind_size)
		end
	end
end



local killHook = Blind.debuff_hand
function Blind:debuff_hand(cards, hand, handname, check)
	local instakill = self:unik_kill_hand(cards, hand, handname, check)
	if killHook(self,cards, hand, handname, check) == true or instakill == true then
		if instakill == true then
			G.GAME.unik_instant_death_hand = true
		else
			G.GAME.unik_instant_death_hand = nil
		end
		return true
	else
		G.GAME.unik_instant_death_hand = nil
		return false
	end
end