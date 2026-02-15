SMODS.ScreenShader {
    key = "pinchbulge",
    path = "pinchbulge.fs",
    send_vars = function(self)
        return {
            center_pos = G.pinch_center or {0,0},
            intensity = G.pinch_intensity or 1,
            radius = G.pinch_radius or 0,
            res = {love.graphics.getWidth(), love.graphics.getHeight()}
        }
    end,
}

local update_hook = Game.update
function Game:update(dt)
    if G.pinch_card and not (G.pinch_card.removed) then
        G.pinch_center = aquill.get_movable_pixel_pos(G.pinch_card)
        G.pinch_radius = 150
    else
        G.pinch_radius = 0
    end
    return update_hook(self,dt)
end