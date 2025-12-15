local game_hook = Game.init_game_object
function Game:init_game_object()

    local game = game_hook(self)

    game.dormant_exponent = 1.1 
    game.upgraded_blind_bonus = 4

    return game
end