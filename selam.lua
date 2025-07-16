-- Rayfield Library'yi yükle
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
    Name = "Spin GUI",
    LoadingTitle = "Spin GUI",
    LoadingSubtitle = "by Assistant",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = nil,
        FileName = "SpinConfig"
    },
    Discord = {
        Enabled = false,
        Invite = "",
        RememberJoins = true
    },
    KeySystem = false,
    KeySettings = {
        Title = "Spin GUI",
        Subtitle = "Key System",
        Note = "No key needed",
        FileName = "Key",
        SaveKey = true,
        GrabKeyFromSite = false,
        Key = ""
    }
})

local MainTab = Window:CreateTab("Main", 4483362458)

MainTab:CreateButton({
    Name = "10 Free Spin",
    Callback = function()
        local player = game.Players.LocalPlayer
        if player:FindFirstChild("FreeSpins") then
            player.FreeSpins.Value = player.FreeSpins.Value + 10
        else
            Rayfield:Notify({
                Title = "Hata",
                Content = "FreeSpins değeri bulunamadı!",
                Duration = 3
            })
        end
    end,
})

Rayfield:Load()
