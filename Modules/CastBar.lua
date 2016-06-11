local gUF = LibStub("AceAddon-3.0"):GetAddon("gUF")
local CastBar = gUF:NewModule("CastBar", "AceEvent-3.0")

local L = LibStub("AceLocale-3.0"):GetLocale("gUF", true)

local bars = {}
local frames = {}

function CastBar:OnInitialize()
	gUF:Print("CastBar Module - OnInitialize")

	self:SetEnabledState(false)
end

function CastBar:OnEnable()
	gUF:Print("CastBar Module - OnEnable")

	--self:RegisterEvent("UNIT_SPELLCAST_CHANNEL_INTERRUPTED")
	self:RegisterEvent("UNIT_SPELLCAST_CHANNEL_START")
	self:RegisterEvent("UNIT_SPELLCAST_CHANNEL_STOP", "EventStopCast")
	self:RegisterEvent("UNIT_SPELLCAST_CHANNEL_UPDATE")
	self:RegisterEvent("UNIT_SPELLCAST_DELAYED")
	self:RegisterEvent("UNIT_SPELLCAST_FAILED", "EventStopCast")
	self:RegisterEvent("UNIT_SPELLCAST_INTERRUPTED")
	--self:RegisterEvent("UNIT_SPELLCAST_INTERRUPTIBLE")
	--self:RegisterEvent("UNIT_SPELLCAST_NOT_INTERRUPTIBLE")
	self:RegisterEvent("UNIT_SPELLCAST_START")
	self:RegisterEvent("UNIT_SPELLCAST_STOP", "EventStopCast")
	--self:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED")

	--if (frame == Perl_ArcaneBar_target) then
		self:RegisterEvent("PLAYER_TARGET_CHANGED")
	--elseif (frame == Perl_ArcaneBar_focus) then
		self:RegisterEvent("PLAYER_FOCUS_CHANGED")
	--end

	self.db = gUF.db:RegisterNamespace("gUFDB", self.defaults)

	self:CreateRemoveFrames()											-- Create any frames that are enabled
end

function CastBar:OnDisable()
	gUF:Print("CastBar Module - OnDisable")

	self:UnregisterAllEvents()
end

-- function CastBar:EnableModule()
-- --	if( self.db.profile.combat ) then
-- --		frame:RegisterEvent("PLAYER_FOCUS_CHANGED")
-- --		frame:RegisterEvent("PLAYER_TARGET_CHANGED")
-- --		frame:RegisterEvent("UNIT_SPELLCAST_CHANNEL_START")
-- --		frame:RegisterEvent("UNIT_SPELLCAST_CHANNEL_STOP")
-- --		frame:RegisterEvent("UNIT_SPELLCAST_CHANNEL_UPDATE")
-- --		frame:RegisterEvent("UNIT_SPELLCAST_DELAYED")
-- --		frame:RegisterEvent("UNIT_SPELLCAST_FAILED")
-- --		frame:RegisterEvent("UNIT_SPELLCAST_INTERRUPTED")
-- --		frame:RegisterEvent("UNIT_SPELLCAST_START")
-- --		frame:RegisterEvent("UNIT_SPELLCAST_STOP")
-- --	end
-- 	gUF:Print("CastBar Module - EnableModule")
-- end
--
-- function CastBar:DisableModule()
-- 	self:UnregisterAllEvents()
-- 	gUF:Print("CastBar Module - DisableModule")
-- end

function CastBar:UNIT_SPELLCAST_CHANNEL_START()

end

-- function CastBar:UNIT_SPELLCAST_CHANNEL_STOP()
--
-- end

function CastBar:UNIT_SPELLCAST_CHANNEL_UPDATE()

end

function CastBar:UNIT_SPELLCAST_DELAYED()

end

function CastBar:UNIT_SPELLCAST_FAILED()

end

function CastBar:UNIT_SPELLCAST_INTERRUPTED()

end

function CastBar:UNIT_SPELLCAST_START(event, unit)
	gUF:Print("CastBar Module - UNIT_SPELLCAST_START")

	if not frames[unit] then return end

	for frame in pairs(frames[unit]) do
		--gUF:Print("CastBar Module - UNIT_SPELLCAST_START UNIT FOUND")
		--frame.healthbar:SetMinMaxValues(0, UnitHealthMax(unit))
		--frame.arcanebar:UNIT_HEALTH(nil, unit)

		--local arcanebar = "gUF_"..unit
		--arcanebar = arcanebar.arcanebar
		--arcanebar:SetValue(100)


		--local _
		local text, _, _, _, startTime, endTime, _, _, notInterruptible = UnitCastingInfo(unit)

		--frame.arcanebar:SetStatusBarColor(Perl_ArcaneBar_Colors.main.r, Perl_ArcaneBar_Colors.main.g, Perl_ArcaneBar_Colors.main.b, transparency)
		--frame.arcanebar.barSpark:Show()
		frame.arcanebar.startTime = startTime / 1000
		frame.arcanebar.maxValue = endTime / 1000
		frame.arcanebar:SetMinMaxValues(frame.arcanebar.startTime, frame.arcanebar.maxValue)
		frame.arcanebar:SetValue(frame.arcanebar.startTime)

		if (notInterruptible) then
			--frame.arcanebar:SetStatusBarColor(Perl_ArcaneBar_Colors.notInterruptible.r, Perl_ArcaneBar_Colors.notInterruptible.g, Perl_ArcaneBar_Colors.notInterruptible.b, transparency)
		end

		-- if (frame.arcanebar.namereplace == 1) then
		-- 	if (frame.arcanebar.nameframetext == nil) then
		-- 		if (frame.arcanebar.unit == "player") then
		-- 			frame.arcanebar.nameframetext = Perl_Player_NameBarText
		-- 			frame.arcanebar.parentframe = Perl_Player_Frame
		-- 		elseif (frame.arcanebar.unit == "target") then
		-- 			frame.arcanebar.nameframetext = Perl_Target_NameBarText
		-- 		elseif (frame.arcanebar.unit == "focus") then
		-- 			frame.arcanebar.nameframetext = Perl_Focus_NameBarText
		-- 		elseif (frame.arcanebar.unit == "party1") then
		-- 			frame.arcanebar.nameframetext = Perl_Party_MemberFrame1_Name_NameBarText
		-- 			frame.arcanebar.parentframe = Perl_Party_MemberFrame1
		-- 		elseif (frame.arcanebar.unit == "party2") then
		-- 			frame.arcanebar.nameframetext = Perl_Party_MemberFrame2_Name_NameBarText
		-- 			frame.arcanebar.parentframe = Perl_Party_MemberFrame2
		-- 		elseif (frame.arcanebar.unit == "party3") then
		-- 			frame.arcanebar.nameframetext = Perl_Party_MemberFrame3_Name_NameBarText
		-- 			frame.arcanebar.parentframe = Perl_Party_MemberFrame3
		-- 		elseif (frame.arcanebar.unit == "party4") then
		-- 			frame.arcanebar.nameframetext = Perl_Party_MemberFrame4_Name_NameBarText
		-- 			frame.arcanebar.parentframe = Perl_Party_MemberFrame4
		-- 		end
		-- 	end
		-- 	if (frame.arcanebar.nameframetext ~= nil) then
		-- 		frame.arcanebar.nameframetext:SetText(text)
		-- 	end
		-- end

		frame.arcanebar:SetAlpha(0.8)
		frame.arcanebar.holdTime = 0
		frame.arcanebar.casting = 1
		frame.arcanebar.channeling = nil
		frame.arcanebar.fadeOut = nil
		frame.arcanebar.delaySum = 0
		frame.arcanebar:Show()

		-- if (frame.arcanebar.showtimer == 1) then
		-- 	frame.arcanebar.castTimeText:Show()
		-- else
		-- 	frame.arcanebar.castTimeText:Hide()
		-- end
	end

end

--function CastBar:UNIT_SPELLCAST_STOP(event, unit)
function CastBar:EventStopCast(event, unit)
	--gUF:Print("CastBar Module - UNIT_SPELLCAST_STOP")
	gUF:Print("CastBar Module - "..event)

	if not frames[unit] then return end

	for frame in pairs(frames[unit]) do
		--frame.arcanebar:Hide()

		if (frame.arcanebar:IsShown()) then
			--if (frame.arcanebar.channeling == nil) then
				--frame.arcanebar.barSpark:Hide()
			--end
			--frame.arcanebar.barFlash:SetAlpha(0.0)
			--frame.arcanebar.barFlash:Show()
			frame.arcanebar:SetValue(frame.arcanebar.maxValue)
			--frame.arcanebar:SetStatusBarColor(Perl_ArcaneBar_Colors.success.r, Perl_ArcaneBar_Colors.success.g, Perl_ArcaneBar_Colors.success.b, transparency)
			--if (event == "UNIT_SPELLCAST_STOP") then
				frame.arcanebar.casting = nil
			--else
				--frame.arcanebar.channeling = nil
			--end
			frame.arcanebar.delaySum = 0
			frame.arcanebar.flash = 1
			frame.arcanebar.fadeOut = 1
			frame.arcanebar.holdTime = 0

			-- if (frame.arcanebar.showtimer == 1) then
			-- 	frame.arcanebar.castTimeText:Show()
			-- end
		end

		-- if (frame.arcanebar.namereplace == 1) then
		-- 	if (frame.arcanebar.casting == nil and frame.arcanebar.channeling == nil) then
		-- 		if (frame.arcanebar.nameframetext == nil) then
		-- 			if (frame.arcanebar.unit == "player") then
		-- 				frame.arcanebar.nameframetext = Perl_Player_NameBarText
		-- 				frame.arcanebar.parentframe = Perl_Player_Frame
		-- 			elseif (frame.arcanebar.unit == "target") then
		-- 				frame.arcanebar.nameframetext = Perl_Target_NameBarText
		-- 			elseif (frame.arcanebar.unit == "focus") then
		-- 				frame.arcanebar.nameframetext = Perl_Focus_NameBarText
		-- 			elseif (frame.arcanebar.unit == "party1") then
		-- 				frame.arcanebar.nameframetext = Perl_Party_MemberFrame1_Name_NameBarText
		-- 				frame.arcanebar.parentframe = Perl_Party_MemberFrame1
		-- 			elseif (frame.arcanebar.unit == "party2") then
		-- 				frame.arcanebar.nameframetext = Perl_Party_MemberFrame2_Name_NameBarText
		-- 				frame.arcanebar.parentframe = Perl_Party_MemberFrame2
		-- 			elseif (frame.arcanebar.unit == "party3") then
		-- 				frame.arcanebar.nameframetext = Perl_Party_MemberFrame3_Name_NameBarText
		-- 				frame.arcanebar.parentframe = Perl_Party_MemberFrame3
		-- 			elseif (frame.arcanebar.unit == "party4") then
		-- 				frame.arcanebar.nameframetext = Perl_Party_MemberFrame4_Name_NameBarText
		-- 				frame.arcanebar.parentframe = Perl_Party_MemberFrame4
		-- 			end
		-- 		end
		-- 		if (frame.arcanebar.nameframetext ~= nil) then
		-- 			frame.arcanebar.nameframetext:SetText(frame.arcanebar.unitname)
		-- 		end
		-- 	end
		-- end
	end
end

function CastBar:PLAYER_TARGET_CHANGED()

end

function CastBar:PLAYER_FOCUS_CHANGED()

end

function CastBar:Reload()
	gUF:Print("CastBar Module - Reload")
end

function CastBar:OnUpdate(elapsed)
	--gUF:Print("CastBar Module - OnUpdate")
	--gUF:Print( tostring( self:GetName() ) )

	local getTime = GetTime()

	-- if (self.showtimer == 1) then
	-- 	local current_time = self.maxValue - getTime
	-- 	if (self.channeling) then
	-- 		current_time = self.endTime - getTime
	-- 	end
	-- 	if (current_time < 0) then
	-- 		current_time = 0
	-- 	end
	--
	-- 	local text = math.max(current_time, 0) + 0.001, 1, 4
	-- 	if (text >= 100) then
	-- 		text = string.sub(text, 1, 3)
	-- 	else
	-- 		text = string.sub(text, 1, 4)
	-- 	end
	-- 	if (self.delaySum ~= 0) then
	-- 		local delay = string.sub(math.max(self.delaySum / 1000, 0) + 0.001, 1, 4)
	-- 		if (self.channeling == 1) then
	-- 			self.sign = "-"
	-- 		else
	-- 			self.sign = "+"
	-- 		end
	-- 		text = "|cffcc0000"..self.sign..delay.."|r "..text
	-- 	end
	-- 	self.castTimeText:SetText(text)
	-- end

	if (self.casting) then
		local status = getTime
		if (status > self.maxValue) then
			status = self.maxValue
		end
		if (status == self.maxValue) then
			self:SetValue(status)
			self:SetStatusBarColor(0.0, 1.0, 0.0)
			--if (notInterruptible) then
				--self:SetStatusBarColor(Perl_ArcaneBar_Colors.notInterruptible.r, Perl_ArcaneBar_Colors.notInterruptible.g, Perl_ArcaneBar_Colors.notInterruptible.b)
			--end
			--self.barSpark:Hide()
			--self.barFlash:SetAlpha(0.0)
			--self.barFlash:Show()
			self.flash = 1
			self.fadeOut = 1
			self.casting = nil
			self.channeling = nil
			self.delaySum = 0
			-- if (self.nameframetext == nil) then
			-- 	if (self.unit == "player") then
			-- 		self.nameframetext = Perl_Player_NameBarText
			-- 		self.parentframe = Perl_Player_Frame
			-- 	elseif (self.unit == "target") then
			-- 		self.nameframetext = Perl_Target_NameBarText
			-- 	elseif (self.unit == "focus") then
			-- 		self.nameframetext = Perl_Focus_NameBarText
			-- 	elseif (self.unit == "party1") then
			-- 		self.nameframetext = Perl_Party_MemberFrame1_Name_NameBarText
			-- 		self.parentframe = Perl_Party_MemberFrame1
			-- 	elseif (self.unit == "party2") then
			-- 		self.nameframetext = Perl_Party_MemberFrame2_Name_NameBarText
			-- 		self.parentframe = Perl_Party_MemberFrame2
			-- 	elseif (self.unit == "party3") then
			-- 		self.nameframetext = Perl_Party_MemberFrame3_Name_NameBarText
			-- 		self.parentframe = Perl_Party_MemberFrame3
			-- 	elseif (self.unit == "party4") then
			-- 		self.nameframetext = Perl_Party_MemberFrame4_Name_NameBarText
			-- 		self.parentframe = Perl_Party_MemberFrame4
			-- 	end
			-- end
			-- if (self.nameframetext ~= nil) then
			-- 	self.nameframetext:SetText(self.unitname)
			-- end
			return
		end
		self:SetValue(status)
		--self.barFlash:Hide()
		--local sparkPosition = ((status - self.startTime) / (self.maxValue - self.startTime)) * (self.nameframewidth - 10)
		--if (sparkPosition < 0) then
			--sparkPosition = 0
		--end
		--self.barSpark:SetPoint("CENTER", self, "LEFT", sparkPosition, 0)
	elseif (self.channeling) then
		local time = getTime
		if (time > self.endTime) then
			time = self.endTime
		end
		if (time == self.endTime) then
			self:SetStatusBarColor(0.0, 1.0, 0.0)
			if (notInterruptible) then
				--self:SetStatusBarColor(Perl_ArcaneBar_Colors.notInterruptible.r, Perl_ArcaneBar_Colors.notInterruptible.g, Perl_ArcaneBar_Colors.notInterruptible.b)
			end
			--self.barSpark:Hide()
			--self.barFlash:SetAlpha(0.0)
			--self.barFlash:Show()
			self.flash = 1
			self.fadeOut = 1
			self.casting = nil
			self.channeling = nil
			self.delaySum = 0
			-- if (self.nameframetext == nil) then
			-- 	if (self.unit == "player") then
			-- 		self.nameframetext = Perl_Player_NameBarText
			-- 		self.parentframe = Perl_Player_Frame
			-- 	elseif (self.unit == "target") then
			-- 		self.nameframetext = Perl_Target_NameBarText
			-- 	elseif (self.unit == "focus") then
			-- 		self.nameframetext = Perl_Focus_NameBarText
			-- 	elseif (self.unit == "party1") then
			-- 		self.nameframetext = Perl_Party_MemberFrame1_Name_NameBarText
			-- 		self.parentframe = Perl_Party_MemberFrame1
			-- 	elseif (self.unit == "party2") then
			-- 		self.nameframetext = Perl_Party_MemberFrame2_Name_NameBarText
			-- 		self.parentframe = Perl_Party_MemberFrame2
			-- 	elseif (self.unit == "party3") then
			-- 		self.nameframetext = Perl_Party_MemberFrame3_Name_NameBarText
			-- 		self.parentframe = Perl_Party_MemberFrame3
			-- 	elseif (self.unit == "party4") then
			-- 		self.nameframetext = Perl_Party_MemberFrame4_Name_NameBarText
			-- 		self.parentframe = Perl_Party_MemberFrame4
			-- 	end
			-- end
			--self.nameframetext:SetText(self.unitname)
			return
		end
		local barValue = self.startTime + (self.endTime - time)
		self:SetValue(barValue)
		--self.barFlash:Hide()
		--local sparkPosition = ((barValue - self.startTime) / (self.endTime - self.startTime)) * (self.nameframewidth - 10)
		--self.barSpark:SetPoint("CENTER", self, "LEFT", sparkPosition, 0)
	elseif (getTime < self.holdTime) then
		return
	-- elseif (self.flash) then
	-- 	local alpha = self.barFlash:GetAlpha() + CASTING_BAR_FLASH_STEP
	-- 	if (alpha < 1) then
	-- 		self.barFlash:SetAlpha(alpha)
	-- 	else
	-- 		self.barFlash:SetAlpha(0.8)
	-- 		self.flash = nil
	-- 	end
	elseif (self.fadeOut) then
		local alpha = self:GetAlpha() - CASTING_BAR_ALPHA_STEP
		if (alpha > 0) then
			self:SetAlpha(alpha)
		else
			self.fadeOut = nil
			self:Hide()
		end
	end
end

function CastBar:CreateRemoveFrames()
	gUF:Print("CastBar Module - CreateRemoveFrames")
	-- local frames = gUF:GetActiveUnitFrameNames()
	-- for i in pairs(frames) do
	-- 	--gUF:Print(frames[i].."_NameFrameOverlay")
	-- 	gUF:Print(frames[i])
	-- end

	--local frames = gUF:GetActiveUnitFrames()
	frames = gUF:GetActiveUnitFrames()
	for i,v in pairs(frames) do
		for frame in pairs(v) do
			if (frame.arcanebar == nil) then
			--gUF:Print(tostring(frame.unit))
			--gUF:Print(tostring(frame.nameframeoverlay:GetName()))
			--gUF:Print(tostring(frame:GetName()))

			--local frame = CreateFrame("Frame", framename, UIParent, nil)
			--frame:SetFrameStrata("LOW")
			--frame:SetMovable(1)
			--frame:SetHeight(1)
			--frame:SetWidth(1)

			--local unit = frame.unit


			frame.arcanebar = CreateFrame("StatusBar", nil, frame, nil)
			frame.arcanebar:Hide()
			frame.arcanebar:SetPoint("TOPLEFT", frame.nameframe, "TOPLEFT", 4, -4)
			frame.arcanebar:SetHeight(frame.nameframe:GetHeight()-8)
			frame.arcanebar:SetWidth(frame.nameframe:GetWidth()-8)
			--frame.arcanebar:SetHeight(24)
			--frame.arcanebar:SetWidth(200)
			frame.arcanebar:SetScript("OnUpdate", CastBar.OnUpdate)

			frame.arcanebar:SetStatusBarTexture("Interface\\TARGETINGFRAME\\UI-StatusBar")
			frame.arcanebar:GetStatusBarTexture():SetHorizTile(false)
			frame.arcanebar:GetStatusBarTexture():SetVertTile(false)
			--frame.arcanebar:SetStatusBarColor(0, 0.65, 0)

			--gUF:Print(frame.nameframe:GetHeight())

			frame.arcanebar:SetMinMaxValues(0, 100)
			frame.arcanebar:SetValue(0)
			--frame.arcanebar:Show()

			--gUF:Print( frame.arcanebar:GetValue() )

			--frame.healthbar:SetStatusBarColor(self.db.profile.global[L["Health Bar Color"]].r, self.db.profile.global[L["Health Bar Color"]].g, self.db.profile.global[L["Health Bar Color"]].b, self.db.profile.global[L["Health Bar Color"]].a)
			--frame.bars += frame.arcanebar
			--gUF:SetupStatusBarTextures(frame)



			end
		end
	end
end
