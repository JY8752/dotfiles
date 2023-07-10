local timer    = require("hs.timer")
local eventtap = require("hs.eventtap")
local events   = eventtap.event.types
local module   = {}

-- double tap の間隔[s]
module.timeFrame = 1

-- toggle で kitty を表示/非表示する
module.action = function()
    local appName = "kitty"
    local app = hs.application.get(appName)

    if app == nil then
        hs.application.launchOrFocus(appName)
    elseif app:isFrontmost() then
        app:hide()
    else
        hs.application.launchOrFocus(appName)
    end
end


local timeFirstControl, firstDown, secondDown = 0, false, false
local noFlags = function(ev)
    local result = true
    for _, v in pairs(ev:getFlags()) do
        if v then
            result = false
            break
        end
    end
    return result
end


-- control だけが押されているか確認
local onlyCtrl = function(ev)
    local result = ev:getFlags().ctrl
    for k, v in pairs(ev:getFlags()) do
        if k ~= "ctrl" and v then
            result = false
            break
        end
    end
    return result
end


-- module.timeFrame 秒以内に 2 回 control を押した時に module.action を実行する
module.eventWatcher = eventtap.new({events.flagsChanged, events.keyDown}, function(ev)
    if (timer.secondsSinceEpoch() - timeFirstControl) > module.timeFrame then
        timeFirstControl, firstDown, secondDown = 0, false, false
    end

    if ev:getType() == events.flagsChanged then
        if noFlags(ev) and firstDown and secondDown then
            if module.action then module.action() end
            timeFirstControl, firstDown, secondDown = 0, false, false
        elseif onlyCtrl(ev) and not firstDown then
            firstDown = true
            timeFirstControl = timer.secondsSinceEpoch()
        elseif onlyCtrl(ev) and firstDown then
            secondDown = true
        elseif not noFlags(ev) then
            timeFirstControl, firstDown, secondDown = 0, false, false
        end
    else
        timeFirstControl, firstDown, secondDown = 0, false, false
    end
    return false
end):start()
