aquill.Upgradable {
    tier = 1,
    group = "scorebound_crystal",
    calculate = function(self, card, context)
        if context.individual then
            if context.cardarea == "unscored" then
                local count = #context.scoring_hand
                return {mult = aquill.percent_buff(card.ability.extra.unscoring, card.ability.extra.buff*count)}
            elseif context.cardarea == G.play then
                local count = #aquill.remove_elements(G.play.cards, context.scoring_hand)
                return {chips = aquill.percent_buff(card.ability.extra.scoring, card.ability.extra.buff*count)}
            end
        end
    end,
    config = { extra = {scoring = 12, unscoring = 4, buff = 20} },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.unscoring,
                card.ability.extra.scoring,
                card.ability.extra.buff
            }
        }
    end,
}

aquill.Upgradable {
    tier = 2,
    group = "scorebound_crystal",
    calculate = function(self, card, context)
        if context.individual then
            if context.cardarea == "unscored" then
                local count = #context.scoring_hand
                return {mult = aquill.percent_buff(card.ability.extra.unscoring, card.ability.extra.buff*count)}
            elseif context.cardarea == G.play then
                local count = #aquill.remove_elements(G.play.cards, context.scoring_hand)
                return {chips = aquill.percent_buff(card.ability.extra.scoring, card.ability.extra.buff*count)}
            end
        end
        SMODS.poll_rarity("rare")
    end,
    config = { extra = {scoring = 50, unscoring = 10, buff = 20} },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.unscoring,
                card.ability.extra.scoring,
                card.ability.extra.buff
            }
        }
    end,
}

aquill.Upgradable {
    tier = 3,
    group = "scorebound_crystal",
    calculate = function(self, card, context)
        if context.individual then
            if context.cardarea == "unscored" then
                local count = #context.scoring_hand
                return {xmult = aquill.percent_buff(card.ability.extra.unscoring, card.ability.extra.buff*count)}
            elseif context.cardarea == G.play then
                local count = #aquill.remove_elements(G.play.cards, context.scoring_hand)
                return {xchips = aquill.percent_buff(card.ability.extra.scoring, card.ability.extra.buff*count)}
            end
        end
    end,
    config = { extra = {scoring = 1.25, unscoring = 1.5, buff = 20} },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.unscoring,
                card.ability.extra.scoring,
                card.ability.extra.buff
            }
        }
    end,
}

aquill.Upgradable {
    tier = 4,
    group = "scorebound_crystal",
    calculate = function(self, card, context)
        if context.individual then
            local enh = next(SMODS.get_enhancements(context.other_card)) and card.ability.extra.enh_exp or 1
            if context.cardarea == "unscored" then
                local count = #context.scoring_hand
                local xm = aquill.percent_buff(card.ability.extra.unscoring, card.ability.extra.buff*count)
                xm = xm ^ enh
                return {
                    xmult = xm
                }
            elseif context.cardarea == G.play then
                local count = #aquill.remove_elements(G.play.cards, context.scoring_hand)
                local xc = aquill.percent_buff(card.ability.extra.scoring, card.ability.extra.buff*count)
                xc = xc ^ enh
                return {
                    xchips = xc
                }
            end
        end

        if context.before then
            local first_card = G.play.cards[1]
            if first_card then
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    func = function()
                        first_card:set_ability(SMODS.poll_enhancement({guaranteed = true}))
                        first_card:juice_up()
                        return true
                    end
                }))
            end
        end
    end,
    config = { extra = {scoring = 1.25, unscoring = 1.5, buff = 20, enh_exp = 2} },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.unscoring,
                card.ability.extra.scoring,
                card.ability.extra.buff,
                card.ability.extra.enh_exp
            }
        }
    end,
}

aquill.Upgradable {
    tier = 5,
    group = "scorebound_crystal",
    calculate = function(self, card, context)
        if context.individual then
            local enh = next(SMODS.get_enhancements(context.other_card)) and card.ability.extra.enh_exp or 1
            local edi = context.other_card.edition and card.ability.extra.edi_tet or 1
            if context.cardarea == "unscored" then
                local count = #context.scoring_hand
                local x = aquill.percent_buff(card.ability.extra.unscoring, card.ability.extra.buff*count)
                x = to_big(x)
                x = x ^ enh
                x = x:tetrate(edi)
                return {
                    xmult = x
                }
            elseif context.cardarea == G.play then
                local count = #aquill.remove_elements(G.play.cards, context.scoring_hand)
                local x = aquill.percent_buff(card.ability.extra.scoring, card.ability.extra.buff*count)
                x = to_big(x)
                x = x ^ enh
                x = x:tetrate(edi)
                return {
                    xchips = x
                }
            end
        end

        if context.before then
            local first_card = G.play.cards[1]
            if first_card then
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    func = function()
                        first_card:set_ability(SMODS.poll_enhancement({guaranteed = true}))
                        first_card:juice_up()
                        return true
                    end
                }))
            end

            local last_card = G.play.cards[#G.play.cards]
            if last_card then
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    func = function()
                        last_card:set_edition(SMODS.poll_edition({guaranteed = true}))
                        last_card:juice_up()
                        return true
                    end
                }))
            end
        end
    end,
    config = { extra = {scoring = 1.25, unscoring = 1.5, buff = 20, enh_exp = 2, edi_tet = 2} },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.unscoring,
                card.ability.extra.scoring,
                card.ability.extra.buff,
                card.ability.extra.enh_exp,
                card.ability.extra.edi_tet
            }
        }
    end,
}