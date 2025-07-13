--register hypercom
SMODS.Joker:take_ownership("j_mf_unregisteredhypercam",{
    rarity = 3
}, true)

--apostle of wands: blacklist epic, exotics,legendary blinds,

SMODS.Consumable:take_ownership("c_paperback_apostle_of_wands",{
    use = function(self, card, area, copier)
    PB_UTIL.use_consumable_animation(card, nil, function()
      if #G.jokers.cards < G.jokers.config.card_limit then
        G.SETTINGS.paused = true

        local selectable_jokers = {}

        for _, v in ipairs(G.P_CENTER_POOLS.Joker) do
          -- Only shows discovered non-legendary and non-owned jokers
          if v.discovered and v.rarity ~= 4 and v.rarity ~= 'cry_epic' and v.rarity ~= 'cry_exotic' and v.rarity ~="unik_legendary_blind_finity" and not Cryptid.pin_debuff[v.rarity] and not next(SMODS.find_card(v.key)) then
            selectable_jokers[#selectable_jokers + 1] = v
          end
        end

        -- If the list of jokers is empty, we want at least one option so the user can leave the menu
        if #selectable_jokers <= 0 then
          selectable_jokers[#selectable_jokers + 1] = G.P_CENTERS.j_joker
        end

        G.FUNCS.overlay_menu {
          config = { no_esc = true },
          definition = PB_UTIL.apostle_of_wands_collection_UIBox(
            selectable_jokers,
            { 5, 5, 5 },
            {
              no_materialize = true,
              modify_card = function(other_card, center)
                other_card.sticker = get_joker_win_sticker(center)
                PB_UTIL.create_select_card_ui(other_card, G.jokers)
              end,
              h_mod = 1.05,
            }
          ),
        }
      end
    end)
  end
}, true)