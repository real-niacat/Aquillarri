function G.FUNCS.select_blind_harder(e)
    G.GAME.dormant_blind = true
    G.GAME.dormant_exponent_gain = G.GAME.dormant_exponent_gain or 0.05
    G.GAME.dormant_exponent = G.GAME.dormant_exponent and (G.GAME.dormant_exponent+G.GAME.dormant_exponent_gain) or 1.1
    G.FUNCS.select_blind(e)
end