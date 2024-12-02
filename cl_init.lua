local RANGE_WHISPER = 1.5
local RANGE_NORMAL = 3.0
local RANGE_YELL = 6.0
local RANGE_VEHMEGA = 50.0
local RANGE_MICROPHONE = 100.0

local voiceRange = RANGE_NORMAL


Citizen.CreateThread( function()
    while true do
	
		local voiceM = ( LocalPlayer.state['proximity'] or { distance = RANGE_NORMAL } ).distance
	
		if voiceM == 1.5 then
			voiceRange = RANGE_WHISPER
		elseif voiceM == 3.0 then
			voiceRange = RANGE_NORMAL
		elseif voiceM == 6.0 then
			voiceRange = RANGE_YELL
		elseif voiceM == 50.0 then
			voiceRange = RANGE_VEHMEGA
		elseif voiceM == 100.0 then
			voiceRange = RANGE_MICROPHONE
		end
		
        local voice = voiceRange == RANGE_WHISPER and '~y~Whisper' or voiceRange == RANGE_NORMAL and '~w~Normal' or voiceRange == RANGE_YELL and '~r~Shouting' or voiceRange == RANGE_VEHMEGA and '~r~Vehicle Megaphone' or voiceRange == RANGE_MICROPHONE and '~r~Stage Microphone'

        local speaking = NetworkIsPlayerTalking( PlayerId() )
        voice = speaking and voice .. ' ~g~(Speaking)' or voice

        exports.sample_util:DrawTextRightOfMinimap( exports.sample_util:GetHudColor() .. "Voice: " .. voice, 0.0, 0.08, 0.4 )

        Citizen.Wait( 0 )
    end
end )