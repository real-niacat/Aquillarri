aquill.corruption = {}

function G.FUNCS.hover_entropic_corruption(e) -- i :heart: hover ui
    if not e.parent or not e.parent.states then return end
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
    G.GAME.entropic_corruption_gain = 6.5 --gain 6.5% when selecting non-upgraded blind
    G.GAME.entropic_corruption_gain_multiplier = 1
    G.GAME.entropic_corruption_loss_multiplier = 1
    G.GAME.entropic_corruption_blind_thresh = 0.15 --need 15% corruption before it starts affecting blind sizes
    G.GAME.entropic_corruption_upgraded_max_exponent = 0.05
    aquill.corruption.refresh_ui()
    aquill.corruption.modify(0)
    aquill.update_blind_displays()
end

function aquill.corruption.allowed()
    return not aquill.config.disable_corruption
end

function aquill.corruption.disable()
    G.GAME.entropic_corruption_enabled = false
    aquill.corruption.refresh_ui()
    aquill.update_blind_displays()
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

function aquill.corruption.get_upgraded_exponent()
    -- 
    return (1 - aquill.corruption.get_progress()) * G.GAME.entropic_corruption_upgraded_max_exponent
end

local get_blind_amount_hook = get_blind_amount
function get_blind_amount(ante) -- used for multiplying blind size
    local original_value = get_blind_amount_hook(ante)

    if not aquill.corruption.enabled() then
        return original_value
    end

    local x = aquill.corruption.get() /
        (100 + (G.GAME.entropic_corruption_max - 100) / 5) -- intentionally allows for x values of beyond 1 to further punish high corruption even with higher maximums
    local rx = aquill.corruption.get_progress()
    if x and (x >= G.GAME.entropic_corruption_blind_thresh) then
        -- some silly math
        local multiplier = to_big((x+1)*3):tetrate(x*2)
        return to_big(original_value):mul(multiplier)
    end
    return original_value
end
