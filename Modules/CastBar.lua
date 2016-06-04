local gUF = LibStub("AceAddon-3.0"):GetAddon("gUF")
local CastBar = gUF:NewModule("CastBar", "AceEvent-3.0")

local L = LibStub("AceLocale-3.0"):GetLocale("gUF", true)

local bars = {}

function CastBar:OnInitialize()
	gUF:Print("CastBar Module - OnInitialize")

	self:SetEnabledState(false)
end

function CastBar:OnEnable()
	gUF:Print("CastBar Module - OnEnable")

	self:RegisterEvent("UNIT_SPELLCAST_CHANNEL_START")
	self:RegisterEvent("UNIT_SPELLCAST_CHANNEL_STOP")
	self:RegisterEvent("UNIT_SPELLCAST_CHANNEL_UPDATE")
	self:RegisterEvent("UNIT_SPELLCAST_DELAYED")
	self:RegisterEvent("UNIT_SPELLCAST_FAILED")
	self:RegisterEvent("UNIT_SPELLCAST_INTERRUPTED")
	self:RegisterEvent("UNIT_SPELLCAST_START")
	self:RegisterEvent("UNIT_SPELLCAST_STOP")

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

function CastBar:UNIT_SPELLCAST_CHANNEL_STOP()

end

function CastBar:UNIT_SPELLCAST_CHANNEL_UPDATE()

end

function CastBar:UNIT_SPELLCAST_DELAYED()

end

function CastBar:UNIT_SPELLCAST_FAILED()

end

function CastBar:UNIT_SPELLCAST_INTERRUPTED()

end

function CastBar:UNIT_SPELLCAST_START()

end

function CastBar:UNIT_SPELLCAST_STOP()

end

function CastBar:PLAYER_TARGET_CHANGED()

end

function CastBar:PLAYER_FOCUS_CHANGED()

end

function CastBar:Reload()
	gUF:Print("CastBar Module - Reload")
end

function CastBar:CreateRemoveFrames()
	-- local frames = gUF:GetActiveUnitFrameNames()
	-- for i in pairs(frames) do
	-- 	--gUF:Print(frames[i].."_NameFrameOverlay")
	-- 	gUF:Print(frames[i])
	-- end

	local frames = gUF:GetActiveUnitFrames()
	for i,v in pairs(frames) do
		for frame in pairs(v) do
			--gUF:Print(tostring(frame.unit))
			--gUF:Print(tostring(frame.nameframeoverlay:GetName()))

			-- local unit = frame.unit
			-- 
			--
			-- frame.arcanebar = CreateFrame("StatusBar", nil, frame, nil)
			-- frame.arcanebar:SetPoint("TOPLEFT", frame.nameframeoverlay, "TOPLEFT", 10, -10)
			-- frame.arcanebar:SetHeight(10)
			-- frame.arcanebar:SetWidth(150)










		end
	end
end
