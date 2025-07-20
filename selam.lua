local player = game.Players.LocalPlayer
local mouse = player:GetMouse()
local screenGui = Instance.new("ScreenGui", player.PlayerGui)
screenGui.Name = "AdoptMeScriptGUI"

local frame = Instance.new("Frame", screenGui)
frame.Size = UDim2.new(0, 300, 0, 200)
frame.Position = UDim2.new(0.5, -150, 0.5, -100)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true -- 🟢 GUI taşınabilir

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, 0, 0, 30)
title.Text = "Adopt Me Script"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.BackgroundTransparency = 1
title.Font = Enum.Font.SourceSansBold
title.TextSize = 20

local madeBy = Instance.new("TextLabel", frame)
madeBy.Size = UDim2.new(1, 0, 0, 20)
madeBy.Position = UDim2.new(0, 0, 1, -20)
madeBy.Text = "Made by sxx21"
madeBy.TextColor3 = Color3.fromRGB(200, 200, 200)
madeBy.BackgroundTransparency = 1
madeBy.Font = Enum.Font.SourceSans
madeBy.TextSize = 14

local function runCounter(duration, callback)
	local counter = Instance.new("TextLabel", frame)
	counter.Size = UDim2.new(1, 0, 0, 30)
	counter.Position = UDim2.new(0, 0, 0, 40)
	counter.Text = "0%"
	counter.TextColor3 = Color3.fromRGB(255, 255, 255)
	counter.BackgroundTransparency = 1
	counter.Font = Enum.Font.SourceSansBold
	counter.TextSize = 20
	for i = 0, 100 do
		counter.Text = tostring(i) .. "%"
		wait(duration/100)
	end
	counter:Destroy()
	if callback then callback() end
end

local function createButton(name, posY, onClick, flagName, duration)
	local btn = Instance.new("TextButton", frame)
	btn.Size = UDim2.new(0.9, 0, 0, 40)
	btn.Position = UDim2.new(0.05, 0, 0, posY)
	btn.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
	btn.Text = name.." (OFF)"
	btn.TextColor3 = Color3.new(1,1,1)
	btn.Font = Enum.Font.SourceSansBold
	btn.TextSize = 16

	btn.MouseButton1Click:Connect(function()
		if not _G[flagName] then
			btn.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
			btn.Text = name.." (ON)"
			runCounter(duration, function()
				_G[flagName] = true
				onClick()
			end)
		else
			btn.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
			btn.Text = name.." (OFF)"
			_G[flagName] = false
		end
	end)
end

createButton("Bypass Anti Cheat", 60, function()
	print("Gelişmiş Anti Cheat koruması aktif!")

	local mt = getrawmetatable(game)
	setreadonly(mt, false)
	local oldNamecall = mt.__namecall
	local oldIndex = mt.__index

	mt.__namecall = newcclosure(function(self, ...)
		local method = getnamecallmethod()
		if tostring(method):lower() == "kick" then
			warn("[AntiCheat] Kick denemesi engellendi.")
			return
		end
		return oldNamecall(self, ...)
	end)

	mt.__index = newcclosure(function(self, key)
		if tostring(key):lower() == "kick" then
			warn("[AntiCheat] Kick (index) engellendi.")
			return function() end
		end
		return oldIndex(self, key)
	end)

	player.CharacterAdded:Connect(function(char)
		local hum = char:WaitForChild("Humanoid")
		hum:GetPropertyChangedSignal("WalkSpeed"):Connect(function()
			if hum.WalkSpeed < 16 then
				hum.WalkSpeed = 16
				warn("[AntiCheat] WalkSpeed resetlendi.")
			end
		end)
		hum:GetPropertyChangedSignal("JumpPower"):Connect(function()
			if hum.JumpPower < 50 then
				hum.JumpPower = 50
				warn("[AntiCheat] JumpPower resetlendi.")
			end
		end)
	end)

	for _,v in pairs(game:GetDescendants()) do
		if v:IsA("RemoteEvent") or v:IsA("RemoteFunction") then
			v.OnClientEvent:Connect(function(...)
				local args = {...}
				for i,v in ipairs(args) do
					if tostring(v):lower():find("log") then
						warn("[AntiCheat] Loglama RemoteEvent’i iptal edildi.")
						return
					end
				end
			end)
		end
	end

end, "isBypassActive", 15)

createButton("Glitch Trade", 110, function()
	print("Trade glitch başlıyor!")
	local function autoAccept()
		local tradeUI = player.PlayerGui:FindFirstChild("TradeUI") -- isim oyuna göre değişebilir
		if tradeUI then
			local myAccept = tradeUI:FindFirstChild("MyAcceptButton")
			local theirAccept = tradeUI:FindFirstChild("TheirAcceptButton")
			if myAccept and theirAccept then
				myAccept.MouseButton1Click:Fire()
				wait(0.5)
				theirAccept.MouseButton1Click:Fire()
			else
				warn("Trade UI butonları bulunamadı.")
			end
		else
			warn("Trade UI bulunamadı.")
		end
	end
	autoAccept()
end, "isGlitchActive", 7)
