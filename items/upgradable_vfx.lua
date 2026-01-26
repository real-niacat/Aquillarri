SMODS.Shader {
    key = "flashlight",
    path = "flashlight.fs",
}

SMODS.ScreenShader {
    key = "flashlight",
    shader = "aqu_flashlight",
    send_vars = function(self)
        return {
            center_pos = G.aqu_flashlight_center or { love.graphics.getWidth() / 2, love.graphics.getHeight() / 2 },
            dist = G.aqu_flashlight_distance or 500,
        }
    end,
    should_apply = function(self)
        return G.aqu_flashlight_enabled
    end,
    order = 5,
}

SMODS.Shader {
    key = "static_flashlight",
    path = "static_flashlight.fs",
}

SMODS.ScreenShader {
    key = "static_flashlight",
    shader = "aqu_static_flashlight",
    send_vars = function(self)
        return {
            center_pos = G.aqu_flashlight_center or { love.graphics.getWidth() / 2, love.graphics.getHeight() / 2 },
            dist = (G.aqu_flashlight_distance * 3) or 500,
            iTime = G.TIMERS.REAL,
        }
    end,
    should_apply = function(self)
        return G.aqu_flashlight_enabled
    end,
    order = 6,
}

SMODS.Shader {
    key = "invertradius",
    path = "invertradius.fs",
}

SMODS.ScreenShader {
    key = "invert",
    shader = "aqu_invertradius",
    send_vars = function(self)
        return {
            center_pos = G.aqu_invert_center or { love.graphics.getWidth() / 2, love.graphics.getHeight() / 2 },
            dist = G.aqu_invert_distance or 500,
        }
    end,
    should_apply = function(self)
        return G.aqu_invert_enabled
    end,
    order = 7
}

function aquill.upgrade_joker_fx(card, ability)
    local particle_list = {}
    local high_detail = not aquill.config.alt_upgrade

    local colour_list = {
        HEX("3c096c"),
        HEX("5a189a"),
        HEX("9d4edd"),
    }

    G.E_MANAGER:add_event(Event({
        trigger = 'after',
        func = function()
            if G.aqu_upgrading then
                return false
            end
            G.aqu_upgrading = true

            if high_detail then
                G.E_MANAGER:add_event(Event({
                    trigger = "after",
                    func = function()
                        G.aqu_flashlight_enabled = true
                        G.aqu_flashlight_distance = aquill.max_diagonal()
                        G.aqu_invert_enabled = true
                        G.aqu_invert_distance = 0

                        local card_position = aquill.get_card_pixel_pos(card)
                        G.aqu_flashlight_center = card_position
                        G.aqu_invert_center = card_position
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
                                ease = 'inexpo',
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
                    card:set_cost()
                    SMODS.calculate_context({ aqu_upgrade = true, card = card })

                    if high_detail then
                        local border = aquill.max_diagonal()
                        G.E_MANAGER:add_event(Event({
                            trigger = 'ease',
                            ease = 'outexpo',
                            ref_table = G,
                            ref_value = 'aqu_flashlight_distance',
                            ease_to = 100000,
                            delay = 2,
                            timer = "REAL",
                            func = (function(t) return t end),
                            blockable = false,
                        }), "other")
                        G.E_MANAGER:add_event(Event({
                            trigger = 'ease',
                            ease = 'insine',
                            ref_table = G,
                            ref_value = 'aqu_invert_distance',
                            ease_to = border,
                            delay = 4,
                            timer = "REAL",
                            func = (function(t) return t end),
                            blockable = false,
                        }), "other")
                        
                        G.E_MANAGER:add_event(Event({
                            trigger = "after",
                            delay = 4,
                            func = function()
                                G.aqu_flashlight_enabled = false
                                return true
                            end
                        }), "other")
                        G.E_MANAGER:add_event(Event({
                            trigger = "after",
                            delay = 4,
                            func = function()
                                G.aqu_invert_enabled = false
                                G.aqu_upgrading = false
                                return true
                            end
                        }), "other")
                    end
                    return true
                end,
                delay = 1,
                timer = "REAL",
            }))

            return true
        end
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
