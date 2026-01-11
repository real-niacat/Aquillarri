function G.FUNCS.select_blind_harder(e)
    G.GAME.dormant_blind = true
    G.GAME.dormant_blind_visuals = true
    G.FUNCS.select_blind(e)
end

function create_UIBox_hover_upgraded()
    local text_scale = 0.3
    local text_col = G.C.PURPLE
    local dt1 = DynaText({
        string = { { string = localize('ph_aqu_upgrade_1'), colour = text_col } },
        scale =
            text_scale,
        silent = true,
        pop_delay = 4.5,
        pop_in = 0,
        bump = true
    })
    local dt2 = DynaText({
        string = { { string = localize('ph_aqu_upgrade_2'), colour = text_col } },
        scale =
            text_scale,
        silent = true,
        pop_delay = 4.5,
        pop_in = 0.8,
        bump = true
    })
    return {
        n = G.UIT.ROOT,
        config = { align = "cm", padding = 0.05, r = 0.01, colour = darken(G.C.JOKER_GREY, 0.1), shadow = 0.2, },
        nodes = {
            {
                n = G.UIT.C,
                config = { padding = 0.1, colour = G.C.WHITE, r = 0.01 },
                nodes = {
                    {
                        n = G.UIT.R,
                        config = { align = "tl" },
                        nodes = {
                            {
                                n = G.UIT.C,
                                config = { align = "tl" },
                                nodes = {
                                    { n = G.UIT.R, nodes = { { n = G.UIT.O, config = { object = dt1 } }, } },
                                    { n = G.UIT.R, nodes = { { n = G.UIT.O, config = { object = dt2 } }, } },
                                    -- { n = G.UIT.O, config = { object = dt3 } },
                                }
                            },
                        }
                    },
                }
            }


        }
    }
end

function G.FUNCS.hover_upgrade_blind(e)
    if not e.parent or not e.parent.states then return end
    -- print(e.states.hover.is, e.parent.states.hover.is)
    if (e.states.hover.is or e.parent.states.hover.is) and (e.created_on_pause == G.SETTINGS.paused) and not e.parent.children.alert then
        e.parent.children.alert = UIBox {
            definition = create_UIBox_hover_upgraded(),
            config = { align = "tm", offset = { x = 0, y = -0.1 },
                major = e.parent,
                instance_type = 'POPUP' },
        }
        play_sound('paper1', math.random() * 0.1 + 0.55, 0.42)
        play_sound('tarot2', math.random() * 0.1 + 0.55, 0.09)
        e.parent.children.alert.states.collide.can = false
    elseif e.parent.children.alert and
        ((not e.states.collide.is and not e.parent.states.collide.is) or (e.created_on_pause ~= G.SETTINGS.paused)) then
        e.parent.children.alert:remove()
        e.parent.children.alert = nil
    end
end

aquill.add_trigger(
    function(context)
        if context.end_of_round and context.main_eval then
            if G.GAME.dormant_blind then
                G.GAME.dormant_rarity_boost = G.GAME.dormant_rarity_boost + 1
            end

            G.GAME.dormant_blind = false
            G.GAME.dormant_exponent = G.GAME.dormant_exponent_base +
                ((G.GAME.round_resets.ante - 1) * G.GAME.dormant_exponent_gain)
        end
    end
)

aquill.add_trigger(
    function(context)
        if context.starting_shop then
            if G.GAME.dormant_blind_visuals then
                -- attention_text({
                --     cover = G.jokers,
                --     text = localize({ type = "variable", key = "aqu_dormant_rates", vars = { G.GAME.dormant_boost_per_upgraded } }),
                --     hold = 4,
                --     scale = 1,
                --     cover_colour = G.C.FILTER
                -- })
            end
            G.GAME.dormant_blind_visuals = false
        end
    end
)

aquill.add_trigger(
    function(context)
        if context.setting_blind and G.GAME.dormant_blind then
            G.E_MANAGER:add_event(Event({
                func = function()
                    G.GAME.blind.chips = aquill.calc_dormant_blind_size(G.GAME.blind.chips)
                    G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
                    G.HUD_blind:recalculate()

                    G.GAME.blind.dollars = G.GAME.blind.dollars + G.GAME.dormant_bonus
                    G.GAME.dormant_blind_bonus_display = string.rep(localize("$"), G.GAME.dormant_bonus)
                    G.GAME.blind.loc_name = G.GAME.blind.loc_name .. "+"
                    return true
                end
            }))
        end
    end
)

aquill.add_trigger(
    function(context)
        if aquill.corruption.enabled() and context.setting_blind then
            if G.GAME.dormant_blind then
                aquill.corruption.modify(G.GAME.entropic_corruption_loss)
            else
                aquill.corruption.modify(G.GAME.entropic_corruption_gain)
            end
        end
    end
)
