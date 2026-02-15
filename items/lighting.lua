function aquill.get_card_bounds(array) 
    local positions = {}
    for _,card in pairs(array) do
        local tl = aquill.movable_top_left_pos(card)
        local br = aquill.movable_bottom_right_pos(card)
        table.insert(positions, {
            tl[1], tl[2],
            br[1], br[2], 
        })
    end

    table.insert(positions, {math.huge, math.huge, math.huge, math.huge})

    return positions
end

SMODS.ScreenShader {
    key = "lighting",
    path = "lighting.fs",
    should_apply = function(self)
        return false
    end,
    send_vars = function(self)
        return {
            center_pos = G.light_center or {1920/2, 1080/2},
            intensity = G.light_intensity or 100,
            cards = {array = aquill.get_card_bounds(G.I.CARD)}
        }
    end
}

