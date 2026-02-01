local start_run = Game.start_run
function Game:start_run(args)
    local ret = start_run(self,args)
    local new_run = not args.savetext

    if new_run then
        self.GAME.starting_bonus_shop_slots = 1
        self.GAME.starting_bonus_win_ante = 2
        self.GAME.starting_bonus_booster_slots = 1

        change_shop_size(self.GAME.starting_bonus_shop_slots)
        self.GAME.win_ante = self.GAME.win_ante + self.GAME.starting_bonus_win_ante
        SMODS.change_booster_limit(self.GAME.starting_bonus_booster_slots)
    end

    return ret
end