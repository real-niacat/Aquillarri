-- format: {key = loc_key, max = max_counter, should_inc = function(context) end}
-- should_inc is just like calculate except it just increments if the function returns true rather than directly doing anything
aquill.closed_portal_options = {
    {
        key = "c_aqu_clp_upgrade",
        max = 2,
        should_inc = function(context)
            if context.setting_upgraded_blind then
                return true
            end
        end
    },
    {
        key = "c_aqu_clp_scorecards",
        max = 20,
        should_inc = function(context)
            if context.individual and context.cardarea == G.play then
                return true
            end
        end
    },
    {
        key = "c_aqu_clp_selljokers",
        max = 3,
        should_inc = function(context)
            if context.selling_card and context.card.config.center.set == "Joker" then
                return true
            end
        end
    },
    {
        key = "c_aqu_clp_earnmoney",
        max = 3,
        should_inc = function(context)
            if context.money_altered and to_big(context.amount) > to_big() then
                return true
            end
        end
    },
}

SMODS.Consumable {
    key = "closed_portal",
    set = "Spectral",
    in_pool = function() return false end,
    config = { extra = { next_tier = 0, current_counter = 0, max_counter = 0, option = 0, scale_by = 1, stop = false } }, --scale_by should always be 1
    loc_vars = function(self, info_queue, card)
        local option = card.ability.extra.option
        return {
            vars = {
                card.ability.extra.current_counter,
                card.ability.extra.max_counter,
                card.ability.extra.next_tier,
                colours = { G.C["aqu_aquill_" .. (card.ability.extra.next_tier * 2)] },
            },
            key = option > 0 and aquill.closed_portal_options[option].key or nil
        }
    end,
    calculate = function(self, card, context)
        if card.ability.extra.stop then
            return
        end
        local option = card.ability.extra.option
        if option > 0 and aquill.closed_portal_options[card.ability.extra.option].should_inc(context) then
            SMODS.scale_card(card,
                { ref_table = card.ability.extra, ref_value = "current_counter", scalar_value = "scale_by" })
            if card.ability.extra.current_counter >= card.ability.extra.max_counter then
                card.ability.extra.stop = true
                local nilscape = SMODS.add_card({ key = "c_aqu_nilscape_portal", area = G.consumeables })
                nilscape.ability.extra.upgrade_strength = card.ability.extra.next_tier
                G.E_MANAGER:add_event(Event({
                    func = function()
                        card:start_dissolve({ G.C.PURPLE })
                        return true
                    end
                }))
            end
        end
    end,
    atlas = "generic_1",
    pos = {x=1, y=3},
}