-- ==============================================================================
-- 🌸 [TAKESA HUB] : FINAL KEY SYSTEM LOADER (WITH 24H CACHE SYSTEM)
-- ==============================================================================
local HttpService = game:GetService("HttpService")
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local LP = Players.LocalPlayer

-- ระบบเช็คและบันทึกเวลา 24 ชั่วโมง (Cache System)
local fileName = "TakesaHub_Session.json"
local cacheValidHours = 24

local function isKeyCached()
    if readfile and writefile and isfile then
        if isfile(fileName) then
            local success, data = pcall(function()
                return HttpService:JSONDecode(readfile(fileName))
            end)
            if success and data and data.timestamp then
                local currentTime = os.time()
                local elapsedSeconds = currentTime - data.timestamp
                local elapsedHours = elapsedSeconds / 3600
                -- ถ้ายังไม่ครบ 24 ชั่วโมง และคีย์ตรงกัน ให้ผ่านได้เลย
                if elapsedHours < cacheValidHours then
                    return true
                end
            end
        end
    end
    return false
end

local function saveKeyCache()
    if writefile then
        pcall(function()
            local data = {
                timestamp = os.time()
            }
            writefile(fileName, HttpService:JSONEncode(data))
        end)
    end
end

-- ฟังก์ชันรันสคริปต์หลัก TAKESA HUB
local function loadMainScript()
    pcall(function()
        loadstring(game:HttpGet("https://gist.githubusercontent.com/asplqkkm-cloud/898f8282f79e122278c77a66102f441b/raw/3c2ec24dc10601686587f39df9ff64d7349a98c6/gistfile1.txt"))()
    end)
end

-- ตรวจสอบว่าเคยใส่คีย์ภายใน 24 ชม. หรือยัง ถ้าเคยแล้วเปิด Hub ทันที
if isKeyCached() then
    loadMainScript()
    return
end

-- คำนวณคีย์ประจำวัน (อ้างอิงตามวัน/เดือน UTC)
local dateTable = os.date("!*t")
local day = dateTable.day
local month = dateTable.month
local secretMath = ((day * 313) + (month * 719) + 88665)
local EXPECTED_KEY = "TK-" .. tostring(secretMath) .. "-HUB"

-- สร้าง UI หน้าต่างใส่คีย์ (กรณีที่ยังไม่เคยยืนยัน หรือหมดอายุ 24 ชม.)
local guiName = "TakesaKeySystemUI"
if CoreGui:FindFirstChild(guiName) then CoreGui[guiName]:Destroy() end
if LP.PlayerGui:FindFirstChild(guiName) then LP.PlayerGui[guiName]:Destroy() end

local screenGui = Instance.new("ScreenGui", CoreGui:FindFirstChild("CoreGui") and CoreGui or LP.PlayerGui)
screenGui.Name = guiName
screenGui.ResetOnSpawn = false

local frame = Instance.new("Frame", screenGui)
frame.Size = UDim2.new(0, 320, 0, 180)
frame.Position = UDim2.new(0.5, -160, 0.5, -90)
frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
frame.BorderSizePixel = 0

local corner = Instance.new("UICorner", frame)
corner.CornerRadius = UDim.new(0, 14)

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, 0, 0, 40)
title.BackgroundColor3 = Color3.fromRGB(235, 242, 255)
title.TextColor3 = Color3.fromRGB(60, 80, 120)
title.TextSize = 13
title.Font = Enum.Font.GothamBold
title.Text = "🌸 TAKESA HUB // SYSTEM KEY"
local titleCorner = Instance.new("UICorner", title)
titleCorner.CornerRadius = UDim.new(0, 14)

local textBox = Instance.new("TextBox", frame)
textBox.Size = UDim2.new(0.85, 0, 0, 38)
textBox.Position = UDim2.new(0.075, 0, 0, 55)
textBox.BackgroundColor3 = Color3.fromRGB(245, 247, 252)
textBox.TextColor3 = Color3.fromRGB(50, 110, 210)
textBox.PlaceholderText = "กรอกคีย์ประจำวันตรงนี้..."
textBox.Text = ""
textBox.TextSize = 12
textBox.Font = Enum.Font.GothamBold
local boxCorner = Instance.new("UICorner", textBox)
boxCorner.CornerRadius = UDim.new(0, 8)

local submitBtn = Instance.new("TextButton", frame)
submitBtn.Size = UDim2.new(0.4, 0, 0, 38)
submitBtn.Position = UDim2.new(0.075, 0, 0, 110)
submitBtn.BackgroundColor3 = Color3.fromRGB(90, 140, 255)
submitBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
submitBtn.TextSize = 12
submitBtn.Font = Enum.Font.GothamBold
submitBtn.Text = "🔑 ยืนยันคีย์"
local subCorner = Instance.new("UICorner", submitBtn)
subCorner.CornerRadius = UDim.new(0, 8)

local getLinkBtn = Instance.new("TextButton", frame)
getLinkBtn.Size = UDim2.new(0.4, 0, 0, 38)
getLinkBtn.Position = UDim2.new(0.525, 0, 0, 110)
getLinkBtn.BackgroundColor3 = Color3.fromRGB(230, 238, 250)
getLinkBtn.TextColor3 = Color3.fromRGB(60, 80, 120)
getLinkBtn.TextSize = 12
getLinkBtn.Font = Enum.Font.GothamBold
getLinkBtn.Text = "📋 คัดลอกลิงก์รับคีย์"
local linkCorner = Instance.new("UICorner", getLinkBtn)
linkCorner.CornerRadius = UDim.new(0, 8)

-- ลิงก์ Public Gist ของน้อง
local GIST_KEY_URL = "https://gist.github.com/asplqkkm-cloud/bd31493794798e8f875113919c03a837"

getLinkBtn.MouseButton1Click:Connect(function()
    pcall(function()
        if setclipboard then
            setclipboard(GIST_KEY_URL)
            getLinkBtn.Text = "✅ คัดลอกสำเร็จ!"
            task.wait(2)
            getLinkBtn.Text = "📋 คัดลอกลิงก์รับคีย์"
        end
    end)
end)

submitBtn.MouseButton1Click:Connect(function()
    if textBox.Text == EXPECTED_KEY then
        submitBtn.Text = "✅ คีย์ถูกต้อง!"
        submitBtn.BackgroundColor3 = Color3.fromRGB(80, 200, 120)
        
        -- บันทึกเวลาจำสิทธิ์ 24 ชั่วโมงลงไฟล์เครื่อง
        saveKeyCache()
        
        task.wait(1)
        screenGui:Destroy()
        
        -- โหลดสคริปต์หลัก TAKESA HUB
        loadMainScript()
    else
        submitBtn.Text = "❌ คีย์ไม่ถูกต้อง!"
        submitBtn.BackgroundColor3 = Color3.fromRGB(240, 100, 100)
        task.wait(1.5)
        submitBtn.Text = "🔑 ยืนยันคีย์"
        submitBtn.BackgroundColor3 = Color3.fromRGB(90, 140, 255)
    end
end)
