-- 按 App 自动切换输入法
-- 切换到下表中的 App 时，自动把输入法切到指定的 source ID
-- 常用 ID：英文 "com.apple.keylayout.ABC"，简体拼音 "com.apple.inputmethod.SCIM.ITABC"

local inputSourceForApp = {
  ["com.onevcat.prowl"] = "com.apple.keylayout.ABC",
  ["com.tencent.xinWeChat"] = "com.apple.inputmethod.SCIM.ITABC", -- 微信 → 中文
  ["com.tencent.WeWorkMac"] = "com.apple.inputmethod.SCIM.ITABC", -- 企业微信 → 中文
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
