-- ==========================================
-- 底部胶囊 Toast
-- ==========================================

local toast = {}

local toastCanvas = nil
local toastTimer = nil

local function clearToast()
  if toastTimer then
    toastTimer:stop()
    toastTimer = nil
  end
  if toastCanvas then
    toastCanvas:delete()
    toastCanvas = nil
  end
end

-- 显示提示；重复调用会替换当前提示。
function toast.show(message, duration)
  clearToast()
  duration = math.max(tonumber(duration) or 3, 0.8)
  local window = hs.window.focusedWindow()
  local screen = window and window:screen() or hs.screen.mainScreen()
  local bounds = screen:frame()
  local fontSize = 12
  local textStyle = {
    font = { name = "PingFangSC-Semibold", size = fontSize },
    color = { red = 0.9, green = 0.93, blue = 0.98, alpha = 1 },
  }
  -- 先生成 styledtext，测量和绘制复用同一个对象。
  -- getTextDrawingSize 的普通样式参数要求 font 为字符串。
  local text = hs.styledtext.new(message, textStyle)
  local textSize = hs.drawing.getTextDrawingSize(text)
  local width = math.min(math.max(textSize.w + 68, 180), bounds.w - 48)
  local height, padding = 42, 24
  local x = bounds.x + (bounds.w - width) / 2 - padding
  local y = bounds.y + bounds.h - height - 32 - padding
  local canvas = hs.canvas.new({ x = x, y = y + 22, w = width + padding * 2, h = height + padding * 2 })
  toastCanvas = canvas
  canvas:level("overlay")
  canvas:behaviorAsLabels({ "canJoinAllSpaces", "fullScreenAuxiliary", "stationary" })
  canvas:clickActivating(false)

  -- 多层柔光，避免硬边阴影。
  for i = 1, 5 do
    local spread = (6 - i) * 3
    canvas:appendElements({
      type = "rectangle", action = "stroke", strokeWidth = spread * 2,
      strokeColor = { red = 0.12, green = 0.48, blue = 1, alpha = 0.018 + i * 0.006 },
      roundedRectRadii = { xRadius = height / 2, yRadius = height / 2 },
      frame = { x = padding, y = padding, w = width, h = height },
    })
  end
  canvas:appendElements({
    type = "rectangle", action = "strokeAndFill", strokeWidth = 1.5,
    strokeColor = { red = 0.2, green = 0.59, blue = 1, alpha = 0.95 },
    fillGradient = "linear", fillGradientAngle = 90,
    fillGradientColors = {
      { red = 0.035, green = 0.045, blue = 0.065, alpha = 0.97 },
      { red = 0.09, green = 0.13, blue = 0.20, alpha = 0.97 },
    },
    roundedRectRadii = { xRadius = height / 2, yRadius = height / 2 },
    frame = { x = padding, y = padding, w = width, h = height },
  })
  -- 圆圈感叹号：三个图形一起轻晃，保持图标完整。
  local iconStart = canvas:elementCount() + 1
  local iconX, iconY = padding + 24, padding + height / 2
  local iconColor = { red = 1, green = 0.77, blue = 0.35, alpha = 1 }
  canvas:appendElements(
    {
      type = "oval", action = "strokeAndFill", strokeWidth = 1.1,
      strokeColor = iconColor,
      fillColor = { red = 1, green = 0.65, blue = 0.15, alpha = 0.08 },
      frame = { x = iconX - 8, y = iconY - 8, w = 16, h = 16 },
    },
    {
      type = "rectangle", action = "fill", fillColor = iconColor,
      roundedRectRadii = { xRadius = 1, yRadius = 1 },
      frame = { x = iconX - 0.8, y = iconY - 4.8, w = 1.6, h = 6.4 },
    },
    {
      type = "oval", action = "fill", fillColor = iconColor,
      frame = { x = iconX - 1, y = iconY + 3.2, w = 2, h = 2 },
    }
  )
  canvas:appendElements({
    type = "text", text = text,
    frame = { x = padding + 42, y = padding + (height - textSize.h) / 2,
      w = width - 58, h = textSize.h + 2 },
  })
  canvas:alpha(0):show()
  local started = hs.timer.secondsSinceEpoch()
  toastTimer = hs.timer.doEvery(1 / 30, function()
    local elapsed = hs.timer.secondsSinceEpoch() - started
    if elapsed >= duration then
      clearToast()
      return
    end
    local entrance = math.min(elapsed / 0.3, 1)
    local eased = 1 - (1 - entrance) ^ 3
    local exit = math.max(0, (elapsed - (duration - 0.35)) / 0.35)
    canvas:alpha(eased * (1 - exit))
    canvas:topLeft({ x = x, y = y + 22 * (1 - eased) + 10 * exit })
    canvas:elementAttribute(6, "strokeColor", {
      red = 0.2, green = 0.59, blue = 1, alpha = 0.75 + 0.2 * math.sin(elapsed * 4),
    })
    -- 每隔一段时间短暂左右晃动，带一点上下浮动。
    local shake = math.sin(elapsed * 24) * math.max(0, math.cos(elapsed * 3)) ^ 6 * 1.6
    local bob = math.sin(elapsed * 5)
    canvas:elementAttribute(iconStart, "frame", {
      x = iconX - 8 + shake, y = iconY - 8 + bob, w = 16, h = 16,
    })
    canvas:elementAttribute(iconStart + 1, "frame", {
      x = iconX - 0.8 + shake, y = iconY - 4.8 + bob, w = 1.6, h = 6.4,
    })
    canvas:elementAttribute(iconStart + 2, "frame", {
      x = iconX - 1 + shake, y = iconY + 3.2 + bob, w = 2, h = 2,
    })
  end)
end

-- 允许调用方提前关闭提示。
toast.clear = clearToast

return toast
