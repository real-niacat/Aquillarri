local background_colour_hook = ease_background_colour_blind
function ease_background_colour_blind(state, blind_override)
    if G.GAME and G.GAME.dormant_blind then
        ease_background_colour({
            new_colour = G.C.PURPLE,
            special_colour = mix_colours(G.C.WHITE, G.C.PURPLE, 0.2),
            contrast = 2.5
        })
        if G.GAME.blind then
            G.GAME.blind:change_colour()
        end
        return
    end


    return background_colour_hook(state, blind_override)
end

local blind_colour_hook = Blind.change_colour
function Blind:change_colour(blind_col)
    local key = self.config.blind.key
    if G.GAME.dormant_blind then
        blind_col = mix_colours(G.C.PURPLE, get_blind_main_colour(key == "bl_small" and "Small" or key == "bl_big" and "Big" or key), 0.5)
    end

    return blind_colour_hook(self,blind_col)
end

G.C.aqu_bg_prim = HEX("C369FF")
G.C.aqu_bg_sec = HEX("8C71D4")

local main_menu_hook = Game.main_menu
function Game:main_menu(context)
    local original_return = main_menu_hook(self, context)
    aquill.bg_speed = 0.2



    G.SPLASH_BACK:define_draw_steps({ -- meow?
        {
            shader = "splash",
            send = {
                { name = "time",       ref_table = G.TIMERS, ref_value = "REAL_SHADER" },
                { name = "vort_speed", ref_table = aquill,   ref_value = "bg_speed" },
                { name = "colour_1",   ref_table = G.C,      ref_value = "aqu_bg_prim" },
                { name = "colour_2",   ref_table = G.C,      ref_value = "aqu_bg_sec" },
            },
        },
    })

    return original_return
end