SMODS.Rarity {
    key = "dormant",
    badge_colour = HEX("CCCCCC"),
    get_weight = function(self, weight, object_type)
        local m = G.GAME.upgraded_boost_per_upgraded ^ G.GAME.upgraded_rarity_boost
        local d = 1
        if G.jokers then
            local j = 0
            for _,joker in pairs(G.jokers.cards) do
                if joker.config.center.upgrade then j = j + 1 end
            end
            d = 5^(3*j)
        end
        local rmod = 3 ^ (1 / (G.GAME.round+1))
        return math.min((weight * m * rmod) / d, 0.3)
    end,
    default_weight = 0.01,
    pools = { ["Joker"] = true },
    disable_if_empty = true,
}

SMODS.Rarity {
    key = "hyper",
    badge_colour = aquill.colours[2],
    default_weight = 0,
    pools = {},
    disable_if_empty = true,
}

SMODS.Rarity {
    key = "hyperplus",
    badge_colour = aquill.colours[4],
    default_weight = 0,
    pools = {},
    disable_if_empty = true,
}

SMODS.Rarity {
    key = "hyperplusplus",
    badge_colour = aquill.colours[6],
    default_weight = 0,
    pools = {},
    disable_if_empty = true,
}

SMODS.Rarity {
    key = "extreme",
    badge_colour = aquill.colours[8],
    default_weight = 0,
    pools = {},
    disable_if_empty = true, 
}