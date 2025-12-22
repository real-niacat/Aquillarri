local update_shopref = Game.update_shop
function Game.update_shop(self, dt)
    if G.GAME.block_shop == 1 then
        G.GAME.block_shop = 2

        G.E_MANAGER:add_event(Event {
            func = function()
                aquill.postboss_fx()
                return true
            end,
            trigger = "after",
            blocking = true,
            blockable = false,
        })
    elseif G.GAME.block_shop == 2 then

    else
        update_shopref(self, dt)
    end
end

aquill.add_trigger(function(context)
    if context.end_of_round and context.main_eval and context.beat_boss then
        -- if context.end_of_round and context.main_eval then
        G.GAME.block_shop = 1
    end
end)

local screendist = 10

function create_UIBox_overview()
    -- print("we are running twin please run me ")
    local text_scale = 0.3
    local tab = "    "

    local times_ran = 0
    local prev_rate = 0
    local total_poptimers = 0
    local function create_line(txt, scale, reftab, refval, pop, final)
        times_ran = times_ran + 1
        local len = #(txt or "")
        local rate = 1 + math.max((0.2 * (5 - len)), 0)
        local poptimer = pop or ((times_ran - 1) - (-0.5 * prev_rate))
        local built = { n = G.UIT.O, config = { object = DynaText { string = txt or { { ref_table = reftab, ref_value = refval } }, pop_in_rate = rate, pop_in = poptimer, colours = { HEX("00ff00") }, scale = text_scale * (scale or 1) } } }
        prev_rate = rate
        total_poptimers = total_poptimers + poptimer

        if final then
            G.E_MANAGER:add_event(Event({
                func = function()
                    aquill.ease_uibox_offset("ante_overview", nil, screendist)
                    G.GAME.block_shop = nil
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            G.ante_overview:remove()
                            G.ante_overview = nil     
                            return true
                        end
                    }))
                    return true
                end,
                trigger = "after",
                delay = total_poptimers-32,
            }))
        end
        return built
    end

    local function add_lines(table_of_lines)
        return {
            n = G.UIT.R,
            config = { align = "cl", padding = 0.01 },
            nodes = table_of_lines
        }
    end

    return {
        n = G.UIT.ROOT,
        config = { align = "tl", padding = 0.03, colour = HEX("00000000") },
        nodes = {
            {
                n = G.UIT.C,
                config = { align = "tl", padding = 0.05, colour = { 0.215, 0.258, 0.267, 1 } },
                nodes = {
                    {
                        n = G.UIT.R,
                        config = { align = "tl", colour = G.C.DYN_UI.BOSS_DARK, minh = 0.25, minw = 3, padding = 0.08 },
                        nodes = {
                            {
                                n = G.UIT.C,
                                config = { align = "tl", padding = 0.01 },
                                nodes = {
                                    add_lines({ create_line("function ANTE.calc_overscore()", 1.5) }),
                                    add_lines({ create_line(tab .. "local times_overscored = 3") }),
                                    add_lines({ create_line(tab .. "local avg_overscore_percentage = 75") }),
                                    add_lines({ create_line(tab .. "local thresh = ANTE * 200 // Currently 200.") }),
                                    add_lines({ create_line(tab ..
                                    "G.GAME.blind_curve_increase += (avg_overscore_percentage*times_overscored) - thresh") }),
                                    add_lines({ create_line(tab .. "// Blinds scale 25% faster.", 1.2) }),
                                    add_lines({ create_line("end", 1.5) }),

                                },
                            },

                        }
                    },
                    {
                        n = G.UIT.R,
                        config = { align = "tl", colour = G.C.DYN_UI.BOSS_DARK, minh = 0.25, minw = 3, padding = 0.08 },
                        nodes = {
                            {
                                n = G.UIT.C,
                                config = { align = "tl", padding = 0.01 },
                                nodes = {
                                    add_lines({ create_line("function BLIND.get_upgrade_stats()", 1.5) }),
                                    add_lines({ create_line(tab .. "local times_upgraded = 4") }),
                                    add_lines({ create_line(tab .. "local dormant_chance_multiplier = 1.5^times_upgraded") }),
                                    add_lines({ create_line(tab .. "local dormant_exponent = 1.0 + (0.1*ANTE)") }),
                                    add_lines({ create_line(tab .. "return {dormant_chance_multiplier, dormant_exponent}") }),
                                    add_lines({ create_line(tab .. "// Dormant Jokers are 5x more common than default.",
                                        1.2) }),
                                    add_lines({ create_line(tab .. "// Upgraded blinds have ^1.1 blind size", 1.2) }),
                                    add_lines({ create_line("end", 1.5, nil, nil, nil, true) }),
                                },
                            },

                        }
                    },


                }
            },


        }
    }
end

function aquill.ease_uibox_offset(ref_value, x, y)
    if not G[ref_value] then return end
    if x then
        ease_value(G[ref_value].config.offset, "x", x, false, nil, nil, nil, "insine")
    end

    if y then
        ease_value(G[ref_value].config.offset, "y", y, false, nil, nil, nil, "insine")
    end
end

function aquill.postboss_fx()
    G.ante_overview = UIBox {
        definition = create_UIBox_overview(),
        config = { align = ('cmi'), offset = { x = 1, y = 4.35+screendist }, major = G.jokers }
    }
    G.E_MANAGER:add_event(Event({
        func = function()
            aquill.ease_uibox_offset("ante_overview", nil, -screendist)
            return true
        end,
        trigger = "immediate",
    }), "other")
end


if G and G.GAME then
    if G.ante_overview then G.ante_overview:remove() end
    G.ante_overview = UIBox {
        definition = create_UIBox_overview(),
        config = { align = ('cmi'), offset = { x = 1, y = 4.35 }, major = G.jokers }
    }
end