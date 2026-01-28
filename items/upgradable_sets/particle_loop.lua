aquill.Upgradable {
    tier = 1,
    group = "particleloop",
    calculate = function(self, card, context)
        if context.joker_main then
            for i = 0, (card.ability.extra.retriggers - 1) do --imitates retriggering without actually doing it
                SMODS.calculate_effect(
                { chips = card.ability.extra.chips + (i * (card.ability.extra.gain / 100) * card.ability.extra.chips) },
                    card)
                SMODS.calculate_effect({ message = localize("k_again_ex") }, card)
            end
        end

        if context.end_of_round and context.main_eval then
            SMODS.scale_card(card,
                { ref_table = card.ability.extra, ref_value = "retriggers", scalar_value = "retrig_gain" })
        end
    end,
    config = { extra = { chips = 2, gain = 10, retriggers = 2, retrig_gain = 1 }, preserve = {"retriggers"} },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.chips,
                card.ability.extra.gain,
                card.ability.extra.retriggers,
                card.ability.extra.retrig_gain
            }
        }
    end,
}

aquill.Upgradable {
    tier = 2,
    group = "particleloop",
    calculate = function(self, card, context)
        if context.joker_main then
            for i = 0, (card.ability.extra.retriggers - 1) do --imitates retriggering without actually doing it
                SMODS.calculate_effect(
                { chips = card.ability.extra.chips + (i * (card.ability.extra.gain / 100) * card.ability.extra.chips) },
                    card)
                SMODS.calculate_effect({ message = localize("k_again_ex") }, card)
            end
        end

        if context.end_of_round and context.main_eval then
            SMODS.scale_card(card,
                { ref_table = card.ability.extra, ref_value = "retriggers", scalar_value = "retrig_gain" })
        end
    end,
    config = { extra = { chips = 20, gain = 10, retriggers = 2, retrig_gain = 2 }, preserve = {"retriggers"} },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.chips,
                card.ability.extra.gain,
                card.ability.extra.retriggers,
                card.ability.extra.retrig_gain
            }
        }
    end,
}

aquill.Upgradable {
    tier = 3,
    group = "particleloop",
    calculate = function(self, card, context)
        if context.joker_main then
            for i = 0, (card.ability.extra.retriggers - 1) do --imitates retriggering without actually doing it
                SMODS.calculate_effect(
                { chips = card.ability.extra.chips + (i * (card.ability.extra.gain / 100) * card.ability.extra.chips) },
                    card)
                SMODS.calculate_effect(
                { xchips = card.ability.extra.xchips +
                (i * (card.ability.extra.gain / 100) * (card.ability.extra.xchips - 1)) }, card)
                SMODS.calculate_effect({ message = localize("k_again_ex") }, card)
            end
        end

        if context.end_of_round and context.main_eval then
            SMODS.scale_card(card,
                { ref_table = card.ability.extra, ref_value = "retriggers", scalar_value = "retrig_gain" })
        end
    end,
    config = { extra = { chips = 20, gain = 10, retriggers = 2, retrig_gain = 2, xchips = 1.2 }, preserve = {"retriggers"} },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.chips,
                card.ability.extra.gain,
                card.ability.extra.retriggers,
                card.ability.extra.retrig_gain,
                card.ability.extra.xchips,
            }
        }
    end,
}

aquill.Upgradable {
    tier = 4,
    group = "particleloop",
    calculate = function(self, card, context)
        if context.joker_main then
            for i = 0, (card.ability.extra.retriggers - 1) do --imitates retriggering without actually doing it
                SMODS.calculate_effect(
                { chips = card.ability.extra.chips + (i * (card.ability.extra.gain / 100) * card.ability.extra.chips) },
                    card)
                SMODS.calculate_effect(
                { xchips = card.ability.extra.xchips +
                (i * (card.ability.extra.gain / 100) * (card.ability.extra.xchips - 1)) }, card)
                SMODS.calculate_effect({ message = localize("k_again_ex") }, card)
            end
        end

        if context.end_of_round and context.main_eval then
            SMODS.scale_card(card,
                { ref_table = card.ability.extra, ref_value = "retriggers", scalar_value = "retrig_gain" })
        end
    end,
    config = { extra = { chips = 25, gain = 25, retriggers = 3, retrig_gain = 3, xchips = 1.2 }, preserve = {"retriggers"} },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.chips,
                card.ability.extra.gain,
                card.ability.extra.retriggers,
                card.ability.extra.retrig_gain,
                card.ability.extra.xchips,
            }
        }
    end,
}

aquill.Upgradable {
    tier = 5,
    group = "particleloop",
    calculate = function(self, card, context)
        if context.joker_main then
            for i = 0, (card.ability.extra.retriggers - 1) do --imitates retriggering without actually doing it
                SMODS.calculate_effect(
                { chips = card.ability.extra.chips + (i * (card.ability.extra.gain / 100) * card.ability.extra.chips) },
                    card)
                SMODS.calculate_effect(
                { xchips = card.ability.extra.xchips +
                (i * (card.ability.extra.gain / 100) * (card.ability.extra.xchips - 1)) }, card)
                SMODS.calculate_effect({ message = localize("k_again_ex") }, card)
            end
        end

        if context.end_of_round and context.main_eval then
            SMODS.scale_card(card,
                { ref_table = card.ability.extra, ref_value = "retriggers", scalar_value = "retrig_gain" })
        end
    end,
    config = { extra = { chips = 50, gain = 75, retriggers = 3, retrig_gain = 3, xchips = 2 }, preserve = {"retriggers"} },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.chips,
                card.ability.extra.gain,
                card.ability.extra.retriggers,
                card.ability.extra.retrig_gain,
                card.ability.extra.xchips,
            }
        }
    end,
}
