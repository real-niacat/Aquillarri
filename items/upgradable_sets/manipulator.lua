aquill.Upgradable {
    tier = 1,
    group = "manip",
    calculate = function(self, card, context)
        -- score random cards
        if context.final_scoring_step then
            for _, playing_card in pairs(context.full_hand) do
                SMODS.score_card(playing_card, { cardarea = G.hand })
            end
        end
    end,
    config = { extra = {} },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {

            }
        }
    end,
}

aquill.Upgradable {
    tier = 2,
    group = "manip",
    calculate = function(self, card, context)
        -- score random cards
        if context.final_scoring_step then
            for _, playing_card in pairs(context.full_hand) do
                SMODS.score_card(playing_card, { cardarea = G.hand })
            end
            for _, playing_card in pairs(G.hand.cards) do
                SMODS.score_card(playing_card, { cardarea = G.play })
            end
        end
    end,
    config = { extra = {} },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {

            }
        }
    end,
}

aquill.Upgradable {
    tier = 3,
    group = "manip",
    calculate = function(self, card, context)
        -- score random cards
        if context.final_scoring_step then
            for _, playing_card in pairs(context.full_hand) do
                SMODS.score_card(playing_card, { cardarea = G.hand })
            end
            for _, playing_card in pairs(G.hand.cards) do
                SMODS.score_card(playing_card, { cardarea = G.play })
            end
            for _, playing_card in pairs(G.discard.cards) do
                if SMODS.pseudorandom_probability(card, "manip3", card.ability.extra.numerator, card.ability.extra.denominator) then
                    SMODS.score_card(playing_card, {cardarea = G.hand})
                end
            end
        end
    end,
    config = { extra = { numerator = 1, denominator = 3 } },
    loc_vars = function(self, info_queue, card)
        local n, d = SMODS.get_probability_vars(card, card.ability.extra.numerator, card.ability.extra.denominator)
        return {
            vars = {
                n, d
            }
        }
    end,
}

aquill.Upgradable {
    tier = 4,
    group = "manip",
    calculate = function(self, card, context)
        -- score random cards
        if context.final_scoring_step then
            for _, playing_card in pairs(context.full_hand) do
                SMODS.score_card(playing_card, { cardarea = G.hand })
            end
            for _, playing_card in pairs(G.hand.cards) do
                SMODS.score_card(playing_card, { cardarea = G.play })
            end
            for _, playing_card in pairs(G.discard.cards) do
                if SMODS.pseudorandom_probability(card, "manip3", card.ability.extra.numerator, card.ability.extra.denominator) then
                    SMODS.score_card(playing_card, {cardarea = G.hand})
                end
            end
            for _, playing_card in pairs(G.deck.cards) do
                if SMODS.pseudorandom_probability(card, "manip4", card.ability.extra.numerator, card.ability.extra.denominator) then
                    SMODS.score_card(playing_card, {cardarea = G.play})
                end
            end
        end
    end,
    config = { extra = { numerator = 1, denominator = 3 } },
    loc_vars = function(self, info_queue, card)
        local n, d = SMODS.get_probability_vars(card, card.ability.extra.numerator, card.ability.extra.denominator)
        return {
            vars = {
                n, d
            }
        }
    end,
}

aquill.Upgradable {
    tier = 5,
    group = "manip",
    calculate = function(self, card, context)
        -- score random cards
        if context.final_scoring_step then
            for _, playing_card in pairs(context.full_hand) do
                SMODS.score_card(playing_card, { cardarea = G.hand })
            end
            for _, playing_card in pairs(G.hand.cards) do
                SMODS.score_card(playing_card, { cardarea = G.play })
            end
            for _, playing_card in pairs(G.discard.cards) do
                if SMODS.pseudorandom_probability(card, "manip3", card.ability.extra.numerator, card.ability.extra.denominator) then
                    SMODS.score_card(playing_card, {cardarea = G.hand})
                end
            end
            for _, playing_card in pairs(G.deck.cards) do
                if SMODS.pseudorandom_probability(card, "manip4", card.ability.extra.numerator, card.ability.extra.denominator) then
                    SMODS.score_card(playing_card, {cardarea = G.play})
                end
            end
            for i=1,card.ability.extra.cards do
                SMODS.score_card(pseudorandom_element(G.playing_cards, "rand_hand"), {cardarea = G.hand})
            end
            for i=1,card.ability.extra.cards do
                SMODS.score_card(pseudorandom_element(G.playing_cards, "rand_play"), {cardarea = G.play})
            end
        end
    end,
    config = { extra = { numerator = 1, denominator = 3, cards = 15 } },
    loc_vars = function(self, info_queue, card)
        local n, d = SMODS.get_probability_vars(card, card.ability.extra.numerator, card.ability.extra.denominator)
        return {
            vars = {
                n, d, card.ability.extra.cards
            }
        }
    end,
}
