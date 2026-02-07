SMODS.Shader {
    key = "galaxy",
    path = "galaxy.fs",
}

function aquill.enable_galaxy()
    G.SPLASH_BACK:define_draw_steps({ {
        shader = 'aqu_galaxy',
        send = {
            { name = 'iTime', ref_table = G.TIMERS, ref_value = 'REAL_SHADER' },
        }
    } })
end

function aquill.disable_galaxy()
    G.ARGS.spin = {
        amount = 0,
        real = 0,
        eased = 0
    }

    G.SPLASH_BACK:define_draw_steps({ {
        shader = 'background',
        send = {
            { name = 'time',        ref_table = G.TIMERS,       ref_value = 'REAL_SHADER' },
            { name = 'spin_time',   ref_table = G.TIMERS,       ref_value = 'BACKGROUND' },
            { name = 'colour_1',    ref_table = G.C.BACKGROUND, ref_value = 'C' },
            { name = 'colour_2',    ref_table = G.C.BACKGROUND, ref_value = 'L' },
            { name = 'colour_3',    ref_table = G.C.BACKGROUND, ref_value = 'D' },
            { name = 'contrast',    ref_table = G.C.BACKGROUND, ref_value = 'contrast' },
            { name = 'spin_amount', ref_table = G.ARGS.spin,    ref_value = 'amount' }
        }
    } })
end
