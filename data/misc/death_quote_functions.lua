function Blind:has_death_quotes()
    --finity will override this
    if (FinisherBossBlindQuips and FinisherBossBlindQuips[self.config.blind.key]) then
        return false
    end
    if self.disabled then
        return false
    end
    if self.config.blind.death_card then
        if self.config.blind.death_card.quotes and type(self.config.blind.death_card.quotes) == 'table' then
            return true
        end
    end
    if self.config.blind.death_message then
        return true
    end
    return false
end

function Blind:get_death_quote()
    if not self:has_death_quotes() then
        return nil
    end
    if self.config.blind.death_message then
        return self.config.blind.death_message
    end
     if self.config.blind.death_card then
        if self.config.blind.death_card.quotes and type(self.config.blind.death_card.quotes) == 'table' then
            return self.config.blind.death_card.quotes[math.random(#self.config.blind.death_card.quotes)]
        end
    end
end

function Blind:get_death_say_times()
    if self.config.blind.death_message then
        return 5
    end
    if self.config.blind.death_card then
        if self.config.blind.death_card.quotes and self.config.blind.death_card.say_times then
            return self.config.blind.death_card.say_times
        end
    end
    return 5
end

function Blind:mod_card(card)
	if not self.disabled then
		local obj = self.config.blind
		if obj.death_card and obj.death_card.mod_card and type(obj.death_card.mod_card) == "function" then
			return obj.death_card:mod_card(card)
		end
	end
end