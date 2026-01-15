aquill.Upgradable {
    tier = 1,
    group = "magicorb",
    calculate = function(self, card, context)
        if context.modify_shop_card then
            card.ability.extra.remaining = card.ability.extra.remaining - 1 
            if card.ability.extra.remaining <= 0 then
                context.card:set_edition(SMODS.poll_edition({ guaranteed = true }))
                card:juice_up()
                card.ability.extra.remaining = card.ability.extra.max
            end
        end
    end,
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.max, card.ability.extra.remaining}}
    end,
    config = { extra = { max = 7, remaining = 1, loss = 1 } },
}

aquill.Upgradable {
    tier = 2,
    group = "magicorb",
    calculate = function(self, card, context)
        if context.modify_shop_card then
            card.ability.extra.remaining = card.ability.extra.remaining - (#aquill.get_editioned_cards(card.area) + 1)
            if card.ability.extra.remaining <= 0 then
                context.card:set_edition(SMODS.poll_edition({ guaranteed = true }))
                card:juice_up()
                card.ability.extra.remaining = card.ability.extra.max
            end
        end
    end,
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.max, card.ability.extra.remaining}}
    end,
    config = { extra = { max = 12, remaining = 1, loss = 1 } },
}
-- G.GAME.current_round.free_rerolls = math.max(G.GAME.current_round.free_rerolls + mod, 0)
    -- calculate_reroll_cost(true)

aquill.Upgradable {
    tier = 3,
    group = "magicorb",
    calculate = function(self, card, context)
        if context.modify_shop_card then
            card.ability.extra.remaining = card.ability.extra.remaining - (#aquill.get_editioned_cards(card.area) + 1)
            if card.ability.extra.remaining <= 0 then
                context.card:set_edition(SMODS.poll_edition({ guaranteed = true }))
                card:juice_up()
                card.ability.extra.remaining = card.ability.extra.max
            end
        end

        if context.buying_card and not context.buying_self and context.card.edition then
            G.GAME.current_round.free_rerolls = math.max(G.GAME.current_round.free_rerolls + 1, 0)
            calculate_reroll_cost(true)
        end
    end,
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.max, card.ability.extra.remaining}}
    end,
    config = { extra = { max = 14, remaining = 1, loss = 1 } },
}

aquill.Upgradable {
    tier = 4,
    group = "magicorb",
    calculate = function(self, card, context)
        if context.modify_shop_card then
            card.ability.extra.remaining = card.ability.extra.remaining - (#aquill.get_editioned_cards(card.area) + 1)
            if card.ability.extra.remaining <= 0 then
                context.card:set_edition(SMODS.poll_edition({ guaranteed = true }))
                card:juice_up()
                card.ability.extra.remaining = card.ability.extra.max
            end
        end

        if context.buying_card and not context.buying_self and context.card.edition then
            G.GAME.current_round.free_rerolls = math.max(G.GAME.current_round.free_rerolls + 1, 0)
            calculate_reroll_cost(true)
        end

        if context.end_of_round and context.main_eval then
           
            for _,c in pairs(G.I.CARD) do
                if c.edition and SMODS.pseudorandom_probability(c, "edition_copy_" .. c.unique_val, card.ability.extra.num, card.ability.extra.den) then
                    local to_copy = pseudorandom_element(c.area.cards, "aqu_edition_copy")
                    to_copy:set_edition(c.edition.key)
                end
            end

        end
    end,
    loc_vars = function(self, info_queue, card)
        local n,d = SMODS.get_probability_vars(card, card.ability.extra.num, card.ability.extra.den)
        return {vars = {card.ability.extra.max, card.ability.extra.remaining, n, d}}
    end,
    config = { extra = { max = 14, remaining = 1, loss = 1, num = 1, den = 6 } },
}

aquill.Upgradable {
    tier = 5,
    group = "magicorb",
    calculate = function(self, card, context)
        if context.modify_shop_card then
            card.ability.extra.remaining = card.ability.extra.remaining - (#aquill.get_editioned_cards(card.area) + 1)
            if card.ability.extra.remaining <= 0 then
                context.card:set_edition(SMODS.poll_edition({ guaranteed = true }))
                card:juice_up()
                card.ability.extra.remaining = card.ability.extra.max
            end
        end

        if context.buying_card and not context.buying_self and context.card.edition then
            G.GAME.current_round.free_rerolls = math.max(G.GAME.current_round.free_rerolls + 1, 0)
            calculate_reroll_cost(true)
        end

        if context.end_of_round and context.main_eval then
           
            for _,c in pairs(G.I.CARD) do
                if c.edition and SMODS.pseudorandom_probability(c, "edition_copy_" .. c.unique_val, card.ability.extra.num, card.ability.extra.den) then
                    local to_copy = pseudorandom_element(c.area.cards, "aqu_edition_copy")
                    to_copy:set_edition(c.edition.key)
                end
            end

        end

        if (context.retrigger_joker_check and context.other_card.edition) or (context.repetition and context.other_card.edition) then
            return {repetitions = #aquill.get_editioned_cards(card.area)}
        end
    end,
    loc_vars = function(self, info_queue, card)
        local n,d = SMODS.get_probability_vars(card, card.ability.extra.num, card.ability.extra.den)
        return {vars = {card.ability.extra.max, card.ability.extra.remaining, n, d}}
    end,
    config = { extra = { max = 14, remaining = 1, loss = 1, num = 1, den = 4 } },
}