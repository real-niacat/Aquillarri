SMODS.Shader {
    key = "flashlight",
    path = "flashlight.fs",
}

aquill.add_screen_shader({
    key = "aqu_flashlight",
    should_apply = function()
        return G.aqu_flashlight_enabled
    end,
    send = {
        {
            key = "center_pos",
            func = function()                  -- PIXELS
                return G.aqu_flashlight_center or { love.graphics.getWidth() / 2, love.graphics.getHeight() / 2 }
            end
        },
        {
            key = "dist",
            func = function()
                return G.aqu_flashlight_distance or 500
            end
        },
    }
})

function aquill.upgrade_joker_fx(card, ability)
    local particle_list = {}
    local high_detail = not aquill.config.alt_upgrade

    local colour_list = {
        HEX("3c096c"),
        HEX("5a189a"),
        HEX("9d4edd"),
    }

    if high_detail then
        G.E_MANAGER:add_event(Event({
            trigger = "after",
            func = function()
                G.aqu_flashlight_enabled = true
                G.aqu_flashlight_distance = 3500 -- if your monitor is more than 10,000 pixels wide i don't even fucking care anymore

                G.aqu_flashlight_center = { -- this shit pisses me the fuck off but i see no better solution than approximating it
                    (card.T.x * (G.TILESCALE * G.TILESIZE)) + (G.TILESCALE*love.graphics.getWidth()*0.01),
                    (card.T.y * (G.TILESCALE * G.TILESIZE)) + (G.TILESCALE*love.graphics.getHeight()*0.01),
                }
                return true
            end,
            delay = 0.25,
            timer = "REAL",
            blocking = true,
            blockable = false,
            force_stop = true,
        }))
    end
    for i = 1, 3 do
        G.E_MANAGER:add_event(Event({
            trigger = "after",
            func = function()
                card:juice_up(i / 5, i / 5)

                if high_detail then
                    G.E_MANAGER:add_event(Event({
                        trigger = 'ease',
                        ease = 'outexpo',
                        ref_table = G,
                        ref_value = 'aqu_flashlight_distance',
                        ease_to = G.aqu_flashlight_distance / 2,
                        delay = 1,
                        timer = "REAL",
                        func = (function(t) return t end),
                        blockable = false,
                    }))
                end

                play_sound("aqu_impact", 1 + (i / 8), 5)
                if high_detail then
                    particle_list[i] = Particles(1, 1, 0, 0, {
                        timer = 0.01,
                        scale = 0.3 * i,
                        initialize = true,
                        speed = 0.7 * i,
                        padding = 1,
                        attach = card,
                        lifespan = 1 + i,
                        fill = true,
                        colours = colour_list,
                    })

                    G.E_MANAGER:add_event(Event({
                        func = function()
                            particle_list[i]:fade(1, 1)
                            G.E_MANAGER:add_event(Event({
                                func = function()
                                    if particle_list[i].fade_alpha == 1 then
                                        particle_list[i]:remove()
                                        return true
                                    end
                                end,
                            }), "other")
                            return true
                        end,
                        trigger = "after",
                        delay = i
                    }), "other")
                end

                return true
            end,
            delay = 0.25 + (i),
            timer = "REAL",
            blocking = true,
            blockable = false,
            force_stop = true,
        }))
    end

    if not high_detail then
        G.E_MANAGER:add_event(Event({
            trigger = "after",
            func = function()
                card:flip()
                return true
            end,
            delay = 0.99,
            timer = "REAL",
        }))
        G.E_MANAGER:add_event(Event({
            trigger = "after",
            func = function()
                card:flip()
                return true
            end,
            delay = 1.25,
            timer = "REAL",
            blocking = false,
            blockable = true
        }))
    end

    G.E_MANAGER:add_event(Event({
        trigger = "after",
        func = function()
            card:juice_up(1, 1)
            play_sound("aqu_bass", 1, 8)
            aquill.preserved_set_ability(card, ability)
            SMODS.calculate_context({ aqu_upgrade = true, card = card })

            if high_detail then
                G.E_MANAGER:add_event(Event({
                    trigger = 'ease',
                    ease = 'inexpo',
                    ref_table = G,
                    ref_value = 'aqu_flashlight_distance',
                    ease_to = 100000,
                    delay = 2,
                    timer = "REAL",
                    func = (function(t) return t end),
                    blockable = false,
                }))
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 2,
                    func = function()
                        G.aqu_flashlight_enabled = false
                        return true
                    end
                }))
            end
            return true
        end,
        delay = 1,
        timer = "REAL",
    }))
end

local card_update_hook = Card.update
function Card:update(dt)
    if self.states.hover.is then
        self.ghover_timer = self.ghover_timer and (self.ghover_timer + dt) or dt
        self.ghover_state = 1
    else
        self.ghover_timer = self.ghover_timer and (self.ghover_timer - dt) or -dt
        self.ghover_state = -1
    end
    self.ghover_timer = math.max(self.ghover_timer, 0)
    self.ghover_timer = math.min(self.ghover_timer, 1)

    return card_update_hook(self, dt)
end

SMODS.draw_ignore_keys["backwheel"] = true

SMODS.DrawStep {
    key = "t5_backwheel",
    func = function(card, layer)
        if layer ~= "card" then
            return
        end
        if not card.ghover_timer then
            return
        end

        if not (card.config.center.tier and card.config.center.tier >= 5 and (not card.area.config.collection)) then
            return
        end

        if not card.children.backwheel then
            card.children.backwheel = Sprite(card.T.x, card.T.y, card.T.w, card.T.h,
                G.ASSET_ATLAS['aqu_upgradable_placeholder'], { x = 0, y = 1 })
            card.children.backwheel.role.draw_major = card
            card.children.backwheel.states.hover.can = false
            card.children.backwheel.states.click.can = false
        end

        local e = G.exp or 0.6
        local function f(x)
            local r = math.max(x * 1.5, x ^ 0.25)
            return math.min(r, 1)
        end
        local scale_prog = card.ghover_state == 1 and f(card.ghover_timer) or 1 - f(1 - card.ghover_timer)

        local scale = scale_prog
        card.children.backwheel:draw_shader('dissolve', nil, nil, true, card.children.center, scale, G.TIMERS.REAL)
    end,
    order = -100
}
