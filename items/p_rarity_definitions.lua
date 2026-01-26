SMODS.Rarity {
    key = "dormant",
    badge_colour = HEX("CCCCCC"),
    get_weight = function(self, weight, object_type)
        local m = G.GAME.dormant_boost_per_upgraded ^ G.GAME.dormant_rarity_boost
        local d = 1
        if G.jokers then
            local j = 0
            for _,joker in pairs(G.jokers.cards) do
                if joker.config.center.upgrade then j = j + 1 end
            end
            d = 5^(3*(j+1))
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
    badge_colour = HEX("32FFAA"),
    default_weight = 0,
    pools = {},
    disable_if_empty = true,
}

SMODS.Rarity {
    key = "hyperplus",
    badge_colour = HEX("49DBFF"),
    default_weight = 0,
    pools = {},
    disable_if_empty = true,
}

SMODS.Rarity {
    key = "hyperplusplus",
    badge_colour = HEX("2344FF"),
    default_weight = 0,
    pools = {},
    disable_if_empty = true,
}

SMODS.Rarity {
    key = "extreme",
    badge_colour = HEX("E523FF"),
    default_weight = 0,
    pools = {},
    disable_if_empty = true, 
}