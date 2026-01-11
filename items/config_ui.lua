aquill.config_tab = function()
    local scale = 5 / 6
    return {
        n = G.UIT.ROOT,
        config = { align = "cm", minh = G.ROOM.T.h * 0.25, padding = 0.0, r = 0.1, colour = G.C.GREY },
        nodes = {
            {
                n = G.UIT.C,
                config = { padding = 0.05 },
                nodes = {
                    {
                        n = G.UIT.R,
                        config = { minw = G.ROOM.T.w * 0.125, padding = 0.05, align = "cm", },
                        nodes = {
                            create_toggle {
                                label = localize("ph_aqu_config_alt_upgrade_effect_label"),
                                info = localize("ph_aqu_config_alt_upgrade_effect_info"),
                                active_colour = G.C.GREEN,
                                ref_table = aquill.config,
                                ref_value = "alt_upgrade"
                            }
                        },
                    },
                }
            },

        }
    }
end
