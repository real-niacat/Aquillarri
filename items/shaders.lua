SMODS.Shader {
    key = "boostedblind",
    path = "boostedblind.fs",
}

SMODS.Shader {
    key = "crt_override",
    path = "CRTOverride.fs"
}

local blind_draw_hook = Blind.draw
function Blind:draw()
    blind_draw_hook(self)

    if G.GAME.dormant_blind_visuals then
        self.children.animatedSprite:draw_shader("aqu_boostedblind", nil, {1,G.TIMERS.REAL}, nil)
    end
end