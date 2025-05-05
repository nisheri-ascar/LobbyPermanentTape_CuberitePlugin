-- Plugin logic
-- 1. for 200 seconds. Periodically check if a certain website returns 200 OK, meaning the server is almost done (but not yet) starting
-- 2. Once 200 OK recieved, start a 60 seconds countdown. Giving graceful wait period
-- 3. Once finished, kick all players. 
-- 4. Set serverIsAlive flag to true, kick all incoming players too.

-- Website to check
HTTPServer = "plus-percentage.at.ply.gg"
HTTPPort = "63971"
IsServerAlive = false

-- Define the callbacks to use for the client connection:
local ConnectCallbacks =
{
	OnConnected = function (a_Link)
		-- Connection succeeded, send the http request:
		a_Link:Send("GET / HTTP/1.0\r\nHost: " .. HTTPServer ..  " \r\n\r\n")
	end,

	OnError = function (a_Link, a_ErrorCode, a_ErrorMsg)
		-- Log the error to console:
		LOG("An error has occurred while talking to google.com: " .. a_ErrorCode .. " (" .. a_ErrorMsg .. ")")
	end,

	OnReceivedData = function (a_Link, a_Data)
		-- Log the received data to console:
		LOG("Incoming http data:\r\n" .. a_Data)
	end,

	OnRemoteClosed = function (a_Link)
		-- Log the event into the console:
		LOG("Connection to " .. HTTPServer .. " closed")
	end,
}

function CheckIfHTTPIsAlive()
	if not(cNetwork:Connect(HTTPServer, HTTPPort, ConnectCallbacks)) then
		player.SendAboveActionBarMessage("T")
end

function Countdown()
	LOG("placeholder from countdown")
end


function KickAllPLayers()
-- from cmd_list.lua
	local PlayerTable = {}
	local ForEachPlayer = function(a_Player)
		table.insert(PlayerTable, a_Player:GetName())
	end
	cRoot:Get():ForEachPlayer(ForEachPlayer)
	table.sort(PlayerTable)

end

function OnPlayerJoin(a_Client)
	if(IsServerAlive == true) then
		a_Client:Kick("Transferring to Main Server.")
	end
end

function Initialize(Plugin)
	Plugin:SetName("LobbyPermanentTape")
	Plugin:SetVersion(1)
	return true
end
