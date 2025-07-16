-- Frame, TextBox, TextButton, TextLabel GUI elemanlarının isimleri doğru olmalı!
local frame = script.Parent

-- Sürüklenebilir Frame kodu
local dragging, dragInput, dragStart, startPos
local function update(input)
    local delta = input.Position - dragStart
    frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X,
                              startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end
frame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = frame.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)
frame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInput = input
    end
end)
game:GetService("UserInputService").InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        update(input)
    end
end)

-- PET SPAWN KODU
local rep = game:GetService("ReplicatedStorage")
local player = game.Players.LocalPlayer
local textbox = frame:FindFirstChild("TextBox")
local button = frame:FindFirstChild("TextButton")
local label = frame:FindFirstChild("TextLabel")

button.MouseButton1Click:Connect(function()
    local petName = textbox.Text
    local function deepSearch(parent)
        for _, obj in pairs(parent:GetChildren()) do
            if obj.Name == petName then
                print("Pet bulundu! Tam yol: " .. obj:GetFullName())
                return obj
            end
            local found = deepSearch(obj)
            if found then return found end
        end
        return nil
    end
    local petModel = deepSearch(rep)
    if petModel and petModel:IsA("Model") then
        local newPet = petModel:Clone()
        newPet.Parent = workspace
        local char = player.Character or player.CharacterAdded:Wait()
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        if hrp and newPet.PrimaryPart then
            newPet:SetPrimaryPartCFrame(hrp.CFrame * CFrame.new(0, 0, -5))
            label.Text = "Successful✅"
        else
            label.Text = "Unsuccessful❌"
            warn("PrimaryPart eksik veya karakter bulunamadı!")
        end
    else
        label.Text = "Unsuccessful❌"
        warn("Pet bulunamadı: " .. petName)
    end
    task.wait(1.5)
    label.Text = "Click to item pets"
end)
