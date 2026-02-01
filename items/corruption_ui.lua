function create_UIBox_corruption() -- base ui def
    local text_scale = 0.4

    local e = G.GAME.entropic_corruption_enabled
    local c = not e and G.C.UI.TEXT_LIGHT or (G.C.aqu_entropic_corruption)
    --we create dynatext here due to the limits of ui text elements
    --as they have no property for suffixes, which we need to display it as a percentage
    local dyna = DynaText {
        scale = text_scale * 0.9,
        bump = false,
        string = { {                                                          -- "x and y or z" functions identically do x ? y : z in other langs
            string = not e and localize("ph_aqu_corruption_disabled") or nil, --disabled? say disabled, no fuss
            ref_table = e and G.GAME or nil,                                  --otherwise we use the percentage
            ref_value = e and "entropic_corruption_percent" or nil,
            suffix = e and "%" or nil,                                        --dk if suffix works
        }, colour = c },
    }

    return {
        n = G.UIT.ROOT,
        config = { align = "cm", padding = 0.05, r = 0.01, colour = darken(G.C.UI.BACKGROUND_INACTIVE, 0.15), shadow = 0.1, hover = true, func = "hover_entropic_corruption", one_press = true },
        nodes = {
            {
                n = G.UIT.C,
                config = { padding = 0.1, colour = G.C.UI.BACKGROUND_INACTIVE, r = 0.01 },
                nodes = {
                    { n = G.UIT.R, nodes = { { n = G.UIT.T, config = { text = localize("ph_aqu_corruption"), colour = G.C.WHITE, scale = text_scale * 0.5 } } } },
                    { n = G.UIT.R, config = { align = "cm" },                                                                                                   nodes = { { n = G.UIT.O, config = { object = dyna, id = "percentage" } } } }
                }
            },
        }
    }
end

function create_UIBox_hover_corruption() -- hover ui def
    local text_scale = 0.3
    local text_col = G.C.UI.TEXT_DARK
    local times = 0
    local function t(text) -- just shorthand
        times = times + 1
        return DynaText({
            string = { { string = text, colour = text_col } },
            scale = text_scale,
            silent = true,
            pop_delay = 0,
            pop_in = 0.7 * math.floor((times - 1) / 2), --results in lines 1 & 2 popping in together, same with 3 & 4
            bump = true,
            bump_amount = 0.3,
            -- shadow = true,
        })
    end
    local node_list = {}
    local entries = localize("ph_aqu_corruption_desc")
    for _, entry in pairs(entries) do
        table.insert(node_list, { n = G.UIT.R, nodes = { { n = G.UIT.O, config = { object = t(entry) } }, } })
    end
    local split = {}
    local per_split = 2
    for i, entry in ipairs(node_list) do
        local spot = math.floor((i - 1) / per_split)
        split[spot] = split[spot] or {}
        table.insert(split[spot], entry)
    end
    local function gen_columns(all)
        local ret = {}

        for _, entry in pairs(all) do
            table.insert(ret,
                {
                    n = G.UIT.R,
                    config = { padding = 0.075, colour = HEX("FFFFFF"), r = 0.01 },
                    nodes = entry
                }
            )
        end
        -- 
        return ret
    end

    local ex = node_list[1]
    --
    --todo: try not to kill myself while making this properly display in seperate white boxes
    return {
        n = G.UIT.ROOT,
        config = { align = "cm", padding = 0.05, r = 0.01, colour = lighten(G.C.JOKER_GREY, 0.5), shadow = 0.05, },
        nodes = {
            {
                n = G.UIT.R,
                config = { colour = HEX("545D60"), padding = 0.03, r = 0.01 },
                nodes = {
                    {
                        n = G.UIT.C,
                        config = { padding = 0.085 },
                        nodes = gen_columns(split)
                    }
                }
            }

        }
    }
end
