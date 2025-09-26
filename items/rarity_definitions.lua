SMODS.Rarity {
    key = "dormant",
    badge_colour = HEX("797979"),
    get_weight = function(self, weight, object_type)
        G.GAME.dormant_rarity_exponent = G.GAME.dormant_rarity_exponent or 1
        return weight ^ (weight < 1 and (1 / G.GAME.dormant_exponent) or G.GAME.dormant_exponent)
    end,
    default_weight = 0.07
}