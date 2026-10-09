-- ==========================================
-- 输入法自动切换
-- ==========================================

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


-- ==========================================
-- Surge Managed Profile 自动更新
-- ==========================================

local surgeTask

local function updateSurgeProfile()
  if surgeTask and surgeTask:isRunning() then return end

  surgeTask = hs.task.new(
    "/Applications/Surge.app/Contents/Applications/surge-cli",
    function(exitCode, stdout, stderr)
      if exitCode == 0 then
        print("[Surge] Profile updated successfully")
      else
        print("[Surge] Profile update failed: " .. stderr)
        hs.notify.show("Surge", "配置更新失败", stderr)
      end

      surgeTask = nil
    end,
    { "managed-profile", "update" }
  )

  if surgeTask then
    surgeTask:start()
  end
end

-- 每天凌晨 03:00 自动更新
surgeUpdateTimer = hs.timer.doAt("03:00", "1d", updateSurgeProfile)


-- ==========================================
-- 初始化完成
-- ==========================================

hs.notify.show("Hammerspoon", "", "配置已加载")
