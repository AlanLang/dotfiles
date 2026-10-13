
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
  local currentWindow = terminalShortcutWindow()
  if not currentWindow or currentWindow:id() ~= window:id() then
    toast.show("原终端窗口未获得焦点，请重新触发快捷键")
    return
  end
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

-- 在此维护选择列表：text 为名称，description 为说明，prompt 为实际发送的提示词。
local terminalPrompts = {
  {
    text = "检查当前改动",
    description = "检查缺陷、边界情况和回归，先报告发现",
    prompt = "Review the current diff for bugs, edge cases, and regressions. Report findings before making changes.",
  },
  {
    text = "运行检查和测试",
    description = "运行相关检查与测试，修复改动引起的失败",
    prompt = "Run the relevant checks and tests. Fix any failures caused by these changes.",
  },
  {
    text = "执行方案并验证",
    description = "执行已确认的方案，并验证结果",
    prompt = "Proceed with the proposed approach and verify the result.",
  },
  {
    text = "提交并创建 PR",
    description = "提交当前改动，并创建 Pull Request",
    prompt = "Yes, commit the changes and create a PR.",
  },
}

-- 复用 Toast 的冷白文字与蓝色调；提示词单独保存，避免发送 styledtext。
local promptChoices = {}
for _, item in ipairs(terminalPrompts) do
  table.insert(promptChoices, {
    text = hs.styledtext.new(item.text, {
      font = { name = "PingFangSC-Semibold", size = 13 },
      color = { red = 0.9, green = 0.93, blue = 0.98, alpha = 1 },
    }),
    subText = hs.styledtext.new(item.description, {
      font = { name = "PingFangSC-Regular", size = 11 },
      color = { red = 0.45, green = 0.68, blue = 0.9, alpha = 1 },
    }),
    prompt = item.prompt,
  })
end

local promptTargetWindow
local promptChooser = hs.chooser.new(function(choice)
  local window = promptTargetWindow
  promptTargetWindow = nil
  if not choice or not window then
    return
  end

  -- 选择器关闭后会恢复原窗口焦点，稍等再粘贴并核对窗口。
  hs.timer.doAfter(0.1, function()
    pasteTerminalPrompt(window, choice.prompt)
  end)
end)
promptChooser:choices(promptChoices)
promptChooser:bgDark(true)
promptChooser:fgColor({ red = 0.9, green = 0.93, blue = 0.98, alpha = 1 })
promptChooser:subTextColor({ red = 0.45, green = 0.68, blue = 0.9, alpha = 1 })
promptChooser:placeholderText("搜索提示词 · ↑↓ 选择 · ↵ 发送 · Esc 取消")
promptChooser:searchSubText(true)
promptChooser:rows(#terminalPrompts)
promptChooser:width(32)

local function chooseTerminalPrompt(window)
  promptTargetWindow = window
  promptChooser:query("")
  promptChooser:show()
end


-- ==========================================
-- 根据剪贴板内容选择 AI 提示词
-- ==========================================

hs.hotkey.bind({ "ctrl", "shift", "alt", "cmd" }, "1", nil, function()
  local window = terminalShortcutWindow()
  if not window then
    return
  end

  local content = (hs.pasteboard.getContents() or ""):match("^%s*(.-)%s*$")
  local prompt
  local pattern = "^https://code%.fineres%.com/projects/[^/]+/repos/[^/]+/pull%-requests/%d+"
  local prAddress = content:match(pattern)
  local remainder = prAddress and content:sub(#prAddress + 1)

  if content:match("^https://project%.feishu%.cn/%S+$") then
    prompt = "Investigate and fix this issue."
  elseif prAddress and (remainder == "" or remainder:match("^[/#?]%S*$")) then
    prompt = "Review the PR comments, assess whether each issue is valid, and fix the valid issues. Explain any comments you disagree with."
  elseif content:match("^[A-Za-z]%-%d%d%d%d%d%d%d%d%d%d$") then
    prompt = "提交并创建pr"
  else
    chooseTerminalPrompt(window)
    return
  end

  pasteTerminalPrompt(window, content .. " " .. prompt)
end)


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
  Ctrl + Shift + Alt + Cmd + 1  根据剪贴板内容粘贴对应指令
    飞书项目链接              调查并修复问题
    PR 地址                   评估评论并修复有效问题
    字母-10位数字             提交并创建pr
    其他内容或空剪贴板        打开常用提示词选择列表

自动任务：
  每天 03:00          自动更新 Surge 配置

========================================
]])
