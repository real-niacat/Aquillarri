SMODS.DynaTextEffect {
    key = "shadereffect",
    func = function(dynatext, index, letter)
        G.aqu_text_shader_clock = G.TIMERS.REAL
        G.aqu_text_center_pos = aquill.get_movable_pixel_pos(dynatext)
        G.aqu_text_dims = {dynatext.T.w, dynatext.T.h}
    end
}

SMODS.ScreenShader {
    key = "texthighlight",
    path = "texthighlight.fs",
    send_vars = function(self)
        return {
            center_pos = G.aqu_text_center_pos,
            iTime = G.TIMERS.REAL,
            width = G.aqu_text_dims[1] * G.TILESCALE * G.TILESIZE,
            height = G.aqu_text_dims[2] * G.TILESCALE * G.TILESIZE,
            resolution = {love.graphics.getWidth(), love.graphics.getHeight()},
        }
    end,
    should_apply = function(self)
        return G.aqu_text_shader_clock == G.TIMERS.REAL
    end
}