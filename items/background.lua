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