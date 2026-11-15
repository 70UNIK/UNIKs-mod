local winner = get_joker_win_sticker
function get_joker_win_sticker(_center, index)
    if not G.PROFILES[G.SETTINGS.profile] or not G.PROFILES[G.SETTINGS.profile].joker_usage then
        return 0
    end
    local ret = winner(_center,index)
    return ret
end