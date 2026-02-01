SMODS.Consumable {
    set = "Spectral",
    key = "nilscape_portal",
    can_use = function(self, card)
        if #G.jokers.highlighted ~= 1 then
            return false
        end

        local res = aquill.can_upgrade(G.jokers.highlighted[1], card.ability.extra.upgrade_strength - 1)
        if res == aquill.enums.can_upgrade.no then
            return false
        end

        if res == aquill.enums.can_upgrade.low_power then
            -- create Closed Portal when used
            return true
        end

        if res == aquill.enums.can_upgrade.yes then
            return true
        end
    end,
    use = function(self, card, area, copier)
        local highlighted = G.jokers.highlighted[1]

        if highlighted.config.center.tier >= card.ability.extra.upgrade_strength then
            local closed_portal = SMODS.add_card({ key = "c_aqu_closed_portal", area = G.consumeables })
            local option = pseudorandom("aqu_closed_portal_seed", 1, #aquill.closed_portal_options)
            local tab = aquill.closed_portal_options[option]

            closed_portal.ability.extra.next_tier = card.ability.extra.upgrade_strength + 1
            closed_portal.ability.extra.option = option
            closed_portal.ability.extra.max_counter = tab.max
            return
        end

        G.E_MANAGER:add_event(Event({
            func = function()
                aquill.upgrade_joker(highlighted)
                return true
            end
        }))

        if not aquill.corruption.enabled() then
            aquill.corruption.enable()
        else
            aquill.corruption.add_gain_multiplier(card.ability.extra.corruption_mult)
        end
    end,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {set = "Other", key = "enables_corruption"}
        local desc_key = aquill.corruption.enabled() and self.key .. "_used" or self.key .. "_first"
        local st = card.ability.extra.upgrade_strength
        if G.jokers then
            for _, joker in pairs(G.jokers.cards) do
                if joker.config.center.tier and joker.config.center.tier >= st then
                    desc_key = self.key .. "_blocked"
                    info_queue[#info_queue+1] = G.P_CENTERS.c_aqu_closed_portal
                end
            end
        end


        
        return {
            vars = {
                st,
                card.ability.extra.corruption_mult
                colours = { G.C["aqu_aquill_" .. (st * 2)] }
            },
            key = desc_key
        }
    end,
    config = { extra = { corruption_mult = 1.1, upgrade_strength = 3 } },
    hidden = true,
    soul_rate = 0.075,
    soul_set = "Tarot",
    in_pool = function(self, args)
        for _, joker in pairs(G.jokers.cards) do
            if joker.config.center.upgrade then
                return true
            end
        end
        return false --need an upgradable joker
    end,
    atlas = "generic_1",
    pos = {x=0, y=3},
}

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
