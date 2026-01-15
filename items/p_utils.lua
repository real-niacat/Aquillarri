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

function aquill.upgrade_joker(card)
    if not aquill.can_upgrade(card) then return end
    local key = card.config.center_key
    local ability = G.P_CENTERS[key].upgrade
    aquill.upgrade_joker_fx(card, ability)
end

function aquill.upgrade_joker_fx(card, ability)
    local particle_list = {}
    local high_detail = not aquill.config.alt_upgrade

    local colour_list = {
        HEX("3c096c"),
        HEX("5a189a"),
        HEX("9d4edd"),
    }

    for i = 1, 3 do
        G.E_MANAGER:add_event(Event({
            trigger = "after",
            func = function()
                card:juice_up(i / 5, i / 5)
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
            card:set_ability(ability)
            SMODS.calculate_context({ aqu_upgrade = true, card = card })
            return true
        end,
        delay = 1,
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

-- functions as SMODS.find_card but it applies to all cards with the same group
function aquill.find_card_group(group_key)
    local found = {}
    for _, center in pairs(G.P_CENTERS) do
        if center.group == group_key then
            found = SMODS.merge_lists({ found, SMODS.find_card(center.key) })
        end
    end
    return found
end

function aquill.get_predecessor(key)
    local cen = G.P_CENTERS[key]
    return aquill.upgrade_groups[cen.group][cen.tier - 1]
end

function aquill.roman_numerals(s)
    -- code taken and (MINORLY) adapted from https://gist.github.com/efrederickson/4080372
    local numbers = { 1, 5, 10, 50, 100, 500, 1000 }
    local chars = { "I", "V", "X", "L", "C", "D", "M" }

    --s = tostring(s)
    s = tonumber(s)
    if not s or s ~= s then error "Unable to convert to number" end
    if s == math.huge then error "Unable to convert infinity" end
    s = math.floor(s)
    if s <= 0 then return s end
    local ret = ""
    for i = #numbers, 1, -1 do
        local num = numbers[i]
        while s - num >= 0 and s > 0 do
            ret = ret .. chars[i]
            s = s - num
        end
        --for j = i - 1, 1, -1 do
        for j = 1, i - 1 do
            local n2 = numbers[j]
            if s - (num - n2) >= 0 and s < num and s > 0 and num - n2 ~= n2 then
                ret = ret .. chars[j] .. chars[i]
                s = s - (num - n2)
                break
            end
        end
    end
    return ret
end

function aquill.fancy_roman_numerals(n)
    -- n is 1-10, assume no more
    return " {C:aqu_aquill_" .. n*2 .."}" .. aquill.roman_numerals(n)
end

function aquill.x_screen_perc(percent)
    return percent * love.graphics.getWidth()
end

function aquill.y_screen_perc(percent)
    return percent * love.graphics.getHeight()
end

function aquill.to_pixels(balaunits)
    return balaunits * 100
end

function aquill.to_balaunits(pixels)
    return pixels / 100
end

function aquill.distance_1d(p1, p2)
    return math.abs(p1 - p2)
end

function aquill.distance_2d(p1, p2)
    return math.sqrt(((p1.x - p2.x) ^ 2) + ((p1.y - p2.y) ^ 2))
end

function aquill.create_canvas()
    local w = love.window.fromPixels(love.graphics.getWidth())
    local h = love.window.fromPixels(love.graphics.getHeight())
    local canvas = love.graphics.newCanvas(w * G.CANV_SCALE, h * G.CANV_SCALE, { type = '2d', readable = true })
    canvas:setFilter('linear', 'linear')
    return canvas
end

function aquill.get_editioned_cards(area)
    local cs = {}
    for _, card in pairs(area.cards) do
        if card.edition and card.edition.key then
            table.insert(cs, card)
        end
    end
    return cs
end

function aquill.get_relative(card, offset)
    local found = nil
    for i, c in ipairs(card.area.cards) do
        if c == card then
            found = card.area.cards[i + offset]
        end
    end
    return found
end

function aquill.bool(value)
    return not not value
end

function aquill.unique_ranks(table_of_cards)
    local ranks = {}
    for _,card in pairs(table_of_cards) do
        ranks[card:get_id()] = true
    end
    local amount = 0
    for _,rank in pairs(ranks) do
        amount = amount + 1
    end
    return amount
end

function aquill.log(table_of_funcs, ref)
    if ref then
        local old = table_of_funcs[ref]
        table_of_funcs[ref] = function(...)
            print(ref, "called with args", ...)
            return old(...)
        end
        return
    end


    for k, entry in pairs(table_of_funcs) do
        if type(entry) == "function" then
            table_of_funcs[k] = function(...)
                print(k, "called with args", ...)
                return entry(...)
            end
        end
    end
end
