aquill.corruption = {}

function create_UIBox_corruption() -- base ui def
    local text_scale = 0.4

    local e = G.GAME.entropic_corruption_enabled
    local c = not e and G.C.UI.TEXT_LIGHT or (G.C.aqu_entropic_corruption)
    --we create dynatext here due to the limits of ui text elements
    --as they have no property for suffixes, which we need to display it as a percentage
    local dyna = DynaText {
        scale = text_scale * 0.9,
        bump = false,
        string = { {                                                          -- "x and y or z" functions identically do x ? y : z in other langs
            string = not e and localize("ph_aqu_corruption_disabled") or nil, --disabled? say disabled, no fuss
            ref_table = e and G.GAME or nil,                                  --otherwise we use the percentage
            ref_value = e and "entropic_corruption_percent" or nil,
            suffix = e and "%" or nil,                                        --dk if suffix works
        }, colour = c },
    }

    return {
        n = G.UIT.ROOT,
        config = { align = "cm", padding = 0.05, r = 0.01, colour = darken(G.C.UI.BACKGROUND_INACTIVE, 0.15), shadow = 0.1, hover = true, func = "hover_entropic_corruption", one_press = true },
        nodes = {
            {
                n = G.UIT.C,
                config = { padding = 0.1, colour = G.C.UI.BACKGROUND_INACTIVE, r = 0.01 },
                nodes = {
                    { n = G.UIT.R, nodes = { { n = G.UIT.T, config = { text = localize("ph_aqu_corruption"), colour = G.C.WHITE, scale = text_scale * 0.5 } } } },
                    { n = G.UIT.R, config = { align = "cm" }, nodes = { { n = G.UIT.O, config = { object = dyna, id = "percentage" } } } }
                }
            },
        }
    }
end

function create_UIBox_hover_corruption() -- hover ui def
    local text_scale = 0.3
    local text_col = G.C.PURPLE
    local times = 0
    local function t(text) -- just shorthand
        times = times + 1
        return DynaText({
            string = { { string = text, colour = text_col } },
            scale = text_scale,
            silent = true,
            pop_delay = 4.5,
            pop_in = 0.7 * math.floor((times-1)/2), --results in lines 1 & 2 popping in together, same with 3 & 4
            bump = true,
            bump_amount = 0.3,
        })
    end
    local node_list = {}
    local entries = localize("ph_aqu_corruption_desc")
    for _, entry in pairs(entries) do
        table.insert(node_list, { n = G.UIT.R, nodes = { { n = G.UIT.O, config = { object = t(entry) } }, } })
    end


    return {
        n = G.UIT.ROOT,
        config = { align = "cm", padding = 0.05, r = 0.01, colour = darken(G.C.JOKER_GREY, 0.1), shadow = 0.05, },
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
                                nodes = node_list
                            },
                        }
                    },
                }
            }


        }
    }
end

function G.FUNCS.hover_entropic_corruption(e) -- i :heart: hover ui
    if not e.parent or not e.parent.states then return end
    aquill.e = e
    if (e.states.hover.is or e.parent.states.hover.is) and (e.created_on_pause == G.SETTINGS.paused) and not e.parent.children.desc_popup then
        -- e.parent.children.desc_popup =
        e.parent.children.desc_popup = UIBox {
            definition = create_UIBox_hover_corruption(),
            config = { align = "bl", offset = { x = 1.8, y = 2.3 },
                major = e.parent,
                instance_type = 'POPUP' },
        }
        play_sound('paper1', math.random() * 0.1 + 0.55, 0.42)
        play_sound('tarot2', math.random() * 0.1 + 0.55, 0.09)
        e.parent.children.desc_popup.states.collide.can = false
    elseif e.parent.children.desc_popup and not (e.states.hover.is or e.parent.states.hover.is) and
        ((not e.states.collide.is and not e.parent.states.collide.is) or (e.created_on_pause ~= G.SETTINGS.paused)) then
        e.parent.children.desc_popup:remove()
        e.parent.children.desc_popup = nil
    end
end

local start_run_hook = Game.start_run
function Game:start_run(args)
    local r = start_run_hook(self, args)
    --adds ui
    aquill.corruption.refresh_ui()
end

--corruption helper funcs
function aquill.corruption.refresh_ui()
    if G.entropic_corruption then
        G.entropic_corruption:remove()
        G.entropic_corruption = nil
    end
    G.entropic_corruption = UIBox {
        definition = create_UIBox_corruption(),
        config = { align = ('tri'), offset = { x = 2, y = 0 }, major = G.consumeables }
    }
end

function aquill.corruption.enable()
    if not aquill.corruption.allowed() then
        return
    end

    G.GAME.entropic_corruption_enabled = true
    G.GAME.entropic_corruption_percent = G.GAME.entropic_corruption_percent or 0
    G.GAME.entropic_corruption_max = 100
    G.GAME.entropic_corruption_min = 0
    G.GAME.entropic_corruption_loss = -12 --lose 10% when upgrading blind
    G.GAME.entropic_corruption_gain = 6.5   --gain 6.5% when selecting non-upgraded blind
    G.GAME.entropic_corruption_gain_multiplier = 1
    G.GAME.entropic_corruption_loss_multiplier = 1
    G.GAME.entropic_corruption_blind_thresh = 0.15 --need 15% corruption before it starts affecting blind sizes
    aquill.corruption.refresh_ui()
    aquill.corruption.modify(0)
end

function aquill.corruption.allowed()
    return not aquill.config.disable_corruption
end

function aquill.corruption.disable()
    G.GAME.entropic_corruption_enabled = false
    aquill.corruption.refresh_ui()
end

function aquill.corruption.modify(amount, func)
    if not aquill.corruption.enabled() then
        return
    end

    if amount >= 0 then
        amount = amount * G.GAME.entropic_corruption_gain_multiplier
    else
        amount = amount * G.GAME.entropic_corruption_loss_multiplier
    end

    local old_value = G.GAME.entropic_corruption_percent
    local new = nil
    if func then
        new = func(old_value, amount)
    else
        new = old_value + amount
    end

    local min, max = G.GAME.entropic_corruption_min, G.GAME.entropic_corruption_max

    new = math.max(min, new)
    new = math.min(max, new)


    G.entropic_corruption:get_UIE_by_ID("percentage"):juice_up()
    G.C.aqu_entropic_corruption = mix_colours(G.C.RED, G.C.GREEN, aquill.corruption.get_progress())

    -- ill just set the blind size to effectively naneinf at max
    -- if new >= max then
    --     G.STATE = G.STATES.GAME_OVER
    --     G.STATE_COMPLETE = false
    --     return
    -- end

    G.GAME.entropic_corruption_percent = new
end

function aquill.corruption.enabled()
    return G.GAME.entropic_corruption_enabled and aquill.corruption.allowed()
end

function aquill.corruption.get_progress()
    if not aquill.corruption.enabled() then
        return
    end
    return (G.GAME.entropic_corruption_percent + G.GAME.entropic_corruption_min) / G.GAME.entropic_corruption_max
end

function aquill.corruption.add_gain_multiplier(amount) --shorthand, also allows for hooking
    if not aquill.corruption.enabled() then
        return
    end
    G.GAME.entropic_corruption_gain_multiplier = G.GAME.entropic_corruption_gain_multiplier * amount
end

function aquill.corruption.add_loss_multiplier(amount) --ditto
    if not aquill.corruption.enabled() then
        return
    end
    G.GAME.entropic_corruption_loss_multiplier = G.GAME.entropic_corruption_loss_multiplier * amount
end

function aquill.corruption.get()
    return G.GAME.entropic_corruption_percent or 0
end

local get_blind_amount_hook = get_blind_amount
function get_blind_amount(ante)
    local original_value = get_blind_amount_hook(ante)

    if not aquill.corruption.enabled() then
        return original_value
    end

    local x = aquill.corruption.get() /
    (100 + (G.GAME.entropic_corruption_max - 100) / 5)                                   -- intentionally allows for x values of beyond 1 to further punish high corruption even with higher maximums
    local rx = aquill.corruption.get_progress()
    if x and (x >= G.GAME.entropic_corruption_blind_thresh) then
        -- some silly math
        local operator = math.floor((x + 5) ^ (x^(x+1))) - 1
        local index = ((x + 1) * 2) ^ (x ^ 5)
        if rx == 1 then --actually at max
            operator = math.huge
        end
        return to_big(original_value):arrow(operator, index)
    end
    return original_value
end
