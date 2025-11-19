function UNIK.display_skip_req()
    local obj = SMODS.OPENED_BOOSTER.config.center
    if obj.skip_req_message and type(obj.skip_req_message) == "function" then
        local tableStrings = obj:skip_req_message()
        local struc = {}
        for i,v in pairs(tableStrings) do
            local stuct2 = {}
            for j,x in pairs(v) do
                local stuff = {n=G.UIT.O, config={object = DynaText({string = {x}, colours = {G.C.WHITE},shadow = true, rotate = true, bump = true, spacing =1.85, scale = 0.42, pop_in = 0.5})}}
                table.insert(stuct2,stuff)
            end
            local final = {n=G.UIT.R,config={align = "bm", padding = 0.05}, nodes=stuct2}
            
            table.insert(struc,final)
        end

        return {n=G.UIT.R,config={align = "bm", padding = 0.05}, nodes=struc}
    end
    return nil
end
function UNIK.display_skip_req_offset()
    local obj = SMODS.OPENED_BOOSTER.config.center
    if obj.skip_req_message and type(obj.skip_req_message) == "function" then
        local height = 0
        local tableStrings = obj:skip_req_message()
        local struc = {}
        for i,v in pairs(tableStrings) do
            local stuct2 = {}
            for j,x in pairs(v) do
                local stuff = {n=G.UIT.O, config={object = DynaText({string = {x}, colours = {G.C.WHITE},shadow = true, rotate = true, bump = true, spacing =1.85, scale = 0.42, pop_in = 0.5})}}
                table.insert(stuct2,stuff)
            end
            local final = {n=G.UIT.R,config={align = "bm", padding = 0.05}, nodes=stuct2}
            
            table.insert(struc,final)
            height = height + 1
        end

        return height * 0.4
    end
    return 0
end