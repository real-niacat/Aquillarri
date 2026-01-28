SMODS.Shader {
    key = "cardstatic",
    path = "cardstatic.fs",
}

SMODS.DrawStep {
    key = "evaporating",
    order = 100,
    func = function(card, layer)
        -- (_shader, _shadow_height, _send, _no_tilt, other_obj, ms, mr, mx, my, custom_shader, tilt_shadow)
        if card.evaporation then
            card.ignore_base_shader.evaporating = true
            G.SHADERS["aqu_cardstatic"]:send("progress", card.evaporation)
            G.SHADERS["aqu_cardstatic"]:send("iTime", G.TIMERS.REAL)
            card.children.center:draw_shader("aqu_cardstatic")
        else
            card.ignore_base_shader.evaporating = nil
        end
    end
}

function aquill.evaporate(card)
    -- used for when you have >1 of the same set of upgradable which is Illegal
    card.evaporation = 0
    card.no_shadow = true



    G.E_MANAGER:add_event(Event({
        trigger = 'after',
        delay = 1,
        timer = "REAL",
        func = function()
            G.E_MANAGER:add_event(Event({
                trigger = 'ease',
                ease = 'insine',
                ref_table = card,
                ref_value = 'evaporation',
                ease_to = 2,
                delay = 3,
                timer = "REAL",
                func = (function(t) return t end),
                blockable = false,
            }))
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 2,
                timer = "REAL",
                func = function()
                    card:remove()
                    return true
                end,
                blocking = true,
                blockable = false,
            }))
            return true
        end,
        blocking = true,
        blockable = false,
    }))
end
