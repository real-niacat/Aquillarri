SMODS.Rarity {
    key = "dormant",
    badge_colour = HEX("CCCCCC"),
    get_weight = function(self, weight, object_type)
        return weight * (1.5 ^ G.GAME.dormant_rarity_boost)
    end,
    default_weight = 0.25,
    
}

SMODS.Rarity {
    key = "hyper",
    badge_colour = HEX("32FFAA"),
}

SMODS.Rarity {
    key = "hyperplus",
    badge_colour = HEX("49DBFF"),
}

SMODS.Rarity {
    key = "hyperplusplus",
    badge_colour = HEX("2344FF"),
}

SMODS.Rarity {
    key = "extreme",
    badge_colour = HEX("E523FF"),
}