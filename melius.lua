-- Melius Hub // Ultimate Universal God-Mode Hub
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local localPlayer = Players.LocalPlayer
local mouse = localPlayer:GetMouse()

-- Eski menü varsa temizle
if CoreGui:FindFirstChild("MeliusHubGui") then
    CoreGui.MeliusHubGui:Destroy()
end

-- Ana Menü Arayüzü
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "MeliusHubGui"
screenGui.Parent = CoreGui

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 450, 0, 380)
mainFrame.Position = UDim2.new(0.5, -225, 0.5, -190)
mainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Parent = screenGui

local uiCorner = Instance.new("UICorner")
uiCorner.CornerRadius = UDim.new(0, 10)
uiCorner.Parent = mainFrame

-- Üst Bar
local topBar = Instance.new("Frame")
topBar.Size = UDim2.new(1, 0, 0, 45)
topBar.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
topBar.BorderSizePixel = 0
topBar.Parent = mainFrame

local topCorner = Instance.new("UICorner")
topCorner.CornerRadius = UDim.new(0, 10)
topCorner.Parent = topBar

local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, -20, 1, 0)
titleLabel.Position = UDim2.new(0, 12, 0, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "MELIUS HUB // ULTIMATE GOD-MODE"
titleLabel.TextColor3 = Color3.fromRGB(0, 255, 102)
titleLabel.TextSize = 14
titleLabel.Font = Enum.Font.GothamBold
titleLabel.TextXAlignment = Enum.TextXAlignment.Left
titleLabel.Parent = topBar

-- İçerik Kaydırma Alanı
local contentFrame = Instance.new("ScrollingFrame")
contentFrame.Size = UDim2.new(1, -20, 1, -60)
contentFrame.Position = UDim2.new(0, 10, 0, 50)
contentFrame.BackgroundTransparency = 1
contentFrame.BorderSizePixel = 0
contentFrame.CanvasSize = UDim2.new(0, 0, 0, 480)
contentFrame.Parent = mainFrame

local function createButton(name, posY, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 0, 40)
    btn.Position = UDim2.new(0, 0, 0, posY)
    btn.BackgroundColor3 = Color3.fromRGB(28, 28, 28)
    btn.Text = "  " .. name
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 13
    btn.Font = Enum.Font.GothamMedium
    btn.TextXAlignment = Enum.TextXAlignment.Left
    btn.Parent = contentFrame

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = btn

    btn.MouseButton1Click:Connect(callback)
end

-- 1. Uçma (Fly) Değişkenleri
local flying = false
local flySpeed = 50

-- 2. Noclip (Duvarlardan Geçme) Değişkenleri
local noclipEnabled = false
RunService.Stepped:Connect(function()
    if noclipEnabled and localPlayer.Character then
        for _, part in pairs(localPlayer.Character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
    end
end)

-- --- TÜM HİLE BUTONLARI ---

createButton("🚀 Uçma Modu (Fly - Toggle)", 0, function()
    flying = not flying
    local char = localPlayer.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return end
    local rootPart = char.HumanoidRootPart
    
    if flying then
        print("MeliusHub: Uçma Açıldı!")
        local bv = Instance.new("BodyVelocity")
        bv.Name = "MeliusFlyVelocity"
        bv.Parent = rootPart
        bv.MaxForce = Vector3.new(9e9, 9e9, 9e9)
        bv.Velocity = Vector3.new(0, 0, 0)
        
        task.spawn(function()
            while flying do
                task.wait()
                local cam = workspace.CurrentCamera
                local vel = Vector3.new()
                if UserInputService:IsKeyDown(Enum.KeyCode.W) then
                    vel = vel + cam.CFrame.LookVector
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.S) then
                    vel = vel - cam.CFrame.LookVector
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.A) then
                    vel = vel - cam.CFrame.RightVector
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.D) then
                    vel = vel + cam.CFrame.RightVector
                end
                bv.Velocity = vel * flySpeed
            end
            if rootPart:FindFirstChild("MeliusFlyVelocity") then
                rootPart.MeliusFlyVelocity:Destroy()
            end
        end)
    else
        print("MeliusHub: Uçma Kapatıldı!")
        if rootPart:FindFirstChild("MeliusFlyVelocity") then
            rootPart.MeliusFlyVelocity:Destroy()
        end
    end
end)

createButton("👻 Duvarlardan Geçme (Noclip)", 50, function()
    noclipEnabled = not noclipEnabled
    print("MeliusHub Noclip: " .. tostring(noclipEnabled))
end)

createButton("⚡ Süper Hız (WalkSpeed: 120)", 100, function()
    local char = localPlayer.Character
    if char and char:FindFirstChildOfClass("Humanoid") then
        char:FindFirstChildOfClass("Humanoid").WalkSpeed = 120
    end
end)

createButton("🦘 Mega Zıplama (JumpPower: 150)", 150, function()
    local char = localPlayer.Character
    if char and char:FindFirstChildOfClass("Humanoid") then
        char:FindFirstChildOfClass("Humanoid").UseJumpPower = true
        char:FindFirstChildOfClass("Humanoid").JumpPower = 150
    end
end)

createButton("👁️ Oyuncu ESP (İsimleri Görme)", 200, function()
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= localPlayer and p.Character and p.Character:FindFirstChild("Head") then
            if not p.Character.Head:FindFirstChild("MeliusESP") then
                local bg = Instance.new("BillboardGui")
                bg.Name = "MeliusESP"
                bg.Size = UDim2.new(0, 100, 0, 40)
                bg.StudsOffset = Vector3.new(0, 3, 0)
                bg.AlwaysOnTop = true
                bg.Parent = p.Character.Head
                
                local txt = Instance.new("TextLabel")
                txt.Size = UDim2.new(1, 0, 1, 0)
                txt.BackgroundTransparency = 1
                txt.Text = p.Name
                txt.TextColor3 = Color3.fromRGB(0, 255, 102)
                txt.TextSize = 12
                txt.Font = Enum.Font.GothamBold
                txt.Parent = bg
            end
        end
    end
    print("MeliusHub: ESP Aktif Edildi!")
end)

createButton("💡 Fullbright (Geceyi Gündüz Yap / Işık)", 250, function()
    local Lighting = game:GetService("Lighting")
    Lighting.Brightness = 3
    Lighting.ClockTime = 12
    Lighting.GlobalShadows = false
    Lighting.FogEnd = 999999
end)

createButton("🎯 FOV Changer (Görüş Açısı: 120)", 300, function()
    workspace.CurrentCamera.FieldOfView = 120
end)

createButton("🔄 Karakteri Sıfırla (Respawn)", 350, function()
    local char = localPlayer.Character
    if char and char:FindFirstChildOfClass("Humanoid") then
        char:FindFirstChildOfClass("Humanoid").Health = 0
    end
end)

createButton("❌ Menüyü Kapat / Gizle", 400, function()
    screenGui:Destroy()
end)

print("Melius Hub Ultimate God-Mode Yüklendi!")
