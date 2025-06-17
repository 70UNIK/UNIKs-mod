--Blind hooks


--Debuffs after scoring.
function Blind:unik_debuff_after_hand(poker_hands, scoring_hand,cards, check,mult,hand_chips,sum)
	if not self.disabled then
		local obj = self.config.blind
		if obj.unik_debuff_after_hand and type(obj.unik_debuff_after_hand) == "function" then
			return obj:unik_debuff_after_hand(poker_hands, scoring_hand,cards, check,mult,hand_chips,sum)
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
function Blind:unik_after_defeat(score)
    if not self.disabled then
		local obj = self.config.blind
		if obj.unik_after_defeat and type(obj.unik_after_defeat) == "function" then
			return obj:unik_after_defeat(score)
		end
	end
end