--All blinds are video poker
--A
for i = 1, #G.CHALLENGES do
    if (G.CHALLENGES[i].id == 'c_unik_video_poker_1' or G.CHALLENGES[i].id == 'c_unik_video_poker_2' or G.CHALLENGES[i].id == 'c_unik_video_poker_3') and #G.CHALLENGES[i].restrictions.banned_other == 0 then
        for k, v in pairs(G.P_BLINDS) do
            if k ~= "bl_unik_video_poker" and v.boss then
                G.CHALLENGES[i].restrictions.banned_other[#G.CHALLENGES[i].restrictions.banned_other+1] = {id = k, type = 'blind'}
            end
        end
    end
end