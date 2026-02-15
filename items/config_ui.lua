aquill.config_tab = function()
    return {
        n = G.UIT.ROOT,
        config = { r = 0.1, minw = 8, align = "tm", padding = 0.075, colour = G.C.GREY },
        nodes = {
            create_tabs({
                snap_to_nav = true,
                scale = 0.8,
                tabs = {
                    {
                        label = localize("ph_aqu_visual"),
                        chosen = true,
                        tab_definition_function = aquill.ui.visual
                    },
                    {
                        label = localize("ph_aqu_gameplay"),
                        tab_definition_function = aquill.ui.gameplay
                    },
                }
            }),
        }
    }
end


aquill.ui.width = 0.6 --80%
aquill.ui.height = 0.5

function aquill.ui.visual()
    return {
        n = G.UIT.ROOT,
        config = { align = "cm", minh = G.ROOM.T.h * aquill.ui.height, padding = 0.0, r = 0.1, colour = G.C.GREY },
        nodes = {
            {
                n = G.UIT.C,
                config = { padding = 0.05 },
                nodes = {
                    {
                        n = G.UIT.R,
                        config = { minw = G.ROOM.T.w * aquill.ui.width, padding = 0.05, align = "tl", },
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
                    {
                        n = G.UIT.R,
                        config = { minw = G.ROOM.T.w * aquill.ui.width, padding = 0.05, align = "tl", },
                        nodes = {
                            create_toggle {
                                label = localize("ph_aqu_config_upgrade_info_queue_label"),
                                info = localize("ph_aqu_config_upgrade_info_queue_info"),
                                active_colour = G.C.GREEN,
                                ref_table = aquill.config,
                                ref_value = "show_upgrade_info_queue"
                            }
                        },
                    },
                    {
                        n = G.UIT.R,
                        config = { minw = G.ROOM.T.w * aquill.ui.width, padding = 0.05, align = "tl", },
                        nodes = {
                            create_toggle {
                                label = localize("ph_aqu_config_disable_screenshader_label"),
                                info = localize("ph_aqu_config_disable_screenshader_info"),
                                active_colour = G.C.GREEN,
                                ref_table = aquill.config,
                                ref_value = "disable_screenshader"
                            }
                        },
                    },
                }
            },

        }
    }
end

function aquill.ui.gameplay()
    return {
        n = G.UIT.ROOT,
        config = { align = "cm", minh = G.ROOM.T.h * aquill.ui.height, padding = 0.0, r = 0.1, colour = G.C.GREY },
        nodes = {
            {
                n = G.UIT.C,
                config = { padding = 0.05 },
                nodes = {
                    {
                        n = G.UIT.R,
                        config = { minw = G.ROOM.T.w * aquill.ui.width, padding = 0.05, align = "tl", },
                        nodes = {
                        },
                    },
                }
            },

        }
    }
end
