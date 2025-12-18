aquill.calculate = function(self, context)

    for _,trigger in pairs(aquill.triggers) do
        trigger.trigger(context)
    end


end
