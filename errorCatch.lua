
MLog = {}

MLog.Terms = {"error", "not", "failed", "invalid", "cannot", "attempt", "typeerror", "function"}
MLog.WebhookURL = ""
MLog.EmbedColor = 16711680  -- Red color
MLog.UseDiscord = false -- True or False
MLog.UseBoth = false -- this is used to use both discord and send a log.txt file [Highly Suggested if you need support]
MLog.EnableLogging = true -- sends logs to players through f8 and server side


if MLog.EnableLogging == true then
    print("MP Error Catching Live")
end

error = function(msg)  -- Keep the name as 'error' as required
    TriggerServerEvent('logError', MLog.UseDiscord, MLog.UseBoth,  MLog.WebhookURL, GetCurrentResourceName(), msg)
    if MLog.EnableLogging then
        print("Error From " .. GetCurrentResourceName() .. " sent and logged to server owners! Please create a ticket")
    end
end

Citizen.Trace = function(msg)
    for _, term in ipairs(MLog.Terms) do
        if string.find(msg, term) then
            error(msg)
            break
        end
    end
end
