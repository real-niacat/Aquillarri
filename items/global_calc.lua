function aquill.add_trigger(run_func) --used b/c adding a ton of stuff in global_calc.lua is unorganized
	table.insert(aquill.triggers, { trigger = run_func })
end

aquill.calculate = function(self, context)

    for _,trigger in pairs(aquill.triggers) do
        trigger.trigger(context)
    end

end
