SMODS.Atlas {
    key = "lily",
    px = 71,
    py = 95,
    path = "lily.png",
}

SMODS.Joker {
    key = "lily",
    atlas = "lily",
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
    lily_card.states.drag.can = false
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
                config = { object = aquill.desc_dynatext("hi! i'm ") },
            }, {
                n = G.UIT.O,
                config = { object = aquill.desc_dynatext("Lily Felli", G.C.FILTER) },
            }, },
        },
        {
            n = G.UIT.R,
            config = {},
            nodes = { {
                n = G.UIT.O,
                config = { object = aquill.desc_dynatext("<- this is literally me") },
            }, },
        },
        aquill.ui.padding_row(text_height*0.5),
        {
            n = G.UIT.R,
            config = {},
            nodes = { {
                n = G.UIT.O,
                config = { object = aquill.desc_dynatext("i created all of Aquillarri") },
            }, },
        },
        {
            n = G.UIT.R,
            config = {},
            nodes = { {
                n = G.UIT.O,
                config = { object = aquill.desc_dynatext("including shaders, code, art") },
            }, },
        },
        aquill.ui.padding_row(text_height*0.5),
        {
            n = G.UIT.R,
            config = {},
            nodes = { {
                n = G.UIT.O,
                config = { object = aquill.desc_dynatext("except this card on the left.", nil, 0.9) },
            }, },
        },
        {
            n = G.UIT.R,
            config = {},
            nodes = { {
                n = G.UIT.O,
                config = { object = aquill.desc_dynatext("that was made by Camostar34!", nil, 0.9) },
            }, },
        },
    }

    local function genrows(list)
        local t = {}
        for _,entry in pairs(list) do
            table.insert(t,
                {
                    n = G.UIT.R,
                    config = {},
                    nodes = {{
                        n = G.UIT.O,
                        config = {object = aquill.desc_dynatext(entry), padding = 0.05},
                    },},
                }
            )
        end
        return t
    end

    local people = {
        {"cg223", "lord.ruby", "pangaea47", "notmario."},
        {"scraptake", "naoriley", "aikoyori", "mailingway"}
    }

    return {
        n = G.UIT.ROOT,
        config = { align = "cm", padding = 0.1, r = 0.1, colour = G.C.GREY },
        nodes = {
            {
                n = G.UIT.C,
                config = { align = "tm" },
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
                    aquill.ui.padding_row(text_height*0.5),
                    {
                        n = G.UIT.R,
                        config = {align = "cm"},
                        nodes = {
                            {
                                n = G.UIT.O,
                                config = { object = aquill.desc_dynatext("Inspirational People", G.C.FILTER, 1.25), align = "cm" },
                            },
                        },
                    },
                    {
                        n = G.UIT.R,
                        config = {align = "cm"},
                        nodes = {{
                            n = G.UIT.O,
                            config = {object = aquill.desc_dynatext("(to me, at least)", nil, 0.6)},
                        },},
                    },
                    aquill.ui.padding_row(text_height*0.75),
                    {
                        n = G.UIT.R,
                        config = {align = "cm"},
                        nodes = {
                            {
                                n = G.UIT.C,
                                config = {align = "cm"},
                                nodes = genrows(people[1]),
                            },
                            aquill.ui.padding_col(text_height),
                            {
                                n = G.UIT.C,
                                config = {align = "cm"},
                                nodes = genrows(people[2]),
                            },
                        },
                    },
                    aquill.ui.padding_row(text_height),
                    {
                        n = G.UIT.R,
                        config = {align = "cm"},
                        nodes = {{
                            n = G.UIT.O,
                            config = {object = aquill.desc_dynatext("and you!", G.C.aqu_aquill_10, 1.5)},
                        },},
                    },
                },
            },

        }
    }
end
