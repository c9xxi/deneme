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
        local petName = "La Vacca Saturno Saturnita"
        local hole = workspace:FindFirstChild("SpawnLocation")
        if hole then
            local petModel = game.ReplicatedStorage:FindFirstChild(petName)
            if petModel then
                local newPet = petModel:Clone()
                newPet.Parent = workspace
                newPet:SetPrimaryPartCFrame(hole.CFrame + Vector3.new(0, 2, 0))
            else
                Rayfield:Notify({
                    Title = "Hata",
                    Content = "Pet modeli bulunamadı!",
                    Duration = 3
                })
            end
        else
            Rayfield:Notify({
                Title = "Hata",
                Content = "Delik (SpawnLocation) bulunamadı!",
                Duration = 3
            })
        end
    end,
})

MainTab:CreateButton({
    Name = "Workspace Objelerini Konsola Yazdır",
    Callback = function()
        for i, v in pairs(workspace:GetChildren()) do
            print(v.Name)
        end
        Rayfield:Notify({
            Title = "Bilgi",
            Content = "Workspace objeleri F9 konsolunda listelendi!",
            Duration = 3
        })
    end,
})

Rayfield:Load()
