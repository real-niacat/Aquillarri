SMODS.Shader {
    key = "ephemeral",
    path = "ephemeral.fs"
}

SMODS.Edition {
    key = "ephemeral",
    shader = "ephemeral",
    disable_base_shader = true,
    disable_shadow = true,
    calculate = function(self, card, context)
        if context.main_scoring then
            return {
                xmult = context.cardarea == G.play and card.edition.xmult,
                chips = context.cardarea == G.hand and card.edition.chips,
            }
        end

        if context.playing_card_end_of_round then
            card:start_dissolve()
        end

        if context.modify_scoring_hand and context.other_card == card then
            return {add_to_hand = true}
        end
    end,
    config = {xmult = 3, chips = 60},
    loc_vars = function(self, info_queue, card)
        return {vars = {
            card.edition.xmult or self.config.xmult,
            card.edition.chips or self.config.chips,
        }}
    end,
    in_pool = function(self, args)
        return false
    end
}