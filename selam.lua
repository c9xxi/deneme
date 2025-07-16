-- Rayfield Library'yi yükle
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
    Name = "Pet Spawner",
    LoadingTitle = "Pet Spawner GUI",
    LoadingSubtitle = "by selam",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = nil,
        FileName = "PetSpawnerConfig"
    },
    Discord = {
        Enabled = false,
        Invite = "",
        RememberJoins = true
    },
    KeySystem = false,
    KeySettings = {
        Title = "Pet Spawner",
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
    Name = "Spawn La Vacca Saturno Saturnita",
    Callback = function()
        local rep = game:GetService("ReplicatedStorage")
        local spawnPetEvent = rep:FindFirstChild("SpawnPet")
        if spawnPetEvent then
            spawnPetEvent:FireServer("La Vacca Saturno Saturnita")
        else
            Rayfield:Notify({
                Title = "Hata",
                Content = "SpawnPet eventi bulunamadı!",
                Duration = 3
            })
        end
    end,
})

Rayfield:Load()
