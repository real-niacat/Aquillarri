SMODS.Atlas {
    key = "lily",
    px = 71,
    py = 95,
    path = "lily.png",
}

SMODS.Joker {
    key = "lily",
    atlas = "lily",
    soul_pos = { x = 1, y = 0 },
    update = function(self, card, dt)
        if card.area and (not card.area.config.collection) then
            card:remove()
        end
    end,
    discovered = true,
    unlocked = true,
    no_collection = true
}

local text_height = 0.4

function aquill.desc_dynatext(text, col, scalemult)
    return DynaText {
        string = { { string = text, colour = col or G.C.UI.TEXT_LIGHT } },
        scale = 0.4 * (scalemult or 1),
        shadow = true
    }
end

function aquill.ui.padding_row(pad)
    return { n = G.UIT.R, config = { padding = pad } }
end

function aquill.ui.padding_col(pad)
    return { n = G.UIT.C, config = { padding = pad } }
end

function aquill.ui.credit()
    local area = false
    local center = G.P_CENTERS.j_aqu_lily
    center.alerted = true

    local lily_card = Card(0, 0, G.CARD_W, G.CARD_H, nil, center)
    lily_card.no_ui = true
    local lily_area = nil

    if area then
        local config = { card_limit = 1, type = 'title', highlight_limit = 0, collection = true }
        lily_area = CardArea(0, 0, G.CARD_W, G.CARD_H, config)
        lily_area:emplace(lily_card)
    end

    local strs = localize("ph_aqu_bio")

    local bio_texts = {
        {
            n = G.UIT.R,
            config = {},
            nodes = { {
                n = G.UIT.O,
                config = { object = aquill.desc_dynatext(strs[1]) },
            }, {
                n = G.UIT.O,
                config = { object = aquill.desc_dynatext(strs[2], G.C.FILTER) },
            }, },
        },
        {
            n = G.UIT.R,
            config = {},
            nodes = { {
                n = G.UIT.O,
                config = { object = aquill.desc_dynatext(strs[3]) },
            }, },
        },
        {
            n = G.UIT.R,
            config = {},
            nodes = { {
                n = G.UIT.O,
                config = { object = aquill.desc_dynatext(strs[4]) },
            }, },
        },
        aquill.ui.padding_row(text_height),
        {
            n = G.UIT.R,
            config = {},
            nodes = { {
                n = G.UIT.O,
                config = { object = aquill.desc_dynatext(strs[5], nil, 0.7) },
            }, },
        },
        aquill.ui.padding_row(text_height),
        {
            n = G.UIT.R,
            config = {},
            nodes = { {
                n = G.UIT.O,
                config = { object = aquill.desc_dynatext(strs[6], nil, 0.7) },
            }, },
        },
        {
            n = G.UIT.R,
            config = {},
            nodes = { {
                n = G.UIT.O,
                config = { object = aquill.desc_dynatext(strs[7], nil, 0.7) },
            }, },
        },
    }

    return {
        n = G.UIT.ROOT,
        config = { align = "cm", padding = 0.1, r = 0.1, colour = G.C.GREY },
        nodes = {
            {
                n = G.UIT.R,
                config = {},
                nodes = {
                    {
                        n = G.UIT.O,
                        config = { object = area and lily_area or lily_card },
                    },
                    {
                        n = G.UIT.C,
                        config = {},
                        nodes = bio_texts,
                    }
                },
            },
            
        }
    }
end
