local gUF = LibStub("AceAddon-3.0"):GetAddon("gUF")
local CastBar = gUF:NewModule("CastBar", "AceEvent-3.0")

local L = LibStub("AceLocale-3.0"):GetLocale("gUF", true)

function CastBar:OnInitialize()
--	self.defaults = {
--		profile = {
--			combat = true,
--		},
--	}
--
--	self.db = SSPVP.db:RegisterNamespace("eots", self.defaults)
	gUF:Print("CastBar Module OnInitialize")
end

function CastBar:EnableModule()
--	if( self.db.profile.combat ) then
--		frame:RegisterEvent("PLAYER_FOCUS_CHANGED")
--		frame:RegisterEvent("PLAYER_TARGET_CHANGED")
--		frame:RegisterEvent("UNIT_SPELLCAST_CHANNEL_START")
--		frame:RegisterEvent("UNIT_SPELLCAST_CHANNEL_STOP")
--		frame:RegisterEvent("UNIT_SPELLCAST_CHANNEL_UPDATE")
--		frame:RegisterEvent("UNIT_SPELLCAST_DELAYED")
--		frame:RegisterEvent("UNIT_SPELLCAST_FAILED")
--		frame:RegisterEvent("UNIT_SPELLCAST_INTERRUPTED")
--		frame:RegisterEvent("UNIT_SPELLCAST_START")
--		frame:RegisterEvent("UNIT_SPELLCAST_STOP")
--	end
	gUF:Print("CastBar Module - EnableModule")
end

function CastBar:DisableModule()
	self:UnregisterAllEvents()
	gUF:Print("CastBar Module - DisableModule")
end

function CastBar:Reload()
--	if (self.isActive) then
--		self:UnregisterAllEvents()
--		self:EnableModule()
--	end
gUF:Print("CastBar Module - Reload")
end

--function EOTS:ParseCombat(event, msg)
--	if( string.match(msg, L["captured the"]) ) then
--		local bases
--		if( event == "CHAT_MSG_BG_SYSTEM_HORDE" ) then
--			bases = string.match(select(3, GetWorldStateUIInfo(3)), L["Bases: ([0-9]+)  Victory Points: ([0-9]+)/2000"])
--		elseif( event == "CHAT_MSG_BG_SYSTEM_ALLIANCE" ) then
--			bases = string.match(select(3, GetWorldStateUIInfo(2)), L["Bases: ([0-9]+)  Victory Points: ([0-9]+)/2000"])
--		end
--
--		bases = tonumber(bases)
--		if( not bases ) then
--			return
--		end
--
--		-- 4 towers = 500 points
--		-- 3 towers = 100 points
--		-- 2 towers = 85 points
--		-- 1 tower = 75 points
--
--		if( bases == 4 ) then
--			SSPVP:CombatText(string.format(L["+%d Points"], 500), SSPVP:GetFactionColor(event))
--		elseif( bases == 3 ) then
--			SSPVP:CombatText(string.format(L["+%d Points"], 100), SSPVP:GetFactionColor(event))
--		elseif( bases == 2 ) then
--			SSPVP:CombatText(string.format(L["+%d Points"], 85), SSPVP:GetFactionColor(event))
--		elseif( bases == 1 ) then
--			SSPVP:CombatText(string.format(L["+%d Points"], 75), SSPVP:GetFactionColor(event))
--		end
--	end
--end
--
---- Clean up the text to not be so hugeassly long
--hooksecurefunc("WorldStateAlwaysUpFrame_Update", function()
--	if( AlwaysUpFrame1 ) then
--		local alliance = _G["AlwaysUpFrame1Text"]
--		local bases, points = string.match(alliance:GetText(), L["Bases: ([0-9]+)  Victory Points: ([0-9]+)/2000"])
--
--		if( bases and points ) then
--			alliance:SetText(string.format(L["Bases %d  Points %d/2000"], bases, points))
--		end
--	end
--
--	if( AlwaysUpFrame2 ) then
--		local horde = _G["AlwaysUpFrame2Text"]
--		local bases, points = string.match(horde:GetText(), L["Bases: ([0-9]+)  Victory Points: ([0-9]+)/2000"])
--
--		if( bases and points ) then
--			horde:SetText(string.format( L["Bases %d  Points %d/2000"], bases, points))
--		end
--	end
--end)
