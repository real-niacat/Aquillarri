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

aquill.add_enum("can_upgrade", { "yes", "no", "low_power" })

function aquill.can_upgrade(card, power)
    local cen = G.P_CENTERS[card.config.center_key]

    if not cen.upgrade then
        return aquill.enums.can_upgrade.no --explicitly false, just in case
    end

    if not power then power = math.huge end
    --power not specified? don't limit!

    local tier = G.P_CENTERS[cen.upgrade].tier --check against power level of upgrade source
    if tier <= power then
        return aquill.enums.can_upgrade.yes
    end
    return aquill.enums.can_upgrade.low_power --not strong enough!
end

function aquill.upgrade_joker(card)
    if aquill.can_upgrade(card) == aquill.enums.can_upgrade.no then return end
    local key = card.config.center_key
    local ability = G.P_CENTERS[key].upgrade
    aquill.upgrade_joker_fx(card, ability)
end

function aquill.lerp(a, b, t)
    return a + t * (b - a)
end

-- sets ability of a card like Card:set_ability but it also respects Card.ability.preserve
-- Card.ability.preserve should be an arraylike table of keys to variables in Card.ability.extra to keep
function aquill.preserved_set_ability(card, ability_key)
    -- usually i would hook, but this is ONLY to be used for upgrading jokers
    -- so i dont want any shenanigans from other mods to affect or cause this

    local vars = card.ability

    if not vars.preserve then --there's nothing to preserve brochacho
        card:set_ability(ability_key)
        return
    end

    if not vars.extra then --there's still nothing to preserve brochacho
        card:set_ability(ability_key)
        return
    end

    local saved = {}
    for _, entry in pairs(vars.preserve) do
        saved[entry] = vars.extra[entry] --standard is to keep them in extra
    end


    card:set_ability(ability_key)
    G.E_MANAGER:add_event(Event({
        func = function()
            -- this is in an event due to timing issues, but it's in the "other" queue as to not disrupt anything else
            for key, value in pairs(saved) do
                card.ability.extra[key] = value --copying back
            end
            return true
        end
    }), "other")
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
    return " ({C:aqu_aquill_" .. n * 2 .. "}" .. localize("k_tier") .. " " .. aquill.roman_numerals(n) .. "{})"
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
    for _, card in pairs(table_of_cards) do
        ranks[card:get_id()] = true
    end
    local amount = 0
    for _, rank in pairs(ranks) do
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

function aquill.random_tag(seed)
    local tag_pool = get_current_pool('Tag')
    for i = #tag_pool, 1, -1 do
        if tag_pool[i] == "UNAVAILABLE" then
            table.remove(tag_pool, i)
        end
    end --more code than just iterating, but this is significantly cleaner in my head
    local selected_tag = pseudorandom_element(tag_pool, pseudoseed(seed))
    return selected_tag
end
--returns a movable's pixel position (center)
function aquill.get_movable_pixel_pos(mov)
    return {
        (G.ROOM.T.x + mov.VT.x + mov.VT.w * 0.5) * (G.TILESIZE * G.TILESCALE),
        (G.ROOM.T.y + mov.VT.y + mov.VT.h * 0.5) * (G.TILESIZE * G.TILESCALE),
    }
end

function aquill.movable_top_left_pos(mov)
    local center = aquill.get_movable_pixel_pos(mov)
    center = {
        center[1] - (mov.VT.w * 0.5 * G.TILESCALE * G.TILESIZE),
        center[2] - (mov.VT.h * 0.5 * G.TILESCALE * G.TILESIZE)
    }
    return center
end

function aquill.movable_bottom_right_pos(mov)
    local center = aquill.get_movable_pixel_pos(mov)
    center = {
        center[1] + (mov.VT.w * 0.5 * G.TILESCALE * G.TILESIZE),
        center[2] + (mov.VT.h * 0.5 * G.TILESCALE * G.TILESIZE)
    }
    return center
end

function aquill.pythag(a, b)
    local ax, ay, bx, by = a[1], a[2], b[1], b[2]
    return math.sqrt(((ax - bx) ^ 2) + ((ay - by) ^ 2))
end

function aquill.max_diagonal()
    return aquill.pythag({ 0, 0 }, { love.graphics.getWidth(), love.graphics.getHeight() })
end

function aquill.get_index(card)
    local area = card.area
    for i, c in ipairs(area.cards) do
        if c == card then
            return i
        end
    end
    return false -- what the fuck?
end

function aquill.balance(a, b, percent)
    local arem = a * percent
    local brem = b * percent

    local total = arem + brem
    a = a + (total / 2) - arem
    b = b + (total / 2) - brem

    return a, b
end

function aquill.get_current_profile() --shorthand
    return G.PROFILES[G.SETTINGS.profile]
end

function aquill.graph(inc, func)
    for i = 0, 5, (inc or 1) do
        print(i, func(i))
    end
end

-- returns a table with all elements of base_table except those in remove_table
function aquill.remove_elements(base_table, remove_table)
    -- how the fuck do i do this without being in O(n^2)
    local reverse_remove = {} -- oh thats how
    for k, v in pairs(remove_table) do
        reverse_remove[v] = k
    end
    local new_table = {}
    for key, value in pairs(base_table) do
        if not reverse_remove[value] then
            new_table[key] = value
        end
    end
    return new_table
end

function aquill.percent_buff(number, perc)
    return number * (1 + (perc / 100))
end

function aquill.update_blind_displays()
    local base = get_blind_amount(G.GAME.round_resets.ante)
    G.GAME.upgraded_blind_displays = {}
    for k,mult in pairs(G.GAME.blind_mults) do
        G.GAME.upgraded_blind_displays[k] = number_format(aquill.calc_upgraded_blind_size(base*mult))
    end
end