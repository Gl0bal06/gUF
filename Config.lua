local L = LibStub("AceLocale-3.0"):GetLocale("gUF", true)
local gUF = LibStub("AceAddon-3.0"):GetAddon("gUF")
--local LSM

local anchorPoints = {
	[1] = L["Bottom Left"],
	[2] = L["Bottom Right"],
	[3] = L["Left"],
	[4] = L["Right"],
	[5] = L["Top Left"],
	[6] = L["Top Right"],
}

local function getOption(info)
	if (info.arg[2]) then
		return gUF.db.profile[info.arg[1]][info.arg[2]][info.arg[3]]
	else
		return gUF.db.profile[info.arg[1]][info.arg[3]]
	end
end

local function setOption(info, value)
	if (info.arg[2]) then
		gUF.db.profile[info.arg[1]][info.arg[2]][info.arg[3]] = value
	else
		gUF.db.profile[info.arg[1]][info.arg[3]] = value
	end
	if (info.arg[4]) then
		local func = info.arg[4]
		func()
	end
end

local function getColor(info)
	return gUF.db.profile[info.arg[1]][info.arg[2]].r, gUF.db.profile[info.arg[1]][info.arg[2]].g, gUF.db.profile[info.arg[1]][info.arg[2]].b, gUF.db.profile[info.arg[1]][info.arg[2]].a
end

local function setColor(info, r, g, b, a)
	gUF.db.profile[info.arg[1]][info.arg[2]].r = r
	gUF.db.profile[info.arg[1]][info.arg[2]].g = g
	gUF.db.profile[info.arg[1]][info.arg[2]].b = b
	gUF.db.profile[info.arg[1]][info.arg[2]].a = a
	if (info.arg[3]) then
		local func = info.arg[3]
		func()
	end
end

-- Return all registered SML textures
local textures = {}
local function GetTextures()
	for k in pairs(textures) do textures[k] = nil end

	for _, name in pairs(gUF.LSM:List(gUF.LSM.MediaType.STATUSBAR)) do
		textures[name] = name
	end
	
	return textures
end

--local function getBuffDebuffPosition(info)
----	if (info.arg[2]) then
----		return position[ gUF.db.profile[info.arg[1]][info.arg[2]][info.arg[3]] ]
----	else
----		return position[ gUF.db.profile[info.arg[1]][info.arg[3]] ]
----	end
----	for i=1,6 do
----		if (position[i] == gUF.db.profile[info.arg[1]][info.arg[2]][info.arg[3]]) then
----			return i
----		end
----	end
--	if (info.arg[2]) then
--		return gUF.db.profile[info.arg[1]][info.arg[2]][info.arg[3]]
--	else
--		return gUF.db.profile[info.arg[1]][info.arg[3]]
--	end
--end
--
--local function setBuffDebuffPosition(info, value)
--	if (info.arg[2]) then
--		gUF.db.profile[info.arg[1]][info.arg[2]][info.arg[3]] = value
--	else
--		gUF.db.profile[info.arg[1]][info.arg[3]] = value
--	end
--	if (info.arg[4]) then
--		local func = info.arg[4]
--		func()
--	end
--end

gUF.options = {
	name = "gUF",
	desc = "desc",
	type="group",
	childGroups = "tree",
	args={
		ConfigMode = {
			name = L["Config Mode"],
			desc = L["Easily position normally hidden frames and options."].."  Also doesn't work yet.",
			type = "toggle",
			order = 1,
			get = getOption,
			set = setOption,
			arg = {"global", nil, L["Config Mode"], nil},		-- db location, db variable name, function call (if any) (inline functions ok)
		},
		Locked = {
			name = L["Lock Frames"],
			desc = L["Locks the unit frames."],
			type = "toggle",
			order = 2,
			get = getOption,
			set = setOption,
			arg = {"global", nil, L["Lock Frames"], nil},
		},


		global = {
			name = L["Global Options"],
			type="group",
			order = 1,
--			childGroups = "tab",
			args = {
				FrameColors = {
					name = L["Frame Colors"],
					type= "group",
					order = 1,
					inline = true,
					args = {
						BackgroundColor = {
							name = L["Background Color"],
							desc = "desc",
							type = "color",
							order = 1,
							hasAlpha = true,
							get = getColor,
							set = setColor,
							arg = {"global", L["Background Color"], function() gUF:SetupAllBorderBackground() end},
						},
						BorderColor = {
							name = L["Border Color"],
							desc = "desc",
							type = "color",
							order = 2,
							hasAlpha = true,
							get = getColor,
							set = setColor,
							arg = {"global", L["Border Color"], function() gUF:SetupAllBorderBackground() end},
						},
						Reset = {
							name = L["Reset"],
							desc = "desc",
							type = "toggle",
							order = 3,
							set = function()
								gUF.db.profile.global[L["Background Color"]].r = gUF.defaults.profile.global[L["Background Color"]].r
								gUF.db.profile.global[L["Background Color"]].g = gUF.defaults.profile.global[L["Background Color"]].g
								gUF.db.profile.global[L["Background Color"]].b = gUF.defaults.profile.global[L["Background Color"]].b
								gUF.db.profile.global[L["Background Color"]].a = gUF.defaults.profile.global[L["Background Color"]].a
								gUF.db.profile.global[L["Border Color"]].r = gUF.defaults.profile.global[L["Border Color"]].r
								gUF.db.profile.global[L["Border Color"]].g = gUF.defaults.profile.global[L["Border Color"]].g
								gUF.db.profile.global[L["Border Color"]].b = gUF.defaults.profile.global[L["Border Color"]].b
								gUF.db.profile.global[L["Border Color"]].a = gUF.defaults.profile.global[L["Border Color"]].a
								gUF:SetupAllBorderBackground()
							end,
						},
					},
				},
				BarOptions = {
					name = L["Bar Options"],
					type= "group",
					order = 2,
					inline = true,
					args = {
						BarTextures = {
							name = L["Bar Textures"],
							type= "group",
							order = 1,
							inline = true,
							args = {
								statusBarTexture = {
									name = L["Status Bar Texture"],
									desc = "desc",
									type = "select",
									order = 1,
									dialogControl = "LSM30_Statusbar",
									values = GetTextures,
									get = getOption,
									set = setOption,
									arg = {"global", nil, L["Status Bar Texture"], function() gUF:SetupAllStatusBarTextures() end},
								},
								statusBarBackgroundTexture = {
									name = L["Status Bar Background Texture"],
									desc = "desc",
									type = "select",
									order = 2,
									dialogControl = "LSM30_Statusbar",
									values = GetTextures,
									get = getOption,
									set = setOption,
									arg = {"global", nil, L["Status Bar Background Texture"], function() gUF:SetupAllStatusBarBackgroundTextures() end},
								},
							},
						},
						BarColors = {
							name = L["Bar Colors"],
							type= "group",
							order = 2,
							inline = true,
							args = {
								healthBarColor = {
									name = L["Health Bar Color"],
									desc = "desc",
									type = "color",
									order = 1,
									hasAlpha = true,
									get = getColor,
									set = setColor,
									arg = {"global", L["Health Bar Color"], function() gUF:SetupAllBarColors() end},
								},
								manaBarColor = {
									name = L["Mana Bar Color"],
									desc = "desc",
									type = "color",
									order = 2,
									hasAlpha = true,
									get = getColor,
									set = setColor,
									arg = {"global", L["Mana Bar Color"], function() gUF:SetupAllBarColors() end},
								},
								rageBarColor = {
									name = L["Rage Bar Color"],
									desc = "desc",
									type = "color",
									order = 3,
									hasAlpha = true,
									get = getColor,
									set = setColor,
									arg = {"global", L["Rage Bar Color"], function() gUF:SetupAllBarColors() end},
								},
								focusBarColor = {
									name = L["Focus Bar Color"],
									desc = "desc",
									type = "color",
									order = 4,
									hasAlpha = true,
									get = getColor,
									set = setColor,
									arg = {"global", L["Focus Bar Color"], function() gUF:SetupAllBarColors() end},
								},
								energyBarColor = {
									name = L["Energy Bar Color"],
									desc = "desc",
									type = "color",
									order = 5,
									hasAlpha = true,
									get = getColor,
									set = setColor,
									arg = {"global", L["Energy Bar Color"], function() gUF:SetupAllBarColors() end},
								},
								runicPowerBarColor = {
									name = L["Runic Power Bar Color"],
									desc = "desc",
									type = "color",
									order = 6,
									hasAlpha = true,
									get = getColor,
									set = setColor,
									arg = {"global", L["Runic Power Bar Color"], function() gUF:SetupAllBarColors() end},
								},
								Reset = {
									name = L["Reset"],
									desc = "desc",
									type = "toggle",
									order = 7,
									set = function()
										gUF.db.profile.global[L["Health Bar Color"]].r = gUF.defaults.profile.global[L["Health Bar Color"]].r
										gUF.db.profile.global[L["Health Bar Color"]].g = gUF.defaults.profile.global[L["Health Bar Color"]].g
										gUF.db.profile.global[L["Health Bar Color"]].b = gUF.defaults.profile.global[L["Health Bar Color"]].b
										gUF.db.profile.global[L["Health Bar Color"]].a = gUF.defaults.profile.global[L["Health Bar Color"]].a
										gUF.db.profile.global[L["Mana Bar Color"]].r = gUF.defaults.profile.global[L["Mana Bar Color"]].r
										gUF.db.profile.global[L["Mana Bar Color"]].g = gUF.defaults.profile.global[L["Mana Bar Color"]].g
										gUF.db.profile.global[L["Mana Bar Color"]].b = gUF.defaults.profile.global[L["Mana Bar Color"]].b
										gUF.db.profile.global[L["Mana Bar Color"]].a = gUF.defaults.profile.global[L["Mana Bar Color"]].a
										gUF.db.profile.global[L["Rage Bar Color"]].r = gUF.defaults.profile.global[L["Rage Bar Color"]].r
										gUF.db.profile.global[L["Rage Bar Color"]].g = gUF.defaults.profile.global[L["Rage Bar Color"]].g
										gUF.db.profile.global[L["Rage Bar Color"]].b = gUF.defaults.profile.global[L["Rage Bar Color"]].b
										gUF.db.profile.global[L["Rage Bar Color"]].a = gUF.defaults.profile.global[L["Rage Bar Color"]].a
										gUF.db.profile.global[L["Focus Bar Color"]].r = gUF.defaults.profile.global[L["Focus Bar Color"]].r
										gUF.db.profile.global[L["Focus Bar Color"]].g = gUF.defaults.profile.global[L["Focus Bar Color"]].g
										gUF.db.profile.global[L["Focus Bar Color"]].b = gUF.defaults.profile.global[L["Focus Bar Color"]].b
										gUF.db.profile.global[L["Focus Bar Color"]].a = gUF.defaults.profile.global[L["Focus Bar Color"]].a
										gUF.db.profile.global[L["Energy Bar Color"]].r = gUF.defaults.profile.global[L["Energy Bar Color"]].r
										gUF.db.profile.global[L["Energy Bar Color"]].g = gUF.defaults.profile.global[L["Energy Bar Color"]].g
										gUF.db.profile.global[L["Energy Bar Color"]].b = gUF.defaults.profile.global[L["Energy Bar Color"]].b
										gUF.db.profile.global[L["Energy Bar Color"]].a = gUF.defaults.profile.global[L["Energy Bar Color"]].a
										gUF.db.profile.global[L["Runic Power Bar Color"]].r = gUF.defaults.profile.global[L["Runic Power Bar Color"]].r
										gUF.db.profile.global[L["Runic Power Bar Color"]].g = gUF.defaults.profile.global[L["Runic Power Bar Color"]].g
										gUF.db.profile.global[L["Runic Power Bar Color"]].b = gUF.defaults.profile.global[L["Runic Power Bar Color"]].b
										gUF.db.profile.global[L["Runic Power Bar Color"]].a = gUF.defaults.profile.global[L["Runic Power Bar Color"]].a
										gUF:SetupAllBarColors()
									end,
								},
							},
						},
						BarMisc = {
							name = L["Misc"],
							type= "group",
							order = 3,
							inline = true,
							args = {
								colorFramesByDebuff = {
									name = L["Color Frame By Debuff"],
									desc = "desc",
									type = "toggle",
									order = 1,
									get = getOption,
									set = setOption,
									arg = {"global", nil, L["Color Frame By Debuff"], function() if (UnitExists("target")) then gUF:UNIT_AURA(nil, "target") end end},
								},
							},
						},
--						BackgroundColor = {
--							name = L["Background Color"],
--							desc = "desc",
--							type = "color",
--							order = 1,
--							hasAlpha = true,
--							get = getColor,
--							set = setColor,
--							arg = {"global", L["Background Color"], function() gUF:SetupAllBorderBackground() end},
--						},
--						BorderColor = {
--							name = L["Border Color"],
--							desc = "desc",
--							type = "color",
--							order = 2,
--							hasAlpha = true,
--							get = getColor,
--							set = setColor,
--							arg = {"global", L["Border Color"], function() gUF:SetupAllBorderBackground() end},
--						},
--						Reset = {
--							name = L["Reset"],
--							desc = "desc",
--							type = "toggle",
--							order = 3,
--							set = function()
--								gUF.db.profile.global[L["Background Color"]].r = gUF.defaults.profile.global[L["Background Color"]].r
--								gUF.db.profile.global[L["Background Color"]].g = gUF.defaults.profile.global[L["Background Color"]].g
--								gUF.db.profile.global[L["Background Color"]].b = gUF.defaults.profile.global[L["Background Color"]].b
--								gUF.db.profile.global[L["Background Color"]].a = gUF.defaults.profile.global[L["Background Color"]].a
--								gUF.db.profile.global[L["Border Color"]].r = gUF.defaults.profile.global[L["Border Color"]].r
--								gUF.db.profile.global[L["Border Color"]].g = gUF.defaults.profile.global[L["Border Color"]].g
--								gUF.db.profile.global[L["Border Color"]].b = gUF.defaults.profile.global[L["Border Color"]].b
--								gUF.db.profile.global[L["Border Color"]].a = gUF.defaults.profile.global[L["Border Color"]].a
--								gUF:SetupAllBorderBackground()
--							end,
--						},
					},
				},
			},
		},
		focus = {
			name = L["Focus"],
			type = "group",
			order = 2,
			childGroups = "tab",
			args = {
				--more options go here
			},
		},
		focustarget = {
			name = L["Focus' Target"],
			type = "group",
			order = 3,
			childGroups = "tab",
			args = {
				--more options go here
			},
		},
		party = {
			name = L["Party"],
			type = "group",
			order = 4,
			childGroups = "tab",
			args = {
				--more options go here
			},
		},
		partypet = {
			name = L["Party Pets"],
			type = "group",
			order = 5,
			childGroups = "tab",
			args = {
				--more options go here
			},
		},
		partytarget = {
			name = L["Party Targets"],
			type = "group",
			order = 6,
			childGroups = "tab",
			args = {
				--more options go here
			},
		},
		player = {
			name = L["Player"],
			type = "group",
			order = 7,
			childGroups = "tab",
			args = {
				FrameAttributes = {
					name = L["Frame Attributes"],
					type = "group",
					order = 1,
					args = {
						enabled = {
							name = L["Enabled"],
							desc = "desc",
							type = "toggle",
							order = 1,
							get = getOption,
							set = setOption,
							arg = {"player", nil, L["Enabled"], function() gUF:CreateRemoveFrames() end},
						},
						colorNamesByClass = {
							name = L["Color Names By Class"],
							desc = "desc",
							type = "toggle",
							--order = 1,
							get = getOption,
							set = setOption,
							arg = {"player", nil, L["Color Names By Class"], function() if (UnitExists("player")) then gUF:UNIT_FACTION(nil, "player") end end},
						},
						showPvPStatusIcon = {
							name = L["Show PvP Status Icon"],
							desc = "desc",
							type = "toggle",
							--order = 1,
							get = getOption,
							set = setOption,
							arg = {"player", nil, L["Show PvP Status Icon"], function() if (UnitExists("player")) then gUF:UNIT_FACTION(nil, "player") end end},
						},
					},
				},
				Buffs = {
					name = L["Buffs"],
					type = "group",
					order = 2,
					args = {
						numberOfBuffs = {
							name = L["Number of Buffs"],
							desc = "desc",
							type = "range",
							order = 1,
							min = 0,
							max = 20,
							step = 1,
							get = getOption,
							set = setOption,
							arg = {"player", "buffs", L["Number of Buffs"], function() gUF:ResetBuffsAndDebuffs("player") if (UnitExists("player")) then gUF:UNIT_AURA(nil, "player") end end},
						},
						buffsPerRow = {
							name = L["Buffs Per Row"],
							desc = "desc",
							type = "range",
							order = 2,
							min = 1,
							max = 20,
							step = 1,
							get = getOption,
							set = setOption,
							arg = {"player", "buffs", L["Buffs Per Row"], function() gUF:LayoutBuffs(nil, "player", "buffs") if (UnitExists("player")) then gUF:UNIT_AURA(nil, "player") end end},
						},
						horizontalSpacing = {
							name = L["Horizontal Spacing"],
							desc = "desc",
							type = "range",
							order = 3,
							min = 0,
							max = 20,
							step = 1,
							get = getOption,
							set = setOption,
							arg = {"player", "buffs", L["Horizontal Spacing"], function() gUF:LayoutBuffs(nil, "player", "buffs") if (UnitExists("player")) then gUF:UNIT_AURA(nil, "player") end end},
						},
						verticalSpacing = {
							name = L["Vertical Spacing"],
							desc = "desc",
							type = "range",
							order = 4,
							min = -20,
							max = 0,
							step = 1,
							get = getOption,
							set = setOption,
							arg = {"player", "buffs", L["Vertical Spacing"], function() gUF:LayoutBuffs(nil, "player", "buffs") if (UnitExists("player")) then gUF:UNIT_AURA(nil, "player") end end},
						},
						xOffset = {
							name = L["X Offset"],
							desc = "desc",
							type = "range",
							order = 5,
							min = -50,
							max = 50,
							step = 1,
							get = getOption,
							set = setOption,
							arg = {"player", "buffs", L["X Offset"], function() gUF:LayoutBuffs(nil, "player", "buffs") if (UnitExists("player")) then gUF:UNIT_AURA(nil, "player") end end},
						},
						yOffset = {
							name = L["Y Offset"],
							desc = "desc",
							type = "range",
							order = 6,
							min = -50,
							max = 50,
							step = 1,
							get = getOption,
							set = setOption,
							arg = {"player", "buffs", L["Y Offset"], function() gUF:LayoutBuffs(nil, "player", "buffs") if (UnitExists("player")) then gUF:UNIT_AURA(nil, "player") end end},
						},
						position = {
							name = L["Position"],
							desc = "desc",
							type = "select",
							style = "dropdown",
							order = 7,
							get = getOption,
							set = setOption,
							values = anchorPoints,
							arg = {"player", "buffs", L["Position"], function() gUF:LayoutBuffs(nil, "player", "buffs") if (UnitExists("player")) then gUF:UNIT_AURA(nil, "player") end end},
						},
						growUpwards = {
							name = L["Grow Upwards"],
							desc = "desc",
							type = "toggle",
							order = 8,
							get = getOption,
							set = setOption,
							arg = {"player", "buffs", L["Grow Upwards"], function() gUF:LayoutBuffs(nil, "player", "buffs") if (UnitExists("player")) then gUF:UNIT_AURA(nil, "player") end end},
						},
						expandLeft = {
							name = L["Expand Left"],
							desc = "desc",
							type = "toggle",
							order = 9,
							get = getOption,
							set = setOption,
							arg = {"player", "buffs", L["Expand Left"], function() gUF:LayoutBuffs(nil, "player", "buffs") if (UnitExists("player")) then gUF:UNIT_AURA(nil, "player") end end},
						},
						showCooldownModels = {
							name = L["Show Cooldown Models"],
							desc = "desc",
							type = "toggle",
							order = 10,
							get = getOption,
							set = setOption,
							arg = {"player", "buffs", L["Show Cooldown Models"], function() gUF:ResetBuffsAndDebuffs("player") if (UnitExists("player")) then gUF:UNIT_AURA(nil, "player") end end},
						},
						classicBuffDebuffMode = {
							name = L["Classic Buff & Debuff Mode"],
							desc = "desc",
							type = "toggle",
							order = 11,
							get = getOption,
							set = setOption,
							arg = {"player", nil, L["Classic Buff & Debuff Mode"], function() gUF:LayoutBuffs(nil, "player", "buffs") gUF:LayoutBuffs(nil, "player", "debuffs") if (UnitExists("player")) then gUF:UNIT_AURA(nil, "player") end end},
						},
					},
				},
				Debuffs = {
					name = L["Debuffs"],
					type = "group",
					order = 3,
					args = {
						numberOfDebuffs = {
							name = L["Number of Debuffs"],
							desc = "desc",
							type = "range",
							order = 1,
							min = 0,
							max = 20,
							step = 1,
							get = getOption,
							set = setOption,
							arg = {"player", "debuffs", L["Number of Debuffs"], function() gUF:ResetBuffsAndDebuffs("player") if (UnitExists("player")) then gUF:UNIT_AURA(nil, "player") end end},
						},
						buffsPerRow = {
							name = L["Debuffs Per Row"],
							desc = "desc",
							type = "range",
							order = 2,
							min = 1,
							max = 20,
							step = 1,
							get = getOption,
							set = setOption,
							arg = {"player", "debuffs", L["Buffs Per Row"], function() gUF:LayoutBuffs(nil, "player", "debuffs") if (UnitExists("player")) then gUF:UNIT_AURA(nil, "player") end end},
						},
						horizontalSpacing = {
							name = L["Horizontal Spacing"],
							desc = "desc",
							type = "range",
							order = 3,
							min = 0,
							max = 20,
							step = 1,
							get = getOption,
							set = setOption,
							arg = {"player", "debuffs", L["Horizontal Spacing"], function() gUF:LayoutBuffs(nil, "player", "debuffs") if (UnitExists("player")) then gUF:UNIT_AURA(nil, "player") end end},
						},
						verticalSpacing = {
							name = L["Vertical Spacing"],
							desc = "desc",
							type = "range",
							order = 4,
							min = -20,
							max = 0,
							step = 1,
							get = getOption,
							set = setOption,
							arg = {"player", "debuffs", L["Vertical Spacing"], function() gUF:LayoutBuffs(nil, "player", "debuffs") if (UnitExists("player")) then gUF:UNIT_AURA(nil, "player") end end},
						},
						xOffset = {
							name = L["X Offset"],
							desc = "desc",
							type = "range",
							order = 5,
							min = -50,
							max = 50,
							step = 1,
							get = getOption,
							set = setOption,
							arg = {"player", "debuffs", L["X Offset"], function() gUF:LayoutBuffs(nil, "player", "debuffs") if (UnitExists("player")) then gUF:UNIT_AURA(nil, "player") end end},
						},
						yOffset = {
							name = L["Y Offset"],
							desc = "desc",
							type = "range",
							order = 6,
							min = -50,
							max = 50,
							step = 1,
							get = getOption,
							set = setOption,
							arg = {"player", "debuffs", L["Y Offset"], function() gUF:LayoutBuffs(nil, "player", "debuffs") if (UnitExists("player")) then gUF:UNIT_AURA(nil, "player") end end},
						},
						position = {
							name = L["Position"],
							desc = "desc",
							type = "select",
							style = "dropdown",
							order = 7,
							get = getOption,
							set = setOption,
							values = anchorPoints,
							arg = {"player", "debuffs", L["Position"], function() gUF:LayoutBuffs(nil, "player", "debuffs") if (UnitExists("player")) then gUF:UNIT_AURA(nil, "player") end end},
						},
						growUpwards = {
							name = L["Grow Upwards"],
							desc = "desc",
							type = "toggle",
							order = 8,
							get = getOption,
							set = setOption,
							arg = {"player", "debuffs", L["Grow Upwards"], function() gUF:LayoutBuffs(nil, "player", "debuffs") if (UnitExists("player")) then gUF:UNIT_AURA(nil, "player") end end},
						},
						expandLeft = {
							name = L["Expand Left"],
							desc = "desc",
							type = "toggle",
							order = 9,
							get = getOption,
							set = setOption,
							arg = {"player", "debuffs", L["Expand Left"], function() gUF:LayoutBuffs(nil, "player", "debuffs") if (UnitExists("player")) then gUF:UNIT_AURA(nil, "player") end end},
						},
						showCooldownModels = {
							name = L["Show Cooldown Models"],
							desc = "desc",
							type = "toggle",
							order = 10,
							get = getOption,
							set = setOption,
							arg = {"player", "debuffs", L["Show Cooldown Models"], function() gUF:ResetBuffsAndDebuffs("player") if (UnitExists("player")) then gUF:UNIT_AURA(nil, "player") end end},
						},
						classicBuffDebuffMode = {
							name = L["Classic Buff & Debuff Mode"],
							desc = "desc",
							type = "toggle",
							order = 11,
							get = getOption,
							set = setOption,
							arg = {"player", nil, L["Classic Buff & Debuff Mode"], function() gUF:LayoutBuffs(nil, "player", "buffs") gUF:LayoutBuffs(nil, "player", "debuffs") if (UnitExists("player")) then gUF:UNIT_AURA(nil, "player") end end},
						},
					},
				},
				Text = {
					name = L["Text"],
					type = "group",
					order = 4,
					args = {
						
					},
				},
			},
		},
		pet = {
			name = L["Player's Pet"],
			type = "group",
			order = 8,
			childGroups = "tab",
			args = {
				--more options go here
			},
		},
		pettarget = {
			--name = L["Target of Player's Pet"],
			name = "Player's Pet Target",
			type = "group",
			order = 9,
			childGroups = "tab",
			args = {
				--more options go here
			},
		},
		target = {
			name = L["Target"],
			type = "group",
			order = 10,
			childGroups = "tab",
			args = {
				FrameAttributes = {
					name = L["Frame Attributes"],
					type = "group",
					order = 1,
					args = {
						enabled = {
							name = L["Enabled"],
							desc = "desc",
							type = "toggle",
							order = 1,
							get = getOption,
							set = setOption,
							arg = {"target", nil, L["Enabled"], function() gUF:CreateRemoveFrames() end},
						},
						colorNamesByClass = {
							name = L["Color Names By Class"],
							desc = "desc",
							type = "toggle",
							--order = 1,
							get = getOption,
							set = setOption,
							arg = {"target", nil, L["Color Names By Class"], function() if (UnitExists("target")) then gUF:UNIT_FACTION(nil, "target") end end},
						},
						showPvPStatusIcon = {
							name = L["Show PvP Status Icon"],
							desc = "desc",
							type = "toggle",
							--order = 1,
							get = getOption,
							set = setOption,
							arg = {"target", nil, L["Show PvP Status Icon"], function() if (UnitExists("target")) then gUF:UNIT_FACTION(nil, "target") end end},
						},
					},
				},
				Buffs = {
					name = L["Buffs"],
					type = "group",
					order = 2,
					args = {
						numberOfBuffs = {
							name = L["Number of Buffs"],
							desc = "desc",
							type = "range",
							order = 1,
							min = 0,
							max = 20,
							step = 1,
							get = getOption,
							set = setOption,
							arg = {"target", "buffs", L["Number of Buffs"], function() gUF:ResetBuffsAndDebuffs("target") if (UnitExists("target")) then gUF:UNIT_AURA(nil, "target") end end},
						},
						buffsPerRow = {
							name = L["Buffs Per Row"],
							desc = "desc",
							type = "range",
							order = 2,
							min = 1,
							max = 20,
							step = 1,
							get = getOption,
							set = setOption,
							arg = {"target", "buffs", L["Buffs Per Row"], function() gUF:LayoutBuffs(nil, "target", "buffs") if (UnitExists("target")) then gUF:UNIT_AURA(nil, "target") end end},
						},
						horizontalSpacing = {
							name = L["Horizontal Spacing"],
							desc = "desc",
							type = "range",
							order = 3,
							min = 0,
							max = 20,
							step = 1,
							get = getOption,
							set = setOption,
							arg = {"target", "buffs", L["Horizontal Spacing"], function() gUF:LayoutBuffs(nil, "target", "buffs") if (UnitExists("target")) then gUF:UNIT_AURA(nil, "target") end end},
						},
						verticalSpacing = {
							name = L["Vertical Spacing"],
							desc = "desc",
							type = "range",
							order = 4,
							min = -20,
							max = 0,
							step = 1,
							get = getOption,
							set = setOption,
							arg = {"target", "buffs", L["Vertical Spacing"], function() gUF:LayoutBuffs(nil, "target", "buffs") if (UnitExists("target")) then gUF:UNIT_AURA(nil, "target") end end},
						},
						xOffset = {
							name = L["X Offset"],
							desc = "desc",
							type = "range",
							order = 5,
							min = -50,
							max = 50,
							step = 1,
							get = getOption,
							set = setOption,
							arg = {"target", "buffs", L["X Offset"], function() gUF:LayoutBuffs(nil, "target", "buffs") if (UnitExists("target")) then gUF:UNIT_AURA(nil, "target") end end},
						},
						yOffset = {
							name = L["Y Offset"],
							desc = "desc",
							type = "range",
							order = 6,
							min = -50,
							max = 50,
							step = 1,
							get = getOption,
							set = setOption,
							arg = {"target", "buffs", L["Y Offset"], function() gUF:LayoutBuffs(nil, "target", "buffs") if (UnitExists("target")) then gUF:UNIT_AURA(nil, "target") end end},
						},
						position = {
							name = L["Position"],
							desc = "desc",
							type = "select",
							style = "dropdown",
							order = 7,
							get = getOption,
							set = setOption,
							values = anchorPoints,
							arg = {"target", "buffs", L["Position"], function() gUF:LayoutBuffs(nil, "target", "buffs") if (UnitExists("target")) then gUF:UNIT_AURA(nil, "target") end end},
						},
						growUpwards = {
							name = L["Grow Upwards"],
							desc = "desc",
							type = "toggle",
							order = 8,
							get = getOption,
							set = setOption,
							arg = {"target", "buffs", L["Grow Upwards"], function() gUF:LayoutBuffs(nil, "target", "buffs") if (UnitExists("target")) then gUF:UNIT_AURA(nil, "player") end end},
						},
						expandLeft = {
							name = L["Expand Left"],
							desc = "desc",
							type = "toggle",
							order = 9,
							get = getOption,
							set = setOption,
							arg = {"target", "buffs", L["Expand Left"], function() gUF:LayoutBuffs(nil, "target", "buffs") if (UnitExists("target")) then gUF:UNIT_AURA(nil, "target") end end},
						},
						showCooldownModels = {
							name = L["Show Cooldown Models"],
							desc = "desc",
							type = "toggle",
							order = 10,
							get = getOption,
							set = setOption,
							arg = {"target", "buffs", L["Show Cooldown Models"], function() gUF:ResetBuffsAndDebuffs("target") if (UnitExists("target")) then gUF:UNIT_AURA(nil, "target") end end},
						},
						classicBuffDebuffMode = {
							name = L["Classic Buff & Debuff Mode"],
							desc = "desc",
							type = "toggle",
							order = 11,
							get = getOption,
							set = setOption,
							arg = {"target", nil, L["Classic Buff & Debuff Mode"], function() gUF:LayoutBuffs(nil, "target", "buffs") if (UnitExists("target")) then gUF:UNIT_AURA(nil, "target") end end},
						},
					},
				},
				Debuffs = {
					name = L["Debuffs"],
					type= "group",
					order = 3,
					args = {
						numberOfDebuffs = {
							name = L["Number of Debuffs"],
							desc = "desc",
							type = "range",
							order = 1,
							min = 0,
							max = 40,
							step = 1,
							get = getOption,
							set = setOption,
							arg = {"target", "debuffs", L["Number of Debuffs"], function() gUF:ResetBuffsAndDebuffs("target") if (UnitExists("target")) then gUF:UNIT_AURA(nil, "target") end end},
						},
						buffsPerRow = {
							name = L["Debuffs Per Row"],
							desc = "desc",
							type = "range",
							order = 2,
							min = 1,
							max = 20,
							step = 1,
							get = getOption,
							set = setOption,
							arg = {"target", "debuffs", L["Buffs Per Row"], function() gUF:LayoutBuffs(nil, "target", "debuffs") if (UnitExists("target")) then gUF:UNIT_AURA(nil, "target") end end},
						},
						horizontalSpacing = {
							name = L["Horizontal Spacing"],
							desc = "desc",
							type = "range",
							order = 3,
							min = 0,
							max = 20,
							step = 1,
							get = getOption,
							set = setOption,
							arg = {"target", "debuffs", L["Horizontal Spacing"], function() gUF:LayoutBuffs(nil, "target", "debuffs") if (UnitExists("target")) then gUF:UNIT_AURA(nil, "target") end end},
						},
						verticalSpacing = {
							name = L["Vertical Spacing"],
							desc = "desc",
							type = "range",
							order = 4,
							min = -20,
							max = 0,
							step = 1,
							get = getOption,
							set = setOption,
							arg = {"target", "debuffs", L["Vertical Spacing"], function() gUF:LayoutBuffs(nil, "target", "debuffs") if (UnitExists("target")) then gUF:UNIT_AURA(nil, "target") end end},
						},
						xOffset = {
							name = L["X Offset"],
							desc = "desc",
							type = "range",
							order = 5,
							min = -50,
							max = 50,
							step = 1,
							get = getOption,
							set = setOption,
							arg = {"target", "debuffs", L["X Offset"], function() gUF:LayoutBuffs(nil, "target", "debuffs") if (UnitExists("target")) then gUF:UNIT_AURA(nil, "target") end end},
						},
						yOffset = {
							name = L["Y Offset"],
							desc = "desc",
							type = "range",
							order = 6,
							min = -50,
							max = 50,
							step = 1,
							get = getOption,
							set = setOption,
							arg = {"target", "debuffs", L["Y Offset"], function() gUF:LayoutBuffs(nil, "target", "debuffs") if (UnitExists("target")) then gUF:UNIT_AURA(nil, "target") end end},
						},
						position = {
							name = L["Position"],
							desc = "desc",
							type = "select",
							style = "dropdown",
							order = 7,
							get = getOption,
							set = setOption,
							values = anchorPoints,
							arg = {"target", "debuffs", L["Position"], function() gUF:LayoutBuffs(nil, "target", "debuffs") if (UnitExists("target")) then gUF:UNIT_AURA(nil, "target") end end},
						},
						growUpwards = {
							name = L["Grow Upwards"],
							desc = "desc",
							type = "toggle",
							order = 8,
							get = getOption,
							set = setOption,
							arg = {"target", "debuffs", L["Grow Upwards"], function() gUF:LayoutBuffs(nil, "target", "debuffs") if (UnitExists("target")) then gUF:UNIT_AURA(nil, "target") end end},
						},
						expandLeft = {
							name = L["Expand Left"],
							desc = "desc",
							type = "toggle",
							order = 9,
							get = getOption,
							set = setOption,
							arg = {"target", "debuffs", L["Expand Left"], function() gUF:LayoutBuffs(nil, "target", "debuffs") if (UnitExists("target")) then gUF:UNIT_AURA(nil, "target") end end},
						},
						showCooldownModels = {
							name = L["Show Cooldown Models"],
							desc = "desc",
							type = "toggle",
							order = 10,
							get = getOption,
							set = setOption,
							arg = {"target", "debuffs", L["Show Cooldown Models"], function() gUF:ResetBuffsAndDebuffs("target") if (UnitExists("target")) then gUF:UNIT_AURA(nil, "target") end end},
						},
						classicBuffDebuffMode = {
							name = L["Classic Buff & Debuff Mode"],
							desc = "desc",
							type = "toggle",
							order = 11,
							get = getOption,
							set = setOption,
							arg = {"target", nil, L["Classic Buff & Debuff Mode"], function() gUF:LayoutBuffs(nil, "target", "buffs") gUF:LayoutBuffs(nil, "target", "debuffs") if (UnitExists("target")) then gUF:UNIT_AURA(nil, "target") end end},
						},
					},
				},
				Text = {
					name = L["Text"],
					type = "group",
					order = 4,
					args = {
						
					},
				},
			},
		},
		targettarget = {
			name = L["Target's Target"],
			type = "group",
			order = 11,
			childGroups = "tab",
			args = {
				--more options go here
			},
		},
		targettargettarget = {
			--name = L["Target of Target's Target"],
			name = "Target's Target Target",
			type = "group",
			order = 12,
			childGroups = "tab",
			args = {
				--more options go here
			},
		},
		
	},
}

--gUF.options = options
