-- PlayerList.lua

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")

-- Проверяем, если окно уже есть — не создаём заново
if script.Parent:FindFirstChild("PlayerListWindow") then
    script.Parent.PlayerListWindow.Visible = true
    return
end

-- Основное окно
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "PlayerListGUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = game.CoreGui

local Window = Instance.new("Frame")
Window.Name = "PlayerListWindow"
Window.Size = UDim2.new(0, 300, 0, 400)
Window.Position = UDim2.new(0.7, 0, 0.2, 0)
Window.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Window.BorderSizePixel = 0
Window.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 6)
UICorner.Parent = Window

-- Заголовок
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 30)
Title.BackgroundTransparency = 1
Title.Text = "Player List"
Title.Font = Enum.Font.GothamBold
Title.TextSize = 18
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Parent = Window

-- Кнопка закрытия
local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 30, 0, 30)
CloseBtn.Position = UDim2.new(1, -35, 0, 0)
CloseBtn.BackgroundColor3 = Color3.fromRGB(220, 50, 50)
CloseBtn.Text = "X"
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextSize = 18
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.Parent = Window

CloseBtn.MouseButton1Click:Connect(function()
    Window.Visible = false
end)

-- Скролл контейнер для списка игроков
local Scroller = Instance.new("ScrollingFrame")
Scroller.Size = UDim2.new(1, -10, 1, -40)
Scroller.Position = UDim2.new(0, 5, 0, 35)
Scroller.BackgroundTransparency = 1
Scroller.BorderSizePixel = 0
Scroller.CanvasSize = UDim2.new(0, 0, 0, 0)
Scroller.ScrollBarThickness = 6
Scroller.Parent = Window

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 4)
UIListLayout.Parent = Scroller

-- Функция для обновления списка игроков
local function UpdatePlayerList()
    -- Удаляем старые элементы
    for _, child in pairs(Scroller:GetChildren()) do
        if child:IsA("TextLabel") then
            child:Destroy()
        end
    end

    for i, player in pairs(Players:GetPlayers()) do
        local label = Instance.new("TextLabel")
        label.Size = UDim2.new(1, -10, 0, 25)
        label.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        label.TextColor3 = Color3.fromRGB(255, 255, 255)
        label.Font = Enum.Font.Gotham
        label.TextSize = 16
        label.TextXAlignment = Enum.TextXAlignment.Left
        label.Text = player.Name
        label.Name = player.UserId
        label.Parent = Scroller
    end

    -- Обновляем размер скролла под количество игроков
    local layoutSize = UIListLayout.AbsoluteContentSize
    Scroller.CanvasSize = UDim2.new(0, 0, 0, layoutSize.Y + 10)
end

-- Начальное обновление
UpdatePlayerList()

-- Обновлять список при присоединении/уходе игроков
Players.PlayerAdded:Connect(UpdatePlayerList)
Players.PlayerRemoving:Connect(UpdatePlayerList)
