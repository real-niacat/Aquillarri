local game_hook = Game.init_game_object
function Game:init_game_object()

    local game = game_hook(self)

    game.dormant_exponent_base = 1.05
    game.dormant_exponent = game.dormant_exponent_base
    game.dormant_boost_per_upgraded = 1.5
    game.dormant_exponent_gain = 0.02
    game.upgraded_blind_bonus = 4
    game.dormant_bonus = 3
    game.dormant_rarity_boost = 0

    return game
end