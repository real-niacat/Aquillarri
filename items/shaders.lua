SMODS.Shader {
    key = "boostedblind",
    path = "boostedblind.fs",
}

local blind_draw_hook = Blind.draw
function Blind:draw()
    blind_draw_hook(self)

    if G.GAME and G.GAME.dormant_blind then
        self.children.animatedSprite:draw_shader("aqu_boostedblind", nil, {1,G.TIMERS.REAL}, nil)
    end
end