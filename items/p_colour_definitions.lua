local t = 2 
local aquill_colours = {
    SMODS.Gradient {
        key = "aquill_1",
        colours = {
            G.C.GREY,
            lighten(G.C.BLUE,0.5)
        },
        cycle = t
    },
    SMODS.Gradient {
        key = "aquill_2",
        colours = {
            lighten(G.C.BLUE,0.5),
            lighten(G.C.BLUE,0.2)
        },
        cycle = t
    }, 
    SMODS.Gradient {
        key = "aquill_3",
        colours = {
            G.C.BLUE,
            lighten(G.C.PURPLE,0.5)
        },
        cycle = t
    }, 
    SMODS.Gradient {
        key = "aquill_4",
        colours = {
            lighten(G.C.PURPLE,0.5),
            lighten(G.C.PURPLE,0.2)
        },
        cycle = t
    },
    SMODS.Gradient {
        key = "aquill_5",
        colours = {
            G.C.PURPLE,
            lighten(G.C.PURPLE,0.2)
        },
        cycle = t
    }, 
    SMODS.Gradient {
        key = "aquill_6",
        colours = {
            G.C.PURPLE,
            G.C.BLUE,
            G.C.RED
        },
        cycle = t
    }, 
    SMODS.Gradient {
        key = "aquill_7",
        colours = {
            G.C.ORANGE,
            G.C.RED
        },
        cycle = t
    }, 
    SMODS.Gradient {
        key = "aquill_8",
        colours = {
            G.C.ORANGE,
            G.C.RED
        },
        cycle = t
    }, 
    SMODS.Gradient {
        key = "aquill_9",
        colours = {
            G.C.ORANGE,
            G.C.RED,
            G.C.YELLOW
        },
        cycle = t
    }, 
    SMODS.Gradient {
        key = "aquill_10",
        colours = { --roygbiv
            G.C.RED,
            G.C.ORANGE,
            G.C.YELLOW,
            G.C.GREEN,
            G.C.BLUE,
            G.C.PURPLE
        },
        cycle = t
    }, 
}
aquill.colours = aquill_colours

loc_colour()
for i,colour in pairs(aquill_colours) do
    G.ARGS.LOC_COLOURS[colour.key] = colour
    G.C[colour.key] = colour
end