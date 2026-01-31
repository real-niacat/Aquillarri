local game_hook = Game.init_game_object
function Game:init_game_object()

    local game = game_hook(self)

    game.upgraded_exponent_base = 1.04
    game.upgraded_exponent = game.upgraded_exponent_base
    game.upgraded_boost_per_upgraded = 1.5
    game.upgraded_exponent_gain = 0.006
    game.upgraded_bonus = 2
    game.upgraded_rarity_boost = 0

    return game
end