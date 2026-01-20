aquill.shader_stack = {}

---@class ShaderSend: table
---@field key string
---@field func? function
---@field value? number

---@class ShaderData: table
---@field key string
---@field send? ShaderSend[]|table
---@field should_apply? function

---@param args ShaderData
function aquill.add_screen_shader(args)
	assert(args.key, "Key not given for added screen shader")
	table.insert(aquill.shader_stack, args)
end

local resize_hook = love.resize
function love.resize(...)
    local ret = resize_hook(...)

    for _,shader in pairs(aquill.shader_stack) do
        shader.canvas = aquill.create_canvas()
        --if i don't do this, the shader will only apply to the smallest area which the game has been resized to
        -- e.g. resize to 100x100 and then back to 1920x1080, itll only apply to the 100x100 area in the center
    end
    return ret
end

SMODS.Shader {
	key = "example",
	path = "examplescreen.fs",
}
SMODS.Shader {
	key = "example2",
	path = "examplescreen2.fs",
}

--when rendering, crt intensity is multiplied by 0.3
-- this is used instead to shorten the crt recreation
local function getCRT() return G.SETTINGS.GRAPHICS.crt * 0.3 end


-- this is REQUIRED
-- due to some jank with shader-stacking, the CRT will not get drawn like it should. as such, the first screen shader to be applied is the CRT itself
aquill.add_screen_shader({key = "CRT", send = {
    {key = "distortion_fac", func = function()
        return {1.0 + 0.07*getCRT()/100, 1.0 + 0.1*getCRT()/100}
    end},
    {key = "scale_fac", func = function()
        return {1.0 - 0.008*getCRT()/100, 1.0 - 0.008*getCRT()/100}
    end},
    {key = "feather_fac", func = function()
        return 0.01 --can be done with value, not done here for consistency
    end},
    {key = "bloom_fac", func = function()
        return G.SETTINGS.GRAPHICS.bloom - 1
    end},
    {key = "time", func = function()
        return 400 + G.TIMERS.REAL
    end},
    {key = "noise_fac", func = function()
        return 0.001*getCRT()/100
    end},
    {key = "crt_intensity", func = function()
        return 0.16*getCRT()/100
    end},
    {key = "glitch_intensity", func = function()
        return 0 --ditto
    end},
    {key = "scanlines", func = function()
        return G.CANVAS:getPixelHeight()*0.75/G.CANV_SCALE
    end},
    {key = "mouse_screen_pos", func = function()
        return G.video_control and {love.graphics.getWidth()/2, love.graphics.getHeight()/2} or {G.ARGS.eased_cursor_pos.sx, G.ARGS.eased_cursor_pos.sy}
    end},
    {key = "screen_scale", func = function()
        return G.TILESCALE*G.TILESIZE
    end},
    {key = "hovering", func = function()
        return 1
    end},
}})

-- aquill.shader_stack[1].canvas = aquill.create_canvas()