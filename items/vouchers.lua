SMODS.Voucher {
    key = "pyro_radioactive_plasma",
    atlas = "generic_1",
    pos = {x=1, y=2},
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {set = "Other", key = "enables_corruption"}
        return {vars = {card.ability.extra.corruption_increase, self:get_emult(card)}}
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {emult = self:get_emult(card)}
        end

        if context.after then
            aquill.corruption.modify(card.ability.extra.corruption_increase)
        end
    end,
    redeem = function(self, voucher)
        aquill.corruption.enable()
    end,
    config = {extra = {corruption_increase = 5, exponent = 1.1}},
    get_emult = function(self, card)
        local d = 0.05
        return to_big(G.GAME.upgraded_exponent+d):pow(card.ability.extra.exponent) - d
    end
}

SMODS.Voucher {
    key = "hybridized_uran_astatine",
    atlas = "generic_1",
    pos = {x=1, y=2},
    config = {extra = {log_base = 2}},
    requires = {"v_aqu_pyro_radioactive_plasma"},
    redeem = function(self, voucher)
        G.GAME.aqu_hua_base = voucher.ability.extra.log_base
        -- code in p_utils.lua : aquill.calc_upgraded_blind_size
    end
}

SMODS.Voucher {
    key = "neutronium_zero",
    atlas = "generic_1",
    pos = {x=1, y=2},
    requires = {"v_aqu_hybridized_uran_astatine"},
    calculate = function(self, card, context)
        if context.setting_upgraded_blind then
            add_tag(Tag(aquill.random_tag("aqu_neutronium_zero")))
        end
    end
}