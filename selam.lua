-- StarterGui içine bir ScreenGui ekle ve içine bir Frame, TextLabel, TextBox, TextButton koy
-- Aşağıdaki script, Frame içine eklenmeli

local frame = script.Parent

-- Sürüklenebilir yapmak için basit kod:
local dragging
local dragInput
local dragStart
local startPos

local function update(input)
    local delta = input.Position - dragStart
    frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X,
                              startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end-- StarterGui içine bir ScreenGui ekle ve içine bir Frame, TextLabel, TextBox, TextButton koy
-- Aşağıdaki script, Frame içine eklenmeli

local frame = script.Parent

-- Sürüklenebilir yapmak için basit kod:
local dragging
local dragInput
local dragStart
local startPos

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
local textbox = frame.TextBox -- TextBox'un ismi
local button = frame.TextButton -- Butonun ismi
local label = frame.TextLabel -- Sonuç gösterecek TextLabel

button.MouseButton1Click:Connect(function()
    local petName = textbox.Text
    local petModel = rep:FindFirstChild(petName, true) -- Alt klasörlerde de ara
    if petModel then
        local newPet = petModel:Clone()
        newPet.Parent = workspace
        -- Karakterin önüne spawn et
        local char = player.Character or player.CharacterAdded:Wait()
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if hrp and newPet.PrimaryPart then
            newPet:SetPrimaryPartCFrame(hrp.CFrame * CFrame.new(0, 0, -5))
            label.Text = "Successful✅"
        else
            label.Text = "Unsuccessful❌"
        end
    else
        label.Text = "Unsuccessful❌"
    end
    task.wait(1.5)
    label.Text = "Click to item pets"
end)


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
local textbox = frame.TextBox -- TextBox'un ismi
local button = frame.TextButton -- Butonun ismi
local label = frame.TextLabel -- Sonuç gösterecek TextLabel

button.MouseButton1Click:Connect(function()
    local petName = textbox.Text
    local petModel = rep:FindFirstChild(petName)
    if petModel then
        local newPet = petModel:Clone()
        newPet.Parent = workspace
        -- Karakterin önüne spawn et
        local char = player.Character or player.CharacterAdded:Wait()
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if hrp and newPet.PrimaryPart then
            newPet:SetPrimaryPartCFrame(hrp.CFrame * CFrame.new(0, 0, -5))
            label.Text = "Successful✅"
        else
            label.Text = "Unsuccessful❌"
        end
    else
        label.Text = "Unsuccessful❌"
    end
    task.wait(1.5)
    label.Text = "Click to item pets"
end)
