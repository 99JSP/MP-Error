--[[

Creates a log file where resources folder is located at and collects data on the errors

]]--

local logDirectory = 'logs'
local logFile = logDirectory .. '/errors.txt'

local function createLogDirectoryIfNotExists()
    local result = os.execute('mkdir ' .. logDirectory)
    return true
end

local function createLogFileIfNotExists()
    if not createLogDirectoryIfNotExists() then
        return
    end

    local file = io.open(logFile, 'r')
    if file == nil then
        file = io.open(logFile, 'w')
        if file then
            file:write('Error Logs\n')
            file:close()
        else
            print('Could not create log file.')
        end
    else
        file:close()
    end
end


--[[

Loggging of the error is done by date and time and where the resource is and the players steam name on where it was found.

]]--

local function logError(resource, error, player)
    createLogFileIfNotExists()
    local file = io.open(logFile, 'a')
    if file then
        local time = os.date('%Y-%m-%d %H:%M:%S')
        file:write(('[%s] Error in resource %s by player %s: %s\n'):format(time, resource, player, error))
        file:close()
    else
        print('Could not open log file for writing.')
    end
end

local function logErrorDiscord(webhook, resource, error, player)
    local webhook_url = webhook
    local webhook_username = "MP-Error Resource"
    local webhook_avatar_url = "https://pbs.twimg.com/profile_images/1768076342829166592/VH0M2q3u_400x400.jpg"

    local time = os.date('%Y-%m-%d %H:%M:%S')
    local description = ('Error in resource **%s** by player **%s**: %s'):format(resource, player, error)

    local payload = {
        username = webhook_username,
        avatar_url = webhook_avatar_url,
        embeds = {{
			title = "Error in Resource: " .. resource,
            description = description,
            color = 16777215,  -- Red color
            timestamp = time
        }}
    }

    PerformHttpRequest(webhook_url, function(err, text, headers)
        if err ~= 200 then
            print('Failed to send log to Discord webhook.')
        end
    end, 'POST', json.encode(payload), { ['Content-Type'] = 'application/json' })
end



RegisterServerEvent('logError')
AddEventHandler('logError', function(use, UseBoth, webhook, resource, error)
	if not webhook then use = false end
    local player = source
	if use then
    	logErrorDiscord(webhook, resource, error, GetPlayerName(player))
	elseif UseBoth then
		logErrorDiscord(webhook, resource, error, GetPlayerName(player))
		logError(resource, error, GetPlayerName(player))
	else
		logError(resource, error, GetPlayerName(player))
	end
	print("Error Found in resouce == " .. resource .. " See Logs folder for more information!")
end)