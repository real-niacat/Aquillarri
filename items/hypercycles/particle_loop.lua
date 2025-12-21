aquill.Upgradable {
    tier = 1,
    group = "particleloop",
    calculate = function(self, card, context)
        if context.joker_main then

            local success = true
            local loops = 0
            while success do
                SMODS.calculate_effect({chips = card.ability.extra.chips + (loops * card.ability.extra.gain)}, card)
                loops = loops + 1
                success = SMODS.pseudorandom_probability(card, "aqu_particle_loop", card.ability.extra.num, card.ability.extra.den, nil, true)
            end

        end
    end,
    config = {extra = {chips = 2, gain = 2, num = 9, den = 10}},
    loc_vars = function(self, info_queue, card)
        local num, den = SMODS.get_probability_vars(card, card.ability.extra.num, card.ability.extra.den, nil, nil, true)
        return {
            vars = {
                card.ability.extra.chips,
                num,
                den,
                card.ability.extra.gain
            }
        }
    end,
}

aquill.Upgradable {
    tier = 2,
    group = "particleloop",
    calculate = function(self, card, context)
        if context.joker_main then

            local success = true
            local loops = 0
            while success do
                local v = card.ability.extra.chips + (loops * card.ability.extra.gain)
                SMODS.calculate_effect({chips = v}, card)
                loops = loops + 1
                success = SMODS.pseudorandom_probability(card, "aqu_particle_loop", card.ability.extra.num, card.ability.extra.den, nil, true)
            end

        end
    end,
    config = {extra = {chips = 5, gain = 5, num = 14, den = 15}},
    loc_vars = function(self, info_queue, card)
        local num, den = SMODS.get_probability_vars(card, card.ability.extra.num, card.ability.extra.den, nil, nil, true)
        return {
            vars = {
                card.ability.extra.chips,
                num,
                den,
                card.ability.extra.gain
            }
        }
    end,
}

aquill.Upgradable {
    tier = 3,
    group = "particleloop",
    calculate = function(self, card, context)
        if context.joker_main then

            local success = true
            local loops = 0
            while success do
                local v = card.ability.extra.xchips + (loops * card.ability.extra.gain)
                SMODS.calculate_effect({xchips = v}, card)
                loops = loops + 1
                success = SMODS.pseudorandom_probability(card, "aqu_particle_loop", card.ability.extra.num, card.ability.extra.den, nil, true)
            end

        end
    end,
    config = {extra = {xchips = 1.25, gain = 0.05, num = 14, den = 15}},
    loc_vars = function(self, info_queue, card)
        local num, den = SMODS.get_probability_vars(card, card.ability.extra.num, card.ability.extra.den, nil, nil, true)
        return {
            vars = {
                card.ability.extra.xchips,
                num,
                den,
                card.ability.extra.gain
            }
        }
    end,
}

aquill.Upgradable {
    tier = 4,
    group = "particleloop",
    calculate = function(self, card, context)
        if context.joker_main then

            local success = true
            local loops = 0
            while success do
                local v = card.ability.extra.xchips + (loops * card.ability.extra.gain)
                SMODS.calculate_effect({xchips = v}, card)
                loops = loops + 1
                success = SMODS.pseudorandom_probability(card, "aqu_particle_loop", card.ability.extra.num, card.ability.extra.den, nil, true)
            end

        end
    end,
    config = {extra = {xchips = 2, gain = 0.25, num = 19, den = 20}},
    loc_vars = function(self, info_queue, card)
        local num, den = SMODS.get_probability_vars(card, card.ability.extra.num, card.ability.extra.den, nil, nil, true)
        return {
            vars = {
                card.ability.extra.xchips,
                num,
                den,
                card.ability.extra.gain,
            }
        }
    end,
}

aquill.Upgradable {
    tier = 5,
    group = "particleloop",
    calculate = function(self, card, context)
        if context.joker_main then

            local success = true
            local loops = 0
            while success do
                local v = card.ability.extra.echips + (loops * card.ability.extra.gain)
                SMODS.calculate_effect({echips = v}, card)
                loops = loops + 1
                success = SMODS.pseudorandom_probability(card, "aqu_particle_loop", card.ability.extra.num, card.ability.extra.den, nil, true)
            end

        end
    end,
    config = {extra = {echips = 1.2, gain = 0.05, num = 19, den = 20}},
    loc_vars = function(self, info_queue, card)
        local num, den = SMODS.get_probability_vars(card, card.ability.extra.num, card.ability.extra.den, nil, nil, true)
        return {
            vars = {
                card.ability.extra.echips,
                num,
                den,
                card.ability.extra.gain,
            }
        }
    end,
}