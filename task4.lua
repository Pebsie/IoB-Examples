--[[
	This script is the answer for Task 4 of the official scripting documentation.
	It attempts to login as a user, demo, and if it can't find that user it attempts to register it.
	Written by Thomas Lock. Last updated February 18th 2018 @ 12:35pm. v1.
]]

username = "demo"
password = "demo"

result = api.get("?a=login&username="..username.."&password="..password)

if result.authcode then 
	authcode = result.authcode -- the client requires the global value authcode to be set to acknowledge us logging in and update the UI accordingly
else -- this account doesn't exist, or the password is wrong. Since this version of the API doesn't tell us which we'll try and register it
	result = api.get("?a=register&username="..username.."&password="..password)
	if result.authcode then 
		authcode = result.authcode
	else
		error("The script entered is trying to login to an existing account without a correct password") -- this stops execution of the game client and displays this message
	end
end

if authcode then -- we are logged in
	result = api.get("?a=get&scope=player&type=buildingsum&authcode="..authcode)
	if result.num == "0" then
		api.get("?a=build&position="..love.math.random(1,10000).."&type=Castle&authcode="..authcode)
	end
end
