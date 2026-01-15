aquill.Upgradable {
    tier = 1,
    group = "scorebound_crystal",
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            local scored_card = context.other_card
            local rank = scored_card:get_id()
            local bonus = to_big(card.ability.extra.multiplier):pow(aquill.unique_ranks(G.play.cards))
            local dist = 0
            if rank <= 2+dist then
                return { chips = card.ability.extra.chips * bonus }
            end

            if rank >= 14-dist then
                return { mult = card.ability.extra.mult * bonus }
            end
        end
    end,
    config = { extra = { chips = 10, mult = 2, multiplier = 2 } },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.chips,
                card.ability.extra.mult,
                card.ability.extra.multiplier
            }
        }
    end,
}

aquill.Upgradable {
    tier = 2,
    group = "scorebound_crystal",
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            local scored_card = context.other_card
            local rank = scored_card:get_id()
            local bonus = to_big(card.ability.extra.multiplier):pow(aquill.unique_ranks(G.play.cards))
            local dist = 1
            if rank <= 2+dist then
                return { chips = card.ability.extra.chips * bonus }
            end

            if rank >= 14-dist then
                return { mult = card.ability.extra.mult * bonus }
            end
        end
    end,
    config = { extra = { chips = 25, mult = 5, multiplier = 2.5 } },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.chips,
                card.ability.extra.mult,
                card.ability.extra.multiplier
            }
        }
    end,
}

aquill.Upgradable {
    tier = 3,
    group = "scorebound_crystal",
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            local scored_card = context.other_card
            local rank = scored_card:get_id()
            local bonus = to_big(card.ability.extra.multiplier):pow(aquill.unique_ranks(G.play.cards))
            local dist = 3
            if rank <= 2+dist then
                return { chips = card.ability.extra.chips * bonus }
            end

            if rank >= 14-dist then
                return { mult = card.ability.extra.mult * bonus }
            end
        end
    end,
    config = { extra = { chips = 25, mult = 5, multiplier = 3 } },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.chips,
                card.ability.extra.mult,
                card.ability.extra.multiplier
            }
        }
    end,
}

aquill.Upgradable {
    tier = 4,
    group = "scorebound_crystal",
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            local scored_card = context.other_card
            local rank = scored_card:get_id()
            local bonus = to_big(card.ability.extra.multiplier):pow(aquill.unique_ranks(G.play.cards))
            local dist = 4
            if rank <= 2+dist then
                return { chips = card.ability.extra.chips * bonus }
            end

            if rank >= 14-dist then
                return { mult = card.ability.extra.mult * bonus }
            end
        end
    end,
    config = { extra = { chips = 30, mult = 6, multiplier = 4 } },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.chips,
                card.ability.extra.mult,
                card.ability.extra.multiplier
            }
        }
    end,
}

aquill.Upgradable {
    tier = 5,
    group = "scorebound_crystal",
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            local scored_card = context.other_card
            local rank = scored_card:get_id()
            local bonus = to_big(card.ability.extra.multiplier):pow(aquill.unique_ranks(G.play.cards))
            local dist = 5
            if rank <= 2+dist then
                return { chips = card.ability.extra.chips * bonus }
            end

            if rank >= 14-dist then
                return { mult = card.ability.extra.mult * bonus }
            end

            if rank == 8 then
                return {xchips = card.ability.extra.xscores * bonus, xmult = card.ability.extra.xscores * bonus }
            end
        end
    end,
    config = { extra = { chips = 50, mult = 10, multiplier = 5, xscores = 8 } },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.chips,
                card.ability.extra.mult,
                card.ability.extra.multiplier,
                card.ability.extra.xscores
            }
        }
    end,
}