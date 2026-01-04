

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
        local loc_vars_hook = self.loc_vars or function(s,iq,c) end
        self.loc_vars = function(selfcenter,info_queue,card)
            if selfcenter.upgrade then
                local upgrade = G.P_CENTERS[selfcenter.upgrade]
                info_queue[#info_queue+1] = {set = "Other", key = "aqu_upgrade", vars = {localize{set = upgrade.set, type = "name_text", key = upgrade.key}}}
            end
            local hooked_return = loc_vars_hook(selfcenter,info_queue,card) or {}
            hooked_return.vars = hooked_return.vars or {}
            return hooked_return
        end

        local in_pool_hook = self.in_pool or function(center, args) return true end

        self.in_pool = function(selfcenter,args)
            return in_pool_hook(selfcenter,args) and (not next(aquill.find_card_group(selfcenter.group))) --cannot spawn >1 of the same group by default
        end
        SMODS.Joker.register(self)
    end,
    discovered = true,
    unlocked = true,
}

aquill.upgrade_groups = {}

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
                -- print(joker)
                G.P_CENTERS[joker.key].upgrade = group[i+1].key
            end
        end
    end

    aquill.upgrade_groups = groups

    for _,card in pairs(G.P_CENTERS) do
        if card.tier and card.group then
            local entry = G.localization.descriptions[card.set][card.key] or ""
            entry.name = entry.name .. aquill.fancy_roman_numerals(card.tier)
            entry.name_parsed = {loc_parse_string(entry.name)}
        end
    end

    return return_value
end