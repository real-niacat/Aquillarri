function aquill.recalculate_joker_main()
    SMODS.calculate_context{
        joker_main = true,
        cardarea = G.jokers,
        full_hand = G.play.cards,
        scoring_hand = {},
        scoring_name = "",
        poker_hands = {}
    }
end
