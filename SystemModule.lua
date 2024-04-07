local RunService = game:GetService('RunService')
local PlayerService = game:GetService('Players')









local function formatScriptLine(input)
	local scriptName, line = input:match("Script '([^']+):(%d+)")
	if scriptName and line then
		return string.format("Script '%s', Line %s", scriptName, line)
	else
		return input  -- Return unmodified input if parsing fails
	end
end


local function addLineNumber(scriptLine)
	local scriptName, line, restOfLine = scriptLine:match("^(.-):(.-)%s(.+)$")
	if scriptName and line and restOfLine then
		return string.format("%s', Line %s %s", scriptName, line, restOfLine)
	else
		return scriptLine  -- Return unmodified line if parsing fails
	end
end




local AllowedScripts = {{
	['path'] = 'ReplicatedFirst.System',
	['Is'] = 'LocalScript'
}}








local lastSyncTime = tick() -- Initialize the last synchronization time
local function getTime()
	local currentTime = os.time() -- Get the current time in seconds since the epoch
	local hour = math.floor(currentTime / 3600) % 24 -- Calculate hours
	local minute = math.floor(currentTime / 60) % 60 -- Calculate minutes
	local second = currentTime % 60 -- Calculate seconds

	local formattedTime = string.format("%02d:%02d:%02d", hour + 1, minute, second) -- Format the time as HH:MM:SS

	-- Check if it's time to resynchronize the clock (every minute)
	if tick() - lastSyncTime > 60 then
		lastSyncTime = tick() -- Update the last synchronization time
		local systemTime = os.time() -- Get the current system time
		local systemHour = math.floor(systemTime / 3600) % 24 -- Calculate system hours
		local systemMinute = math.floor(systemTime / 60) % 60 -- Calculate system minutes
		local systemSecond = systemTime % 60 -- Calculate system seconds

		-- Calculate the difference between the system time and the current time in the game
		local timeDifference = systemTime - currentTime

		-- Adjust the current time in the game by the time difference
		currentTime = currentTime + timeDifference

		-- Update the formatted time
		formattedTime = string.format("%02d:%02d:%02d", hour + 1, minute, second)
	end

	return formattedTime
end




local function getRunnedScriptBy()
	if RunService:IsServer() then
		return 'Script'
	elseif RunService:IsClient() then
		return 'LocalScript'
	end
end





local function IsScriptAllowedToUseSystemModule(path)
	for i, v in pairs(AllowedScripts) do
		if AllowedScripts[i]['path'] == path and AllowedScripts[i]['Is'] == getRunnedScriptBy() then
			return true
		else
			return false
		end
	end
end


local module = {}



if not RunService:IsStudio() then
	print('This game is using SystemModule')
end




function module:SystemReplicatedStorage()
	local path = debug.info(2, 's')
	local Arg1 = #(debug.info(1, 'n'))
	local Arg2 = #(debug.info(1, 's'))




	local SortBy1 = (Arg1 + Arg2) + 15



	local IsAllowed = IsScriptAllowedToUseSystemModule(path)



	if IsAllowed then
		local returnTable = {}













		return returnTable
	else
		local Info = debug.traceback():sub(SortBy1, 9999):split('\n')
		local Mes = ''
		local Time = getTime()



		for i, v in Info do
			if v ~= '' then
				if string.find(Info[i], 'function') then
					-- Modify the individual line of the traceback
					local modifiedLine = addLineNumber(Info[i])

					-- Concatenate the timestamp, a space, and the modified line
					Mes = Mes .. Time .. " -- Script '" .. modifiedLine .. '\n'
				else
					Mes = Mes .. Time .. ' -- ' .. formatScriptLine("Script '"..Info[i])..'\n'

					print(Info[i])
				end
			else
				continue
			end
		end





		warn("[System] the current thread cannot access '"..debug.info(1, 'n').."' \n"..Time.." -- Stack Begin ".."\n"..Mes..Time.." -- Stack End")
	end
end





function module:SystemPlayerService()
	local path = debug.info(2, 's')
	local Arg1 = #(debug.info(1, 'n'))
	local Arg2 = #(debug.info(1, 's'))




	local SortBy1 = (Arg1 + Arg2) + 15



	local IsAllowed = IsScriptAllowedToUseSystemModule(path)



	if IsAllowed then
		local PlayerTable = {}




		function PlayerTable:getBackpack()
			local success, result = pcall(function()
				local Player = PlayerService.LocalPlayer or PlayerService:GetPlayers()[1]
				local Backpack = Player:FindFirstChildWhichIsA('Backpack')




				if not Backpack then
					repeat task.wait(0.1) if not Backpack then Backpack = Player:FindFirstChildWhichIsA('Backpack') end until (Backpack)
				end



				return Backpack
			end)


			if success then
				return result
			else
				warn("[System] there was an error while getting 'Backpack' \n\n"..tostring(result))


				return nil
			end
		end



		function PlayerTable:getPlayerScripts()
			local success, result = pcall(function()
				local Player = PlayerService.LocalPlayer or PlayerService:GetPlayers()[1]
				local PlayerScripts = Player:FindFirstChildWhichIsA('PlayerScripts')



				if not PlayerScripts then
					repeat task.wait(0.1) if not PlayerScripts then PlayerScripts = Player:FindFirstChildWhichIsA('PlayerScripts') end until (PlayerScripts)
				end



				return PlayerScripts
			end)



			if success then
				return result
			else
				warn("[System] there was an error while getting 'PlayerScripts' \n\n"..tostring(result))
			end
		end




		function PlayerTable:getStarterGear()
			local success, result = pcall(function()
				local Player = PlayerService.LocalPlayer or PlayerService:GetPlayers()[1]
				local StarterGear = Player:FindFirstChildWhichIsA('StarterGear')



				if not StarterGear then
					repeat task.wait(0.1) if not StarterGear then StarterGear = Player:FindFirstChildWhichIsA('StarterGear') end until (StarterGear)
				end





				return StarterGear
			end)





			if success then
				return result
			else
				warn("[System] there was an error while getting 'StarterGear' \n\n"..tostring(result))
			end
		end









		return PlayerTable
	else
		local Info = debug.traceback():sub(SortBy1, 9999):split('\n')
		local Mes = ''
		local Time = getTime()
		local dotDot = {}



		for i, v in ipairs(Info) do
			if v ~= '' then
				if string.find(Info[i], 'function') then
					-- Modify the individual line of the traceback
					local modifiedLine = addLineNumber(Info[i])

					-- Concatenate the timestamp, a space, and the modified line
					Mes = Mes .. Time .. " -- Script '" .. modifiedLine .. '\n'
				else
					Mes = Mes .. Time .. ' -- ' .. formatScriptLine("Script '"..Info[i])..'\n'

					print(Info[i])
				end
			else
				continue
			end
		end





		warn("[System] the current thread cannot access '"..debug.info(1, 'n').."' \n"..Time.." -- Stack Begin ".."\n"..Mes..Time.." -- Stack End")
	end
end






function module:SystemChatService()
	local TextChatService = game:GetService('TextChatService')
	local ServerScriptService = game:GetService('ServerScriptService')
	local StarterGui = game:GetService('StarterGui')
	
	
	
	
	
	
	local SystemChatService = {}
	
	
	
	
	
	
	function SystemChatService:IsChatOnLatestVersion()
		if TextChatService.ChatVersion == Enum.ChatVersion.TextChatService then
			return true
		elseif TextChatService.ChatVersion == Enum.ChatVersion.LegacyChatService then
			return false
		end
	end
	
	
	
	
	
	function SystemChatService:SendMessageInChat()
		local SendMessageInChat = {}
		
		
		-- Make the SendMessge Function
		function SendMessageInChat:SendMessage(Text: string)
			if Text then
				-- Check if Game's ChatVersion is on OLD and then, do this
				if SystemChatService:IsChatOnLatestVersion() == false then
					warn('[SystemModule]: This Chat Version is deprecated, Please use TextChatService instead')
					
					
					StarterGui:SetCore('ChatMakeSystemMessage', {
						Text = Text
					})
				else -- else do this
					local TextChannels = TextChatService:FindFirstChild('TextChannels')
					
					
					if TextChannels then
						local RBXGeneral = TextChannels.RBXGeneral





						
						RBXGeneral:DisplaySystemMessage(Text)
					else
						warn('Cant find TextChannels')
					end
				end
			end
		end
		
		
		
		--- same crap
		function SendMessageInChat:SendMessageWithFont(Text: string, Color: Color3, FontEnum: Enum.Font, FontSize: number|string)
			if Text and Color and Font and FontSize then
				if SystemChatService:IsChatOnLatestVersion() == false then
					warn('[SystemModule]: This Chat Version is deprecated, Please use TextChatService instead')
					
					
					StarterGui:SetCore('ChatMakeSystemMessage', {
						Text = Text,
						Color = Color,
						Font = FontEnum,
						FontSize = FontSize
					})
				else
					local TextChannels = TextChatService:FindFirstChild('TextChannels')
					
					
					
					if TextChannels then
						local RBXGeneral = TextChannels.RBXGeneral
						
						
						
						if tonumber(FontSize) == nil then
							FontSize = 16
						end
						
						
						
						
						RBXGeneral:DisplaySystemMessage("<font color='#"..Color:ToHex().."'><font face='"..FontEnum.Name.."'><font size='"..tonumber(FontSize).."'>"..Text.."</font></font></font>")
					else
						warn('Cant find TextChannels')
					end
				end
			end
		end
		
		
		
		
		return SendMessageInChat
	end
	
	
	
	
	
	return SystemChatService
end




return module
