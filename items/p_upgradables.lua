

aquill.Upgradable = SMODS.Joker:extend {
    required_params = {
        "tier",
        "group"
    },
    register = function(self)
        local rarities = {
            "aqu_dormant",
            "aqu_hyper",
            "aqu_hyperplus",
            "aqu_hyperplusplus",
            "aqu_extreme"
        }
        -- print(self)
        self.rarity = rarities[self.tier]
        self.key = self.class_prefix .. "_" .. self.mod.prefix .. "_" .. self.group .. self.tier
        self.cost = 5 * (2 ^ self.tier)
        local loc_vars_hook = self.loc_vars
        self.loc_vars = function(self,info_queue,card)
            if self.upgrade then
                local upgrade = G.P_CENTERS[self.upgrade]
                info_queue[#info_queue+1] = {set = "Other", key = "aqu_upgrade", vars = {localize{set = upgrade.set, type = "name_text", key = upgrade.key}}}
            end
            return loc_vars_hook(self,info_queue,card)
        end

        local in_pool_hook = self.in_pool

        self.in_pool = function(self,args)
            return in_pool_hook(self,args) and (not aquill.find_card_group(self.group)) --cannot spawn >1 of the same group by default
        end
        SMODS.Joker.register(self)
    end,
    discovered = true,
    unlocked = true,
}

local inject_hook = SMODS.injectItems
function SMODS.injectItems(...)
    local return_value = inject_hook(...)
    local groups = {}

    for key,joker in pairs(G.P_CENTER_POOLS.Joker) do
        if joker.group and joker.tier then
            groups[joker.group] = groups[joker.group] or {}
            groups[joker.group][joker.tier] = {key = joker.key, tier = joker.tier}
        end
    end

    for _,group in pairs(groups) do
        for i,joker in ipairs(group) do
            if group[i+1] then
                print(joker)
                G.P_CENTERS[joker.key].upgrade = group[i+1].key
            end
        end
    end


    return return_value
end