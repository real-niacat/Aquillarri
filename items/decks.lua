SMODS.Back {
    key = "emc",
    apply = function(self, back)
        G.E_MANAGER:add_event(Event({
            func = function()
                if G.GAME.dormant_exponent then
                    G.GAME.dormant_exponent_base = 0.9
                    G.GAME.dormant_exponent_gain = -0.02
                    G.GAME.dormant_exponent = G.GAME.dormant_exponent_base
                    G.GAME.dormant_bonus = -1
                    return true
                end
            end
        }))
    end
}