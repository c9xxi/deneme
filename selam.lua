local player = game.Players.LocalPlayer
local screenGui = Instance.new("ScreenGui", player.PlayerGui)
screenGui.Name = "AdoptMeScriptGUI"

local frame = Instance.new("Frame", screenGui)
frame.Size = UDim2.new(0, 300, 0, 200)
frame.Position = UDim2.new(0.5, -150, 0.5, -100)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, 0, 0, 30)
title.Text = "Adopt Me Script"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.BackgroundTransparency = 1
title.Font = Enum.Font.SourceSansBold
title.TextSize = 20

local message = Instance.new("TextLabel", frame)
message.Size = UDim2.new(1, 0, 0, 30)
message.Position = UDim2.new(0, 0, 0, 160)
message.Text = ""
message.TextColor3 = Color3.fromRGB(0, 255, 0)
message.BackgroundTransparency = 1
message.Font = Enum.Font.SourceSansBold
message.TextSize = 16

local function createButton(name, posY, duration, callback)
	local btn = Instance.new("TextButton", frame)
	btn.Size = UDim2.new(0.9, 0, 0, 40)
	btn.Position = UDim2.new(0.05, 0, posY, 0)
	btn.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
	btn.Text = name .. " (OFF)"
	btn.TextColor3 = Color3.new(1, 1, 1)
	btn.Font = Enum.Font.SourceSansBold
	btn.TextSize = 16

	local counterFrame = Instance.new("Frame", btn)
	counterFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	counterFrame.Position = UDim2.new(0, 0, 1, 0)
	counterFrame.Size = UDim2.new(1, 0, 0, 20)

	local counter = Instance.new("TextLabel", counterFrame)
	counter.Size = UDim2.new(1, 0, 1, 0)
	counter.Text = "0%"
	counter.TextColor3 = Color3.fromRGB(255, 255, 255)
	counter.BackgroundTransparency = 1
	counter.Font = Enum.Font.SourceSansBold
	counter.TextSize = 14

	btn.MouseButton1Click:Connect(function()
		if btn.BackgroundColor3 == Color3.fromRGB(255, 0, 0) then
			btn.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
			btn.Text = name .. " (ON)"
			for i = 0, 100 do
				counter.Text = i .. "%"
				wait(duration / 100)
			end
			message.Text = name .. " tamamlandı!"
			callback()
		else
			btn.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
			btn.Text = name .. " (OFF)"
			message.Text = ""
			counter.Text = "0%"
		end
	end)
end

createButton("Bypass Anti Cheat", 50, 15, function()
	print("Bypass aktif")
	-- Anti Cheat kodları burada
end)

createButton("Glitch Trade", 100, 7, function()
	print("Trade kabul ediliyor")
	local tradeRemote
	for _,v in ipairs(game:GetDescendants()) do
		if v:IsA("RemoteEvent") and v.Name:lower():find("accept") then
			tradeRemote = v
			break
		end
	end
	if tradeRemote then
		tradeRemote:FireServer()
		wait(0.5)
		tradeRemote:FireServer()
		message.Text = "Trade tamamlandı!"
	else
		message.Text = "Trade RemoteEvent bulunamadı!"
	end
end)
