
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


-- 从 init.lua 实际所在目录加载，兼容 ~/.hammerspoon/init.lua 为符号链接。
local initPath = hs.configdir .. "/init.lua"
local linkTarget = hs.fs.symlinkAttributes(initPath, "target")
if linkTarget then
  initPath = linkTarget:sub(1, 1) == "/" and linkTarget or hs.configdir .. "/" .. linkTarget
end
local configDirectory = initPath:match("^(.*)/[^/]+$")
local toast = dofile(configDirectory .. "/toast.lua")

-- 保留 Console 预览入口。
showToast = toast.show


-- AI 提示词快捷键仅允许在终端应用的前台窗口中执行。
local terminalShortcutApps = {
  ["com.onevcat.prowl"] = true,
  ["com.apple.Terminal"] = true,
  ["com.googlecode.iterm2"] = true,
  ["com.mitchellh.ghostty"] = true,
}

local function terminalShortcutWindow()
  local window = hs.window.focusedWindow()
  local app = hs.application.frontmostApplication()
  if not window or not app or not terminalShortcutApps[app:bundleID() or ""] then
    return nil
  end
  local windowApp = window:application()
  if not windowApp or windowApp:pid() ~= app:pid() then
    return nil
  end
  return window
end

local function pasteTerminalPrompt(window, content)
  hs.pasteboard.setContents(content)
  hs.eventtap.keyStroke({ "cmd" }, "v")
  hs.timer.doAfter(0.2, function()
    -- 等待粘贴期间若切换了窗口，不向新窗口发送回车。
    local currentWindow = terminalShortcutWindow()
    if currentWindow and currentWindow:id() == window:id() then
      hs.eventtap.keyStroke({}, "return")
    end
  end)
end


-- ==========================================
-- 飞书项目问题快捷粘贴
-- ==========================================

hs.hotkey.bind({ "ctrl", "shift", "alt", "cmd" }, "1", nil, function()
  local window = terminalShortcutWindow()
  if not window then
    return
  end

  local content = hs.pasteboard.getContents()
  local prefix = "https://project.feishu.cn/"

  if not content or content:sub(1, #prefix) ~= prefix then
    toast.show("无法在剪切板中获取飞书问题地址")
    return
  end

  pasteTerminalPrompt(window, content .. " Investigate and fix this issue.")
end)


-- ==========================================
-- PR 评论问题快捷粘贴
-- ==========================================

hs.hotkey.bind({ "ctrl", "shift", "alt", "cmd" }, "2", nil, function()
  local window = terminalShortcutWindow()
  if not window then
    return
  end

  local content = hs.pasteboard.getContents()
  local pattern = "^https://code%.fineres%.com/projects/[^/]+/repos/[^/]+/pull%-requests/%d+"
  local prAddress = content and content:match(pattern)
  local remainder = prAddress and content:sub(#prAddress + 1)

  if not prAddress or (remainder ~= "" and not remainder:match("^[/#?]")) then
    toast.show("无法在剪切板中获取 PR 地址")
    return
  end

  pasteTerminalPrompt(window, content .. " Review the PR comments, assess whether each issue is valid, and fix the valid issues. Explain any comments you disagree with.")
end)


-- ==========================================
-- 终端 AI 常用提示词快捷粘贴
-- ==========================================

local terminalPrompts = {
  ["3"] = "Review the current diff for bugs, edge cases, and regressions. Report findings before making changes.",
  ["4"] = "Run the relevant checks and tests. Fix any failures caused by these changes.",
  ["5"] = "Proceed with the proposed approach and verify the result.",
  ["6"] = "Yes, commit the changes and create a PR.",
}

for key, prompt in pairs(terminalPrompts) do
  hs.hotkey.bind({ "ctrl", "shift", "alt", "cmd" }, key, nil, function()
    local window = terminalShortcutWindow()
    if not window then
      return
    end

    pasteTerminalPrompt(window, prompt)
  end)
end


-- ==========================================
-- 初始化完成
-- ==========================================

hs.notify.show("Hammerspoon", "", "配置已加载")

print([[
========================================
Hammerspoon 配置加载成功

可用方法：
  updateSurgeProfile()  更新 Surge Managed Profile
  showToast("直接说")  预览底部胶囊提示

快捷键：
  Ctrl + Shift + Alt + Cmd + 1  粘贴飞书项目地址和问题处理指令
  Ctrl + Shift + Alt + Cmd + 2  粘贴 PR 地址和评论问题处理指令
  Ctrl + Shift + Alt + Cmd + 3  检查当前改动并报告问题
  Ctrl + Shift + Alt + Cmd + 4  验证修复并处理相关测试失败
  Ctrl + Shift + Alt + Cmd + 5  执行已确认的方案并验证结果
  Ctrl + Shift + Alt + Cmd + 6  终端中粘贴提交并创建 PR 指令

自动任务：
  每天 03:00          自动更新 Surge 配置

========================================
]])
