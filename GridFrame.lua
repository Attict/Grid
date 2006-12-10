-- GridFrame.lua

--{{{ Libraries

local AceOO = AceLibrary("AceOO-2.0")
local RL = AceLibrary("RosterLib-2.0")
local L = AceLibrary("AceLocale-2.2"):new("Grid")
local GridRange = GridRange

--}}}

--{{{  locals

--}}}
--{{{ FrameXML functions

function GridFrame_OnLoad(self)
	GridFrame:RegisterFrame(self)
end

function GridFrame_OnAttributeChanged(self, name, value)
	local frame = GridFrame.registeredFrames[self:GetName()] 

	if not frame then return end

	if name == "unit" then
		if value then
			local unitName = UnitName(value)
			frame.unitName = unitName
			frame.unit = value
			GridFrame:Debug("updated", self:GetName(), name, value, unitName)
			GridFrame:UpdateIndicators(frame)
		else
			-- unit is nil
			-- move frame to unused pile
			GridFrame:Debug("removed", self:GetName(), name, value, unitName)
			frame.unitName = nil
			frame.unit = value
		end
	end
end

--}}}
--{{{ GridFrameClass

local GridFrameClass = AceOO.Class("AceEvent-2.0", "AceDebug-2.0")

-- used by GridFrame:UpdateOptionsMenu()
GridFrameClass.prototype.indicators = {
	{ type = "border",     order = 1,  name = L["Border"] },
	{ type = "bar",        order = 2,  name = L["Health Bar"] },
	{ type = "text",       order = 3,  name = L["Center Text"] },
	{ type = "text2",      order = 4,  name = L["Center Text 2"] },
	{ type = "icon",       order = 5,  name = L["Center Icon"] },
	{ type = "corner4",    order = 6,  name = L["Top Left Corner"] },
	{ type = "corner3",    order = 7,  name = L["Top Right Corner"] },
	{ type = "corner1",    order = 8,  name = L["Bottom Left Corner"] },
	{ type = "corner2",    order = 9,  name = L["Bottom Right Corner"] },
	{ type = "frameAlpha", order = 10, name = L["Frame Alpha"] },
}

-- frame is passed from GridFrame_OnLoad()
-- the GridFrameClass constructor takes over the frame that was created by CreateFrame()
function GridFrameClass.prototype:init(frame)
	GridFrameClass.super.prototype.init(self)
	self.frame = frame
	self:CreateFrames()
	-- self:Reset()
end

function GridFrameClass.prototype:Reset()
	for _,indicator in ipairs(self.indicators) do
		self:ClearIndicator(indicator.type)
	end
	self:SetWidth(GridFrame:GetFrameWidth())
	self:SetHeight(GridFrame:GetFrameHeight())
	self:SetOrientation(GridFrame.db.profile.orientation)
	self:EnableText2(GridFrame.db.profile.enableText2)
end

function GridFrameClass.prototype:CreateFrames()
	-- create frame
	-- self.frame is created by using the xml template and is passed via the object's constructor
	local f = self.frame

	-- f:Hide()
	f:EnableMouse(true)			
	f:RegisterForClicks("LeftButtonUp", "RightButtonUp", "MiddleButtonUp", "Button4Up", "Button5Up")
	
	-- set our left-click action
	f:SetAttribute("type1", "target")

	-- tooltip support
	f:SetScript("OnEnter", function() self:OnEnter() end)
	f:SetScript("OnLeave", function() self:OnLeave() end)
	
	-- create border
	f:SetBackdrop({
		bgFile = "Interface\\Addons\\Grid\\white16x16", tile = true, tileSize = 16,
		edgeFile = "Interface\\Addons\\Grid\\white16x16", edgeSize = 1,
		insets = {left = 1, right = 1, top = 1, bottom = 1},
	})
	f:SetBackdropBorderColor(0,0,0,0)
	f:SetBackdropColor(0,0,0,1)
	
	-- create bar BG (which users will think is the real bar, as it is the one that has a shiny color)
	-- this is necessary as there's no other way to implement status bars that grow in the other direction than normal
	f.BarBG = f:CreateTexture()
	f.BarBG:SetTexture("Interface\\Addons\\Grid\\gradient32x32")
	f.BarBG:SetPoint("CENTER", f, "CENTER")

	-- create bar
	f.Bar = CreateFrame("StatusBar", nil, f)
	f.Bar:SetStatusBarTexture("Interface\\Addons\\Grid\\gradient32x32")
	f.Bar:SetOrientation("VERTICAL")
	f.Bar:SetMinMaxValues(0,100)
	f.Bar:SetValue(100)
	f.Bar:SetStatusBarColor(0,0,0,0.8)
	f.Bar:SetPoint("CENTER", f, "CENTER")
	f.Bar:SetFrameLevel(4)

	-- create center text
	f.Text = f.Bar:CreateFontString(nil, "ARTWORK")
	f.Text:SetFontObject(GameFontHighlightSmall)
	f.Text:SetFont(STANDARD_TEXT_FONT,GridFrame.db.profile.fontSize)
	f.Text:SetJustifyH("CENTER")
	f.Text:SetJustifyV("CENTER")
	f.Text:SetPoint("BOTTOM", f, "CENTER")

	-- create center text2
	f.Text2 = f.Bar:CreateFontString(nil, "ARTWORK")
	f.Text2:SetFontObject(GameFontHighlightSmall)
	f.Text2:SetFont(STANDARD_TEXT_FONT,GridFrame.db.profile.fontSize)
	f.Text2:SetJustifyH("CENTER")
	f.Text2:SetJustifyV("CENTER")
	f.Text2:SetPoint("TOP", f, "CENTER")
	f.Text2:Hide()
	
	-- create icon
	f.Icon = f.Bar:CreateTexture("Icon", "OVERLAY")
	f.Icon:SetWidth(GridFrame.db.profile.iconSize)
	f.Icon:SetHeight(GridFrame.db.profile.iconSize)
	f.Icon:SetPoint("CENTER", f, "CENTER")
	f.Icon:SetTexCoord(0.05, 0.95, 0.05, 0.95)
	f.Icon:SetTexture(1,1,1,0)
	
	-- set texture
	f:SetNormalTexture(1,1,1,0)
	f:SetHighlightTexture("Interface\\QuestFrame\\UI-QuestTitleHighlight")
	
	self.frame = f

	self:SetWidth(GridFrame:GetFrameWidth())
	self:SetHeight(GridFrame:GetFrameHeight())
	self:SetOrientation(GridFrame.db.profile.orientation)
	self:EnableText2(GridFrame.db.profile.enableText2)
	
	-- set up click casting
	ClickCastFrames = ClickCastFrames or {}
	ClickCastFrames[self.frame] = true
end

-- shows the default unit tooltip
function GridFrameClass.prototype:OnEnter()
	if GridFrame.db.profile.showTooltip == L["Always"] or
		(GridFrame.db.profile.showTooltip == L["OOC"] and
			(not Grid.inCombat or
				(self.unit and UnitIsDeadOrGhost(self.unit)))) then

		self.frame.unit = self.unit
		UnitFrame_OnEnter()
	end
end

function GridFrameClass.prototype:SetWidth(width)
	local f = self.frame
	f:SetWidth(width)
	f.Bar:SetWidth(width-4)
	f.BarBG:SetWidth(width-4)

	self:PlaceIndicators()
end

function GridFrameClass.prototype:SetHeight(height)
	local f = self.frame
	f:SetHeight(height)
	f.Bar:SetHeight(height-4)
	f.BarBG:SetHeight(height-4)

	self:PlaceIndicators()
end

function GridFrameClass.prototype:SetOrientation(orientation)
	self.orientation = orientation
	self:PlaceIndicators()
end

function GridFrameClass.prototype:EnableText2(enabled)
	self.enableText2 = enabled
	self:PlaceIndicators()
end

function GridFrameClass.prototype:PlaceIndicators()
	local f = self.frame

	if self.orientation == "HORIZONTAL" then
		f.Bar:SetOrientation("HORIZONTAL")

		f.Text:SetJustifyH("LEFT")
		f.Text:SetJustifyV("CENTER")
		f.Text:SetHeight(f:GetHeight())
		f.Text:ClearAllPoints()
		f.Text:SetPoint("LEFT", f, "LEFT", 2, 0)
		if self.enableText2 then
			f.Text:SetWidth(f.Bar:GetWidth()/2)
		else
			f.Text:SetWidth(f.Bar:GetWidth())
		end

		f.Text2:SetHeight(f:GetHeight())
		f.Text2:SetWidth(f.Bar:GetWidth()/2)
		f.Text2:SetJustifyH("RIGHT")
		f.Text2:SetJustifyV("CENTER")
		f.Text2:ClearAllPoints()
		if self.enableText2 then
			f.Text2:SetPoint("RIGHT", f, "RIGHT", -2, 0)
		end
	else
		f.Bar:SetOrientation("VERTICAL")

		f.Text:SetJustifyH("CENTER")
		f.Text:SetJustifyV("CENTER")
		f.Text:SetWidth(f:GetWidth())
		f.Text:ClearAllPoints()
		if self.enableText2 then
			f.Text:SetHeight(f.Bar:GetHeight()/2)
			f.Text:SetPoint("BOTTOM", f, "CENTER")
		else
			f.Text:SetHeight(f.Bar:GetHeight())
			f.Text:SetPoint("CENTER", f, "CENTER")
		end

		f.Text2:SetHeight(f.Bar:GetHeight()/2)
		f.Text2:SetWidth(f:GetWidth())
		f.Text2:SetJustifyH("CENTER")
		f.Text2:SetJustifyV("CENTER")
		f.Text2:ClearAllPoints()
		if self.enableText2 then
			f.Text2:SetPoint("TOP", f, "CENTER")
		end
	end
end

function GridFrameClass.prototype:SetCornerSize(size)
	for x = 1, 4 do
		local corner = "corner"..x;
		if self.frame[corner] then
			self.frame[corner]:SetHeight(size)
			self.frame[corner]:SetWidth(size)
		end
	end
end

function GridFrameClass.prototype:SetIconSize(size)
	local f = self.frame
	f.Icon:SetWidth(size)
	f.Icon:SetHeight(size)
end

function GridFrameClass.prototype:SetFontSize(size)
	self.frame.Text:SetFont(STANDARD_TEXT_FONT,size)
	self.frame.Text2:SetFont(STANDARD_TEXT_FONT,size)
end

function GridFrameClass.prototype:OnLeave()
	UnitFrame_OnLeave()
end

-- pass through functions to our main frame
function GridFrameClass.prototype:GetFrameName()
	return self.frame:GetName()
end

function GridFrameClass.prototype:GetFrameHeight()
	return self.frame:GetHeight()
end

function GridFrameClass.prototype:GetFrameWidth()
	return self.frame:GetWidth()
end

function GridFrameClass.prototype:ShowFrame()
	return self.frame:Show()
end

function GridFrameClass.prototype:HideFrame()
	return self.frame:Hide()
end

function GridFrameClass.prototype:SetFrameParent(parentFrame)
	return self.frame:SetParent(parentFrame)
end

-- SetPoint for lazy people
function GridFrameClass.prototype:SetPosition(parentFrame, x, y)
	self.frame:ClearAllPoints()
	self.frame:SetPoint("TOPLEFT", parentFrame, "TOPLEFT", x, y)
end

function GridFrameClass.prototype:SetBar(value, max)
	if max == nil then
		max = 100
	end
	self.frame.Bar:SetValue(value/max*100)
end

function GridFrameClass.prototype:SetBarColor(r, g, b, a)
	if GridFrame.db.profile.invertBarColor then
		self.frame.Bar:SetStatusBarColor(r, g, b, a)
		self.frame.BarBG:SetVertexColor(0, 0, 0, 0)
	else
		self.frame.Bar:SetStatusBarColor(0, 0, 0, 0.8)
		self.frame.BarBG:SetVertexColor(r, g, b ,a)
	end
end

function GridFrameClass.prototype:InvertBarColor()
	local r, g, b, a
	if GridFrame.db.profile.invertBarColor then
		r, g, b, a = self.frame.BarBG:GetVertexColor()
	else
		r, g, b, a = self.frame.Bar:GetStatusBarColor()
	end
	self:SetBarColor(r, g, b, a)
end

function GridFrameClass.prototype:SetText(text, color)
	text = string.sub(text, 1, GridFrame.db.profile.textlength)
	self.frame.Text:SetText(text)
	if text and text ~= "" then
		self.frame.Text:Show()
	else
		self.frame.Text:Hide()
	end
	if color then
		self.frame.Text:SetTextColor(color.r, color.g, color.b, color.a)
	end
end

function GridFrameClass.prototype:SetText2(text, color)
	text = string.sub(text, 1, GridFrame.db.profile.textlength)
	self.frame.Text2:SetText(text)
	if text and text ~= "" then
		self.frame.Text2:Show()
	else
		self.frame.Text2:Hide()
	end
	if color then
		self.frame.Text2:SetTextColor(color.r, color.g, color.b, color.a)
	end
end

function GridFrameClass.prototype:CreateIndicator(indicator)

	self.frame[indicator] = CreateFrame("Frame", nil, self.frame)
	self.frame[indicator]:SetWidth(GridFrame:GetCornerSize())
	self.frame[indicator]:SetHeight(GridFrame:GetCornerSize())
	self.frame[indicator]:SetBackdrop( {
				      bgFile = "Interface\\Addons\\Grid\\white16x16", tile = true, tileSize = 16,
				      edgeFile = "Interface\\Addons\\Grid\\white16x16", edgeSize = 1,
				      insets = {left = 1, right = 1, top = 1, bottom = 1},
			      })
	self.frame[indicator]:SetBackdropBorderColor(0,0,0,1)
	self.frame[indicator]:SetBackdropColor(1,1,1,1)
	self.frame[indicator]:SetFrameLevel(5)
	self.frame[indicator]:Hide()
	
	-- position indicator wherever needed
	if indicator == "corner1" then
		self.frame[indicator]:SetPoint("BOTTOMLEFT", self.frame, "BOTTOMLEFT", 1, 1)
	elseif indicator == "corner2" then
		self.frame[indicator]:SetPoint("BOTTOMRIGHT", self.frame, "BOTTOMRIGHT", -1, 1)
	elseif indicator == "corner3" then
		self.frame[indicator]:SetPoint("TOPRIGHT", self.frame, "TOPRIGHT", -1, -1)
	elseif indicator == "corner4" then
		self.frame[indicator]:SetPoint("TOPLEFT", self.frame, "TOPLEFT", 1, -1)
	end
end

function GridFrameClass.prototype:SetIndicator(indicator, color, text, value, maxValue, texture)
	if not color then color = { r = 1, g = 1, b = 1, a = 1 } end
	if indicator == "border" then
		self.frame:SetBackdropBorderColor(color.r, color.g, color.b, color.a)
	elseif indicator == "corner1" 
	or indicator == "corner2" 
	or indicator == "corner3" 
	or indicator == "corner4" 
	then
		-- create indicator on demand if not available yet
		if not self.frame[indicator] then
			self:CreateIndicator(indicator)
		end
		self.frame[indicator]:SetBackdropColor(color.r, color.g, color.b, color.a)
		self.frame[indicator]:Show()
	elseif indicator == "text" then
		self:SetText(text, color)
	elseif indicator == "text2" then
		self:SetText2(text, color)
	elseif indicator == "frameAlpha" then
		for x = 1, 4 do
			local corner = "corner"..x;
			if self.frame[corner] then
				self.frame[corner]:SetAlpha(color.a)
			end
		end
		self.frame:SetAlpha(color.a)
	elseif indicator == "bar" then
		if value and maxValue then
			self:SetBar(value, maxValue)
		end
		if type(color) == "table" then
			self:SetBarColor(color.r, color.g, color.b, color.a)
		end
	elseif indicator == "icon" then
		if texture then
			self.frame.Icon:SetTexture(texture)
			self.frame.Icon:SetAlpha(1)
			self.frame.Icon:Show()

			if type(color) == "table" then
				self.frame.Icon:SetAlpha(color.a)
			end
		else
			self.frame.Icon:Hide()
		end
	end
end

function GridFrameClass.prototype:ClearIndicator(indicator)
	if indicator == "border" then
		self.frame:SetBackdropBorderColor(0, 0, 0, 0)
	elseif indicator == "corner1" 
	or indicator == "corner2" 
	or indicator == "corner3" 
	or indicator == "corner4" 
	then
		if self.frame[indicator] then
			self.frame[indicator]:SetBackdropColor(1, 1, 1, 1)
			self.frame[indicator]:Hide()
		end
	elseif indicator == "text" then
		self:SetText("")
	elseif indicator == "text2" then
		self:SetText2("")
	elseif indicator == "frameAlpha" then
		for x = 1, 4 do
			local corner = "corner"..x;
			if self.frame[corner] then
				self.frame[corner]:SetAlpha(1)
			end
		end
		self.frame:SetAlpha(1)
	elseif indicator == "bar" then
		self:SetBar(100)
		self:SetBarColor(0, 0, 0, 1)
	elseif indicator == "icon" then
		self.frame.Icon:SetTexture(1,1,1,0)
		self.frame.Icon:Hide()
	end
end

--}}}

--{{{ GridFrame

GridFrame = Grid:NewModule("GridFrame")
GridFrame.frameClass = GridFrameClass

--{{{  AceDB defaults

GridFrame.defaultDB = {
	frameHeight = 26,
	frameWidth = 26,
	cornerSize = 5,
	orientation = "VERTICAL",
	enableText2 = false,
	fontSize = 8,
	iconSize = 16,
	debug = false,
	invertBarColor = false,
	showTooltip = L["OOC"],
	textlength = 4,
	statusmap = {
		["text"] = {
			alert_death = true,
			alert_offline = true,
			unit_name = true,
			unit_healthDeficit = true,
		},
		["text2"] = {
			alert_death = true,
			alert_offline = true,
		},
		["border"] = {
			alert_lowHealth = true,
			alert_lowMana = true,
			player_target = true,
		},
		["corner1"] = {
			alert_heals = true,
		},
		["corner2"] = {
		},
		["corner3"] = {
			debuff_poison = true,
			debuff_magic = true,
			debuff_disease = true,
			debuff_curse = true,
		},
		["corner4"] = {
			alert_aggro = true,
		},
		["frameAlpha"] = {
			alert_death = true,
			alert_offline = true,
			alert_range_oor = true,
		},
		["bar"] = {
			alert_death = true,
			alert_offline = true,
			unit_health = true,
		},
		["icon"] = {
			debuff_poison = true,
			debuff_magic = true,
			debuff_disease = true,
			debuff_curse = true,
		}
	},
}

--}}}

--{{{  AceOptions table

GridFrame.options = {
	type = "group",
	name = L["Frame"],
	desc = L["Options for GridFrame."],
	args = {
		["tooltip"] = {
			type = "text",
			name = L["Show Tooltip"],
			desc = L["Show unit tooltip.  Choose 'Always', 'Never', or 'OOC'."],
			order = 10,
			get = function ()
				return GridFrame.db.profile.showTooltip
			end,
			set = function (v)
				GridFrame.db.profile.showTooltip = v
			end,
			validate = { L["Always"], L["Never"], L["OOC"] }
		},
		["textlength"] = {
			type = "range",
			name = L["Center Text Length"],
			desc = L["Number of characters to show on Center Text indicator."],
			order = 11,
			min = 0,
			max = 8,
			step = 1,
			get = function () return GridFrame.db.profile.textlength end,
			set = function (v)
				GridFrame.db.profile.textlength = v
				GridFrame:UpdateAllFrames()
			end,
		},
		["invert"] = {
			type = "toggle",
			name = L["Invert Bar Color"],
			desc = L["Swap foreground/background colors on bars."],
			order = 12,
			get = function ()
				return GridFrame.db.profile.invertBarColor
			end,
			set = function (v)
				GridFrame.db.profile.invertBarColor = v
				GridFrame:InvertBarColor()
			end,
		},
		["IndicatorsHeaderGap"] = {
			type = "header",
			order = 49,
		},
		["IndicatorsHeader"] = {
			type = "header",
			name = L["Indicators"],
			order = 50,
		},

		["advanced"] = {
			type = "group",
			name = "Advanced",
			desc = "Advanced options.",
			order = -1,
			disabled = function () return Grid.inCombat end,
			args = {
				["text2"] = {
					type = "toggle",
					name = string.format(L["Enable %s indicator"], L["Center Text 2"]),
					desc = string.format(L["Toggle the %s indicator."], L["Center Text 2"]),
					order = 5,
					get = function ()
						      return GridFrame.db.profile.enableText2
					      end,
					set = function (v)
							GridFrame.db.profile.enableText2 = v
							GridFrame:WithAllFrames(function (f) f:EnableText2(v) end)
						end,
				},
				["framewidth"] = {
					type = "range",
					name = L["Frame Width"],
					desc = L["Adjust the width of each unit's frame."],
					min = 10,
					max = 100,
					step = 1,
					get = function ()
						      return GridFrame.db.profile.frameWidth
					      end,
					set = function (v)
						      GridFrame.db.profile.frameWidth = v
						      GridFrame:ResizeAllFrames()
					      end,
				},
				["frameheight"] = {
					type = "range",
					name = L["Frame Height"],
					desc = L["Adjust the height of each unit's frame."],
					min = 10,
					max = 100,
					step = 1,
					get = function ()
						      return GridFrame.db.profile.frameHeight
					      end,
					set = function (v)
						      GridFrame.db.profile.frameHeight = v
						      GridFrame:ResizeAllFrames()
					      end,
				},
				["cornersize"] = {
					type = "range",
					name = L["Corner Size"],
					desc = L["Adjust the size of the corner indicators."],
					min = 1,
					max = 20,
					step = 1,
					get = function ()
						      return GridFrame.db.profile.cornerSize
					      end,
					set = function (v)
						      GridFrame.db.profile.cornerSize = v
						      GridFrame:WithAllFrames(function (f) f:SetCornerSize(v) end)
					      end,
				},
				["iconsize"] = {
					type = "range",
					name = L["Icon Size"],
					desc = L["Adjust the size of the center icon."],
					min = 5,
					max = 50,
					step = 1,
					get = function ()
						      return GridFrame.db.profile.iconSize
					      end,
					set = function (v)
						      GridFrame.db.profile.iconSize = v
						      GridFrame:WithAllFrames(function (f) f:SetIconSize(v) end)
					      end,
				},
				["fontsize"] = {
					type = "range",
					name = L["Font Size"],
					desc = L["Adjust the font size."],
					min = 6,
					max = 24,
					step = 1,
					get = function ()
						      return GridFrame.db.profile.fontSize
					      end,
					set = function (v)
						      GridFrame.db.profile.fontSize = v
						      GridFrame:WithAllFrames(function (f) f:SetFontSize(v) end)
					      end,
				},
				["orientation"] = {
					type = "text",
					name = L["Orientation"],
					desc = L["Set frame orientation."],
					get = function ()
						      return GridFrame.db.profile.orientation
						end,
					set = function (v)
						      GridFrame.db.profile.orientation = v
						      GridFrame:WithAllFrames(function (f) f:SetOrientation(v) end)
						end,
					validate = { "VERTICAL", "HORIZONTAL" }
				},
			},
		},
	},
}

--}}}

function GridFrame:OnInitialize()
	self.super.OnInitialize(self)
	self.debugging = self.db.profile.debug

	self.frames = {}
	self.registeredFrames = {}
end

function GridFrame:OnEnable()
	self:RegisterEvent("Grid_StatusGained")
	self:RegisterEvent("Grid_StatusLost")
	self:UpdateOptionsMenu()
	self:RegisterEvent("Grid_StatusRegistered", "UpdateOptionsMenu")
	self:RegisterEvent("Grid_StatusUnregistered", "UpdateOptionsMenu")
	self:ResetAllFrames()
	self:UpdateAllFrames()
end

function GridFrame:OnDisable()
	self:Debug("OnDisable")
	-- should probably disable and hide all of our frames here
end

function GridFrame:Reset()
	self.super.Reset(self)
	self:UpdateOptionsMenu()
	self:ResetAllFrames()
	self:UpdateAllFrames()
end

function GridFrame:RegisterFrame(frame)
	self:Debug("RegisterFrame", frame:GetName())
	
	self.registeredFrameCount = (self.registeredFrameCount or 0) + 1
	self.registeredFrames[frame:GetName()] = self.frameClass:new(frame)
end

function GridFrame:WithAllFrames(func)
	local frameName, frame
	for frameName,frame in pairs(self.registeredFrames) do
		func(frame)
	end
end

function GridFrame:ResetAllFrames()
	self:WithAllFrames(
		function (f)
			f:Reset()
		end)
	self:TriggerEvent("Grid_UpdateSort")
end

function GridFrame:ResizeAllFrames()
	self:WithAllFrames(
		function (f)
			f:SetWidth(self:GetFrameWidth())
			f:SetHeight(self:GetFrameHeight())
		end)

	self:TriggerEvent("Grid_UpdateSort")
end

function GridFrame:UpdateAllFrames()
	self:WithAllFrames(
		function (f)
			if f.unit then
				GridFrame:UpdateIndicators(f)
			end
		end)
end

function GridFrame:InvertBarColor()
	self:WithAllFrames(
		function (f)
			f:InvertBarColor()
		end)
end

function GridFrame:GetFrameWidth()
	return self.db.profile.frameWidth
end

function GridFrame:GetFrameHeight()
	return self.db.profile.frameHeight
end

function GridFrame:GetCornerSize()
	return self.db.profile.cornerSize
end

function GridFrame:UpdateIndicators(frame)
	local indicator, status
	local unitid = frame.unit
	local name = frame.unitName

	-- self.statusmap[indicator][status]
	for indicator in pairs(self.db.profile.statusmap) do
		status = self:StatusForIndicator(unitid, indicator)
		if status then
			-- self:Debug("Showing status", status.text, "for", name, "on", indicator)
			frame:SetIndicator(indicator,
					   status.color,
					   status.text,
					   status.value,
					   status.maxValue,
					   status.texture)
		else
			-- self:Debug("Clearing indicator", indicator, "for", name)
			frame:ClearIndicator(indicator)
		end
	end
end

function GridFrame:StatusForIndicator(unitid, indicator)
	local statusName, enabled, status, inRange
	local topPriority = 0
	local topStatus
	local statusmap = self.db.profile.statusmap[indicator]
	local name = UnitName(unitid)

	-- self.statusmap[indicator][status]

	for statusName,enabled in pairs(statusmap) do
		status = (enabled and GridStatus:GetCachedStatus(name, statusName))
		if status then
			local valid = true

			-- make sure the status can be displayed
			if (indicator == "text" or indicator == "text2") and not status.text then
				self:Debug("unable to display", statusName, "on", indicator, ": no text")
				valid = false
			end
			if indicator == "icon" and not status.texture then
				self:Debug("unable to display", statusName, "on", indicator, ": no texture")
				valid = false
			end

			if status.range and type(status.range) ~= "number" then
				self:Debug("range not number for", statusName)
				valid = false
			end

			if status.priority and type(status.priority) ~= "number" then
				self:Debug("priority not number for", statusName)
				valid = false
			end

			-- only check range for valid statuses
			if valid then
				inRange = not status.range or self:UnitInRange(unitid, status.range)

				if ((status.priority or 99) > topPriority) and inRange then
					topStatus = status
					topPriority = topStatus.priority
				end
			end
		end
	end

	return topStatus
end

function GridFrame:UnitInRange(id, yrds)
	if not id or not UnitExists(id) then return false end

	local range = GridRange:GetUnitRange(id)
	return range and yrds >= range
end

--{{{ Event handlers

function GridFrame:Grid_StatusGained(name, status, priority, range, color, text, value, maxValue, texture)
	-- local unitid = RL:GetUnitIDFromName(name)
	local frameName, frame

	for frameName,frame in pairs(self.registeredFrames) do
		if frame.unitName == name then
			self:UpdateIndicators(frame)
		end
	end
end

function GridFrame:Grid_StatusLost(name, status)
	-- self:Debug("StatusLost", status, "on", name)
	-- local unitid = RL:GetUnitIDFromName(name)
	local frameName, frame

	for frameName,frame in pairs(self.registeredFrames) do
		if frame.unitName == name then
			self:UpdateIndicators(frame)
		end
	end
end

--}}}

function GridFrame:UpdateOptionsMenu()
	self:Debug("UpdateOptionsMenu()")

	for _,indicator in ipairs(self.frameClass.prototype.indicators) do
		self:UpdateOptionsForIndicator(indicator.type, indicator.name, indicator.order)
	end
end

function GridFrame:UpdateOptionsForIndicator(indicator, name, order)
	local menu = self.options.args
	local status, descr, indicatorMenu

	-- create menu for indicator
	if not menu[indicator] then
		menu[indicator] = {
			type = "group",
			name = name,
			desc = string.format(L["Options for %s indicator."], name),
			order = 50 + (order or 1),
			args = {
				["StatusesHeader"] = {
					type = "header",
					name = L["Statuses"],
					order = 1,
				},
			},
		}
		if indicator == "text2" then
			menu[indicator].disabled = function () return not GridFrame.db.profile.enableText2 end
		end
	end

	indicatorMenu = menu[indicator].args

	-- remove statuses that are not registered
	for status,_ in pairs(indicatorMenu) do
		if status ~= "StatusesHeader" and not GridStatus:IsStatusRegistered(status) then
			indicatorMenu[status] = nil
			self:Debug("Removed", indicator, status)
		end
	end

	-- create entry for each registered status
	for status, _, descr in GridStatus:RegisteredStatusIterator() do
		-- needs to be local for the get/set closures
		local indicatorType = indicator
		local statusKey = status
		
		-- self:Debug(indicator.type, status)
		
		if not indicatorMenu[status] then
			indicatorMenu[status] = {
				type = "toggle",
				name = descr,
				desc = L["Toggle status display."],
				get = function ()
					      return GridFrame.db.profile.statusmap[indicatorType][statusKey]
				      end,
				set = function (v)
					      GridFrame.db.profile.statusmap[indicatorType][statusKey] = v
					      GridFrame:UpdateAllFrames()
				      end,
			}
			
			-- self:Debug("Added", indicator.type, status)
		end
	end
end

--{{ Debugging

function GridFrame:ListRegisteredFrames()
	local frameName, frame, isUnused, unusedFrame, i, frameStatus
	self:Debug("--[ BEGIN Registered Frame List ]--")
	self:Debug("FrameName", "UnitId", "UnitName", "Status")
	for frameName,frame in pairs(self.registeredFrames) do
		frameStatus = "|cff00ff00"

		if frame.frame:IsVisible() then
			frameStatus = frameStatus .. "visible"
		elseif frame.frame:IsShown() then
			frameStatus = frameStatus .. "shown"
		else
			frameStatus = "|cffff0000"
			frameStatus = frameStatus .. "hidden"
		end

		frameStatus = frameStatus .. "|r"

		self:Debug(
			frameName == frame:GetFrameName() and
				"|cff00ff00"..frameName.."|r" or
				"|cffff0000"..frameName.."|r",
			frame.unit == frame.frame:GetAttribute("unit") and
					"|cff00ff00"..(frame.unit or "nil").."|r" or
					"|cffff0000"..(frame.unit or "nil").."|r",
			frame.unit and frame.unitName == UnitName(frame.unit) and
				"|cff00ff00"..(frame.unitName or "nil").."|r" or
				"|cffff0000"..(frame.unitName or "nil").."|r",
			frameStatus)
	end
	GridFrame:Debug("--[ END Registered Frame List ]--")
end

--}}}
