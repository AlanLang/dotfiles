-- 按 App 自动切换输入法
-- 切换到下表中的 App 时，自动把输入法切到指定的 source ID
-- 常用 ID：英文 "com.apple.keylayout.ABC"，Rime 鼠须管 "im.rime.inputmethod.Squirrel.Hans"，
-- 系统简体拼音 "com.apple.inputmethod.SCIM.ITABC"

local english = "com.apple.keylayout.ABC"
local chinese = "im.rime.inputmethod.Squirrel.Hans"

local inputSourceForApp = {
  ["com.onevcat.prowl"] = english,
  ["com.tencent.xinWeChat"] = chinese, -- 微信
  ["com.tencent.WeWorkMac"] = chinese, -- 企业微信
}

appInputWatcher = hs.application.watcher.new(function(_, eventType, app)
  if eventType ~= hs.application.watcher.activated then return end
  local target = inputSourceForApp[app:bundleID() or ""]
  if target and hs.keycodes.currentSourceID() ~= target then
    hs.keycodes.currentSourceID(target)
  end
end)
appInputWatcher:start()

hs.notify.show("Hammerspoon", "", "配置已加载")
