-- ease_background_colour({
--     new_colour = G.C.PURPLE,
--     special_colour = mix_colours(G.C.WHITE, G.C.PURPLE, 0.2),
--     contrast = 2.5
-- })


local background_colour_hook = ease_background_colour
function ease_background_colour(args)
    if G.GAME and G.GAME.dormant_blind then
        background_colour_hook({
            new_colour = G.C.PURPLE,
            special_colour = mix_colours(G.C.WHITE, G.C.PURPLE, 0.2),
            contrast = 2.5
        })
        return
    end


    background_colour_hook(args)
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

local update_hook = Game.update

function Game:update(dt)

    -- pre
    update_hook(self,dt)   
    -- post
    
end