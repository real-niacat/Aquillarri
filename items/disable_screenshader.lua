local register_hook = SMODS.ScreenShader.register
function SMODS.ScreenShader.register(self)
    local should_apply_hook = self.should_apply or function() return true end
    self.should_apply = function(s)
        return should_apply_hook(s) and (not aquill.config.disable_screenshader)
    end
    return register_hook(self)
end