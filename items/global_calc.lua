aquill.calculate = function(self, context)
    if context.end_of_round and context.main_eval then
        G.GAME.dormant_blind = false
        G.GAME.dormant_rarity_exponent = G.GAME.dormant_rarity_exponent and (G.GAME.dormant_rarity_exponent+0.05) or 1.05
    end

    if context.setting_blind and G.GAME.dormant_blind then
        G.E_MANAGER:add_event(Event({
            func = function()
                G.GAME.blind.chips = G.GAME.blind.chips^G.GAME.dormant_exponent
                G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
                G.HUD_blind:recalculate()
                G.hand_text_area.blind_chips:juice_up()
                G.GAME.blind.dollars = G.GAME.blind.dollars + 4
                G.HUD_blind:get_UIE_by_ID("dollars_to_be_earned"):juice_up(7)
                return true
            end
        }))
        
    end
end
