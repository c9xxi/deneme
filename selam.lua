local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Oyuncunun orijinal yürüme hızını saklayacak değişken
local originalWalkSpeed = nil

-- NoClip durumunu kontrol eden değişken
local noClipActive = false

-- Steal butonunun tekrar tekrar basılmasını önlemek için gecikme
local lastStealTime = 0
local stealCooldown = 2 -- 2 saniye bekleme süresi

-- Rayfield UI'ı oluştur
local Rayfield = Rayfield -- Genellikle executor'lar Rayfield'ı global olarak tanımlar

Rayfield:LoadUI(
    {
        Name = "Main Panel",
        Icon = "rbxassetid://6022879685", -- İstediğin bir ikon ID'si
        Color = Color3.fromRGB(0, 150, 255), -- Rayfield arayüz rengi
        PanelDragging = true, -- Paneli sürükleyebilirsin
        PanelMinimizing = true -- Paneli küçültebilirsin
    }
)

---
### **Main Sekmesi**

Rayfield:CreateTab("Main")

---
#### **Speed Özelliği**

Rayfield:CreateToggle(
    "Main", -- Sekme adı
    "Speed", -- Toggle adı
    "Açıldığında hızınızı 50 yapar, kapatıldığında orijinal hızınıza döner.", -- Açıklama
    function(state)
        local character = LocalPlayer.Character
        if not character or not character:FindFirstChildOfClass("Humanoid") then return end

        local humanoid = character:FindFirstChildOfClass("Humanoid")

        if state then
            -- Eğer Speed aktif ediliyorsa
            if originalWalkSpeed == nil then
                originalWalkSpeed = humanoid.WalkSpeed -- Orijinal hızı kaydet
            end
            humanoid.WalkSpeed = 50 -- Hızı 50 yap
        else
            -- Eğer Speed kapatılıyorsa
            if originalWalkSpeed ~= nil then
                humanoid.WalkSpeed = originalWalkSpeed -- Orijinal hıza dön
                originalWalkSpeed = nil -- Orijinal hızı sıfırla
            else
                -- Eğer orijinal hız kaydedilmediyse (örneğin script yeni çalıştırıldıysa), varsayılan hıza dön
                humanoid.WalkSpeed = 16 -- Roblox varsayılan hızı
            end
        end
    end
)

---
#### **NoClip Özelliği**

Rayfield:CreateToggle(
    "Main", -- Sekme adı
    "NoClip", -- Toggle adı
    "Duvarlardan ve nesnelerden geçmenizi sağlar.", -- Açıklama
    function(state)
        noClipActive = state
        local character = LocalPlayer.Character
        if not character then return end

        for _, part in ipairs(character:GetChildren()) do
            if part:IsA("BasePart") then
                part.CanCollide = not state -- Açıkken CanCollide'ı false yap, kapalıyken true
            end
        end

        -- Karakter her yeniden yüklendiğinde (ölünce vb.) NoClip'i tekrar uygulamak için
        LocalPlayer.CharacterAdded:Connect(function(newCharacter)
            if noClipActive then
                for _, part in ipairs(newCharacter:GetChildren()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end
            end
        end)
    end
)

---
#### **Steal Butonu**

Rayfield:CreateButton(
    "Main", -- Sekme adı
    "Steal Pet & Teleport", -- Buton adı
    "Elinizde pet varken sizi kendi basenize ışınlar. (2 saniye bekleme süresi)", -- Açıklama
    function()
        local currentTime = tick()
        if currentTime - lastStealTime < stealCooldown then
            Rayfield:Notify(
                "Steal",
                "Çok hızlısın! Lütfen bekle.",
                5 -- Bildirim süresi (saniye)
            )
            return
        end
        lastStealTime = currentTime

        local character = LocalPlayer.Character
        if not character or not character:FindFirstChildOfClass("Humanoid") then
            Rayfield:Notify(
                "Steal",
                "Karakterin bulunamadı.",
                5
            )
            return
        end

        -- Oyuncunun elinde bir pet olup olmadığını kontrol et
        local hasPet = false
        for _, child in ipairs(character:GetChildren()) do
            -- Pet'in genellikle bir "Handle" veya benzeri bir kısmı olur
            -- Bu kısım oyunlara göre değişebilir. Bu bir örnek kontroldür.
            if child:IsA("Model") and child:FindFirstChild("Handle") then -- Basit bir pet kontrolü
                hasPet = true
                break
            end
        end

        if not hasPet then
            Rayfield:Notify(
                "Steal",
                "Elinizde bir pet bulunamadı!",
                5
            )
            return
        end

        -- Oyuncunun ismini al
        local playerName = LocalPlayer.Name

        
        local targetBase = workspace:FindFirstChild(playerName .. "'s Base") -- Örnek: "PlayerName's Base"
        if not targetBase then
            targetBase = workspace:FindFirstChild("Base") -- Genel bir "Base" objesi
        end

        if targetBase and targetBase:IsA("BasePart") then
            local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
            if humanoidRootPart then
                -- Basenin üstüne ışınla
                humanoidRootPart.CFrame = CFrame.new(targetBase.Position + Vector3.new(0, targetBase.Size.Y / 2 + 3, 0))
                Rayfield:Notify(
                    "Steal",
                    "Pet ile basenize ışınlandınız!",
                    3
                )
            else
                Rayfield:Notify(
                    "Steal",
                    "HumanoidRootPart bulunamadı.",
                    5
                )
            end
        else
            Rayfield:Notify(
                "Steal",
                "Baseniz bulunamadı! Lütfen scripti oyununuza göre ayarlayın.",
                8
            )
        end
    end
)
