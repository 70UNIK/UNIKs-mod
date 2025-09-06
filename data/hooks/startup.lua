local igo2 = Game.init_game_object
function Game:init_game_object()
	local ret = igo2(self)
	ret.cry_banished_keys = {}
	return ret
end
