-- Services
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local localPlayer = Players.LocalPlayer
local playerGui = localPlayer:WaitForChild("PlayerGui")

-- ============================================================
-- DUPLICATE PREVENTION
-- ============================================================
local TAG = "GlacierClient_Running"
if _G[TAG] then
    if _G[TAG].gui and _G[TAG].gui.Parent then
        _G[TAG].gui:Destroy()
    end
end
local glacierInstance = {}
_G[TAG] = glacierInstance

-- ============================================================
-- CONFIG
-- ============================================================
local KEY_URL = "https://pastebin.com/raw/xgTrvLZG"
local chamsKeybind = Enum.KeyCode.X

-- ============================================================
-- MAIN GUI
-- ============================================================
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "GlacierClient"
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.Parent = playerGui
glacierInstance.gui = screenGui

-- ============================================================
-- JARVIS STARTUP ANIMATION
-- ============================================================
local jarvisGui = Instance.new("Frame")
jarvisGui.Size = UDim2.new(1, 0, 1, 0)
jarvisGui.BackgroundColor3 = Color3.fromRGB(0, 5, 15)
jarvisGui.BackgroundTransparency = 0
jarvisGui.BorderSizePixel = 0
jarvisGui.ZIndex = 100
jarvisGui.Parent = screenGui

local scanline = Instance.new("Frame")
scanline.Size = UDim2.new(1, 0, 0, 2)
scanline.BackgroundColor3 = Color3.fromRGB(100, 200, 255)
scanline.BackgroundTransparency = 0.6
scanline.BorderSizePixel = 0
scanline.Position = UDim2.new(0, 0, 0, 0)
scanline.ZIndex = 101
scanline.Parent = jarvisGui

local function makeCornerBracket(parent, anchorX, anchorY, offsetX, offsetY)
    local flipH = anchorX == 1 and -1 or 1
    local flipV = anchorY == 1 and -1 or 1
    local h = Instance.new("Frame")
    h.Size = UDim2.new(0, 40, 0, 2)
    h.Position = UDim2.new(anchorX, offsetX, anchorY, offsetY)
    h.AnchorPoint = Vector2.new(anchorX, anchorY)
    h.BackgroundColor3 = Color3.fromRGB(100, 200, 255)
    h.BackgroundTransparency = 0.2
    h.BorderSizePixel = 0
    h.ZIndex = 102
    h.Parent = parent
    local v = Instance.new("Frame")
    v.Size = UDim2.new(0, 2, 0, 40)
    v.Position = UDim2.new(anchorX, offsetX, anchorY, offsetY)
    v.AnchorPoint = Vector2.new(anchorX, anchorY)
    v.BackgroundColor3 = Color3.fromRGB(100, 200, 255)
    v.BackgroundTransparency = 0.2
    v.BorderSizePixel = 0
    v.ZIndex = 102
    v.Parent = parent
end
makeCornerBracket(jarvisGui, 0, 0, 20, 20)
makeCornerBracket(jarvisGui, 1, 0, -20, 20)
makeCornerBracket(jarvisGui, 0, 1, 20, -20)
makeCornerBracket(jarvisGui, 1, 1, -20, -20)

local jarvisLogo = Instance.new("TextLabel")
jarvisLogo.Size = UDim2.new(0, 400, 0, 60)
jarvisLogo.Position = UDim2.new(0.5, -200, 0.5, -120)
jarvisLogo.BackgroundTransparency = 1
jarvisLogo.Text = "❄ GLACIER"
jarvisLogo.TextColor3 = Color3.fromRGB(100, 200, 255)
jarvisLogo.TextSize = 42
jarvisLogo.Font = Enum.Font.GothamBold
jarvisLogo.TextTransparency = 1
jarvisLogo.ZIndex = 102
jarvisLogo.Parent = jarvisGui

local jarvisSubtitle = Instance.new("TextLabel")
jarvisSubtitle.Size = UDim2.new(0, 400, 0, 30)
jarvisSubtitle.Position = UDim2.new(0.5, -200, 0.5, -55)
jarvisSubtitle.BackgroundTransparency = 1
jarvisSubtitle.Text = "ADVANCED COMBAT SUITE"
jarvisSubtitle.TextColor3 = Color3.fromRGB(150, 220, 255)
jarvisSubtitle.TextSize = 14
jarvisSubtitle.Font = Enum.Font.GothamBold
jarvisSubtitle.TextTransparency = 1
jarvisSubtitle.ZIndex = 102
jarvisSubtitle.Parent = jarvisGui

local statusLines = {
    "INITIALIZING SYSTEMS...",
    "LOADING COMBAT PROTOCOLS...",
    "CALIBRATING TARGETING...",
    "ESTABLISHING CONNECTION...",
    "ALL SYSTEMS ONLINE.",
}
local statusLabels = {}
for i, text in ipairs(statusLines) do
    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(0, 400, 0, 20)
    lbl.Position = UDim2.new(0.5, -200, 0.5, -15 + (i - 1) * 22)
    lbl.BackgroundTransparency = 1
    lbl.Text = "> " .. text
    lbl.TextColor3 = Color3.fromRGB(80, 180, 255)
    lbl.TextSize = 12
    lbl.Font = Enum.Font.GothamBold
    lbl.TextTransparency = 1
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.ZIndex = 102
    lbl.Parent = jarvisGui
    statusLabels[i] = lbl
end

local jarvisProgressBg = Instance.new("Frame")
jarvisProgressBg.Size = UDim2.new(0, 400, 0, 3)
jarvisProgressBg.Position = UDim2.new(0.5, -200, 0.5, 120)
jarvisProgressBg.BackgroundColor3 = Color3.fromRGB(20, 40, 60)
jarvisProgressBg.BorderSizePixel = 0
jarvisProgressBg.ZIndex = 102
jarvisProgressBg.Parent = jarvisGui

local jarvisProgressFill = Instance.new("Frame")
jarvisProgressFill.Size = UDim2.new(0, 0, 1, 0)
jarvisProgressFill.BackgroundColor3 = Color3.fromRGB(100, 200, 255)
jarvisProgressFill.BorderSizePixel = 0
jarvisProgressFill.ZIndex = 103
jarvisProgressFill.Parent = jarvisProgressBg

local jarvisProgressLabel = Instance.new("TextLabel")
jarvisProgressLabel.Size = UDim2.new(0, 400, 0, 20)
jarvisProgressLabel.Position = UDim2.new(0.5, -200, 0.5, 128)
jarvisProgressLabel.BackgroundTransparency = 1
jarvisProgressLabel.Text = "0%"
jarvisProgressLabel.TextColor3 = Color3.fromRGB(100, 200, 255)
jarvisProgressLabel.TextSize = 11
jarvisProgressLabel.Font = Enum.Font.GothamBold
jarvisProgressLabel.TextTransparency = 1
jarvisProgressLabel.TextXAlignment = Enum.TextXAlignment.Left
jarvisProgressLabel.ZIndex = 102
jarvisProgressLabel.Parent = jarvisGui

local function typewrite(label, text, speed)
    label.Text = ""
    label.TextTransparency = 0
    for i = 1, #text do
        label.Text = string.sub(text, 1, i)
        task.wait(speed)
    end
end

local function runJarvisAnimation(onComplete)
    task.spawn(function()
        -- Scanline sweep down
        for i = 0, 100 do
            scanline.Position = UDim2.new(0, 0, i / 100, 0)
            task.wait(0.008)
        end
        task.wait(0.1)

        -- Fade in logo
        for i = 1, 10 do
            jarvisLogo.TextTransparency = 1 - (i / 10)
            task.wait(0.04)
        end
        task.wait(0.15)

        -- Fade in subtitle
        for i = 1, 10 do
            jarvisSubtitle.TextTransparency = 1 - (i / 10)
            task.wait(0.03)
        end
        task.wait(0.2)

        jarvisProgressLabel.TextTransparency = 0

        -- Typewrite status lines with progress bar
        for i, lbl in ipairs(statusLabels) do
            typewrite(lbl, "> " .. statusLines[i], 0.025)
            local startPct = (i - 1) / #statusLines
            local endPct = i / #statusLines
            for s = 1, 20 do
                local pct = startPct + (endPct - startPct) * (s / 20)
                jarvisProgressFill.Size = UDim2.new(pct, 0, 1, 0)
                jarvisProgressLabel.Text = math.floor(pct * 100) .. "%"
                task.wait(0.012)
            end
            task.wait(0.08)
        end

        task.wait(0.4)

        -- Flash
        for i = 1, 3 do
            jarvisGui.BackgroundTransparency = 0.6
            task.wait(0.05)
            jarvisGui.BackgroundTransparency = 0
            task.wait(0.05)
        end
        task.wait(0.2)

        -- Fade out
        for i = 1, 20 do
            local t = i / 20
            jarvisGui.BackgroundTransparency = t
            jarvisLogo.TextTransparency = t
            jarvisSubtitle.TextTransparency = t
            jarvisProgressLabel.TextTransparency = t
            jarvisProgressFill.BackgroundTransparency = t
            for _, lbl in ipairs(statusLabels) do
                lbl.TextTransparency = t
            end
            task.wait(0.03)
        end

        jarvisGui:Destroy()
        onComplete()
    end)
end

-- ============================================================
-- BACKDROP + KEY CARD
-- ============================================================
local backdrop = Instance.new("Frame")
backdrop.Size = UDim2.new(1, 0, 1, 0)
backdrop.BackgroundColor3 = Color3.fromRGB(0, 5, 15)
backdrop.BackgroundTransparency = 0.25
backdrop.BorderSizePixel = 0
backdrop.Visible = false
backdrop.Parent = screenGui

local card = Instance.new("Frame")
card.Size = UDim2.new(0, 300, 0, 220)
card.Position = UDim2.new(0.5, -150, 0.5, -110)
card.BackgroundColor3 = Color3.fromRGB(4, 10, 22)
card.BorderSizePixel = 0
card.Visible = false
card.Parent = screenGui
Instance.new("UICorner", card).CornerRadius = UDim.new(0, 6)

local cardStroke = Instance.new("UIStroke", card)
cardStroke.Color = Color3.fromRGB(0, 160, 220)
cardStroke.Thickness = 1

-- Corner bracket accents on key card
local function cardCorner(px, py, ox, oy, flipH, flipV)
    local h = Instance.new("Frame")
    h.Size = UDim2.new(0, 14, 0, 2)
    h.Position = UDim2.new(px, ox + (flipH and -14 or 0), py, oy)
    h.BackgroundColor3 = Color3.fromRGB(0, 180, 255)
    h.BackgroundTransparency = 0.2
    h.BorderSizePixel = 0
    h.ZIndex = 5
    h.Parent = card
    local v = Instance.new("Frame")
    v.Size = UDim2.new(0, 2, 0, 14)
    v.Position = UDim2.new(px, ox + (flipH and -2 or 0), py, oy + (flipV and -14 or 0))
    v.BackgroundColor3 = Color3.fromRGB(0, 180, 255)
    v.BackgroundTransparency = 0.2
    v.BorderSizePixel = 0
    v.ZIndex = 5
    v.Parent = card
end
cardCorner(0, 0, 4, 4, false, false)
cardCorner(1, 0, -4, 4, true, false)
cardCorner(0, 1, 4, -4, false, true)
cardCorner(1, 1, -4, -4, true, true)

local cardTitle = Instance.new("Frame")
cardTitle.Size = UDim2.new(1, 0, 0, 42)
cardTitle.BackgroundColor3 = Color3.fromRGB(0, 15, 35)
cardTitle.BorderSizePixel = 0
cardTitle.Parent = card
Instance.new("UICorner", cardTitle).CornerRadius = UDim.new(0, 6)

local cardTitleFix = Instance.new("Frame")
cardTitleFix.Size = UDim2.new(1, 0, 0, 10)
cardTitleFix.Position = UDim2.new(0, 0, 1, -10)
cardTitleFix.BackgroundColor3 = Color3.fromRGB(0, 15, 35)
cardTitleFix.BorderSizePixel = 0
cardTitleFix.Parent = cardTitle

-- Glowing title bar accent line
local cardTitleAccent = Instance.new("Frame")
cardTitleAccent.Size = UDim2.new(1, 0, 0, 1)
cardTitleAccent.Position = UDim2.new(0, 0, 1, 0)
cardTitleAccent.BackgroundColor3 = Color3.fromRGB(0, 160, 220)
cardTitleAccent.BackgroundTransparency = 0.3
cardTitleAccent.BorderSizePixel = 0
cardTitleAccent.Parent = cardTitle

local titleText = Instance.new("TextLabel")
titleText.Size = UDim2.new(1, -10, 1, 0)
titleText.Position = UDim2.new(0, 10, 0, 0)
titleText.BackgroundTransparency = 1
titleText.Text = "❄ GLACIER CLIENT"
titleText.TextColor3 = Color3.fromRGB(100, 200, 255)
titleText.TextSize = 14
titleText.Font = Enum.Font.GothamBold
titleText.TextXAlignment = Enum.TextXAlignment.Left
titleText.Parent = cardTitle

local subtitle = Instance.new("TextLabel")
subtitle.Size = UDim2.new(1, -20, 0, 20)
subtitle.Position = UDim2.new(0, 10, 0, 50)
subtitle.BackgroundTransparency = 1
subtitle.Text = "> ENTER ACCESS KEY TO CONTINUE"
subtitle.TextColor3 = Color3.fromRGB(0, 140, 200)
subtitle.TextSize = 11
subtitle.Font = Enum.Font.GothamBold
subtitle.TextXAlignment = Enum.TextXAlignment.Left
subtitle.Parent = card

local keyInput = Instance.new("TextBox")
keyInput.Size = UDim2.new(1, -20, 0, 34)
keyInput.Position = UDim2.new(0, 10, 0, 76)
keyInput.BackgroundColor3 = Color3.fromRGB(5, 18, 38)
keyInput.BorderSizePixel = 0
keyInput.Text = ""
keyInput.PlaceholderText = "glacier-xxxxxx"
keyInput.PlaceholderColor3 = Color3.fromRGB(40, 100, 150)
keyInput.TextColor3 = Color3.fromRGB(100, 200, 255)
keyInput.TextSize = 13
keyInput.Font = Enum.Font.GothamBold
keyInput.ClearTextOnFocus = false
keyInput.Parent = card
Instance.new("UICorner", keyInput).CornerRadius = UDim.new(0, 4)
Instance.new("UIPadding", keyInput).PaddingLeft = UDim.new(0, 8)
local keyInputStroke = Instance.new("UIStroke", keyInput)
keyInputStroke.Color = Color3.fromRGB(0, 120, 180)
keyInputStroke.Thickness = 1

local errorLabel = Instance.new("TextLabel")
errorLabel.Size = UDim2.new(1, -20, 0, 16)
errorLabel.Position = UDim2.new(0, 10, 0, 116)
errorLabel.BackgroundTransparency = 1
errorLabel.Text = ""
errorLabel.TextColor3 = Color3.fromRGB(255, 60, 60)
errorLabel.TextSize = 11
errorLabel.Font = Enum.Font.GothamBold
errorLabel.TextXAlignment = Enum.TextXAlignment.Left
errorLabel.Parent = card

local confirmBtn = Instance.new("TextButton")
confirmBtn.Size = UDim2.new(1, -20, 0, 34)
confirmBtn.Position = UDim2.new(0, 10, 0, 138)
confirmBtn.BackgroundColor3 = Color3.fromRGB(0, 40, 80)
confirmBtn.BorderSizePixel = 0
confirmBtn.Text = "CONFIRM KEY"
confirmBtn.TextColor3 = Color3.fromRGB(100, 200, 255)
confirmBtn.TextSize = 13
confirmBtn.Font = Enum.Font.GothamBold
confirmBtn.Parent = card
Instance.new("UICorner", confirmBtn).CornerRadius = UDim.new(0, 4)
local confirmStroke = Instance.new("UIStroke", confirmBtn)
confirmStroke.Color = Color3.fromRGB(0, 120, 200)
confirmStroke.Thickness = 1

local savedNote = Instance.new("TextLabel")
savedNote.Size = UDim2.new(1, -20, 0, 16)
savedNote.Position = UDim2.new(0, 10, 0, 196)
savedNote.BackgroundTransparency = 1
savedNote.Text = ""
savedNote.TextColor3 = Color3.fromRGB(0, 140, 200)
savedNote.TextSize = 10
savedNote.Font = Enum.Font.GothamBold
savedNote.TextXAlignment = Enum.TextXAlignment.Left
savedNote.Parent = card

-- ============================================================
-- LOADING SCREEN
-- ============================================================
local loadingCard = Instance.new("Frame")
loadingCard.Size = UDim2.new(0, 300, 0, 160)
loadingCard.Position = UDim2.new(0.5, -150, 0.5, -80)
loadingCard.BackgroundColor3 = Color3.fromRGB(4, 10, 22)
loadingCard.BorderSizePixel = 0
loadingCard.Visible = false
loadingCard.Parent = screenGui
Instance.new("UICorner", loadingCard).CornerRadius = UDim.new(0, 6)

local loadStroke = Instance.new("UIStroke", loadingCard)
loadStroke.Color = Color3.fromRGB(0, 160, 220)
loadStroke.Thickness = 1

local loadTitleBar = Instance.new("Frame")
loadTitleBar.Size = UDim2.new(1, 0, 0, 42)
loadTitleBar.BackgroundColor3 = Color3.fromRGB(0, 15, 35)
loadTitleBar.BorderSizePixel = 0
loadTitleBar.Parent = loadingCard
Instance.new("UICorner", loadTitleBar).CornerRadius = UDim.new(0, 6)

local loadTitleFix = Instance.new("Frame")
loadTitleFix.Size = UDim2.new(1, 0, 0, 10)
loadTitleFix.Position = UDim2.new(0, 0, 1, -10)
loadTitleFix.BackgroundColor3 = Color3.fromRGB(0, 15, 35)
loadTitleFix.BorderSizePixel = 0
loadTitleFix.Parent = loadTitleBar

local loadTitleAccent = Instance.new("Frame")
loadTitleAccent.Size = UDim2.new(1, 0, 0, 1)
loadTitleAccent.Position = UDim2.new(0, 0, 1, 0)
loadTitleAccent.BackgroundColor3 = Color3.fromRGB(0, 160, 220)
loadTitleAccent.BackgroundTransparency = 0.3
loadTitleAccent.BorderSizePixel = 0
loadTitleAccent.Parent = loadTitleBar

local loadTitle = Instance.new("TextLabel")
loadTitle.Size = UDim2.new(1, -10, 1, 0)
loadTitle.Position = UDim2.new(0, 10, 0, 0)
loadTitle.BackgroundTransparency = 1
loadTitle.Text = "❄ GLACIER CLIENT"
loadTitle.TextColor3 = Color3.fromRGB(100, 200, 255)
loadTitle.TextSize = 14
loadTitle.Font = Enum.Font.GothamBold
loadTitle.TextXAlignment = Enum.TextXAlignment.Left
loadTitle.Parent = loadTitleBar

local loadStatusLabel = Instance.new("TextLabel")
loadStatusLabel.Size = UDim2.new(1, -20, 0, 20)
loadStatusLabel.Position = UDim2.new(0, 10, 0, 50)
loadStatusLabel.BackgroundTransparency = 1
loadStatusLabel.Text = "> INITIALIZING..."
loadStatusLabel.TextColor3 = Color3.fromRGB(0, 160, 220)
loadStatusLabel.TextSize = 11
loadStatusLabel.Font = Enum.Font.GothamBold
loadStatusLabel.TextXAlignment = Enum.TextXAlignment.Left
loadStatusLabel.Parent = loadingCard

local progressBg = Instance.new("Frame")
progressBg.Size = UDim2.new(1, -20, 0, 4)
progressBg.Position = UDim2.new(0, 10, 0, 80)
progressBg.BackgroundColor3 = Color3.fromRGB(5, 20, 40)
progressBg.BorderSizePixel = 0
progressBg.Parent = loadingCard
Instance.new("UICorner", progressBg).CornerRadius = UDim.new(1, 0)
local progressBgStroke = Instance.new("UIStroke", progressBg)
progressBgStroke.Color = Color3.fromRGB(0, 80, 130)
progressBgStroke.Thickness = 1

local progressFill = Instance.new("Frame")
progressFill.Size = UDim2.new(0, 0, 1, 0)
progressFill.BackgroundColor3 = Color3.fromRGB(0, 180, 255)
progressFill.BorderSizePixel = 0
progressFill.Parent = progressBg
Instance.new("UICorner", progressFill).CornerRadius = UDim.new(1, 0)

local spinnerFrame = Instance.new("Frame")
spinnerFrame.Size = UDim2.new(1, 0, 0, 30)
spinnerFrame.Position = UDim2.new(0, 0, 0, 100)
spinnerFrame.BackgroundTransparency = 1
spinnerFrame.Parent = loadingCard

local dots = {}
for i = 1, 5 do
    local dot = Instance.new("Frame")
    dot.Size = UDim2.new(0, 8, 0, 8)
    dot.Position = UDim2.new(0.5, (i - 3) * 16 - 4, 0.5, -4)
    dot.BackgroundColor3 = Color3.fromRGB(180, 215, 235)
    dot.BorderSizePixel = 0
    dot.Parent = spinnerFrame
    Instance.new("UICorner", dot).CornerRadius = UDim.new(1, 0)
    dots[i] = dot
end

local spinnerActive = false
task.spawn(function()
    local t = 0
    while true do
        task.wait(0.05)
        if spinnerActive then
            t += 1
            for i, dot in ipairs(dots) do
                local phase = ((t + i * 4) % 20) / 20
                local brightness = math.clamp(180 + math.floor(math.sin(phase * math.pi * 2) * 50), 100, 230)
                dot.BackgroundColor3 = Color3.fromRGB(brightness - 30, brightness, brightness + 20)
            end
        end
    end
end)

local function animateProgress(targetPct, duration, statusText)
    loadStatusLabel.Text = "> " .. statusText
    local startSize = progressFill.Size.X.Scale
    local steps = 30
    for i = 1, steps do
        progressFill.Size = UDim2.new(startSize + (targetPct - startSize) * (i / steps), 0, 1, 0)
        task.wait(duration / steps)
    end
end

-- ============================================================
-- KEY SAVE / LOAD
-- ============================================================
local function saveKey(key)
    pcall(function() writefile("GlacierKey.txt", key) end)
end

local function loadSavedKey()
    local ok, result = pcall(function() return readfile("GlacierKey.txt") end)
    if ok and result and result ~= "" then
        return result:gsub("%s+", ""):lower()
    end
    return nil
end

-- ============================================================
-- LAUNCH CLIENT
-- ============================================================
local function launchClient()
    local chamsEnabled = false
    local crosshairEnabled = false
    local guiVisible = true
    local listeningForKeybind = false
    local highlightStorage = {}

    local pfPlayersFolder = Workspace:WaitForChild("Players")

    -- ── Chams Logic ──────────────────────────────────────────
    local function getAllCharacters()
        local characters = {}
        for _, folder in ipairs(pfPlayersFolder:GetChildren()) do
            if folder:IsA("Folder") then
                for _, model in ipairs(folder:GetChildren()) do
                    if model:IsA("Model") then
                        table.insert(characters, model)
                    end
                end
            end
        end
        return characters
    end

    local function isTeammate(character)
        local folder = character.Parent
        if not folder then return false end
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= localPlayer and folder.Name:find(player.Name) then
                return player.TeamColor == localPlayer.TeamColor
            end
        end
        return false
    end

    local function applyChams(character)
        if not character or highlightStorage[character] then return end
        local highlight = Instance.new("Highlight")
        highlight.Adornee = character
        highlight.FillColor = Color3.fromRGB(255, 60, 60)
        highlight.OutlineColor = Color3.fromRGB(255, 60, 60)
        highlight.FillTransparency = 0.5
        highlight.OutlineTransparency = 0
        highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
        highlight.Parent = character
        highlightStorage[character] = highlight
    end

    local function removeChams(character)
        if highlightStorage[character] then
            highlightStorage[character]:Destroy()
            highlightStorage[character] = nil
        end
    end

    local function removeAllChams()
        for character in pairs(highlightStorage) do
            removeChams(character)
        end
    end

    local function updateChams()
        removeAllChams()
        if not chamsEnabled then return end
        for _, character in ipairs(getAllCharacters()) do
            if not isTeammate(character) then
                applyChams(character)
            end
        end
    end

    pfPlayersFolder.DescendantAdded:Connect(function(desc)
        if desc:IsA("Model") then
            task.wait(0.3)
            if chamsEnabled then updateChams() end
        end
    end)

    pfPlayersFolder.DescendantRemoving:Connect(function(desc)
        if highlightStorage[desc] then removeChams(desc) end
    end)

    task.spawn(function()
        while true do
            task.wait(2)
            if chamsEnabled then updateChams() end
        end
    end)

    -- ── Crosshair ─────────────────────────────────────────────
    local crosshairGui = Instance.new("Frame")
    crosshairGui.Size = UDim2.new(1, 0, 1, 0)
    crosshairGui.BackgroundTransparency = 1
    crosshairGui.BorderSizePixel = 0
    crosshairGui.Visible = false
    crosshairGui.ZIndex = 10
    crosshairGui.Parent = screenGui

    local CX_LEN = 10   -- line length
    local CX_GAP = 4    -- gap from center
    local CX_T   = 2    -- thickness
    local CX_COL = Color3.fromRGB(0, 220, 255)

    local function makeLine(w, h, ox, oy)
        local f = Instance.new("Frame")
        f.Size = UDim2.new(0, w, 0, h)
        f.Position = UDim2.new(0.5, ox, 0.5, oy)
        f.BackgroundColor3 = CX_COL
        f.BackgroundTransparency = 0.1
        f.BorderSizePixel = 0
        f.ZIndex = 11
        f.Parent = crosshairGui
        return f
    end

    -- top, bottom, left, right lines
    local cxTop    = makeLine(CX_T,   CX_LEN, -CX_T/2, -(CX_GAP + CX_LEN))
    local cxBottom = makeLine(CX_T,   CX_LEN, -CX_T/2,   CX_GAP)
    local cxLeft   = makeLine(CX_LEN, CX_T,   -(CX_GAP + CX_LEN), -CX_T/2)
    local cxRight  = makeLine(CX_LEN, CX_T,    CX_GAP,             -CX_T/2)

    -- center dot
    local cxDot = Instance.new("Frame")
    cxDot.Size = UDim2.new(0, CX_T, 0, CX_T)
    cxDot.Position = UDim2.new(0.5, -CX_T/2, 0.5, -CX_T/2)
    cxDot.BackgroundColor3 = CX_COL
    cxDot.BackgroundTransparency = 0.1
    cxDot.BorderSizePixel = 0
    cxDot.ZIndex = 11
    cxDot.Parent = crosshairGui

    local function setCrosshair(enabled)
        crosshairEnabled = enabled
        crosshairGui.Visible = enabled
    end

    -- ── Notification system ───────────────────────────────────
    local notifFrame = Instance.new("Frame")
    notifFrame.Size = UDim2.new(0, 200, 0, 300)
    notifFrame.Position = UDim2.new(1, -210, 1, -10)
    notifFrame.BackgroundTransparency = 1
    notifFrame.AnchorPoint = Vector2.new(0, 1)
    notifFrame.Parent = screenGui

    local notifList = Instance.new("UIListLayout")
    notifList.HorizontalAlignment = Enum.HorizontalAlignment.Right
    notifList.VerticalAlignment = Enum.VerticalAlignment.Bottom
    notifList.SortOrder = Enum.SortOrder.LayoutOrder
    notifList.Padding = UDim.new(0, 4)
    notifList.Parent = notifFrame

    local notifCount = 0
    local function notify(title, body)
        notifCount += 1
        local n = Instance.new("Frame")
        n.Size = UDim2.new(1, 0, 0, 48)
        n.BackgroundColor3 = Color3.fromRGB(4, 10, 22)
        n.BackgroundTransparency = 0.05
        n.BorderSizePixel = 0
        n.LayoutOrder = notifCount
        n.ClipsDescendants = true
        n.Parent = notifFrame
        Instance.new("UICorner", n).CornerRadius = UDim.new(0, 4)
        local ns = Instance.new("UIStroke", n)
        ns.Color = Color3.fromRGB(0, 160, 220)
        ns.Thickness = 1

        -- left accent bar
        local bar = Instance.new("Frame")
        bar.Size = UDim2.new(0, 2, 1, 0)
        bar.BackgroundColor3 = Color3.fromRGB(0, 200, 255)
        bar.BorderSizePixel = 0
        bar.Parent = n

        local nt = Instance.new("TextLabel")
        nt.Size = UDim2.new(1, -12, 0, 18)
        nt.Position = UDim2.new(0, 8, 0, 5)
        nt.BackgroundTransparency = 1
        nt.Text = title
        nt.TextColor3 = Color3.fromRGB(100, 200, 255)
        nt.TextSize = 12
        nt.Font = Enum.Font.GothamBold
        nt.TextXAlignment = Enum.TextXAlignment.Left
        nt.Parent = n

        local nb = Instance.new("TextLabel")
        nb.Size = UDim2.new(1, -12, 0, 16)
        nb.Position = UDim2.new(0, 8, 0, 24)
        nb.BackgroundTransparency = 1
        nb.Text = body
        nb.TextColor3 = Color3.fromRGB(80, 160, 200)
        nb.TextSize = 11
        nb.Font = Enum.Font.Gotham
        nb.TextXAlignment = Enum.TextXAlignment.Left
        nb.Parent = n

        -- slide in
        n.Position = UDim2.new(1, 10, 0, 0)
        n:TweenPosition(UDim2.new(0, 0, 0, 0), "Out", "Quad", 0.2, true)

        task.delay(3, function()
            if n and n.Parent then
                n:TweenPosition(UDim2.new(1, 10, 0, 0), "Out", "Quad", 0.2, true)
                task.wait(0.25)
                if n and n.Parent then n:Destroy() end
            end
        end)
    end

    -- ── Array HUD ─────────────────────────────────────────────
    local arrayFrame = Instance.new("Frame")
    arrayFrame.Size = UDim2.new(0, 160, 0, 80)
    arrayFrame.Position = UDim2.new(1, -170, 0, 10)
    arrayFrame.BackgroundTransparency = 1
    arrayFrame.Parent = screenGui

    local arrayList = Instance.new("UIListLayout")
    arrayList.HorizontalAlignment = Enum.HorizontalAlignment.Right
    arrayList.VerticalAlignment = Enum.VerticalAlignment.Top
    arrayList.SortOrder = Enum.SortOrder.LayoutOrder
    arrayList.Padding = UDim.new(0, 2)
    arrayList.Parent = arrayFrame

    local statsLabel = Instance.new("TextLabel")
    statsLabel.Size = UDim2.new(1, 0, 0, 18)
    statsLabel.BackgroundTransparency = 1
    statsLabel.TextColor3 = Color3.fromRGB(0, 160, 220)
    statsLabel.TextSize = 11
    statsLabel.Font = Enum.Font.GothamBold
    statsLabel.TextXAlignment = Enum.TextXAlignment.Right
    statsLabel.TextStrokeTransparency = 0.4
    statsLabel.LayoutOrder = 0
    statsLabel.Parent = arrayFrame

    local function makeArrayLabel(text, order)
        local lbl = Instance.new("TextLabel")
        lbl.Size = UDim2.new(1, 0, 0, 16)
        lbl.BackgroundTransparency = 1
        lbl.TextColor3 = Color3.fromRGB(100, 200, 255)
        lbl.TextSize = 11
        lbl.Font = Enum.Font.GothamBold
        lbl.TextXAlignment = Enum.TextXAlignment.Right
        lbl.TextStrokeTransparency = 0.4
        lbl.Text = text
        lbl.Visible = false
        lbl.LayoutOrder = order
        lbl.Parent = arrayFrame
        return lbl
    end

    local chamsArrayLabel     = makeArrayLabel("Enemy Chams", 1)
    local crosshairArrayLabel = makeArrayLabel("Crosshair", 2)

    local lastFpsTime = tick()
    local fpsCount = 0
    local displayFps = 0
    RunService.Heartbeat:Connect(function()
        fpsCount += 1
        if tick() - lastFpsTime >= 1 then
            displayFps = fpsCount
            fpsCount = 0
            lastFpsTime = tick()
        end
        local ping = math.floor(localPlayer:GetNetworkPing() * 1000)
        statsLabel.Text = displayFps .. " FPS  " .. #Players:GetPlayers() .. " PLR  " .. ping .. "ms"
    end)

    -- ── Helper: make a toggle row ─────────────────────────────
    local function makeToggle(parent, text, yPos, onToggle)
        local row = Instance.new("Frame")
        row.Size = UDim2.new(1, -20, 0, 32)
        row.Position = UDim2.new(0, 10, 0, yPos)
        row.BackgroundTransparency = 1
        row.Parent = parent

        local lbl = Instance.new("TextLabel")
        lbl.Size = UDim2.new(1, -50, 1, 0)
        lbl.BackgroundTransparency = 1
        lbl.Text = text
        lbl.TextColor3 = Color3.fromRGB(160, 210, 240)
        lbl.TextSize = 12
        lbl.Font = Enum.Font.GothamBold
        lbl.TextXAlignment = Enum.TextXAlignment.Left
        lbl.Parent = row

        local bg = Instance.new("Frame")
        bg.Size = UDim2.new(0, 38, 0, 20)
        bg.Position = UDim2.new(1, -42, 0.5, -10)
        bg.BackgroundColor3 = Color3.fromRGB(5, 20, 40)
        bg.BorderSizePixel = 0
        bg.Parent = row
        Instance.new("UICorner", bg).CornerRadius = UDim.new(1, 0)
        local bgStroke = Instance.new("UIStroke", bg)
        bgStroke.Color = Color3.fromRGB(0, 80, 130)
        bgStroke.Thickness = 1

        local knob = Instance.new("Frame")
        knob.Size = UDim2.new(0, 14, 0, 14)
        knob.Position = UDim2.new(0, 3, 0.5, -7)
        knob.BackgroundColor3 = Color3.fromRGB(0, 100, 160)
        knob.BorderSizePixel = 0
        knob.Parent = bg
        Instance.new("UICorner", knob).CornerRadius = UDim.new(1, 0)

        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(1, 0, 1, 0)
        btn.BackgroundTransparency = 1
        btn.Text = ""
        btn.Parent = bg

        local toggled = false
        local function setToggle(val)
            toggled = val
            if val then
                bg.BackgroundColor3 = Color3.fromRGB(0, 45, 90)
                bgStroke.Color = Color3.fromRGB(0, 160, 220)
                knob.BackgroundColor3 = Color3.fromRGB(0, 180, 255)
                knob:TweenPosition(UDim2.new(0, 21, 0.5, -7), "Out", "Quad", 0.15, true)
            else
                bg.BackgroundColor3 = Color3.fromRGB(5, 20, 40)
                bgStroke.Color = Color3.fromRGB(0, 80, 130)
                knob.BackgroundColor3 = Color3.fromRGB(0, 100, 160)
                knob:TweenPosition(UDim2.new(0, 3, 0.5, -7), "Out", "Quad", 0.15, true)
            end
            onToggle(val)
        end

        btn.MouseButton1Click:Connect(function()
            setToggle(not toggled)
        end)

        return setToggle
    end

    -- ── Main Window ────────────────────────────────────────────
    local window = Instance.new("Frame")
    window.Size = UDim2.new(0, 230, 0, 230)
    window.Position = UDim2.new(0, 20, 0.5, -115)
    window.BackgroundColor3 = Color3.fromRGB(4, 10, 22)
    window.BorderSizePixel = 0
    window.Active = true
    window.Draggable = true
    window.Parent = screenGui
    Instance.new("UICorner", window).CornerRadius = UDim.new(0, 6)

    local wStroke = Instance.new("UIStroke", window)
    wStroke.Color = Color3.fromRGB(0, 160, 220)
    wStroke.Thickness = 1

    local function winCorner(px, py, ox, oy, flipH, flipV)
        local h = Instance.new("Frame")
        h.Size = UDim2.new(0, 12, 0, 2)
        h.Position = UDim2.new(px, ox + (flipH and -12 or 0), py, oy)
        h.BackgroundColor3 = Color3.fromRGB(0, 180, 255)
        h.BackgroundTransparency = 0.2
        h.BorderSizePixel = 0
        h.ZIndex = 5
        h.Parent = window
        local v = Instance.new("Frame")
        v.Size = UDim2.new(0, 2, 0, 12)
        v.Position = UDim2.new(px, ox + (flipH and -2 or 0), py, oy + (flipV and -12 or 0))
        v.BackgroundColor3 = Color3.fromRGB(0, 180, 255)
        v.BackgroundTransparency = 0.2
        v.BorderSizePixel = 0
        v.ZIndex = 5
        v.Parent = window
    end
    winCorner(0, 0, 3, 3, false, false)
    winCorner(1, 0, -3, 3, true, false)
    winCorner(0, 1, 3, -3, false, true)
    winCorner(1, 1, -3, -3, true, true)

    -- Title bar
    local titleBar = Instance.new("Frame")
    titleBar.Size = UDim2.new(1, 0, 0, 36)
    titleBar.BackgroundColor3 = Color3.fromRGB(0, 15, 35)
    titleBar.BorderSizePixel = 0
    titleBar.Parent = window
    Instance.new("UICorner", titleBar).CornerRadius = UDim.new(0, 6)

    local titleBarFix = Instance.new("Frame")
    titleBarFix.Size = UDim2.new(1, 0, 0, 10)
    titleBarFix.Position = UDim2.new(0, 0, 1, -10)
    titleBarFix.BackgroundColor3 = Color3.fromRGB(0, 15, 35)
    titleBarFix.BorderSizePixel = 0
    titleBarFix.Parent = titleBar

    local titleBarAccent = Instance.new("Frame")
    titleBarAccent.Size = UDim2.new(1, 0, 0, 1)
    titleBarAccent.Position = UDim2.new(0, 0, 1, 0)
    titleBarAccent.BackgroundColor3 = Color3.fromRGB(0, 160, 220)
    titleBarAccent.BackgroundTransparency = 0.3
    titleBarAccent.BorderSizePixel = 0
    titleBarAccent.Parent = titleBar

    local titleLabel = Instance.new("TextLabel")
    titleLabel.Size = UDim2.new(1, -10, 1, 0)
    titleLabel.Position = UDim2.new(0, 10, 0, 0)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = "❄ GLACIER CLIENT"
    titleLabel.TextColor3 = Color3.fromRGB(100, 200, 255)
    titleLabel.TextSize = 14
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.Parent = titleBar

    local keybindHint = Instance.new("TextLabel")
    keybindHint.Size = UDim2.new(0, 80, 1, 0)
    keybindHint.Position = UDim2.new(1, -85, 0, 0)
    keybindHint.BackgroundTransparency = 1
    keybindHint.Text = "[RShift]"
    keybindHint.TextColor3 = Color3.fromRGB(0, 100, 160)
    keybindHint.TextSize = 10
    keybindHint.Font = Enum.Font.GothamBold
    keybindHint.TextXAlignment = Enum.TextXAlignment.Right
    keybindHint.Parent = titleBar

    -- Section helper
    local function makeSection(parent, text, yPos)
        local lbl = Instance.new("TextLabel")
        lbl.Size = UDim2.new(1, -20, 0, 18)
        lbl.Position = UDim2.new(0, 10, 0, yPos)
        lbl.BackgroundTransparency = 1
        lbl.Text = "// " .. text
        lbl.TextColor3 = Color3.fromRGB(0, 120, 180)
        lbl.TextSize = 10
        lbl.Font = Enum.Font.GothamBold
        lbl.TextXAlignment = Enum.TextXAlignment.Left
        lbl.Parent = parent
        -- thin underline
        local line = Instance.new("Frame")
        line.Size = UDim2.new(1, -20, 0, 1)
        line.Position = UDim2.new(0, 10, 0, yPos + 18)
        line.BackgroundColor3 = Color3.fromRGB(0, 80, 130)
        line.BackgroundTransparency = 0.5
        line.BorderSizePixel = 0
        line.Parent = parent
    end

    makeSection(window, "VISUALS", 42)

    local toggleChams = makeToggle(window, "Enemy Chams", 64, function(val)
        chamsEnabled = val
        chamsArrayLabel.Visible = val
        updateChams()
        notify("Enemy Chams", val and "Enabled" or "Disabled")
    end)

    makeToggle(window, "Crosshair", 100, function(val)
        setCrosshair(val)
        crosshairArrayLabel.Visible = val
        notify("Crosshair", val and "Enabled" or "Disabled")
    end)

    -- Divider
    local divider = Instance.new("Frame")
    divider.Size = UDim2.new(1, -20, 0, 1)
    divider.Position = UDim2.new(0, 10, 0, 143)
    divider.BackgroundColor3 = Color3.fromRGB(0, 80, 130)
    divider.BackgroundTransparency = 0.5
    divider.BorderSizePixel = 0
    divider.Parent = window

    makeSection(window, "KEYBINDS", 148)

    local keybindRow = Instance.new("Frame")
    keybindRow.Size = UDim2.new(1, -20, 0, 28)
    keybindRow.Position = UDim2.new(0, 10, 0, 170)
    keybindRow.BackgroundTransparency = 1
    keybindRow.Parent = window

    local keybindRowLabel = Instance.new("TextLabel")
    keybindRowLabel.Size = UDim2.new(0.6, 0, 1, 0)
    keybindRowLabel.BackgroundTransparency = 1
    keybindRowLabel.Text = "Toggle Chams"
    keybindRowLabel.TextColor3 = Color3.fromRGB(160, 210, 240)
    keybindRowLabel.TextSize = 12
    keybindRowLabel.Font = Enum.Font.GothamBold
    keybindRowLabel.TextXAlignment = Enum.TextXAlignment.Left
    keybindRowLabel.Parent = keybindRow

    local keybindBtn = Instance.new("TextButton")
    keybindBtn.Size = UDim2.new(0, 68, 0, 24)
    keybindBtn.Position = UDim2.new(1, -70, 0.5, -12)
    keybindBtn.BackgroundColor3 = Color3.fromRGB(0, 25, 55)
    keybindBtn.BorderSizePixel = 0
    keybindBtn.Text = chamsKeybind.Name
    keybindBtn.TextColor3 = Color3.fromRGB(100, 200, 255)
    keybindBtn.TextSize = 11
    keybindBtn.Font = Enum.Font.GothamBold
    keybindBtn.Parent = keybindRow
    Instance.new("UICorner", keybindBtn).CornerRadius = UDim.new(0, 4)
    local kbStroke = Instance.new("UIStroke", keybindBtn)
    kbStroke.Color = Color3.fromRGB(0, 120, 200)
    kbStroke.Thickness = 1

    keybindBtn.MouseButton1Click:Connect(function()
        if listeningForKeybind then return end
        listeningForKeybind = true
        keybindBtn.Text = "..."
        keybindBtn.BackgroundColor3 = Color3.fromRGB(0, 40, 80)
        keybindBtn.TextColor3 = Color3.fromRGB(0, 200, 255)
        local conn
        conn = UserInputService.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.Keyboard then
                chamsKeybind = input.KeyCode
                keybindBtn.Text = input.KeyCode.Name
                keybindBtn.BackgroundColor3 = Color3.fromRGB(0, 25, 55)
                keybindBtn.TextColor3 = Color3.fromRGB(100, 200, 255)
                listeningForKeybind = false
                conn:Disconnect()
                notify("Keybind", "Set to " .. input.KeyCode.Name)
            end
        end)
    end)

    -- Version tag at bottom
    local versionLabel = Instance.new("TextLabel")
    versionLabel.Size = UDim2.new(1, -20, 0, 16)
    versionLabel.Position = UDim2.new(0, 10, 1, -18)
    versionLabel.BackgroundTransparency = 1
    versionLabel.Text = "GLACIER v3.0  //  PHANTOM FORCES"
    versionLabel.TextColor3 = Color3.fromRGB(0, 70, 110)
    versionLabel.TextSize = 9
    versionLabel.Font = Enum.Font.GothamBold
    versionLabel.TextXAlignment = Enum.TextXAlignment.Center
    versionLabel.Parent = window

    -- Global keybinds
    UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if gameProcessed then return end
        if listeningForKeybind then return end
        if input.KeyCode == Enum.KeyCode.RightShift then
            guiVisible = not guiVisible
            window.Visible = guiVisible
        elseif input.KeyCode == chamsKeybind then
            toggleChams(not chamsEnabled)
        end
    end)

    -- Welcome notification
    task.delay(0.5, function()
        notify("❄ Glacier Client", "Loaded successfully")
    end)
end

-- ============================================================
-- LOADING SEQUENCE
-- ============================================================
local function runLoadingSequence()
    backdrop.Visible = false
    card.Visible = false
    loadingCard.Visible = true
    spinnerActive = true
    animateProgress(0.2, 0.4, "Connecting to servers...")
    animateProgress(0.5, 0.5, "Verifying license...")
    animateProgress(0.8, 0.4, "Loading modules...")
    animateProgress(1.0, 0.3, "Done!")
    task.wait(0.4)
    spinnerActive = false
    loadingCard.Visible = false
    backdrop.Visible = false
    launchClient()
end

-- ============================================================
-- KEY VALIDATION
-- ============================================================
local function validateKey(entered)
    local validKeys = {}
    local ok, result = pcall(function() return game:HttpGet(KEY_URL) end)
    if ok and result then
        for line in result:gmatch("[^\n]+") do
            local trimmed = line:gsub("%s+", ""):lower()
            if trimmed ~= "" then table.insert(validKeys, trimmed) end
        end
    else
        return false, "Could not reach key server."
    end
    for _, key in ipairs(validKeys) do
        if entered == key then return true, "" end
    end
    return false, "Invalid key. Please try again."
end

-- ============================================================
-- BOOT: JARVIS → KEY SCREEN → CLIENT
-- ============================================================
runJarvisAnimation(function()
    backdrop.Visible = true
    card.Visible = true

    local saved = loadSavedKey()
    if saved then
        savedNote.Text = "> Saved key found, validating..."
        confirmBtn.Text = "VALIDATING..."
        confirmBtn.TextColor3 = Color3.fromRGB(0, 160, 220)
        keyInput.Text = saved
        task.spawn(function()
            local valid, err = validateKey(saved)
            if valid then
                confirmBtn.BackgroundColor3 = Color3.fromRGB(0, 60, 30)
                confirmBtn.TextColor3 = Color3.fromRGB(0, 220, 120)
                confirmBtn.Text = "ACCESS GRANTED"
                savedNote.Text = "> Welcome back!"
                task.wait(0.8)
                runLoadingSequence()
            else
                savedNote.Text = "> Saved key invalid. Enter a new one."
                keyInput.Text = ""
                confirmBtn.BackgroundColor3 = Color3.fromRGB(0, 40, 80)
                confirmBtn.TextColor3 = Color3.fromRGB(100, 200, 255)
                confirmBtn.Text = "CONFIRM KEY"
            end
        end)
    else
        savedNote.Text = "> No saved key found."
    end

    confirmBtn.MouseButton1Click:Connect(function()
        local entered = keyInput.Text:lower():gsub("%s+", "")
        if entered == "" then errorLabel.Text = "> Please enter a key." return end
        confirmBtn.Text = "CHECKING..."
        confirmBtn.BackgroundColor3 = Color3.fromRGB(0, 30, 60)
        confirmBtn.TextColor3 = Color3.fromRGB(0, 140, 200)
        errorLabel.Text = ""
        task.spawn(function()
            local valid, err = validateKey(entered)
            if valid then
                saveKey(entered)
                confirmBtn.BackgroundColor3 = Color3.fromRGB(0, 60, 30)
                confirmBtn.TextColor3 = Color3.fromRGB(0, 220, 120)
                confirmBtn.Text = "ACCESS GRANTED"
                savedNote.Text = "> Key saved!"
                task.wait(0.8)
                runLoadingSequence()
            else
                errorLabel.Text = "> " .. err
                confirmBtn.BackgroundColor3 = Color3.fromRGB(60, 10, 10)
                confirmBtn.TextColor3 = Color3.fromRGB(255, 80, 80)
                confirmBtn.Text = "ACCESS DENIED"
                task.wait(1.5)
                confirmBtn.BackgroundColor3 = Color3.fromRGB(0, 40, 80)
                confirmBtn.TextColor3 = Color3.fromRGB(100, 200, 255)
                confirmBtn.Text = "CONFIRM KEY"
                keyInput.Text = ""
            end
        end)
    end)

    keyInput.FocusLost:Connect(function(enterPressed)
        if enterPressed then confirmBtn.MouseButton1Click:Fire() end
    end)
end)
