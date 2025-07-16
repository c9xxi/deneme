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
    Name = "Pet Nerede? (Konsola Yazdır)",
    Callback = function()
        local petName = "La Vacca Saturno Saturnita"
        local found = false
        -- Workspace
        if workspace:FindFirstChild(petName) then
            print(petName .. " Workspace içinde bulundu!")
            found = true
        end
        -- ReplicatedStorage
        if game.ReplicatedStorage:FindFirstChild(petName) then
            print(petName .. " ReplicatedStorage içinde bulundu!")
            found = true
        end
        -- ServerStorage
        if game:GetService("ServerStorage"):FindFirstChild(petName) then
            print(petName .. " ServerStorage içinde bulundu!")
            found = true
        end
        -- StarterPack
        if game:GetService("StarterPack"):FindFirstChild(petName) then
            print(petName .. " StarterPack içinde bulundu!")
            found = true
        end
        -- StarterPlayer
        if game:GetService("StarterPlayer"):FindFirstChild(petName) then
            print(petName .. " StarterPlayer içinde bulundu!")
            found = true
        end
        -- Lighting
        if game:GetService("Lighting"):FindFirstChild(petName) then
            print(petName .. " Lighting içinde bulundu!")
            found = true
        end
        if not found then
            print(petName .. " hiçbir ana klasörde bulunamadı!")
        end
        Rayfield:Notify({
            Title = "Bilgi",
            Content = "Petin yeri F9 konsolunda!",
            Duration = 3
        })
    end,
})

Rayfield:Load()
