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
	local path = debug.info(2, 's')
	local Arg1 = #(debug.info(1, 'n'))
	local Arg2 = #(debug.info(1, 's'))




	local SortBy1 = (Arg1 + Arg2) + 15
	
	
	
	
	local IsAllowed = IsScriptAllowedToUseSystemModule(path)



	if IsAllowed then
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





function module:SystemConverterService()
	local path = debug.info(2, 's')
	local Arg1 = #(debug.info(1, 'n'))
	local Arg2 = #(debug.info(1, 's'))




	local SortBy1 = (Arg1 + Arg2) + 15




	local IsAllowed = IsScriptAllowedToUseSystemModule(path)



	if IsAllowed then
		local ConverterTable = {}
		
		
		
		
		function ConverterTable:TextToBase64(data)
			local b = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
			
			return ((data:gsub('.', function(x) 
				local r,b='',x:byte()
				for i=8,1,-1 do r=r..(b%2^i-b%2^(i-1)>0 and '1' or '0') end
				return r;
			end)..'0000'):gsub('%d%d%d?%d?%d?%d?', function(x)
				if (#x < 6) then return '' end
				local c=0
				for i=1,6 do c=c+(x:sub(i,i)=='1' and 2^(6-i) or 0) end
				return b:sub(c+1,c+1)
			end)..({ '', '==', '=' })[#data%3+1])
		end
		
		
		
		
		function ConverterTable:Base64ToText(data)
			local b = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
			
			data = string.gsub(data, '[^'..b..'=]', '')
			
			return (data:gsub('.', function(x)
				if (x == '=') then return '' end
				local r,f='',(b:find(x)-1)
				for i=6,1,-1 do r=r..(f%2^i-f%2^(i-1)>0 and '1' or '0') end
				return r;
			end):gsub('%d%d%d?%d?%d?%d?%d?%d?', function(x)
				if (#x ~= 8) then return '' end
				local c=0
				for i=1,8 do c=c+(x:sub(i,i)=='1' and 2^(8-i) or 0) end
				return string.char(c)
			end))
		end
		
		
		
		
		function ConverterTable:TextToHex(Text: string)
			local str = Text
			
			return (str:gsub('.', function (c)
				return string.format('%02X', string.byte(c))
			end))
		end
		
		
		
		function ConverterTable:HexToText(Text: string)
			local str = Text

			return (str:gsub('..', function (cc)
				return string.char(tonumber(cc, 16))
			end))
		end
		
		
		
		function ConverterTable:TextToBinary(Text: string)
			local String = Text
			
			
			local BinaryString = {}

			for i, Character in ipairs(String:split'') do --> ex: {"A", "B", "C"}
				local Binary = ""
				local Byte = Character:byte() -- convert character to ascii character code
				while Byte > 0 do
					-- apply formula for converting number to binary
					Binary = tostring(Byte % 2) .. Binary
					Byte = math.modf(Byte / 2) -- modf to strip decimal
				end
				table.insert(BinaryString, string.format("%.8d", Binary)) -- format string to always have at least 8 characters (00000000)
			end

			return table.concat(BinaryString, " ")
		end
		
		
		
		function ConverterTable:BinaryToText(Binary: string)
			local BinaryString = Binary
			
			
			local String = ""

			for i, Binary in ipairs(BinaryString:split' ') do --> ex: {"01000001", "01000010", "01000011"}
				local Byte = tonumber(Binary, 2) -- convert binary (base 2) to ascii character code
				String ..= string.char(Byte) -- get character from ascii code and append it at end of string
			end

			return String
		end
		
		
		
		
		function ConverterTable:TextToDecimal(text: string)
			local decimalRepresentation = ''
			
			
			
			for i = 1, #text do
				local char = text:sub(i, i) -- Get the character at position i
				local decimalValue = string.byte(char) -- Get the ASCII value of the character
				decimalRepresentation = decimalRepresentation .. decimalValue .. " " -- Append the decimal value to the result
			end
			
			
			
			return decimalRepresentation
		end
		
		
		
		function ConverterTable:DecimalToText(Decimal: string)
			local text = ""
			
			
			for decimalValue in Decimal:gmatch("%d+") do
				local char = string.char(tonumber(decimalValue)) -- Convert the ASCII value to its corresponding character
				text = text .. char -- Append the character to the result
			end
			
			
			return text
		end
		
		
		
		
		function ConverterTable:TextToOctal(text: string)
			local octalRepresentation = ""

			for i = 1, #text do
				local char = text:sub(i, i) -- Get the character at position i
				local octalValue = string.format("%o", string.byte(char)) -- Get the octal representation of the ASCII value of the character
				octalRepresentation = octalRepresentation .. octalValue .. " " -- Append the octal value to the result
			end

			return octalRepresentation
		end
		
		
		function ConverterTable:OctalToText(octal: string)
			local octalString = octal
			
			
			local text = ""

			for octalValue in octalString:gmatch("%d+") do
				local decimalValue = tonumber(octalValue, 8) -- Convert the octal value to its corresponding decimal value
				local char = string.char(decimalValue) -- Convert the ASCII value to its corresponding character
				text = text .. char -- Append the character to the result
			end

			return text
		end
		
		
		
		
		
		
		return ConverterTable
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




function module:SystemMusicService()
	local path = debug.info(2, 's')
	local Arg1 = #(debug.info(1, 'n'))
	local Arg2 = #(debug.info(1, 's'))




	local SortBy1 = (Arg1 + Arg2) + 15




	local IsAllowed = IsScriptAllowedToUseSystemModule(path)



	if IsAllowed then
		local MusicService = {}
		
		
		
		function MusicService:CreateSound(SoundID: number|string)
			local Sound = Instance.new('Sound')
			
			local SoundTable = {}
			
			
			
			
			
			local success, result = pcall(function()
				if typeof(SoundID) == 'string' then
					if not string.find(SoundID, 'rbxassetid://') then
						Sound.SoundId = 'rbxassetid://'..SoundID
					else
						Sound.SoundId = SoundID
					end
				else
					Sound.SoundId = 'rbxassetid://'..SoundID
				end
			end)
			
			
			
			
			
			if not success then
				print('There was an Error while loading SoundID\n\n'..tostring(result))
			end
			
			
			Sound.Parent = game:GetService('ReplicatedStorage')
			
			
			
			
			
			function SoundTable:SetParent(Parent)
				if not Parent then
					Sound.Parent = game:GetService('ReplicatedStorage')
				else
					if typeof(Parent) == 'Instance' then
						Sound.Parent = Parent
					else
						print('Cannot be anything else than a Instance / Game. \n\n'..tostring(debug.traceback()))
					end
				end
				
				
				
				return SoundTable
			end
			
			
			
			
			
			function SoundTable:SetName(Name: string)
				if Name and typeof(Name) == 'string' then
					Sound.Name = Name
				else
					print('Must be a string.\n\n'..tostring(debug.traceback()))
				end



				return SoundTable
			end
			
			
			
			
			function SoundTable:SetLooping(trueOrFalse: boolean)
				if trueOrFalse and typeof(trueOrFalse) == 'boolean' then
					Sound.Looped = trueOrFalse
					Sound.PlaybackRegionsEnabled = trueOrFalse
				else
					print('Must be a trueOrfalse.\n\n'..tostring(debug.traceback()))
				end
			end
			
			
			
			
			
			
			function SoundTable:SetVolume(Volume: number)
				if typeof(Volume) == 'number' then
					Sound.Volume = Volume
				else
					print('Must be a Number. \n\n'..tostring(debug.traceback()))
				end
				
				
				
				return SoundTable
			end
			
			
			
			
			
			function SoundTable:Play()
				local success, result = pcall(function()
					Sound:Play()
				end)


				if not success then
					print('There was an Error\n\n'..tostring(result))
				end
				
				
				
				return SoundTable
			end
			
			
			
			function SoundTable:Stop()
				local success, result = pcall(function()
					Sound:Stop()
				end)


				if not success then
					print('There was an Error\n\n'..tostring(result))
				end
				
				
				
				return SoundTable
			end
		
		
			return SoundTable
		end
		
		
		return MusicService
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










return module
