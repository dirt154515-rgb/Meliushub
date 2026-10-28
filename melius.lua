-- Melius Hub Script Menu (Client-side)
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local localPlayer = Players.LocalPlayer

-- Eğer daha önce açıldıysa eskisini sil
if CoreGui:FindFirstChild("MeliusHubGui") then
    CoreGui.MeliusHubGui:Destroy()
end

-- Ana GUI Oluşturma
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "MeliusHubGui"
screenGui.Parent = CoreGui

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 420, 0, 260)
mainFrame.Position = UDim2.new(0.5, -210, 0.5, -130)
mainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Draggable = true -- Ekranın istediğin yerine sürükleyebilirsin
mainFrame.Parent = screenGui

-- Köşeleri Yumuşatma
local uiCorner = Instance.new("UICorner")
uiCorner.CornerRadius = UDim.new(0, 8)
uiCorner.Parent = mainFrame

-- Üst Bar (Başlık)
local topBar = Instance.new("Frame")
topBar.Size = UDim2.new(1, 0, 0, 40)
topBar.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
topBar.BorderSizePixel = 0
topBar.Parent = mainFrame

local topCorner = Instance.new("UICorner")
topCorner.CornerRadius = UDim.new(0, 8)
topCorner.Parent = topBar

local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, -20, 1, 0)
titleLabel.Position = UDim2.new(0, 10, 0, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "MELIUS HUB // v1.0 (Key-Free)"
titleLabel.TextColor3 = Color3.fromRGB(0, 255, 102) -- Neon Yeşil
titleLabel.TextSize = 15
titleLabel.Font = Enum.Font.GothamBold
titleLabel.TextXAlignment = Enum.TextXAlignment.Left
titleLabel.Parent = topBar

-- Kapatma Butonu (X)
local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 30, 0, 30)
closeBtn.Position = UDim2.new(1, -35, 0, 5)
closeBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
closeBtn.Text = "X"
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.TextSize = 14
closeBtn.Font = Enum.Font.GothamBold
closeBtn.Parent = topBar

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 6)
closeCorner.Parent = closeBtn

closeBtn.MouseButton1Click:Connect(function()
    screenGui:Destroy()
end)

-- İçerik Alanı (Butonlar)
local contentFrame = Instance.new("ScrollingFrame")
contentFrame.Size = UDim2.new(1, -20, 1, -60)
contentFrame.Position = UDim2.new(0, 10, 0, 50)
contentFrame.BackgroundTransparency = 1
contentFrame.BorderSizePixel = 0
contentFrame.CanvasSize = UDim2.new(0, 0, 0, 200)
contentFrame.Parent = mainFrame

-- Fonksiyon: Menüye Şık Buton Ekleme
local function createButton(name, posY, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 0, 40)
    btn.Position = UDim2.new(0, 0, 0, posY)
    btn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    btn.Text = "  " .. name
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 14
    btn.Font = Enum.Font.GothamMedium
    btn.TextXAlignment = Enum.TextXAlignment.Left
    btn.Parent = contentFrame

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = btn

    btn.MouseButton1Click:Connect(callback)
end

-- 1. Buton: Görünmezlik
createButton("Görünmezlik (Invisibility)", 0, function()
    local char = localPlayer.Character
    if char then
        for _, v in ipairs(char:GetDescendants()) do
            if v:IsA("BasePart") or v:IsA("MeshPart") or v:IsA("Decal") then
                v.Transparency = 1
            elseif v:IsA("Accessory") then
                local handle = v:FindFirstChild("Handle")
                if handle then handle.Transparency = 1 end
            end
        end
        print("MeliusHub: Görünmezlik aktif!")
    end
end)

-- 2. Buton: Hız Hilesi (Speed Boost)
createButton("Süper Hız (Speed: 50)", 50, function()
    local char = localPlayer.Character
    if char and char:FindFirstChildOfClass("Humanoid") then
        char:FindFirstChildOfClass("Humanoid").WalkSpeed = 50
        print("MeliusHub: Hız artırıldı!")
    end
end)

-- 3. Buton: Normal Hıza Dön
createButton("Normal Hıza Dön", 100, function()
    local char = localPlayer.Character
    if char and char:FindFirstChildOfClass("Humanoid") then
        char:FindFirstChildOfClass("Humanoid").WalkSpeed = 16
        print("MeliusHub: Hız normale döndü.")
    end
end)

print("Melius Hub başarıyla yüklendi!")
