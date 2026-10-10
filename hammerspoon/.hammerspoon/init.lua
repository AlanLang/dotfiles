
-- ==========================================
-- 按 App 自动切换输入法
-- ==========================================

local english = "com.apple.keylayout.ABC"
local chinese = "im.rime.inputmethod.Squirrel.Hans"

local inputSourceForApp = {
  ["com.onevcat.prowl"] = english,
  ["com.mitchellh.ghostty"] = english,
  ["com.tencent.xinWeChat"] = chinese, -- 微信
  ["com.tencent.WeWorkMac"] = chinese, -- 企业微信
}

appInputWatcher = hs.application.watcher.new(function(_, eventType, app)
  if eventType ~= hs.application.watcher.activated or not app then
    return
  end

  local target = inputSourceForApp[app:bundleID() or ""]
  if target and hs.keycodes.currentSourceID() ~= target then
    hs.keycodes.currentSourceID(target)
  end
end)

appInputWatcher:start()


-- ==========================================
-- Surge Managed Profile 自动更新
-- ==========================================

local surgeCLI = "/Applications/Surge.app/Contents/Applications/surge-cli"
local surgeTask = nil

-- 全局方法，支持 Console 手动调用
function updateSurgeProfile()
  -- 防止重复执行
  if surgeTask then
    print("[Surge] Update already running")
    return
  end

  surgeTask = hs.task.new(
    surgeCLI,
    function(exitCode, stdout, stderr)
      if exitCode == 0 then
        print("[Surge] Profile update succeeded")
        if stdout and stdout ~= "" then
          print(stdout)
        end
      else
        local message = stderr or "Unknown error"
        print("[Surge] Profile update failed: " .. message)
        hs.notify.show("Surge", "配置更新失败", message)
      end

      surgeTask = nil
    end,
    { "managed-profile", "update" }
  )

  if not surgeTask or not surgeTask:start() then
    print("[Surge] Failed to start update task")
    surgeTask = nil
    hs.notify.show("Surge", "配置更新失败", "无法启动更新任务")
  end
end

-- 每天凌晨 03:00 自动更新
surgeUpdateTimer = hs.timer.doAt("03:00", "1d", updateSurgeProfile)


-- ==========================================
-- 初始化完成
-- ==========================================

hs.notify.show("Hammerspoon", "", "配置已加载")

print([[
========================================
Hammerspoon 配置加载成功

可用方法：
  updateSurgeProfile()  更新 Surge Managed Profile

自动任务：
  每天 03:00          自动更新 Surge 配置

========================================
]])
