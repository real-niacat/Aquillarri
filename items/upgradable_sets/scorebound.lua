aquill.Upgradable {
    tier = 1,
    group = "scorebound_crystal",
    calculate = function(self, card, context)
        if context.individual then

            if context.cardarea == "unscored" then
                local count = #context.scoring_hand
                return {mult = aquill.percent_buff(card.ability.extra.unscoring, card.ability.extra.buff*count)}
            elseif context.cardarea == G.play then
                local count = #aquill.remove_elements(G.play, context.scoring_hand)
                return {chips = aquill.percent_buff(card.ability.extra.scoring, card.ability.extra.buff*count)}
            end

        end
    end,
    config = { extra = {scoring = 12, unscoring = 4, buff = 20} },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.unscoring,
                card.ability.extra.scoring,
                card.ability.extra.buff
            }
        }
    end,
}