aquill.calculate = function(self, context)
    if context.end_of_round and context.main_eval then
        G.GAME.dormant_blind = false
        G.GAME.dormant_rarity_exponent = 1.1 + (G.GAME.round_resets.ante * 0.1)
    end

    if context.setting_blind and G.GAME.dormant_blind then
        G.E_MANAGER:add_event(Event({
            func = function()
                G.GAME.blind.chips = aquill.calc_dormant_blind_size(G.GAME.blind.chips)
                G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
                G.HUD_blind:recalculate()
                
                G.GAME.blind.dollars = G.GAME.blind.dollars
                G.GAME.blind.loc_name = G.GAME.blind.loc_name .. "+"
                
                G.E_MANAGER:add_event(Event({
                    func = function()
                        G.hand_text_area.blind_chips:juice_up()
                        G.HUD_blind:get_UIE_by_ID("dollars_to_be_earned"):juice_up(7)
                        return true
                    end
                }))
                return true
            end
        }))
    end
end
