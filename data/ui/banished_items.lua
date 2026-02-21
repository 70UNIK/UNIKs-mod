function UNIK.get_banned_count()
    local counter = 0
    local gros_michael = 0
    if G.GAME.paperback and G.GAME.paperback.banned_run_keys then
        for i,v in pairs(G.GAME.paperback.banned_run_keys) do
             if G.P_CENTERS[i] then
                counter = counter + 1
                if i == 'j_gros_michel' then
                    gros_michael = 1
                end
            end
        end
    end
    if G.GAME.cry_banished_keys then
        for i,v in pairs(G.GAME.cry_banished_keys) do
            --prevents displaying cards that have been banned by jen earlier.
            if G.P_CENTERS[i] then
                if not G.GAME.paperback or (G.GAME.paperback and not G.GAME.paperback.banned_run_keys[i]) then
                    counter = counter + 1
                end
                if i == 'j_gros_michel' and not G.GAME.paperback or (G.GAME.paperback and not G.GAME.paperback.banned_run_keys[i]) then
                    gros_michael = 1
                end
            end
        end
    end
    if G.GAME.pool_flags.gros_michel_extinct and gros_michael == 0 then
        counter = counter + 1
    end
    return counter
end

function UNIK.getCombinedBannedTable()
    local banned = {}
    local gros_michael = 0
    if G.GAME.paperback and G.GAME.paperback.banned_run_keys then
        for i,v in pairs(G.GAME.paperback.banned_run_keys) do
            if G.P_CENTERS[i] then
                banned[#banned+1] = i
                if i == 'j_gros_michel' then
                    gros_michael = 1
                end
            end
            
        end
    end
    if G.GAME.cry_banished_keys then
        for i,v in pairs(G.GAME.cry_banished_keys) do
            if G.P_CENTERS[i] then
                if not G.GAME.paperback or (G.GAME.paperback and not G.GAME.paperback.banned_run_keys[i]) then
                    banned[#banned+1] = i
                end
                if i == 'j_gros_michel' and not G.GAME.paperback or (G.GAME.paperback and not G.GAME.paperback.banned_run_keys[i]) then
                    gros_michael = 1
                end
            end
        end
    end
    if G.GAME.pool_flags.gros_michel_extinct and gros_michael == 0 then
        banned[#banned+1] = 'j_gros_michel'
    end

    return banned
end

--combine paperbacks banished list with this mod's
--used paperback's code for this
function G.UIDEF.unik_banished_items()
    if UNIK.get_banned_count() > 0 then
        local args
        local _pool = UNIK.getCombinedBannedTable()
        local rows = {5,5}
        args = args or {}
        args.w_mod = args.w_mod or 1
        args.h_mod = args.h_mod or 1
        args.card_scale = args.card_scale or 1
        local deck_tables = {}
        local pool = SMODS.collection_pool(_pool)

        G.your_collection = {}
        local cards_per_page = 0
        local row_totals = {}
        for j = 1, #rows do
            if cards_per_page >= #pool and args.collapse_single_page then
            rows[j] = nil
            else
            row_totals[j] = cards_per_page
            cards_per_page = cards_per_page + rows[j]
            G.your_collection[j] = CardArea(
                G.ROOM.T.x + 0.2 * G.ROOM.T.w / 2, G.ROOM.T.h,
                (args.w_mod * rows[j] + 0.25) * G.CARD_W,
                args.h_mod * G.CARD_H,
                { card_limit = rows[j], type = args.area_type or 'title', highlight_limit = 0, collection = true }
            )
            table.insert(deck_tables,
                {
                n = G.UIT.R,
                config = { align = "cm", padding = 0.07, no_fill = true },
                nodes = {
                    { n = G.UIT.O, config = { object = G.your_collection[j] } }
                }
                })
            end
        end

        local options = {}
        for i = 1, math.ceil(#pool / cards_per_page) do
            table.insert(
            options,
            localize('k_page') .. ' ' .. tostring(i) .. '/' .. tostring(math.ceil(#pool / cards_per_page))
            )
        end

        G.FUNCS.unik_card_collection_page = function(e)
            if not e or not e.cycle_config then return end
            for j = 1, #G.your_collection do
            for i = #G.your_collection[j].cards, 1, -1 do
                local c = G.your_collection[j]:remove_card(G.your_collection[j].cards[i])
                c:remove()
                c = nil
            end
            end
            for j = 1, #rows do
            for i = 1, rows[j] do
                local center = pool[i + row_totals[j] + (cards_per_page * (e.cycle_config.current_option - 1))]
                if not center then break end
                local card = Card(G.your_collection[j].T.x + G.your_collection[j].T.w / 2, G.your_collection[j].T.y,
                G.CARD_W * args.card_scale, G.CARD_H * args.card_scale, G.P_CARDS.empty,
                (args.center and G.P_CENTERS[args.center]) or center,{bypass_discovery_center = true})
                if args.modify_card then args.modify_card(card, center, i, j) end
                if not args.no_materialize then card:start_materialize(nil, i > 1 or j > 1) end
                G.your_collection[j]:emplace(card)
            end
            end
            INIT_COLLECTION_CARD_ALERTS()
        end

        G.FUNCS.unik_card_collection_page { cycle_config = { current_option = 1 } }

        -- local t = create_UIBox_generic_options({
        --     back_func = (args and args.back_func) or G.ACTIVE_MOD_UI and "openModUI_" .. G.ACTIVE_MOD_UI.id or 'your_collection',
        --     snap_back = args.snap_back,
        --     infotip = args.infotip,
        --     no_back = true,
        --     contents = 
        -- })
        t = {n=G.UIT.ROOT, config={align = "cm", minw = 3, padding = 0.1, r = 0.1, colour = G.C.CLEAR}, nodes={
                {n=G.UIT.R, config={align = "cm", padding = 0.04}, nodes=
                {
                    { n = G.UIT.R, config = { align = "cm", r = 0.1, colour = G.C.BLACK, emboss = 0.05 }, nodes = deck_tables },
                    (not args.hide_single_page or cards_per_page < #pool) and {
                        n = G.UIT.R,
                        config = { align = "cm" },
                        nodes = {
                        create_option_cycle({
                            options = options,
                            w = 4.5,
                            cycle_shoulders = true,
                            opt_callback = 'unik_card_collection_page',
                            current_option = 1,
                            colour = G.C.RED,
                            no_pips = true,
                            focus_args = { snap_to = true, nav = 'wide' }
                        })
                        }
                    } or nil,
                    { n = G.UIT.R, config = { align = "cm"}, 
                        nodes = {{n=G.UIT.T, config={text = localize("k_unik_banish_desc"), scale = 0.5, colour = G.C.WHITE, shadow = true}}} 
                    },
                    }
                },
            }}
        return t
    else
        return {n=G.UIT.ROOT, config={align = "cm", colour = G.C.CLEAR}, nodes={
            {n=G.UIT.O, config={object = DynaText({string = {localize('ph_no_banished')}, colours = {G.C.UI.TEXT_LIGHT}, bump = true, scale = 0.6})}}
        }}
    end
end