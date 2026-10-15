-- ==============================================================================
-- 🌸 [TAKESA HUB] : MOBILE PRO EDITION (DOUBLE TAP TO COPY INSTRUCTIONS ADDED)
-- ==============================================================================
local Plrs, CoreG, RunS, TweenS, Lighting, Camera, UserInputService, TeleportService, HttpService = game:GetService("Players"), game:GetService("CoreGui"), game:GetService("RunService"), game:GetService("TweenService"), game:GetService("Lighting"), workspace.CurrentCamera, game:GetService("UserInputService"), game:GetService("TeleportService"), game:GetService("HttpService")
local LP = Plrs.LocalPlayer
local UI_N = "TakesaHubMobileEdition"

local safeZ = false
local ugPlat, fixedSafeY = nil, nil

pcall(function()
    if LP:FindFirstChild("TakesaLocalSound") then LP.TakesaLocalSound:Destroy() end
end)
local localSound = Instance.new("Sound")
localSound.Name = "TakesaLocalSound"
localSound.Volume = 1
localSound.Looped = true
localSound.Parent = LP

local function forceDisableUnderground()
    if safeZ then
        safeZ = false
        if ugPlat then ugPlat:Destroy() ugPlat = nil end
        fixedSafeY = nil
        local hrp = LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")
        if hrp then 
            hrp.CFrame = hrp.CFrame + Vector3.new(0, 15, 0)
            hrp.AssemblyLinearVelocity = Vector3.new(0, 0, 0) 
        end
    end
end

local OldNameCall
OldNameCall = hookmetamethod(game, "__namecall", function(self, ...)
    local Method = getnamecallmethod()
    if Method == "Kick" and self == LP then
        forceDisableUnderground()
        return nil
    end
    return OldNameCall(self, ...)
end)

if CoreG:FindFirstChild(UI_N) then CoreG[UI_N]:Destroy() end
if LP.PlayerGui:FindFirstChild(UI_N) then LP.PlayerGui[UI_N]:Destroy() end
local gui = Instance.new("ScreenGui", CoreG:FindFirstChild("CoreGui") and CoreG or LP.PlayerGui)
gui.Name, gui.ResetOnSpawn = UI_N, false

local function cnr(p, r) 
    local c = Instance.new("UICorner", p) 
    c.CornerRadius = UDim.new(0, r or 12) 
    return c 
end

local function addSoftShadow(parent)
    local stroke = Instance.new("UIStroke", parent)
    stroke.Color = Color3.fromRGB(210, 220, 240)
    stroke.Thickness = 1.8
    stroke.Transparency = 0.15
    return stroke
end

local tBtn = Instance.new("TextButton", gui) 
tBtn.Name, tBtn.Size, tBtn.Position, tBtn.BackgroundColor3, tBtn.TextColor3, tBtn.TextSize, tBtn.Font, tBtn.Text, tBtn.Visible, tBtn.Draggable = "FloatingToggle", UDim2.new(0, 56, 0, 56), UDim2.new(0, 20, 0, 120), Color3.fromRGB(90, 140, 255), Color3.fromRGB(255, 255, 255), 16, Enum.Font.GothamBold, "TK", true, true
cnr(tBtn, 28) addSoftShadow(tBtn)

local mF = Instance.new("Frame", gui) 
mF.Name, mF.Size, mF.Position, mF.BackgroundColor3, mF.BorderSizePixel, mF.Visible = "MainFrame", UDim2.new(0, 350, 0, 420), UDim2.new(0.5, -175, 0.5, -210), Color3.fromRGB(255, 255, 255), 0, true 
cnr(mF, 16) addSoftShadow(mF)

local mTitle = Instance.new("TextLabel", mF) 
mTitle.Size, mTitle.BackgroundColor3, mTitle.TextColor3, mTitle.TextSize, mTitle.Font, mTitle.Text = UDim2.new(1, 0, 0, 45), Color3.fromRGB(235, 242, 255), Color3.fromRGB(60, 80, 120), 14, Enum.Font.GothamBold, "  🌸 TAKESA HUB // MOBILE PRO"
mTitle.TextXAlignment = Enum.TextXAlignment.Left cnr(mTitle, 16)

local cBtn = Instance.new("TextButton", mF)
cBtn.Size, cBtn.Position = UDim2.new(0, 35, 0, 35), UDim2.new(1, -40, 0, 5)
cBtn.BackgroundColor3, cBtn.TextColor3, cBtn.TextSize, cBtn.Font, cBtn.Text = Color3.fromRGB(255, 110, 110), Color3.fromRGB(255, 255, 255), 13, Enum.Font.GothamBold, "✕"
cnr(cBtn, 8)

local isOpen = true

cBtn.MouseButton1Click:Connect(function()
    isOpen = false
    mF.Visible = false
    tBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    tBtn.TextColor3 = Color3.fromRGB(90, 140, 255)
end)

tBtn.MouseButton1Click:Connect(function()
    isOpen = not isOpen 
    mF.Visible = isOpen
    tBtn.BackgroundColor3 = isOpen and Color3.fromRGB(90, 140, 255) or Color3.fromRGB(255, 255, 255)
    tBtn.TextColor3 = isOpen and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(90, 140, 255)
end)

local tH = Instance.new("ScrollingFrame", mF)
tH.Size, tH.Position, tH.BackgroundTransparency, tH.CanvasSize, tH.ScrollBarThickness = UDim2.new(1, -10, 0, 40), UDim2.new(0, 5, 0, 50), true, UDim2.new(0, 600, 0, 0), 0

local cH = Instance.new("Frame", mF) 
cH.Size, cH.Position, cH.BackgroundTransparency = UDim2.new(1, -16, 1, -100), UDim2.new(0, 8, 0, 95), true

local tabs, containers = {}, {}

local function mkTab(name, idx, totalTabs, contentHeight)
    local btn = Instance.new("TextButton", tH) 
    btn.Size = UDim2.new(0, 72, 1, -4)
    btn.Position = UDim2.new(0, (idx-1) * 75, 0, 2)
    btn.BackgroundColor3 = (idx == 1) and Color3.fromRGB(90, 140, 255) or Color3.fromRGB(235, 242, 255)
    btn.TextColor3, btn.TextSize, btn.Font, btn.Text = (idx == 1) and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(80, 100, 130), 11, Enum.Font.GothamBold, name 
    cnr(btn, 8) 

    local scr = Instance.new("ScrollingFrame", cH) 
    scr.Size, scr.Position, scr.BackgroundTransparency, scr.ScrollBarThickness = UDim2.new(1,0,1,0), UDim2.new(0,0,0,0), true, 6
    scr.ScrollBarImageColor3, scr.CanvasSize, scr.Visible = Color3.fromRGB(90, 140, 255), UDim2.new(0, 0, 0, contentHeight or 2000), (idx == 1)
    
    table.insert(tabs, btn) 
    table.insert(containers, scr)
    
    btn.MouseButton1Click:Connect(function()
        for i, b in ipairs(tabs) do 
            b.BackgroundColor3 = Color3.fromRGB(235, 242, 255) 
            b.TextColor3 = Color3.fromRGB(80, 100, 130)
            containers[i].Visible = false 
        end
        btn.BackgroundColor3 = Color3.fromRGB(90, 140, 255) 
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        scr.Visible = true
    end)
    return scr
end

local tb1 = mkTab("หน้าแรก", 1, 8, 350)
local tb2 = mkTab("วาร์ป", 2, 8, 350)
local tb3 = mkTab("ESP", 3, 8, 250)
local tb4 = mkTab("ตัวละคร", 4, 8, 2000)
local tb5 = mkTab("เพลง", 5, 8, 4600)
local tb6 = mkTab("ล็อคเป้า", 6, 8, 400)
local tb7 = mkTab("ช่วยเหลือ", 7, 8, 500)
local tb8 = mkTab("แมพต่างๆ", 8, 8, 1650)

-- Tab 1 Content (หน้าแรก)
local wLbl = Instance.new("TextLabel", tb1) 
wLbl.Size, wLbl.Position, wLbl.BackgroundColor3, wLbl.TextColor3, wLbl.TextSize, wLbl.Font, wLbl.Text = UDim2.new(1, 0, 0, 90), UDim2.new(0, 0, 0, 10), Color3.fromRGB(245, 248, 255), Color3.fromRGB(60, 80, 120), 11, Enum.Font.GothamBold, "  🌸 TAKESA HUB // MOBILE PRO EDITION\n  💡 ทริค: กดชื่อเพลง 1 ครั้ง (ใส่ ID) | ถ้าหากอยากคัดลอก ให้แตะชื่อเพลง 2 ครั้ง!\n  🚀 เลื่อนหน้าจอเพื่อดูเมนูเพิ่มเติมได้เลย!"
wLbl.TextXAlignment = Enum.TextXAlignment.Left cnr(wLbl, 10) addSoftShadow(wLbl)

local tiktokBtn = Instance.new("TextButton", tb1)
tiktokBtn.Size, tiktokBtn.Position = UDim2.new(1, 0, 0, 42), UDim2.new(0, 0, 0, 108)
tiktokBtn.BackgroundColor3, tiktokBtn.TextColor3, tiktokBtn.TextSize, tiktokBtn.Font, tiktokBtn.Text = Color3.fromRGB(255, 235, 240), Color3.fromRGB(220, 80, 120), 12, Enum.Font.GothamBold, "🎵 TikTok : @asplqkqkl03 (แตะเพื่อคัดลอก)"
cnr(tiktokBtn, 8) addSoftShadow(tiktokBtn)

tiktokBtn.MouseButton1Click:Connect(function()
    pcall(function()
        local tiktokUrl = "https://www.tiktok.com/@asplqkqkl03?_r=1&_t=ZS-9ATqcI2try3"
        if setclipboard then
            setclipboard(tiktokUrl)
            tiktokBtn.Text = "✅ คัดลอกลิงก์ TikTok สำเร็จ!"
            tiktokBtn.BackgroundColor3 = Color3.fromRGB(80, 200, 120)
            tiktokBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
            task.wait(2)
            tiktokBtn.Text = "🎵 TikTok : @asplqkqkl03 (แตะเพื่อคัดลอก)"
            tiktokBtn.BackgroundColor3 = Color3.fromRGB(255, 235, 240)
            tiktokBtn.TextColor3 = Color3.fromRGB(220, 80, 120)
        else
            tiktokBtn.Text = "⚠️ Executor ไม่รองรับคำสั่งคัดลอก"
            task.wait(2)
            tiktokBtn.Text = "🎵 TikTok : @asplqkqkl03 (แตะเพื่อคัดลอก)"
        end
    end)
end)

local rejoinBtn = Instance.new("TextButton", tb1)
rejoinBtn.Size, rejoinBtn.Position = UDim2.new(1, 0, 0, 42), UDim2.new(0, 0, 0, 158)
rejoinBtn.BackgroundColor3, rejoinBtn.TextColor3, rejoinBtn.TextSize, rejoinBtn.Font, rejoinBtn.Text = Color3.fromRGB(230, 238, 250), Color3.fromRGB(60, 80, 120), 12, Enum.Font.GothamBold, "🔄 เข้าเซิร์ฟเวอร์เดิมใหม่ (Rejoin)"
cnr(rejoinBtn, 8) addSoftShadow(rejoinBtn)

rejoinBtn.MouseButton1Click:Connect(function()
    rejoinBtn.Text = "⏳ กำลังเชื่อมต่อกลับเซิร์ฟเวอร์เดิม..."
    pcall(function()
        TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, LP)
    end)
    task.wait(3)
    rejoinBtn.Text = "🔄 เข้าเซิร์ฟเวอร์เดิมใหม่ (Rejoin)"
end)

local hopBtn = Instance.new("TextButton", tb1)
hopBtn.Size, hopBtn.Position = UDim2.new(1, 0, 0, 42), UDim2.new(0, 0, 0, 210)
hopBtn.BackgroundColor3, hopBtn.TextColor3, hopBtn.TextSize, hopBtn.Font, hopBtn.Text = Color3.fromRGB(230, 238, 250), Color3.fromRGB(60, 80, 120), 12, Enum.Font.GothamBold, "🌐 ย้ายไปห้องอื่นอัตโนมัติ (Server Hop)"
cnr(hopBtn, 8) addSoftShadow(hopBtn)
hopBtn.MouseButton1Click:Connect(function()
    hopBtn.Text = "⏳ กำลังค้นหาห้องใหม่..."
    local api = "https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100"
    local success, result = pcall(function() return HttpService:JSONDecode(game:HttpGet(api)) end)
    if success and result and result.data then
        for _, s in ipairs(result.data) do
            if s.id ~= game.JobId and s.playing < s.maxPlayers then
                TeleportService:TeleportToPlaceInstance(game.PlaceId, s.id, LP)
                break
            end
        end
    end
    task.wait(2)
    hopBtn.Text = "🌐 ย้ายไปห้องอื่นอัตโนมัติ (Server Hop)"
end)

-- Tab 2 Content (Warp)
local tP, tLock = nil, false
local sInfo = Instance.new("TextLabel", tb2) 
sInfo.Size, sInfo.Position, sInfo.BackgroundColor3, sInfo.TextColor3, sInfo.TextSize, sInfo.Font, sInfo.Text = UDim2.new(1, 0, 0, 38), UDim2.new(0, 0, 0, 10), Color3.fromRGB(245, 248, 255), Color3.fromRGB(220, 150, 0), 11, Enum.Font.GothamBold, "  🎯 เป้าหมาย: ยังไม่ได้เลือก"
sInfo.TextXAlignment = Enum.TextXAlignment.Left cnr(sInfo, 8) addSoftShadow(sInfo)

local pScr = Instance.new("ScrollingFrame", tb2) 
pScr.Size, pScr.Position, pScr.BackgroundColor3, pScr.BorderSizePixel, pScr.ScrollBarThickness = UDim2.new(1, 0, 0, 200), UDim2.new(0, 0, 0, 55), Color3.fromRGB(245, 248, 255), 0, 5 
cnr(pScr, 10) addSoftShadow(pScr)

local wBtn = Instance.new("TextButton", tb2) 
wBtn.Size, wBtn.Position, wBtn.BackgroundColor3, wBtn.TextColor3, wBtn.TextSize, wBtn.Font, wBtn.Text = UDim2.new(1, 0, 0, 42), UDim2.new(0, 0, 0, 265), Color3.fromRGB(230, 238, 250), Color3.fromRGB(60, 80, 120), 12, Enum.Font.GothamBold, "📌 เปิด/ปิด การเกาะติด: [ ปิดอยู่ ]" 
cnr(wBtn, 8) addSoftShadow(wBtn)

wBtn.MouseButton1Click:Connect(function()
    tLock = not tLock 
    wBtn.BackgroundColor3 = tLock and Color3.fromRGB(80, 200, 120) or Color3.fromRGB(230, 238, 250)
    wBtn.TextColor3 = tLock and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(60, 80, 120)
    wBtn.Text = "📌 เปิด/ปิด การเกาะติด: " .. (tLock and "[ เปิดใช้งาน ]" or "[ ปิดอยู่ ]")
end)

local function updPList()
    for _, c in pairs(pScr:GetChildren()) do if c:IsA("TextButton") then c:Destroy() end end
    local players = Plrs:GetPlayers() pScr.CanvasSize = UDim2.new(0, 0, 0, #players * 38)
    local off = 0
    for _, p in pairs(players) do
        if p ~= LP then
            local btn = Instance.new("TextButton", pScr) 
            btn.Size, btn.Position = UDim2.new(1, -6, 0, 34), UDim2.new(0, 3, 0, off)
            btn.BackgroundColor3 = (tP == p) and Color3.fromRGB(90, 140, 255) or Color3.fromRGB(255, 255, 255)
            btn.TextColor3, btn.TextSize, btn.Font, btn.Text = (tP == p) and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(60, 80, 120), 11, Enum.Font.GothamSemibold, "  👤 " .. p.Name
            btn.TextXAlignment = Enum.TextXAlignment.Left 
            cnr(btn, 6)
            btn.MouseButton1Click:Connect(function() tP = p sInfo.Text = "  🎯 เป้าหมาย: " .. p.Name updPList() end)
            off = off + 38
        end
    end
end
Plrs.PlayerAdded:Connect(updPList) Plrs.PlayerRemoving:Connect(updPList) task.spawn(updPList)

RunS.RenderStepped:Connect(function()
    if tLock and tP and tP.Character and tP.Character:FindFirstChild("HumanoidRootPart") then
        local mHRP = LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")
        if mHRP then mHRP.CFrame = tP.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 3) end
    end
end)

-- Tab 3 Content (ESP)
local espAct = false
local espB = Instance.new("TextButton", tb3) 
espB.Size, espB.Position, espB.BackgroundColor3, espB.TextColor3, espB.TextSize, espB.Font, espB.Text = UDim2.new(1, 0, 0, 42), UDim2.new(0, 0, 0, 10), Color3.fromRGB(230, 238, 250), Color3.fromRGB(60, 80, 120), 12, Enum.Font.GothamBold, "👀 เปิด/ปิด มองทะลุ: [ ปิดอยู่ ]" 
cnr(espB, 8) addSoftShadow(espB)

local function applyESP(p)
    if not espAct or p == LP then return end
    if p.Character then
        local hum = p.Character:FindFirstChildOfClass("Humanoid")
        if hum and hum.Health > 0 then
            if not p.Character:FindFirstChild("TakesaHighlight") then
                local hl = Instance.new("Highlight", p.Character)
                hl.Name = "TakesaHighlight"
                hl.FillColor = Color3.fromRGB(90, 180, 255)
                hl.OutlineColor = Color3.fromRGB(255, 255, 255)
                hl.FillTransparency = 0.4
            end
            if p.Character:FindFirstChild("Head") and not p.Character:FindFirstChild("TakesaNameTag") then
                local bg = Instance.new("BillboardGui", p.Character)
                bg.Name, bg.Adornee, bg.Size, bg.StudsOffset, bg.AlwaysOnTop = "TakesaNameTag", p.Character.Head, UDim2.new(0, 140, 0, 25), Vector3.new(0, 2.5, 0), true
                local txt = Instance.new("TextLabel", bg) 
                txt.Size, txt.BackgroundTransparency = UDim2.new(1,0,1,0), 1
                txt.TextColor3, txt.TextSize, txt.Font = Color3.fromRGB(50, 110, 210), 12, Enum.Font.GothamBold
                txt.Text = "👤 " .. p.Name
                txt.TextStrokeTransparency = 0 
            end
        else
            if p.Character:FindFirstChild("TakesaNameTag") then p.Character.TakesaNameTag:Destroy() end
            if p.Character:FindFirstChild("TakesaHighlight") then p.Character.TakesaHighlight:Destroy() end
        end
    end
end

local function removeESP(p)
    if p.Character then
        if p.Character:FindFirstChild("TakesaNameTag") then p.Character.TakesaNameTag:Destroy() end
        if p.Character:FindFirstChild("TakesaHighlight") then p.Character.TakesaHighlight:Destroy() end
    end
end

espB.MouseButton1Click:Connect(function()
    espAct = not espAct 
    espB.BackgroundColor3 = espAct and Color3.fromRGB(80, 200, 120) or Color3.fromRGB(230, 238, 250)
    espB.TextColor3 = espAct and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(60, 80, 120)
    espB.Text = "👀 เปิด/ปิด มองทะลุ: " .. (espAct and "[ เปิดใช้งาน ]" or "[ ปิดอยู่ ]")
    for _, p in pairs(Plrs:GetPlayers()) do if espAct then applyESP(p) else removeESP(p) end end
end)

Plrs.PlayerAdded:Connect(function(p) p.CharacterAdded:Connect(function() if espAct then task.wait(0.5) applyESP(p) end end) end)
Plrs.PlayerRemoving:Connect(function(p) removeESP(p) end)

for _, p in pairs(Plrs:GetPlayers()) do
    p.CharacterAdded:Connect(function() if espAct then task.wait(0.5) applyESP(p) end end)
end

RunS.RenderStepped:Connect(function()
    if espAct then for _, p in pairs(Plrs:GetPlayers()) do if p ~= LP then applyESP(p) end end end
end)

-- Tab 4 Content (Character + Anti-Knockback + Drone + Pro Features)
local noclip, spdJump, antiV, infZoom, flyAct, boostFPSAct, antiKBAct = false, false, false, false, false, false, false
local desyncAct, infJumpAct, airWalkAct = false, false, false
local flySpeed = 50
local bgConnection
local airWalkPlatform = nil

local function addT(pos, txt, cb)
    local b = Instance.new("TextButton", tb4) 
    b.Size, b.Position, b.BackgroundColor3, b.TextColor3, b.TextSize, b.Font, b.Text = UDim2.new(1, 0, 0, 38), UDim2.new(0, 0, 0, pos), Color3.fromRGB(230, 238, 250), Color3.fromRGB(60, 80, 120), 11, Enum.Font.GothamBold, txt 
    cnr(b, 8) addSoftShadow(b)
    b.MouseButton1Click:Connect(function() cb(b) end) return b
end

addT(10, "🚀 เปิด/ปิด Boost FPS (ลดแลค): [ ปิดอยู่ ]", function(b)
    boostFPSAct = not boostFPSAct
    b.BackgroundColor3 = boostFPSAct and Color3.fromRGB(80, 200, 120) or Color3.fromRGB(230, 238, 250)
    b.TextColor3 = boostFPSAct and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(60, 80, 120)
    b.Text = "🚀 เปิด/ปิด Boost FPS: " .. (boostFPSAct and "[ เปิด ]" or "[ ปิดอยู่ ]")
    pcall(function()
        Lighting.GlobalShadows = not boostFPSAct
        if setfpscap then setfpscap(boostFPSAct and 240 or 60) end
        for _, v in pairs(game:GetDescendants()) do if boostFPSAct and v:IsA("BasePart") then v.CastShadow = false end end
    end)
end)

addT(52, "🧱 เปิด/ปิด ทะลุกำแพง (Noclip): [ ปิดอยู่ ]", function(b)
    noclip = not noclip 
    b.BackgroundColor3 = noclip and Color3.fromRGB(80, 200, 120) or Color3.fromRGB(230, 238, 250)
    b.TextColor3 = noclip and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(60, 80, 120)
    b.Text = "🧱 เปิด/ปิด ทะลุกำแพง (Noclip): " .. (noclip and "[ เปิด ]" or "[ ปิดอยู่ ]")
end)

RunS.Stepped:Connect(function()
    if noclip and LP.Character then
        for _, part in pairs(LP.Character:GetDescendants()) do
            if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then part.CanCollide = false end
        end
    end
end)

addT(94, "🛡️ เปิด/ปิด กันปลิว (Anti-Knockback): [ ปิดอยู่ ]", function(b)
    antiKBAct = not antiKBAct
    b.BackgroundColor3 = antiKBAct and Color3.fromRGB(80, 200, 120) or Color3.fromRGB(230, 238, 250)
    b.TextColor3 = antiKBAct and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(60, 80, 120)
    b.Text = "🛡️ เปิด/ปิด กันปลิว: " .. (antiKBAct and "[ เปิดใช้งาน ]" or "[ ปิดอยู่ ]")
end)

RunS.RenderStepped:Connect(function()
    if antiKBAct and LP.Character then
        local hrp = LP.Character:FindFirstChild("HumanoidRootPart")
        if hrp then
            local vel = hrp.AssemblyLinearVelocity
            if math.abs(vel.X) > 40 or math.abs(vel.Z) > 40 then hrp.AssemblyLinearVelocity = Vector3.new(0, vel.Y, 0) end
        end
    end
end)

addT(136, "👻 เปิด/ปิด ร่างเงาอำพราง (Desync): [ ปิดอยู่ ]", function(b)
    desyncAct = not desyncAct
    b.BackgroundColor3 = desyncAct and Color3.fromRGB(80, 200, 120) or Color3.fromRGB(230, 238, 250)
    b.TextColor3 = desyncAct and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(60, 80, 120)
    b.Text = "👻 เปิด/ปิด ร่างเงาอำพราง (Desync): " .. (desyncAct and "[ เปิด ]" or "[ ปิดอยู่ ]")
end)

RunS.Heartbeat:Connect(function()
    if desyncAct and LP.Character and LP.Character:FindFirstChild("HumanoidRootPart") then
        local hrp = LP.Character.HumanoidRootPart
        local oldCF = hrp.CFrame
        hrp.CFrame = hrp.CFrame * CFrame.new(math.random(-4, 4), 0, math.random(-4, 4))
        RunS.RenderStepped:Wait()
        hrp.CFrame = oldCF
    end
end)

addT(178, "🦘 เปิด/ปิด กระโดดไม่จำกัด (Infinite Jump): [ ปิดอยู่ ]", function(b)
    infJumpAct = not infJumpAct
    b.BackgroundColor3 = infJumpAct and Color3.fromRGB(80, 200, 120) or Color3.fromRGB(230, 238, 250)
    b.TextColor3 = infJumpAct and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(60, 80, 120)
    b.Text = "🦘 เปิด/ปิด กระโดดไม่จำกัด: " .. (infJumpAct and "[ เปิด ]" or "[ ปิดอยู่ ]")
end)

UserInputService.JumpRequest:Connect(function()
    if infJumpAct and LP.Character and LP.Character:FindFirstChildOfClass("Humanoid") then
        LP.Character:FindFirstChildOfClass("Humanoid"):ChangeState(Enum.HumanoidStateType.Jumping)
    end
end)

addT(220, "☁️ เปิด/ปิด เดินบนอากาศ (Air Walk): [ ปิดอยู่ ]", function(b)
    airWalkAct = not airWalkAct
    b.BackgroundColor3 = airWalkAct and Color3.fromRGB(80, 200, 120) or Color3.fromRGB(230, 238, 250)
    b.TextColor3 = airWalkAct and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(60, 80, 120)
    b.Text = "☁️ เปิด/ปิด เดินบนอากาศ: " .. (airWalkAct and "[ เปิด ]" or "[ ปิดอยู่ ]")
end)

RunS.RenderStepped:Connect(function()
    if airWalkAct and LP.Character and LP.Character:FindFirstChild("HumanoidRootPart") then
        local hrp = LP.Character.HumanoidRootPart
        if not airWalkPlatform or not airWalkPlatform.Parent then
            airWalkPlatform = Instance.new("Part", workspace)
            airWalkPlatform.Size = Vector3.new(5, 1, 5)
            airWalkPlatform.Anchored = true
            airWalkPlatform.Transparency = 0.8
            airWalkPlatform.Color = Color3.fromRGB(90, 140, 255)
        end
        airWalkPlatform.CFrame = CFrame.new(hrp.Position.X, hrp.Position.Y - 3.5, hrp.Position.Z)
    else
        if airWalkPlatform then airWalkPlatform:Destroy() airWalkPlatform = nil end
    end
end)

local ugDepthBox = Instance.new("TextBox", tb4)
ugDepthBox.Size, ugDepthBox.Position = UDim2.new(1, 0, 0, 32), UDim2.new(0, 0, 0, 262)
ugDepthBox.BackgroundColor3, ugDepthBox.TextColor3, ugDepthBox.PlaceholderText, ugDepthBox.Text, ugDepthBox.TextSize, ugDepthBox.Font = Color3.fromRGB(245, 247, 252), Color3.fromRGB(50, 110, 210), "ความลึกมุดดิน (ค่าเริ่มต้น: 15)", "15", 11, Enum.Font.GothamBold
cnr(ugDepthBox, 6) addSoftShadow(ugDepthBox)

addT(300, "🕳️ เปิด/ปิด มุดดิน (Underground): [ ปิดอยู่ ]", function(b)
    safeZ = not safeZ
    b.BackgroundColor3 = safeZ and Color3.fromRGB(80, 200, 120) or Color3.fromRGB(230, 238, 250)
    b.TextColor3 = safeZ and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(60, 80, 120)
    b.Text = "🕳 เปิด/ปิด มุดดิน: " .. (safeZ and "[ เปิด ]" or "[ ปิดอยู่ ]")
    local hrp = LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")
    if safeZ and hrp then
        local depthVal = tonumber(ugDepthBox.Text) or 15
        fixedSafeY = hrp.Position.Y - depthVal
        ugPlat = Instance.new("Part", workspace)
        ugPlat.Name = "TakesaUndergroundPlatform"
        ugPlat.Size = Vector3.new(20, 1, 20)
        ugPlat.Anchored = true
        ugPlat.Transparency = 0.5
        ugPlat.BrickColor = BrickColor.new("Really black")
        ugPlat.CFrame = CFrame.new(hrp.Position.X, fixedSafeY, hrp.Position.Z)
        hrp.CFrame = ugPlat.CFrame + Vector3.new(0, 4, 0)
    else
        forceDisableUnderground()
    end
end)

addT(342, "🛡️ เปิด/ปิด กันตกโลก (Anti-Void): [ ปิดอยู่ ]", function(b)
    antiV = not antiV
    b.BackgroundColor3 = antiV and Color3.fromRGB(80, 200, 120) or Color3.fromRGB(230, 238, 250)
    b.TextColor3 = antiV and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(60, 80, 120)
    b.Text = "🛡️ เปิด/ปิด กันตกโลก: " .. (antiV and "[ เปิด ]" or "[ ปิดอยู่ ]")
end)

RunS.Stepped:Connect(function()
    if antiV and LP.Character then
        local hrp = LP.Character:FindFirstChild("HumanoidRootPart")
        if hrp and hrp.Position.Y < -50 then
            hrp.CFrame = hrp.CFrame + Vector3.new(0, 100, 0)
            hrp.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
        end
    end
end)

addT(384, "🔍 เปิด/ปิด ซูมหน้าจอไกลสุดๆ: [ ปิดอยู่ ]", function(b)
    infZoom = not infZoom
    b.BackgroundColor3 = infZoom and Color3.fromRGB(80, 200, 120) or Color3.fromRGB(230, 238, 250)
    b.TextColor3 = infZoom and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(60, 80, 120)
    b.Text = "🔍 เปิด/ปิด ซูมหน้าจอไกลสุดๆ: " .. (infZoom and "[ เปิด ]" or "[ ปิดอยู่ ]")
end)

RunS.RenderStepped:Connect(function()
    if infZoom then pcall(function() LP.CameraMaxZoomDistance = 999999 end)
    else pcall(function() if LP.CameraMaxZoomDistance == 999999 then LP.CameraMaxZoomDistance = 400 end end) end
end)

local flyCtrlGui = Instance.new("ScreenGui", gui)
flyCtrlGui.Name = "TakesaFlyControls"
flyCtrlGui.Enabled = false
flyCtrlGui.ResetOnSpawn = false

local btnUp = Instance.new("TextButton", flyCtrlGui)
btnUp.Size, btnUp.Position = UDim2.new(0, 45, 0, 45), UDim2.new(1, -60, 0.5, -55)
btnUp.BackgroundColor3, btnUp.TextColor3, btnUp.TextSize, btnUp.Font, btnUp.Text = Color3.fromRGB(90, 140, 255), Color3.fromRGB(255, 255, 255), 18, Enum.Font.GothamBold, "⬆"
cnr(btnUp, 22) addSoftShadow(btnUp)
local flyUpState, flyDownState = false, false
btnUp.MouseButton1Down:Connect(function() flyUpState = true end)
btnUp.MouseButton1Up:Connect(function() flyUpState = false end)

local btnDown = Instance.new("TextButton", flyCtrlGui)
btnDown.Size, btnDown.Position = UDim2.new(0, 45, 0, 45), UDim2.new(1, -60, 0.5, 5)
btnDown.BackgroundColor3, btnDown.TextColor3, btnDown.TextSize, btnDown.Font, btnDown.Text = Color3.fromRGB(90, 140, 255), Color3.fromRGB(255, 255, 255), 18, Enum.Font.GothamBold, "⬇"
cnr(btnDown, 22) addSoftShadow(btnDown)
btnDown.MouseButton1Down:Connect(function() flyDownState = true end)
btnDown.MouseButton1Up:Connect(function() flyDownState = false end)

addT(426, "✈ เปิด/ปิด ระบบบิน (Fly): [ ปิดอยู่ ]", function(b)
    flyAct = not flyAct
    b.BackgroundColor3 = flyAct and Color3.fromRGB(80, 200, 120) or Color3.fromRGB(230, 238, 250)
    b.TextColor3 = flyAct and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(60, 80, 120)
    b.Text = "✈ เปิด/ปิด ระบบบิน (Fly): " .. (flyAct and "[ เปิด ]" or "[ ปิดอยู่ ]")
    flyCtrlGui.Enabled = flyAct
    local char = LP.Character
    if not char then return end
    local hrp, hum = char:FindFirstChild("HumanoidRootPart"), char:FindFirstChildOfClass("Humanoid")
    if flyAct and hrp and hum then
        hum.PlatformStand = true
        local bg = Instance.new("BodyGyro", hrp) bg.P = 9e4 bg.maxTorque = Vector3.new(9e4, 9e4, 9e4)
        local bv = Instance.new("BodyVelocity", hrp) bv.velocity = Vector3.new(0,0,0) bv.maxForce = Vector3.new(9e4, 9e4, 9e4)
        bgConnection = RunS.RenderStepped:Connect(function()
            if not flyAct then return end
            local cam = workspace.CurrentCamera
            bg.cframe = cam.CFrame
            local moveDir = Vector3.new(0,0,0)
            local uS = game:GetService("UserInputService")
            if uS:IsKeyDown(Enum.KeyCode.W) then moveDir = moveDir + cam.CFrame.LookVector end
            if uS:IsKeyDown(Enum.KeyCode.S) then moveDir = moveDir - cam.CFrame.LookVector end
            if flyUpState then moveDir = moveDir + Vector3.new(0,1,0) end
            if flyDownState then moveDir = moveDir - Vector3.new(0,1,0) end
            bv.velocity = moveDir * flySpeed
        end)
    else
        flyUpState, flyDownState = false, false
        if hum then hum.PlatformStand = false end
        if hrp then for _, v in pairs(hrp:GetChildren()) do if v:IsA("BodyGyro") or v:IsA("BodyVelocity") then v:Destroy() end end end
        if bgConnection then bgConnection:Disconnect() end
    end
end)

local sBx = Instance.new("TextBox", tb4) sBx.Size, sBx.Position, sBx.BackgroundColor3, sBx.TextColor3, sBx.PlaceholderText, sBx.Text, sBx.TextSize, sBx.Font = UDim2.new(0.48,0,0,34), UDim2.new(0,0,0,468), Color3.fromRGB(245,247,252), Color3.fromRGB(50,110,210), "ความเร็ว", "60", 11, Enum.Font.GothamBold cnr(sBx, 6) addSoftShadow(sBx)
local jBx = Instance.new("TextBox", tb4) jBx.Size, jBx.Position, jBx.BackgroundColor3, jBx.TextColor3, jBx.PlaceholderText, jBx.Text, jBx.TextSize, jBx.Font = UDim2.new(0.48,0,0,34), UDim2.new(0.52,0,0,468), Color3.fromRGB(245,247,252), Color3.fromRGB(50,110,210), "กระโดด", "120", 11, Enum.Font.GothamBold cnr(jBx, 6) addSoftShadow(jBx)

addT(510, "⚡ เปิด/ปิด ล็อคความเร็ว & กระโดด: [ ปิดอยู่ ]", function(b)
    spdJump = not spdJump 
    b.BackgroundColor3 = spdJump and Color3.fromRGB(80, 200, 120) or Color3.fromRGB(230, 238, 250)
    b.TextColor3 = spdJump and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(60, 80, 120)
    b.Text = "⚡ เปิด/ปิด ความเร็ว: " .. (spdJump and "[ เปิด ]" or "[ ปิดอยู่ ]")
end)

RunS.RenderStepped:Connect(function()
    if spdJump and LP.Character then
        local hum = LP.Character:FindFirstChildOfClass("Humanoid")
        if hum then
            hum.WalkSpeed = tonumber(sBx.Text) or 60
            if hum.UseJumpPower then hum.JumpPower = tonumber(jBx.Text) or 120 else hum.JumpHeight = (tonumber(jBx.Text) or 120) / 4 end
        end
    end
end)

local droneSpeedBox = Instance.new("TextBox", tb4)
droneSpeedBox.Size, droneSpeedBox.Position = UDim2.new(1, 0, 0, 34), UDim2.new(0, 0, 0, 552)
droneSpeedBox.BackgroundColor3, droneSpeedBox.TextColor3, droneSpeedBox.PlaceholderText, droneSpeedBox.Text, droneSpeedBox.TextSize, droneSpeedBox.Font = Color3.fromRGB(245, 247, 252), Color3.fromRGB(50, 110, 210), "ความเร็วโดรน (ค่าเริ่มต้น: 60)", "60", 11, Enum.Font.GothamBold
cnr(droneSpeedBox, 6) addSoftShadow(droneSpeedBox)

local droneActive = false
local dronePart = nil
local droneConn = nil

local droneGui = Instance.new("ScreenGui", gui)
droneGui.Name = "TakesaDroneControls"
droneGui.Enabled = false
droneGui.ResetOnSpawn = false

local exitDroneBtn = Instance.new("TextButton", droneGui)
exitDroneBtn.Size, exitDroneBtn.Position = UDim2.new(0, 140, 0, 40), UDim2.new(0.5, -70, 0, 15)
exitDroneBtn.BackgroundColor3, exitDroneBtn.TextColor3, exitDroneBtn.TextSize, exitDroneBtn.Font, exitDroneBtn.Text = Color3.fromRGB(240, 100, 100), Color3.fromRGB(255, 255, 255), 12, Enum.Font.GothamBold, "❌ ออกจากโดรน"
cnr(exitDroneBtn, 8) addSoftShadow(exitDroneBtn)

local dUp = Instance.new("TextButton", droneGui)
dUp.Size, dUp.Position = UDim2.new(0, 45, 0, 45), UDim2.new(1, -60, 0.5, -55)
dUp.BackgroundColor3, dUp.TextColor3, dUp.TextSize, dUp.Font, dUp.Text = Color3.fromRGB(90, 140, 255), Color3.fromRGB(255, 255, 255), 18, Enum.Font.GothamBold, "⬆"
cnr(dUp, 22) addSoftShadow(dUp)

local dDown = Instance.new("TextButton", droneGui)
dDown.Size, dDown.Position = UDim2.new(0, 45, 0, 45), UDim2.new(1, -60, 0.5, 5)
dDown.BackgroundColor3, dDown.TextColor3, dDown.TextSize, dDown.Font, dDown.Text = Color3.fromRGB(90, 140, 255), Color3.fromRGB(255, 255, 255), 18, Enum.Font.GothamBold, "⬇"
cnr(dDown, 22) addSoftShadow(dDown)

local dForward = Instance.new("TextButton", droneGui)
dForward.Size, dForward.Position = UDim2.new(0, 45, 0, 45), UDim2.new(0, 20, 0.5, -55)
dForward.BackgroundColor3, dForward.TextColor3, dForward.TextSize, dForward.Font, dForward.Text = Color3.fromRGB(90, 140, 255), Color3.fromRGB(255, 255, 255), 14, Enum.Font.GothamBold, "W"
cnr(dForward, 22) addSoftShadow(dForward)

local dBackward = Instance.new("TextButton", droneGui)
dBackward.Size, dBackward.Position = UDim2.new(0, 45, 0, 45), UDim2.new(0, 20, 0.5, 5)
dBackward.BackgroundColor3, dBackward.TextColor3, dBackward.TextSize, dBackward.Font, dBackward.Text = Color3.fromRGB(90, 140, 255), Color3.fromRGB(255, 255, 255), 14, Enum.Font.GothamBold, "S"
cnr(dBackward, 22) addSoftShadow(dBackward)

local dLeft = Instance.new("TextButton", droneGui)
dLeft.Size, dLeft.Position = UDim2.new(0, 40, 0, 40), UDim2.new(0, 70, 0.5, -25)
dLeft.BackgroundColor3, dLeft.TextColor3, dLeft.TextSize, dLeft.Font, dLeft.Text = Color3.fromRGB(90, 140, 255), Color3.fromRGB(255, 255, 255), 14, Enum.Font.GothamBold, "A"
cnr(dLeft, 20) addSoftShadow(dLeft)

local dRight = Instance.new("TextButton", droneGui)
dRight.Size, dRight.Position = UDim2.new(0, 40, 0, 40), UDim2.new(0, 120, 0.5, -25)
dRight.BackgroundColor3, dRight.TextColor3, dRight.TextSize, dRight.Font, dRight.Text = Color3.fromRGB(90, 140, 255), Color3.fromRGB(255, 255, 255), 14, Enum.Font.GothamBold, "D"
cnr(dRight, 20) addSoftShadow(dRight)

local dUpState, dDownState, dFwdState, dBwdState, dLeftState, dRightState = false, false, false, false, false, false

dUp.MouseButton1Down:Connect(function() dUpState = true end)
dUp.MouseButton1Up:Connect(function() dUpState = false end)
dDown.MouseButton1Down:Connect(function() dDownState = true end)
dDown.MouseButton1Up:Connect(function() dDownState = false end)

dForward.MouseButton1Down:Connect(function() dFwdState = true end)
dForward.MouseButton1Up:Connect(function() dFwdState = false end)
dBackward.MouseButton1Down:Connect(function() dBwdState = true end)
dBackward.MouseButton1Up:Connect(function() dBwdState = false end)

dLeft.MouseButton1Down:Connect(function() dLeftState = true end)
dLeft.MouseButton1Up:Connect(function() dLeftState = false end)
dRight.MouseButton1Down:Connect(function() dRightState = true end)
dRight.MouseButton1Up:Connect(function() dRightState = false end)

addT(594, "🛸 เปิด/ปิด โหมดโดรนสำรวจ: [ ปิดอยู่ ]", function(b)
    droneActive = not droneActive
    b.BackgroundColor3 = droneActive and Color3.fromRGB(80, 200, 120) or Color3.fromRGB(230, 238, 250)
    b.TextColor3 = droneActive and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(60, 80, 120)
    b.Text = "🛸 เปิด/ปิด โหมดโดรนสำรวจ: " .. (droneActive and "[ เปิดใช้งาน ]" or "[ ปิดอยู่ ]")
    droneGui.Enabled = droneActive
    
    local char = LP.Character
    if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    
    if droneActive then
        if hrp then
            dronePart = Instance.new("Part", workspace)
            dronePart.Name = "TakesaDroneCameraPart"
            dronePart.Size = Vector3.new(1, 1, 1)
            dronePart.Transparency = 1
            dronePart.Anchored = true
            dronePart.CanCollide = false
            dronePart.CFrame = hrp.CFrame + Vector3.new(0, 5, 0)
            
            Camera.CameraSubject = dronePart
            
            droneConn = RunS.RenderStepped:Connect(function()
                if not droneActive or not dronePart then return end
                local cam = workspace.CurrentCamera
                local moveDir = Vector3.new(0, 0, 0)
                local uS = game:GetService("UserInputService")
                
                if dFwdState or uS:IsKeyDown(Enum.KeyCode.W) then moveDir = moveDir + cam.CFrame.LookVector end
                if dBwdState or uS:IsKeyDown(Enum.KeyCode.S) then moveDir = moveDir - cam.CFrame.LookVector end
                if dLeftState or uS:IsKeyDown(Enum.KeyCode.A) then moveDir = moveDir - cam.CFrame.RightVector end
                if dRightState or uS:IsKeyDown(Enum.KeyCode.D) then moveDir = moveDir + cam.CFrame.RightVector end
                if dUpState then moveDir = moveDir + Vector3.new(0, 1, 0) end
                if dDownState then moveDir = moveDir - Vector3.new(0, 1, 0) end
                
                local currentDroneSpeed = tonumber(droneSpeedBox.Text) or 60
                dronePart.CFrame = dronePart.CFrame + (moveDir * (currentDroneSpeed / 50))
            end)
        end
    else
        dUpState, dDownState, dFwdState, dBwdState, dLeftState, dRightState = false, false, false, false, false, false
        if droneConn then droneConn:Disconnect() end
        if dronePart then dronePart:Destroy() dronePart = nil end
        if char and char:FindFirstChildOfClass("Humanoid") then
            Camera.CameraSubject = char:FindFirstChildOfClass("Humanoid")
        end
    end
end)

exitDroneBtn.MouseButton1Click:Connect(function()
    if droneActive then
        droneActive = false
        droneGui.Enabled = false
        dUpState, dDownState, dFwdState, dBwdState, dLeftState, dRightState = false, false, false, false, false, false
        if droneConn then droneConn:Disconnect() end
        if dronePart then dronePart:Destroy() dronePart = nil end
        local char = LP.Character
        if char and char:FindFirstChildOfClass("Humanoid") then
            Camera.CameraSubject = char:FindFirstChildOfClass("Humanoid")
        end
    end
end)

addT(636, "💀 รีเซ็ตตัวละคร (Force Reset)", function(b)
    pcall(function()
        local hum = LP.Character and LP.Character:FindFirstChildOfClass("Humanoid")
        if hum then hum.Health = 0 end
    end)
end)

-- Tab 5 Content (Music Player)
local musicLabel = Instance.new("TextLabel", tb5)
musicLabel.Size, musicLabel.Position, musicLabel.BackgroundTransparency = UDim2.new(1, 0, 0, 20), UDim2.new(0, 0, 0, 0), true
musicLabel.TextColor3, musicLabel.TextSize, musicLabel.Font = Color3.fromRGB(60, 80, 120), 11, Enum.Font.GothamBold
musicLabel.Text = "🎵 กด 1 ครั้ง = ใส่ ID | ถ้าอยากคัดลอกให้แตะชื่อเพลง 2 ครั้ง"
musicLabel.TextXAlignment = Enum.TextXAlignment.Left

local musicBox = Instance.new("TextBox", tb5)
musicBox.Size, musicBox.Position = UDim2.new(1, 0, 0, 35), UDim2.new(0, 0, 0, 22)
musicBox.BackgroundColor3, musicBox.TextColor3, musicBox.PlaceholderText, musicBox.TextSize, musicBox.Font = Color3.fromRGB(245, 247, 252), Color3.fromRGB(50, 110, 210), "พิมพ์รหัสเพลง หรือจิ้มเลือกด้านล่าง...", 11, Enum.Font.GothamBold
cnr(musicBox, 6) addSoftShadow(musicBox)

local playMusicBtn = Instance.new("TextButton", tb5)
playMusicBtn.Size, playMusicBtn.Position = UDim2.new(0.48, 0, 0, 35), UDim2.new(0, 0, 0, 62)
playMusicBtn.BackgroundColor3, playMusicBtn.TextColor3, playMusicBtn.TextSize, playMusicBtn.Font, playMusicBtn.Text = Color3.fromRGB(80, 200, 120), Color3.fromRGB(255, 255, 255), 11, Enum.Font.GothamBold, "▶ เล่นเพลง"
cnr(playMusicBtn, 6) addSoftShadow(playMusicBtn)

local stopMusicBtn = Instance.new("TextButton", tb5)
stopMusicBtn.Size, stopMusicBtn.Position = UDim2.new(0.48, 0, 0, 35), UDim2.new(0.52, 0, 0, 62)
stopMusicBtn.BackgroundColor3, stopMusicBtn.TextColor3, stopMusicBtn.TextSize, stopMusicBtn.Font, stopMusicBtn.Text = Color3.fromRGB(240, 100, 100), Color3.fromRGB(255, 255, 255), 11, Enum.Font.GothamBold, "⏹ ปิดเพลง"
cnr(stopMusicBtn, 6) addSoftShadow(stopMusicBtn)

local songScroll = Instance.new("ScrollingFrame", tb5)
songScroll.Size, songScroll.Position, songScroll.BackgroundTransparency, songScroll.ScrollBarThickness = UDim2.new(1, 0, 0, 280), UDim2.new(0, 0, 0, 105), true, 5
songScroll.ScrollBarImageColor3 = Color3.fromRGB(90, 140, 255)

local musicList = {
    {name = "สายเบียว 🌸✨", id = "139197283079137"},
    {name = "สายเบียว 2 🌸✨", id = "137486973114353"},
    {name = "สายเบียว 3 🌸✨", id = "123511627553696"},
    {name = "สายเบียว 4 🌸✨", id = "119322956539829"},
    {name = "สายเบียว 5 🌸✨", id = "76650356472656"},
    {name = "สายเบียว 6 🌸✨", id = "80991014952323"},
    {name = "สายเบียว 7 🌸✨", id = "80442979651569"},
    {name = "สายเบียว 8 🌸✨", id = "80197259053353"},
    {name = "สายเบียว 9 🌸✨", id = "133900373762715"},
    {name = "สายเบียว 10 🌸✨", id = "86173461299180"},
    {name = "สายเบียว 11 🌸✨", id = "94229502650041"},
    {name = "สายเบียว 12 🌸✨", id = "123244893615420"},
    {name = "สายเบียว 13 🌸✨", id = "126545930598620"},
    {name = "สายเบียว 14 🌸✨", id = "87570666848900"},
    {name = "สายเบียว 15 🌸✨", id = "121379700947776"},
    {name = "เพลงใหม่ 1 🎵", id = "115189039255362"},
    {name = "เพลงใหม่ 3 🎵", id = "74697049223758"},
    {name = "เพลงใหม่ 4 🎵", id = "110919391228823"},
    {name = "เพลงใหม่ 5 🎵", id = "121242950842428"},
    {name = "เพลงใหม่ 6 🎵", id = "105334271155482"},
    {name = "เพลงใหม่ 7 🎵", id = "134140709844049"},
    {name = "เพลงใหม่ 8 🎵", id = "132049153370517"},
    {name = "เบสหนัก 🔊", id = "72695526421040"},
    {name = "ทนแดนซ์", id = "81533059856274"},
    {name = "แดนซ์มันๆ", id = "108937679300559"},
    {name = "แดนซ์มันๆ 2", id = "99905891709896"},
    {name = "แดนซ์มันๆ 3", id = "124166975687737"},
    {name = "แดนซ์มันๆ 4", id = "120017030311480"},
    {name = "กลัวว่าฉันจะไม่เสียใจ", id = "101470831981570"},
    {name = "ดึกแล้ว", id = "84539223438943"},
    {name = "Song ID 131160502501783", id = "131160502501783"},
    {name = "เอลลา", id = "79999089664644"},
    {name = "อัศจรรย์ x1", id = "99657681572808"},
    {name = "ข้ารับใช้ปีศาจ", id = "106722321672833"},
    {name = "กลีบหนึ่งพันซากุระ", id = "137501677821339"},
    {name = "ซฆ์โปรเกเทพตุ๊ด Remix", id = "133833393017649"},
    {name = "อย่าอิ่มพี่ไวาย แดนซ์", id = "105031411672820"},
    {name = "ขี้หลังควาย", id = "140253483900378"},
    {name = "BUM BUM BUM", id = "121690279003988"},
    {name = "WE FOUND L", id = "99421411270011"},
    {name = "NuCapCap(GayNoi)", id = "127356451659099"},
    {name = "WXH x โอชัวร์ Thai 46", id = "119384998246057"},
    {name = "DJ_Guitar", id = "89325251642828"},
    {name = "ยายแล่ม", id = "81303476351949"},
    {name = "choose(Azov)", id = "81455612889004"},
    {name = "ใบวัน(Azov)", id = "88479490836382"},
    {name = "CLOUD | KICAU MANIA", id = "136298946425465"},
    {name = "ลอส คอนโทรล", id = "94403836240383"},
    {name = "Test Sound Thai", id = "105315854461338"},
    {name = "One Love Zing Zing แดนซ์", id = "78424397783913"},
    {name = "กลัวว่าฉันจะเสียกางเกงใน", id = "72505786943707"},
    {name = "shops(ดึง)", id = "84485792492722"},
    {name = "นางฟ้า", id = "130081842972719"},
    {name = "รักınəyev > Ruyev", id = "127253081806208"},
    {name = "บราซิลโหดๆ", id = "74904585870595"},
    {name = "มีอะไรคุยกับพี่ (มาลี)", id = "80737153055861"},
    {name = "ตดรอบตัด ปื่นๆ", id = "78011874890289"},
    {name = "วอดส์", id = "126877356084859"},
    {name = "เสียงดังๆ ภาษาเวียดนาม", id = "8797756460"},
    {name = "กูเป็นพระเจ้า และมึงก็เป็นพ่อมึงด้วย", id = "5209603084"},
    {name = "MonsterDavi's back", id = "125311861564214"},
    {name = "yพianV2", id = "107571001738028"},
    {name = "ยูตด่ง", id = "125812293155661"},
    {name = "ผู้พัน-ยังเจ-สั้น", id = "8204316369"},
    {name = "ช่รอย", id = "75449789929821"},
    {name = "บอลโลกแดนซ์", id = "121362946861937"},
    {name = "แดนซ์อังกฤษ แรร็อยู่", id = "86987612038693"},
    {name = "ธีโยเฮ", id = "103290244915002"},
    {name = "หนาวนี้คอดใคร", id = "121668833629828"},
    {name = "เอ็มออนิว", id = "85729415298942"},
    {name = "-ชาดิน-ยังต้ำ", id = "80512451099660"},
    {name = "นครดารา", id = "77209823972345"},
    {name = "ป้าจิ๊ก", id = "119037495327681"},
    {name = "ฆาตกรความจำเสื่อม", id = "97029637448189"},
    {name = "มันคงเป็นไปไม่ได้", id = "91350648636448"},
    {name = "ที่น่ะไร", id = "132258931996503"},
    {name = "เสียงรถลั่นๆ", id = "6983172786"},
    {name = "กุหลาบ", id = "134041350719923"},
    {name = "เก่า", id = "78715697950477"},
    {name = "หากตอนนี้เธออยังไม่เกิด TAXI", id = "107698257790582"},
    {name = "I Took A Pill In Ibiza", id = "112350427114020"},
    {name = "เตรสส", id = "133885276548540"},
    {name = "Y Que Fue?", id = "125902207303673"},
    {name = "อิมฮั้วอายฮิ", id = "74758860515324"},
    {name = "แม่หม่ม", id = "92203311285140"},
    {name = "บอลอยู่ใส", id = "74322637197743"},
    {name = "ขำเกรียนๆ", id = "8449305114"},
    {name = "นัดนี่ถือว่าพี่ขอ", id = "134373587254824"},
    {name = "อย่ากรี๊ดพี่จี้ขนาดนั้น", id = "91426225556408"},
    {name = "ขอโทษบอลหลุดตีนเข้าประตู", id = "136456506932813"},
    {name = "อีกะrelanเริ่งหุบปาก", id = "8452537854"},
    {name = "ps2ดัง", id = "3482374640"},
    {name = "ถึงมึงจะพยายามแค่ไหนเขาก็ไปรักมึงหรอก", id = "7364993780"},
    {name = "ไม่ไหวววแล้วอิก๋า", id = "88782461492324"},
    {name = "ขอตัวๆ", id = "8535914549"},
    {name = "ด่าโปธ", id = "2548576192"},
    {name = "ไอ่หน้า he", id = "8012653378"},
    {name = "คนที่ป่าฉัน", id = "140198287497881"},
    {name = "ฤดูร้อนของหัวใจ", id = "131322070745048"},
    {name = "ดี่สาวโดนเส้น", id = "92959928042658"},
    {name = "ไฟหน้าที่ม้ให้จับ", id = "118088761921960"},
    {name = "ใจบาง เสียงปกติ", id = "74367872377052"},
    {name = "My Loudest", id = "108467444707040"},
    {name = "รักกันจนวันตาย", id = "121517337369247"},
    {name = "เล่นได้ลาบมาก", id = "128320250052591"},
    {name = "ดับอนาค ( ดังซั ) / บาลีล่า", id = "2875685811"},
    {name = "sea", id = "127872646798255"},
    {name = "ฝากให้เขารักเธอมากกว่าผม", id = "81049913681783"},
    {name = "แมะแมะแมะ", id = "75038580640135"},
    {name = "######", id = "114252241329278"},
    {name = "จุ๊กกรุ๊ว V2", id = "119110754120034"},
    {name = "บักแล้วคร้าบ", id = "102068629587339"},
    {name = "เขมร1", id = "109192549525612"},
    {name = "PENROY", id = "120636229022344"},
    {name = "SongOne", id = "103637998030679"},
    {name = "Screaming chicken on tree meme", id = "117909139728666"},
    {name = "[ดัง] ด่าใน ติ๊กต็อก", id = "8072155067"},
    {name = "กินกันเสร็จก็กลับๆ", id = "71746449065680"},
    {name = "Scared (Azov)", id = "101470831981570"},
    {name = "ถ้าฉันรักแล้วเธออย่าเลว", id = "101665290190164"},
    {name = "shake that", id = "123871565356517"},
    {name = "Japan", id = "109337680029292"},
    {name = "ปู่อยากต้าย", id = "127536192254037"},
    {name = "醉九门回忆 / แดนจีน", id = "124384558101360"},
    {name = "MinecraftAutumn", id = "108483365019009"},
    {name = "คนไม่เอาถ่าน", id = "139163665055553"},
    {name = "ศักดิ์ศรี", id = "139364859035367"},
    {name = "จริงใจแล้วไม่เห็นค่า Remix", id = "98360514812928"},
    {name = "Thoranee Gunsaeng B", id = "1845861259"},
    {name = "ยาวไป", id = "104528386279346"},
    {name = "đánh mất em", id = "129165024150026"},
    {name = "ผู้เล่า", id = "80302234019139"},
    {name = "บักอ้ายหลายเด้อ", id = "114490631057155"},
    {name = "เพลงที่แชมชอบ", id = "72480594505111"},
    {name = "เกเกRemix(GayNoi)", id = "106672241567740"},
    {name = "ผมไม่รู้", id = "115239828846271"},
    {name = "มานี่มา", id = "112666582385808"},
    {name = "ใบลา", id = "120001813945635"},
    {name = "i miss u!!! (2000)", id = "127562038902452"},
    {name = "Jeb Nid Nid", id = "101255439740047"},
    {name = "yพีโรโม", id = "93904884639656"},
    {name = "เมกำฝัน", id = "125678930927209"},
    {name = "ARIA", id = "97785104909396"},
    {name = "คิดถึงเหลือ", id = "107771886176267"},
    {name = "วิกลัยหลายใจ", id = "77855967456690"},
    {name = "Mimo1", id = "111835636697812"},
    {name = "เธมร V.แดนซ์", id = "102936148496865"},
    {name = "มอเรนา แดนซ์", id = "83399937548339"},
    {name = "แดนซ์", id = "115492336583856"},
    {name = "Zombie หมอลำแดนซ์", id = "114128715751316"},
    {name = "lollipop แดนซ์", id = "100991657598498"},
    {name = "เซ็บๆ / skibidi", id = "120322544127249"},
    {name = "freed from desire แดนซ์มันๆ", id = "87524510292635"},
    {name = "samanthita_Image", id = "1233901110"},
    {name = "Eastern Adventure - 60", id = "1843529632"},
    {name = "tae", id = "2616834021"},
    {name = "ดำโปร 2019", id = "2948576192"},
    {name = "เพลงรักเพลงแรก", id = "85598514920576"},
    {name = "Baby Shark", id = "131822907093877"},
    {name = "ไก่เถื่อนเหอ", id = "107249069416114"},
    {name = "หนมคก", id = "71305893329994"},
    {name = "2nd_part", id = "99234295745057"},
    {name = "3rd_part", id = "96046650797488"},
    {name = "LAZZER", id = "104473870156356"},
    {name = "12", id = "120876234312672"},
    {name = "T DED Taj Mahal", id = "73989721978244"},
    {name = "ผู้หญิงคนไหน", id = "130065665706680"},
    {name = "Once Upon A Time", id = "82475562998551"},
    {name = "50/100", id = "125356270448095"},
    {name = "aunwarpinthemix_800", id = "75939658512385"},
    {name = "Gandeutang", id = "1835605224"},
    {name = "เกลล้ง silly fools", id = "89123368458503"},
    {name = "อาหมวยแดนซ์", id = "94466059598423"},
    {name = "韦成龙14", id = "126846792948717"},
    {name = "ไก่ / Бัวр", id = "7311938606"},
    {name = "Yok sai Yok khwa", id = "128363709380383"},
    {name = "Naza", id = "123055306215100"},
    {name = "Sao Lam Sing", id = "130838220880660"},
    {name = "มาป๋าของฮาน", id = "126140800444986"},
    {name = "ทุกคนคือลูกกูp9d-เรือน", id = "114417841427354"},
    {name = "ซ่า-เรือน", id = "130296691160330"},
    {name = "ขอโทษคับพี่xd", id = "118443319145752"},
    {name = "ขอลายเซ็นหน่อยครับ", id = "96323221573716"},
    {name = "เสียงคราง-เรือนๆ", id = "101108840775263"},
    {name = "เขมรหนี-เรือน", id = "132208892141622"},
    {name = "เสียงประชาสัมพันธ์เปิด", id = "8511588544"},
    {name = "7-11 Sound Thailand", id = "133696608957144"},
    {name = "annoying ah tiktok filter audio V1", id = "80487195372323"},
    {name = "Laughing sound effects", id = "8765911711"},
    {name = "ฮันแน่ อยากโดนเยตูดไปล่า", id = "4876402335"},
    {name = "ออกไป!!!", id = "114147878092393"},
    {name = "อย่ายุ่ง", id = "129620432980586"},
    {name = "หยุดดีกันๆ", id = "123470213268522"},
    {name = "ลองรัก", id = "87109804704340"},
    {name = "เพลงปัสเทคมันส์", id = "125014875225876"},
    {name = "แดนซ์2025", id = "732216245483171"},
    {name = "มาติ๊ดสักหน่อย แดนซ์2024", id = "120255584589934"},
    {name = "โยกหัว", id = "114498642134215"},
    {name = "อินเดีย แดนซ์", id = "107636869435674"},
    {name = "ยืนเด้งอยู่ดีๆ มีคนเรียกว่าพี่คนสวย แดนซ์", id = "118709077830152"},
    {name = "แคน รำซิ่ง", id = "107340964993917"},
    {name = "ระยองฮิ - เอกมัย แดนซ์", id = "83919005919466"},
    {name = "เจ้าๆ", id = "1837943588"},
    {name = "สาวเมืองนนท์", id = "125755511535427"},
    {name = "นิ่งแต่ซิ่ง", id = "90888787859288"},
    {name = "บางระจัน", id = "126380171075625"},
    {name = "ตามจังหวะ", id = "123418190503573"},
    {name = "เลดี้เบีย", id = "114056884370316"},
    {name = "หยิบหยางซิ", id = "133051020869411"},
    {name = "HANNA", id = "7521779250"},
    {name = "sax dance", id = "85624994877786"},
    {name = "หากว่าเธอผ่านได้ยิน", id = "119461101519061"},
    {name = "Monday night คืนจันทร์ - LOSO", id = "122895517618571"},
    {name = "รังสิตติดแกรม", id = "95342421407401"},
    {name = "แดงกับเขียว", id = "82527546792928"},
    {name = "โทน", id = "92315848063057"},
    {name = "กันตรึมสกาแดนซ์", id = "130818537976103"},
    {name = "ยังโอมเศร้า", id = "99441501327992"}
}

songScroll.CanvasSize = UDim2.new(0, 0, 0, #musicList * 40 + 10)

for i, song in ipairs(musicList) do
    local songBtn = Instance.new("TextButton", songScroll)
    songBtn.Size, songBtn.Position = UDim2.new(1, -5, 0, 35), UDim2.new(0, 0, 0, (i - 1) * 40 + 5)
    songBtn.BackgroundColor3, songBtn.TextColor3, songBtn.TextSize, songBtn.Font = Color3.fromRGB(245, 247, 252), Color3.fromRGB(60, 80, 120), 11, Enum.Font.GothamSemibold
    songBtn.Text = "🎵 " .. song.name
    songBtn.TextXAlignment = Enum.TextXAlignment.Left
    cnr(songBtn, 6)
    
    local lastClick = 0
    songBtn.MouseButton1Click:Connect(function()
        local currentTime = tick()
        if currentTime - lastClick < 0.4 then
            -- กด 2 ครั้ง (Double Click) -> คัดลอก ID
            pcall(function()
                if setclipboard then
                    setclipboard(song.id)
                    songBtn.Text = "✅ คัดลอก ID สำเร็จ!"
                    songBtn.BackgroundColor3 = Color3.fromRGB(80, 200, 120)
                    songBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
                    task.wait(1.5)
                    songBtn.Text = "🎵 " .. song.name
                    songBtn.BackgroundColor3 = Color3.fromRGB(245, 247, 252)
                    songBtn.TextColor3 = Color3.fromRGB(60, 80, 120)
                else
                    songBtn.Text = "⚠️ Executor ไม่รองรับคัดลอก"
                    task.wait(1.5)
                    songBtn.Text = "🎵 " .. song.name
                end
            end)
            lastClick = 0
        else
            -- กด 1 ครั้ง -> ใส่ ID ลงช่องกรอกเพลง
            musicBox.Text = song.id
            lastClick = currentTime
        end
    end)
end

playMusicBtn.MouseButton1Click:Connect(function()
    local id = tonumber(musicBox.Text)
    if id then
        pcall(function()
            localSound.SoundId = "rbxassetid://" .. id
            localSound:Play()
            playMusicBtn.Text = "✅ กำลังเล่น!"
            task.wait(1.5)
            playMusicBtn.Text = "▶️ เล่นเพลง"
        end)
    else
        playMusicBtn.Text = "⚠️ ใส่รหัสก่อน!"
        task.wait(1.5)
        playMusicBtn.Text = "▶ เล่นเพลง"
    end
end)

stopMusicBtn.MouseButton1Click:Connect(function()
    pcall(function()
        localSound:Stop()
        stopMusicBtn.Text = "⏹️ ปิดแล้ว"
        task.wait(1.5)
        stopMusicBtn.Text = "⏹ ปิดเพลง"
    end)
end)

-- Tab 6 Content (🎯 ระบบล็อกเป้าผู้เล่นอัตโนมัติ)
local lockTarget = nil
local targetLockEnabled = false

local lockInfoLbl = Instance.new("TextLabel", tb6)
lockInfoLbl.Size, lockInfoLbl.Position = UDim2.new(1, 0, 0, 38), UDim2.new(0, 0, 0, 10)
lockInfoLbl.BackgroundColor3, lockInfoLbl.TextColor3, lockInfoLbl.TextSize, lockInfoLbl.Font, lockInfoLbl.Text = Color3.fromRGB(245, 248, 255), Color3.fromRGB(220, 150, 0), 11, Enum.Font.GothamBold, "  🎯 เป้าหมายที่กำลังล็อก: [ ยังไม่ได้เลือก ]"
lockInfoLbl.TextXAlignment = Enum.TextXAlignment.Left cnr(lockInfoLbl, 8) addSoftShadow(lockInfoLbl)

local targetScr = Instance.new("ScrollingFrame", tb6)
targetScr.Size, targetScr.Position, targetScr.BackgroundColor3, targetScr.BorderSizePixel, targetScr.ScrollBarThickness = UDim2.new(1, 0, 0, 170), UDim2.new(0, 0, 0, 55), Color3.fromRGB(245, 248, 255), 0, 5
cnr(targetScr, 10) addSoftShadow(targetScr)

local toggleLockBtn = Instance.new("TextButton", tb6)
toggleLockBtn.Size, toggleLockBtn.Position = UDim2.new(1, 0, 0, 42), UDim2.new(0, 0, 0, 235), Color3.fromRGB(230, 238, 250), Color3.fromRGB(60, 80, 120), 12, Enum.Font.GothamBold, "🎯 เปิด/ปิด ล็อกเป้ากล้อง: [ ปิดอยู่ ]"
cnr(toggleLockBtn, 8) addSoftShadow(toggleLockBtn)

toggleLockBtn.MouseButton1Click:Connect(function()
    targetLockEnabled = not targetLockEnabled
    toggleLockBtn.BackgroundColor3 = targetLockEnabled and Color3.fromRGB(80, 200, 120) or Color3.fromRGB(230, 238, 250)
    toggleLockBtn.TextColor3 = targetLockEnabled and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(60, 80, 120)
    toggleLockBtn.Text = "🎯 เปิด/ปิด ล็อกเป้ากล้อง: " .. (targetLockEnabled and "[ เปิดใช้งาน ]" or "[ ปิดอยู่ ]")
end)

local function updateTargetList()
    for _, c in pairs(targetScr:GetChildren()) do if c:IsA("TextButton") then c:Destroy() end end
    local players = Plrs:GetPlayers()
    targetScr.CanvasSize = UDim2.new(0, 0, 0, #players * 38)
    local off = 0
    for _, p in pairs(players) do
        if p ~= LP then
            local btn = Instance.new("TextButton", targetScr)
            btn.Size, btn.Position = UDim2.new(1, -6, 0, 34), UDim2.new(0, 3, 0, off)
            btn.BackgroundColor3 = (lockTarget == p) and Color3.fromRGB(90, 140, 255) or Color3.fromRGB(255, 255, 255)
            btn.TextColor3, btn.TextSize, btn.Font, btn.Text = (lockTarget == p) and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(60, 80, 120), 11, Enum.Font.GothamSemibold, "  👤 " .. p.Name
            btn.TextXAlignment = Enum.TextXAlignment.Left
            cnr(btn, 6)
            btn.MouseButton1Click:Connect(function()
                lockTarget = p
                lockInfoLbl.Text = "  🎯 เป้าหมายที่กำลังล็อก: " .. p.Name
                updateTargetList()
            end)
            off = off + 38
        end
    end
end

Plrs.PlayerAdded:Connect(updateTargetList)
Plrs.PlayerRemoving:Connect(updateTargetList)
task.spawn(updateTargetList)

RunS.RenderStepped:Connect(function()
    if targetLockEnabled and lockTarget then
        pcall(function()
            if not lockTarget.Parent or not lockTarget.Character then
                lockTarget = nil
                lockInfoLbl.Text = "  🎯 เป้าหมายที่กำลังล็อก: [ เป้าหมายออกจากเกม ]"
                return
            end
            local tHum = lockTarget.Character:FindFirstChildOfClass("Humanoid")
            local tHead = lockTarget.Character:FindFirstChild("Head") or lockTarget.Character:FindFirstChild("HumanoidRootPart")
            if tHum and tHum.Health <= 0 then
                lockTarget = nil
                lockInfoLbl.Text = "  🎯 เป้าหมายที่กำลังล็อก: [ เป้าหมายเสียชีวิตแล้ว ]"
                return
            end
            if tHead then Camera.CFrame = CFrame.new(Camera.CFrame.Position, tHead.Position) end
        end)
    end
end)

-- Tab 7 Content (🛠️ ระบบช่วยเหลือ - Auto Clicker, Anti-AFK, FPS / Ping Counter)
local statsLabel = Instance.new("TextLabel", tb7)
statsLabel.Size, statsLabel.Position = UDim2.new(1, 0, 0, 45), UDim2.new(0, 0, 0, 10)
statsLabel.BackgroundColor3, statsLabel.TextColor3, statsLabel.TextSize, statsLabel.Font = Color3.fromRGB(245, 248, 255), Color3.fromRGB(60, 80, 120), 12, Enum.Font.GothamBold
statsLabel.Text = "  📊 FPS: Calculating... | Ping: Calculating..."
statsLabel.TextXAlignment = Enum.TextXAlignment.Left
cnr(statsLabel, 8) addSoftShadow(statsLabel)

local frameCount = 0
local lastCheck = tick()

RunS.RenderStepped:Connect(function()
    frameCount = frameCount + 1
    local now = tick()
    if now - lastCheck >= 1 then
        local fps = math.floor(frameCount / (now - lastCheck))
        local ping = math.floor(workspace:GetRealPhysicalResponseTime() * 1000)
        statsLabel.Text = "  📊 FPS: " .. tostring(fps) .. " | Ping: " .. tostring(ping) .. " ms"
        frameCount = 0
        lastCheck = now
    end
end)

local autoClickActive = false
local clickIntervalBox = Instance.new("TextBox", tb7)
clickIntervalBox.Size, clickIntervalBox.Position = UDim2.new(1, 0, 0, 35), UDim2.new(0, 0, 0, 65)
clickIntervalBox.BackgroundColor3, clickIntervalBox.TextColor3, clickIntervalBox.PlaceholderText, clickIntervalBox.Text, clickIntervalBox.TextSize, clickIntervalBox.Font = Color3.fromRGB(245, 247, 252), Color3.fromRGB(50, 110, 210), "ความถี่คลิกต่อวินาที (เช่น 0.1)", "0.1", 11, Enum.Font.GothamBold
cnr(clickIntervalBox, 6) addSoftShadow(clickIntervalBox)

local autoClickBtn = Instance.new("TextButton", tb7)
autoClickBtn.Size, autoClickBtn.Position = UDim2.new(1, 0, 0, 42), UDim2.new(0, 0, 0, 110)
autoClickBtn.BackgroundColor3, autoClickBtn.TextColor3, autoClickBtn.TextSize, autoClickBtn.Font, autoClickBtn.Text = Color3.fromRGB(230, 238, 250), Color3.fromRGB(60, 80, 120), 12, Enum.Font.GothamBold, "🖱️ เปิด/ปิด Auto Clicker: [ ปิดอยู่ ]"
cnr(autoClickBtn, 8) addSoftShadow(autoClickBtn)

autoClickBtn.MouseButton1Click:Connect(function()
    autoClickActive = not autoClickActive
    autoClickBtn.BackgroundColor3 = autoClickActive and Color3.fromRGB(80, 200, 120) or Color3.fromRGB(230, 238, 250)
    autoClickBtn.TextColor3 = autoClickActive and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(60, 80, 120)
    autoClickBtn.Text = "🖱️ เปิด/ปิด Auto Clicker: " .. (autoClickActive and "[ เปิดใช้งาน ]" or "[ ปิดอยู่ ]")
    
    if autoClickActive then
        task.spawn(function()
            while autoClickActive do
                local interval = tonumber(clickIntervalBox.Text) or 0.1
                pcall(function()
                    if VirtualUser then
                        VirtualUser:CaptureController()
                        VirtualUser:ClickButton1(Vector2.new(0, 0))
                    else
                        local tool = LP.Character and LP.Character:FindFirstChildOfClass("Tool")
                        if tool then tool:Activate() end
                    end
                end)
                task.wait(interval)
            end
        end)
    end
end)

local antiAfkActive = false
local antiAfkBtn = Instance.new("TextButton", tb7)
antiAfkBtn.Size, antiAfkBtn.Position = UDim2.new(1, 0, 0, 42), UDim2.new(0, 0, 0, 162)
antiAfkBtn.BackgroundColor3, antiAfkBtn.TextColor3, antiAfkBtn.TextSize, antiAfkBtn.Font, antiAfkBtn.Text = Color3.fromRGB(230, 238, 250), Color3.fromRGB(60, 80, 120), 12, Enum.Font.GothamBold, "💤 เปิด/ปิด กันถูกเตะออกเกม (Anti-AFK): [ ปิดอยู่ ]"
cnr(antiAfkBtn, 8) addSoftShadow(antiAfkBtn)

local vu = game:GetService("VirtualUser")
LP.Idled:Connect(function()
    if antiAfkActive then
        vu:Button2Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
        task.wait(1)
        vu:Button2Up(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
    end
end)

antiAfkBtn.MouseButton1Click:Connect(function()
    antiAfkActive = not antiAfkActive
    antiAfkBtn.BackgroundColor3 = antiAfkActive and Color3.fromRGB(80, 200, 120) or Color3.fromRGB(230, 238, 250)
    antiAfkBtn.TextColor3 = antiAfkActive and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(60, 80, 120)
    antiAfkBtn.Text = "💤 เปิด/ปิด กันถูกเตะออกเกม: " .. (antiAfkActive and "[ เปิดใช้งาน ]" or "[ ปิดอยู่ ]")
end)

-- Tab 8 Content (🗺️ ระบบสคริปต์แมพต่างๆ + ป้ายเตือนค่าย Hub อื่นๆ)
local mapNoteLbl = Instance.new("TextLabel", tb8)
mapNoteLbl.Size, mapNoteLbl.Position = UDim2.new(1, 0, 0, 36), UDim2.new(0, 0, 0, 5)
mapNoteLbl.BackgroundColor3, mapNoteLbl.TextColor3, mapNoteLbl.TextSize, mapNoteLbl.Font = Color3.fromRGB(255, 245, 230), Color3.fromRGB(210, 120, 30), 10, Enum.Font.GothamBold
mapNoteLbl.Text = "⚠️ หมายเหตุ: สคริปต์แมพต่างๆ อาจจะมี script ของค่ายHubอื่นๆอยู่ด้วยนะครับ"
mapNoteLbl.TextWrapped = true
cnr(mapNoteLbl, 8) addSoftShadow(mapNoteLbl)

local mapSelectFrame = Instance.new("Frame", tb8)
mapSelectFrame.Size, mapSelectFrame.Position, mapSelectFrame.BackgroundTransparency = UDim2.new(1, 0, 1, -45), UDim2.new(0, 0, 0, 45), true

local mapList = {
    {
        name = "Military Army Tycoon 🪖", 
        script = function()
            loadstring(game:HttpGet("https://gist.githubusercontent.com/asplqkkm-cloud/7de1a9a4f30164f0674da99cd7e480f7/raw/d3092620ed810cfc51faf686195a525ae21855a2/gistfile1.txt"))()
        end
    },
    {
        name = "Rivals 🎯", 
        script = function()
            loadstring(game:HttpGet("https://pastebin.com/raw/vWDcERZy"))()
        end
    },
    {
        name = "Murder Mystery 2 (MM2) 🗡️", 
        script = function()
            loadstring(game:HttpGet("https://gist.githubusercontent.com/asplqkkm-cloud/91d9d7c60e170322d46c67b2a33189a8/raw/8c6184e3daf189333e7a11316ffa82c120fe59dd/gistfile1.txt"))()
        end
    },
    {
        name = "มวยไร้ชื่อ (Mirage) 🥊", 
        script = function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/J4stJD/Mirage/refs/heads/main/Loader"))()
        end
    },
    {
        name = "Forsaken 🛡️", 
        script = function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/LolnotaKid/project/refs/heads/main/AutoBLOCKKKWAHV1"))()
        end
    },
    {
        name = "Command an Army ⚔️", 
        script = function()
            loadstring(game:HttpGet("https://chronix-gate.net/l"))()
        end
    },
    {
        name = "Baseball ⚾", 
        script = function()
            loadstring(game:HttpGet("https://script-vault-production.up.railway.app/raw/cca31b760609d8fc/main.lua"))()
        end
    },
    {
        name = "Brookhaven 🏡", 
        script = function()
            loadstring(game:HttpGet("https://script-vault-production.up.railway.app/raw/cca31b760609d8fc/main.lua"))()
        end
    },
    {
        name = "เขตความรุนแรง 💥", 
        script = function()
            loadstring(game:HttpGet("https://chronix-gate.net/l"))()
        end
    },
    {
        name = "coquette hub (brook heaven) 🎀", 
        script = function()
            loadstring(game:HttpGet("https://coquette-hub.com/r/5753a035c626"))()
        end
    }
}

mapSelectFrame.Size = UDim2.new(1, 0, 0, #mapList * 52 + 10)

for i, mapData in ipairs(mapList) do
    local mapBtn = Instance.new("TextButton", mapSelectFrame)
    mapBtn.Size, mapBtn.Position = UDim2.new(1, 0, 0, 42), UDim2.new(0, 0, 0, (i - 1) * 50 + 5)
    mapBtn.BackgroundColor3, mapBtn.TextColor3, mapBtn.TextSize, mapBtn.Font, mapBtn.Text = Color3.fromRGB(230, 238, 250), Color3.fromRGB(60, 80, 120), 12, Enum.Font.GothamBold, "  🗺️ " .. mapData.name
    mapBtn.TextXAlignment = Enum.TextXAlignment.Left
    cnr(mapBtn, 8) addSoftShadow(mapBtn)
    
    mapBtn.MouseButton1Click:Connect(function()
        if mapData.script then
            mapBtn.Text = "⏳ กำลังรันสคริปต์ " .. mapData.name .. "..."
            mapBtn.BackgroundColor3 = Color3.fromRGB(90, 140, 255)
            mapBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
            
            pcall(mapData.script)
            
            task.wait(1.5)
            mapBtn.Text = "✅ รันสคริปต์สำเร็จ! (" .. mapData.name .. ")"
            mapBtn.BackgroundColor3 = Color3.fromRGB(80, 200, 120)
            
            task.wait(2)
            mapBtn.Text = "  🗺️ " .. mapData.name
            mapBtn.BackgroundColor3 = Color3.fromRGB(230, 238, 250)
            mapBtn.TextColor3 = Color3.fromRGB(60, 80, 120)
        else
            mapBtn.Text = "⚠️ ยังไม่มีสคริปต์ในแมพนี้"
            task.wait(1.5)
            mapBtn.Text = "  🗺️ " .. mapData.name
        end
    end)
end

print("🌸 TAKESA HUB // MOBILE PRO EDITION FULLY UPDATED WITH SONG INSTRUCTIONS!")
