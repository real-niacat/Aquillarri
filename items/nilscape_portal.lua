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

        if highlighted.config.center.tier == card.ability.extra.upgrade_strength then
            SMODS.add_card({ key = "c_aqu_closed_portal", area = G.consumeables })
            return
        end

        G.E_MANAGER:add_event(Event({
            func = function()
                aquill.upgrade_joker(highlighted)
                return true
            end
        }))
        G.GAME.dormant_exponent_gain = G.GAME.dormant_exponent_gain + card.ability.extra.exponent_increase

        if not aquill.corruption.enabled() then
            aquill.corruption.enable()
        else
            aquill.corruption.add_gain_multiplier(card.ability.extra.corruption_mult)
        end
    end,
    loc_vars = function(self, info_queue, card)
        local desc_key = aquill.corruption.enabled() and self.key .. "_used" or self.key .. "_first"
        if not aquill.corruption.allowed then
            desc_key = self.key .. "_no_corruption"
        end

        if G.jokers then
            for _, joker in pairs(G.jokers.cards) do
                if joker.config.center.tier >= card.ability.extra.upgrade_strength then
                    desc_key = self.key .. "_blocked"
                end
            end
        end


        local st = card.ability.extra.upgrade_strength
        return {
            vars = {
                nil, --load bearing nil
                card.ability.extra.exponent_increase,
                card.ability.extra.corruption_mult,
                st,
                st,
                colours = { G.C["aqu_aquill_" .. (st * 2)] }
            },
            key = desc_key
        }
    end,
    config = { extra = { exponent_increase = 0.03, corruption_mult = 1.1, upgrade_strength = 3 } },
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
    set_ability = function(self, card, initial, delay_sprites)
        if card.ability and card.ability.extra and G.GAME.consumeable_usage[self.key] then
            card.ability.extra.exponent_increase = card.ability.extra.exponent_increase /
                math.sqrt(G.GAME.consumeable_usage[self.key].count)
            card.ability.extra.exponent_increase = aquill.round_to_nearest(card.ability.extra.exponent_increase, 0.0001)
        end
    end,
}

--to future me, add a system to pull this into your consumables and add a goal/cost to allow for upgrading to t4/5. t2-3 are still free (albiet with downsides)

SMODS.Consumable {
    key = "closed_portal",
    set = "Spectral",
    in_pool = function() return false end
}
