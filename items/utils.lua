function aquill.recalculate_joker_main()
    SMODS.calculate_context {
        joker_main = true,
        cardarea = G.jokers,
        full_hand = G.play.cards,
        scoring_hand = {},
        scoring_name = "",
        poker_hands = {}
    }
end

aquill.paths = {
    Scoring = 1,
    Economy = 2,
    Utility = 3,
    Upgrade = 4,
}

function aquill.can_upgrade(card, path)
    local cen = G.P_CENTERS[card.config.center_key]
    local scoring, economy, utility, upgrade = cen.scoring_upgrade, cen.economy_upgrade, cen.utility_upgrade, cen
    .upgrade
    return (path == aquill.paths.Scoring and scoring) or
        (path == aquill.paths.Economy and economy) or
        (path == aquill.paths.Utility and utility) or
        (path == aquill.paths.Upgrade and upgrade)
end

function aquill.upgrade_joker(card, path)
    if not aquill.can_upgrade(card, path) then return end
    local ability = nil
    local key = card.config.center_key
    if path == aquill.paths.Scoring then
        ability = G.P_CENTERS[key].scoring_upgrade
    end
    if path == aquill.paths.Economy then
        ability = G.P_CENTERS[key].economy_upgrade
    end
    if path == aquill.paths.Utility then
        ability = G.P_CENTERS[key].utility_upgrade
    end
    if path == aquill.paths.Upgrade then
        ability = G.P_CENTERS[key].upgrade
    end

    if ability then
        aquill.upgrade_joker_fx(card, ability)
    end
end

function aquill.upgrade_joker_fx(card, ability)
    G.E_MANAGER:add_event(Event({
        trigger = "immediate",
        func = function()
            card:juice_up(1, 1)
            play_sound("explosion_release1", 1, 3)
            card:set_ability(ability)
            return true
        end,
        delay = 1,
    }))
end

function aquill.lerp(a,b,t)
    return a + t * (b - a)
end

function aquill.lerp_mouse(pos, amount)
    local mouse_pos = {x=love.mouse.getX(), y=love.mouse.getY()}
    local new = {x=aquill.lerp(pos.x, mouse_pos.x, amount), y=aquill.lerp(pos.y, mouse_pos.y, amount)}
    love.mouse.setX(math.floor(new.x+0.5))
    love.mouse.setY(math.floor(new.y+0.5))
end

function Card:get_screen_coords()
    return {x=(self.T.x*100) + (self.T.w*25), y=(self.T.y*100) + (self.T.h*25)}
end

local upd = Card.update
function Card:update(dt)
    upd(self,dt)

    if self.gravitational_pull then
        aquill.lerp_mouse(self:get_screen_coords(), 1 - self.gravitational_pull)
    end
end