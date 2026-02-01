aquill.Upgradable {
    tier = 1,
    group = "biava",
    calculate = function(self, card, context)
        if context.end_of_round and context.main_eval and (G.GAME.dollars >= card.ability.extra.spend) and (#G.jokers.cards < G.jokers.config.card_limit) then
            ease_dollars(-card.ability.extra.spend)
            local uncommon = pseudorandom("aqu_biava", 1, 2) == 1
            SMODS.add_card({set = "Joker", rarity = uncommon and "Uncommon" or "Rare"})
        end
    end,
    loc_vars = function(self, info_queue, card)
        return {vars = {
            card.ability.extra.spend,
        }}
    end,
    config = { extra = { spend = 5 } },
}

aquill.Upgradable {
    tier = 2,
    group = "biava",
    calculate = function(self, card, context)
        if context.end_of_round and context.main_eval and (G.GAME.dollars >= card.ability.extra.spend) and (#G.jokers.cards < G.jokers.config.card_limit) then
            ease_dollars(-card.ability.extra.spend)
            local uncommon = pseudorandom("aqu_biava", 1, 2) == 1
            SMODS.add_card({set = "Joker", rarity = uncommon and "Uncommon" or "Rare"})
        end

        if context.joker_main then
            return {
                xmult = self:get_xmult(card)
            }
        end
    end,
    loc_vars = function(self, info_queue, card)
        return {vars = {
            card.ability.extra.spend,
            card.ability.extra.percent,
            self:get_xmult(card)
        }}
    end,
    get_xmult = function(self, card)
        return 1 + (G.GAME.dollars * 0.01 * card.ability.extra.percent)
    end,
    config = { extra = { spend = 4, percent = 1 } },
}

aquill.Upgradable {
    tier = 3,
    group = "biava",
    calculate = function(self, card, context)
        if context.end_of_round and context.main_eval and context.beat_boss then
            local right_joker = card.area.cards[aquill.get_index(card)+1]
            if right_joker then
                ease_dollars(right_joker.sell_cost * 3)
                SMODS.destroy_cards({right_joker})
            end
        elseif context.end_of_round and context.main_eval and (G.GAME.dollars >= card.ability.extra.spend) and (#G.jokers.cards < G.jokers.config.card_limit)then
            ease_dollars(-card.ability.extra.spend)
            local uncommon = pseudorandom("aqu_biava", 1, 2) == 1
            SMODS.add_card({set = "Joker", rarity = uncommon and "Uncommon" or "Rare"})
        end

        if context.joker_main then
            return {
                xmult = self:get_xmult(card)
            }
        end
    end,
    loc_vars = function(self, info_queue, card)
        return {vars = {
            card.ability.extra.spend,
            card.ability.extra.percent,
            self:get_xmult(card)
        }}
    end,
    get_xmult = function(self, card)
        return 1 + (G.GAME.dollars * 0.01 * card.ability.extra.percent)
    end,
    config = { extra = { spend = 3, percent = 3 } },
}

aquill.Upgradable {
    tier = 4,
    group = "biava",
    calculate = function(self, card, context)
        if context.end_of_round and context.main_eval and context.beat_boss then
            local right_joker = card.area.cards[aquill.get_index(card)+1]
            if right_joker then
                ease_dollars(right_joker.sell_cost * 4)
                SMODS.destroy_cards({right_joker})
            end
        elseif context.end_of_round and context.main_eval and (G.GAME.dollars >= card.ability.extra.spend) then
            ease_dollars(-card.ability.extra.spend)
            local uncommon = pseudorandom("aqu_biava", 1, 2) == 1
            SMODS.add_card({set = "Joker", rarity = uncommon and "Uncommon" or "Rare"})
        end

        if context.joker_main then
            return {
                xmult = self:get_xmult(card)
            }
        end
    end,
    loc_vars = function(self, info_queue, card)
        return {vars = {
            card.ability.extra.spend,
            card.ability.extra.percent,
            self:get_xmult(card)
        }}
    end,
    get_xmult = function(self, card)
        return 1 + (G.GAME.dollars * 0.01 * card.ability.extra.percent)
    end,
    config = { extra = { spend = 3, percent = 10 } },
}

aquill.Upgradable {
    tier = 5,
    group = "biava",
    calculate = function(self, card, context)
        if context.end_of_round and context.main_eval and context.beat_boss then
            local right_joker_index = aquill.get_index(card)+1
            local to_destroy = {}
            local sum = 0
            for i=right_joker_index, #card.area.cards do
                local c = card.area.cards[i]
                if c then
                    table.insert(to_destroy, c)
                    sum = sum + (c.sell_cost * 4)
                end
            end
            ease_dollars(sum)
            SMODS.destroy_cards(to_destroy)
        end
        if context.individual and context.cardarea == G.play and (G.GAME.dollars + (G.GAME.dollar_buffer or 0) >= card.ability.extra.spend) then
            local d = -card.ability.extra.spend
            ease_dollars(d)
            G.GAME.dollar_buffer = (G.GAME.dollar_buffer or 0) + d
            G.E_MANAGER:add_event(Event({
                func = function()
                    G.GAME.dollar_buffer = 0
                    return true
                end
            }))
            local uncommon = pseudorandom("aqu_biava", 1, 2) == 1
            SMODS.add_card({set = "Joker", rarity = uncommon and "Uncommon" or "Rare"})
        end

        if context.joker_main then
            return {
                xmult = self:get_xmult(card)
            }
        end
    end,
    loc_vars = function(self, info_queue, card)
        return {vars = {
            card.ability.extra.spend,
            card.ability.extra.percent,
            self:get_xmult(card)
        }}
    end,
    get_xmult = function(self, card)
        return 1 + (G.GAME.dollars * 0.01 * card.ability.extra.percent)
    end,
    config = { extra = { spend = 2, percent = 25 } },
}