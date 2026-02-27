--creates a random tag when played --> create a random tag when scored
BLINDSIDE.Blind({
    key = 'unik_blindside_cliff',
    atlas = 'unik_blindside_blinds',
    pos = {x = 0, y = 3},
    config = {
        extra = {
            value = 19,
            tags = 1,
            tag_up = 1,
        }},
    hues = {"Faded"},
    calculate = function(self, card, context) 
        if context.before then
            local exists = false
            for i,v in pairs(context.scoring_hand) do
                if v == card then
                    exists = true
                    break
                end
            end
            if exists and not card.ability.extra.upgraded then
                for i = 1, card.ability.extra.tags do
                    add_tag(Tag(get_next_tag_key()))
                end
                return {
                    focus = card,
                    message = localize('k_tagged_ex'),
                    card = card,
                }
            end
        end
    end,
    always_scores = true,
    common = true,
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.tags,
            }
        }
    end,
    upgrade = function(card)
        if not card.ability.extra.upgraded then
            card.ability.extra.tags = card.ability.extra.tags + card.ability.extra.tag_up
            card.ability.extra.upgraded = true
        end
    end
})