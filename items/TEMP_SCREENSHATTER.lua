SMODS.Shader {
    key = "shatter",
    path = "shatter.fs",
}

SMODS.ScreenShader {
    key = "shatter",
    shader = "aqu_shatter",
    send_vars = function(self)
        return {
            center = G.shatter_center or { 0, 0 },
            progress = G.shatter_progress or 0.5,
            resolution = { love.graphics.getWidth(), love.graphics.getHeight() },
            iTime = G.TIMERS.REAL
        }
    end,
    should_apply = function(self)
        return true
    end
}