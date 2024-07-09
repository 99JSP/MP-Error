# MLog Error Logging System

## Installation

1. Download the client-side and server-side scripts.
2. Place them in the appropriate resource folder.
3. Configure the `MLog` table in the client-side script as needed.
4. This Client Script needs to be added to every fxmanifest you want it to look over! 
```lua 
client_script '@MP-Error/errorCatch.lua'
```
5. Start the resource on your FiveM server.

## Overview

MLog is a Lua-based error logging system designed for use with FiveM. It captures client-side errors and logs them either to a file on the server or sends them to a Discord webhook for real-time monitoring. This system can be configured to log errors using various methods, ensuring that server owners and developers are aware of issues as they occur.

## Features

- Captures client-side errors based on predefined terms.
- Logs errors to a file on the server.
- Sends error notifications to a Discord webhook.
- Supports logging errors both to a file and Discord simultaneously.
- Enables logging configuration through simple toggles.

## Configuration

### Client-Side Configuration

Edit the `MLog` table in the client-side script to configure the error logging behavior:

- **MLog.Terms**: A list of terms to search for in error messages.
- **MLog.WebhookURL**: The URL of the Discord webhook to send error notifications to.
- **MLog.EmbedColor**: The color of the embed message in Discord (in decimal format).
- **MLog.UseDiscord**: Set to `true` to enable sending errors to Discord.
- **MLog.UseBoth**: Set to `true` to log errors both to a file and Discord.
- **MLog.EnableLogging**: Set to `true` to enable error logging.

### Example Configuration
```lua
MLog = {}

MLog.Terms = {"error", "not", "failed", "invalid", "cannot", "attempt", "typeerror", "function"}
MLog.WebhookURL = "https://discord.com/api/webhooks/YOUR_WEBHOOK_URL"
MLog.EmbedColor = 16711680  -- Red color
MLog.UseDiscord = false
MLog.UseBoth = false
MLog.EnableLogging = true
```

## Usage

### Client-Side Script

1. Place the client-side script (`client.lua`) in your resource folder.
2. Ensure the configuration is set as per your requirements.
3. When `MLog.EnableLogging` is set to `true`, the script will monitor for error messages and log them accordingly.

### Server-Side Script

1. Place the server-side script (`server.lua`) in your resource folder.
2. The server script will create a `logs` directory and an `errors.txt` file if they do not exist.
3. Errors will be logged to `errors.txt` and/or sent to the specified Discord webhook based on your configuration.

### Error Handling Functions

#### Client-Side
- **error(msg)**: Triggers an event to log the error on the server.
- **Citizen.Trace(msg)**: Checks the message against the terms in `MLog.Terms` and calls `error(msg)` if a term is found.

#### Server-Side
- **logError(resource, error, player)**: Logs the error to a file.
- **logErrorDiscord(webhook, resource, error, player)**: Sends the error to a Discord webhook.

### Events

- **RegisterServerEvent('logError')**: Listens for the `logError` event from the client, processes the error, and logs it accordingly.

## Conclusion

MLog provides a robust solution for logging and monitoring errors in FiveM resources. By configuring the script to send logs to both a file and Discord, server owners can ensure they have comprehensive error tracking and timely notifications for efficient troubleshooting.
