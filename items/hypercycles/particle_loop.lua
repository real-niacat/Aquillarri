SMODS.Joker {
    key = "particle_loop",
    rarity = "aqu_dormant",
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
    upgrade = "j_aqu_particle_loop_upgraded",
}

SMODS.Joker {
    key = "particle_loop_upgraded",
    rarity = "aqu_dormant",
    calculate = function(self, card, context)
        if context.joker_main then

            local success = true
            local loops = 0
            while success do
                local v = card.ability.extra.chips + (loops * card.ability.extra.gain)
                SMODS.calculate_effect({chips = v, mult = v}, card)
                loops = loops + 1
                success = SMODS.pseudorandom_probability(card, "aqu_particle_loop", card.ability.extra.num, card.ability.extra.den, nil, true)
            end

        end
    end,
    config = {extra = {chips = 3, gain = 3, num = 14, den = 15}},
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
    upgrade = nil,
}