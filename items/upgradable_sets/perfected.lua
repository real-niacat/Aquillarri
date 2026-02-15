aquill.Upgradable {
    tier = 1,
    group = "perf",
    calculate = function(self, card, context)
        if context.press_play then
            local pcard = SMODS.add_card({ area = G.play, set = "Enhanced", edition = "e_aqu_ephemeral" })
            pcard.from_perf = true
            pcard:start_materialize()
        end
    end,
    config = { extra = {} },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.e_aqu_ephemeral
        return {
            vars = {

            }
        }
    end,
}

aquill.Upgradable {
    tier = 2,
    group = "perf",
    calculate = function(self, card, context)
        if context.press_play then
            local pcard = SMODS.add_card({ area = G.play, set = "Enhanced", edition = "e_aqu_ephemeral" })
            pcard.from_perf = true
            pcard:start_materialize()
            local hcard = SMODS.add_card({ area = G.hand, set = "Enhanced", edition = "e_aqu_ephemeral" })
            hcard.from_perf = true
            hcard:start_materialize()
        end
    end,
    config = { extra = {} },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.e_aqu_ephemeral
        return {
            vars = {

            }
        }
    end,
}

aquill.Upgradable {
    tier = 3,
    group = "perf",
    calculate = function(self, card, context)
        if context.press_play then
            local pcard = SMODS.add_card({ area = G.play, set = "Enhanced", edition = "e_aqu_ephemeral" })
            pcard.from_perf = true
            pcard:start_materialize()
            local hcard = SMODS.add_card({ area = G.hand, set = "Enhanced", edition = "e_aqu_ephemeral" })
            hcard.from_perf = true
            hcard:start_materialize()
        end

        if context.before then
            local to_enhance = context.full_hand[#context.full_hand]
            if to_enhance then
                G.E_MANAGER:add_event(Event({
                    trigger = 'immediate',
                    func = function()
                        to_enhance:set_ability(SMODS.poll_enhancement({ guaranteed = true }))
                        to_enhance:juice_up()
                        return true
                    end
                }))
            end
        end
    end,
    config = { extra = {} },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.e_aqu_ephemeral
        return {
            vars = {

            }
        }
    end,
}

aquill.Upgradable {
    tier = 4,
    group = "perf",
    calculate = function(self, card, context)
        if context.press_play then
            local pcard = SMODS.add_card({ area = G.play, set = "Enhanced", edition = "e_aqu_ephemeral" })
            pcard.from_perf = true
            pcard:start_materialize()
            local hcard = SMODS.add_card({ area = G.hand, set = "Enhanced", edition = "e_aqu_ephemeral" })
            hcard.from_perf = true
            hcard:start_materialize()

            for _,playing_card in pairs(G.hand.highlighted) do
                local copy = copy_card(playing_card)
                copy:add_to_deck()
                copy:set_edition("e_aqu_ephemeral", true, true)
                copy:start_materialize()
                G.play:emplace(copy)
            end
        end

        if context.before then
            for _, to_enhance in pairs(context.full_hand) do
                G.E_MANAGER:add_event(Event({
                    trigger = 'immediate',
                    func = function()
                        if next(SMODS.get_enhancements(to_enhance)) then
                            return true
                        end
                        to_enhance:set_ability(SMODS.poll_enhancement({ guaranteed = true }))
                        to_enhance:juice_up()
                        return true
                    end
                }))
            end
        end
    end,
    config = { extra = {} },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.e_aqu_ephemeral
        return {
            vars = {

            }
        }
    end,
}

aquill.Upgradable {
    tier = 5,
    group = "perf",
    calculate = function(self, card, context)
        if context.press_play then
            for i=1,3 do
                local pcard = SMODS.add_card({ area = G.play, set = "Enhanced", edition = "e_aqu_ephemeral" })
                pcard.from_perf = true
                pcard:start_materialize()
            end

            for _,playing_card in pairs(G.hand.highlighted) do
                local copy = copy_card(playing_card)
                copy:add_to_deck()
                copy:set_edition("e_aqu_ephemeral", true, true)
                copy:start_materialize()
                G.play:emplace(copy)
            end

            for _,playing_card in pairs(aquill.remove_elements(G.hand.cards, G.hand.highlighted)) do
                local copy = copy_card(playing_card)
                copy:add_to_deck()
                copy:set_edition("e_aqu_ephemeral", true, true)
                copy:start_materialize()
                G.hand:emplace(copy)
            end
        end

        if context.before then
            for _, to_enhance in pairs(context.full_hand) do
                G.E_MANAGER:add_event(Event({
                    trigger = 'immediate',
                    func = function()
                        if next(SMODS.get_enhancements(to_enhance)) then
                            return true
                        end
                        to_enhance:set_ability(SMODS.poll_enhancement({ guaranteed = true }))
                        to_enhance:juice_up()
                        return true
                    end
                }))
            end
        end
    end,
    config = { extra = {} },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.e_aqu_ephemeral
        return {
            vars = {

            }
        }
    end,
}
