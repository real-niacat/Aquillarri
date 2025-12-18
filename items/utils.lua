function aquill.recalculate_joker_main()
    SMODS.calculate_context {
        joker_main = true,
        cardarea = G.jokers,
        full_hand = G.play.cards,
        scoring_hand = {},
        scoring_name = "",
        poker_hands = {}
    }
end

function aquill.can_upgrade(card)
    local cen = G.P_CENTERS[card.config.center_key]
    return cen.upgrade
end

function aquill.upgrade_joker(card, path)
    if not aquill.can_upgrade(card, path) then return end
    local key = card.config.center_key
    local ability = G.P_CENTERS[key].upgrade
    aquill.upgrade_joker_fx(card, ability)
end

function aquill.upgrade_joker_fx(card, ability)

    for i=1,3 do
        G.E_MANAGER:add_event(Event({
            trigger = "after",
            func = function()
                card:juice_up(i/5, i/5)
                return true
            end,
            delay = 0.25+(0.5*i),
            timer = "REAL",
            blocking = true,
            blockable = false,
            force_stop = true,
        }))
    end

    G.E_MANAGER:add_event(Event({
        trigger = "after",
        func = function()
            card:juice_up(1, 1)
            play_sound("explosion_release1", 1, 3)
            card:set_ability(ability)
            return true
        end,
        delay = 0.5,
        timer = "REAL",
    }))
end

function aquill.lerp(a, b, t)
    return a + t * (b - a)
end

function aquill.lerp_mouse(pos, amount)
    local mouse_pos = { x = love.mouse.getX(), y = love.mouse.getY() }
    local new = { x = aquill.lerp(pos.x, mouse_pos.x, amount), y = aquill.lerp(pos.y, mouse_pos.y, amount) }
    love.mouse.setX(math.floor(new.x + 0.5))
    love.mouse.setY(math.floor(new.y + 0.5))
end

function Card:get_screen_coords()
    return { x = (self.T.x * 100) + (self.T.w * 25), y = (self.T.y * 100) + (self.T.h * 25) }
end

local upd = Card.update
function Card:update(dt)
    upd(self, dt)

    if self.gravitational_pull then
        aquill.lerp_mouse(self:get_screen_coords(), 1 - self.gravitational_pull)
    end
end

function math.round(n)
    return math.floor(n + 0.5)
end

function aquill.round_to_nearest(n, round)
    return math.round(n / round) * round
end

function aquill.calc_dormant_blind_size(original_blind_size)
    local n = to_big(original_blind_size):pow(G.GAME.dormant_exponent)
    local place_value = 10 ^ math.floor(math.log10(n))
    n = aquill.round_to_nearest(n, place_value)
    return n
end