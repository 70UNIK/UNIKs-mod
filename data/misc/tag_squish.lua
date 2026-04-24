local at = add_tag
function add_tag(tag)
    at(tag)
    if #G.HUD_tags > 13 then
        for i = 2, #G.HUD_tags do
            G.HUD_tags[i].config.offset.u = 0.9-0.9*13/#G.HUD_tags
        end
    end
end
local tr = Tag.remove
function Tag:remove(tag)
    tr(self)
    if #G.HUD_tags >= 13 then
        for i = 2, #G.HUD_tags do
            G.HUD_tags[i].config.offset.u = 0.9-0.9*13/#G.HUD_tags
        end
    end
end