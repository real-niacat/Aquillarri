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
                return true
            end
        }))
        
    end
end
