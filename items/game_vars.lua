local game_hook = Game.init_game_object
function Game:init_game_object()

    local game = game_hook(self)

    game.dormant_exponent_base = 1.1
    game.dormant_exponent = game.dormant_exponent_base
    game.dormant_boost_per_upgraded = 1.5
    game.dormant_exponent_gain = 0.012
    game.dormant_bonus = 2
    game.dormant_rarity_boost = 0

    return game
end