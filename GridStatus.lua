-- GridStatus.lua

--{{{ Libraries

local RL = AceLibrary("RosterLib-2.0")
local L = AceLibrary("AceLocale-2.2"):new("Grid")

--}}}
--{{{ GridStatus

GridStatus = Grid:NewModule("GridStatus", "AceModuleCore-2.0")
GridStatus:SetModuleMixins("AceDebug-2.0", "AceEvent-2.0")

--{{{ Module prototype

GridStatus.modulePrototype.core = GridStatus

function GridStatus.modulePrototype:OnInitialize()
	if not self.db then
		self.core.core:RegisterDefaults(self.name, "profile", self.defaultDB or {})
		self.db = self.core.core:AcquireDBNamespace(self.name)
	end
	self.debugging = self.db.profile.debug
	self.debugFrame = GridStatus.debugFrame
end

function GridStatus.modulePrototype:Reset()
	self.debugging = self.db.profile.debug
	self:Debug("Reset")
end

function GridStatus.modulePrototype:InitializeOptions()
	GridStatus:Debug("InitializeOptions", self.name)
	local module = self
	if not self.options then
		self.options = {
			type = "group",
			name = (self.menuName or self.name),
			desc = string.format(L["Options for %s."], self.name),
			args = {},
		}

	end

	if self.extraOptions then
		for name, option in pairs(self.extraOptions) do
			self.options.args[name] = option
		end
	end
end

function GridStatus.modulePrototype:RegisterStatus(status, desc, options, inMainMenu)
	local module = self
	local optionMenu

	GridStatus:RegisterStatus(status, desc, (self.name or true))

	if inMainMenu then
		optionMenu = GridStatus.options.args
	else
		if not self.options then
			self:InitializeOptions()
		end

		optionMenu = self.options.args
	end

	if not optionMenu[status] then
		optionMenu[status] = {
			type = "group",
			name = desc,
			desc = string.format(L["Status: %s"], desc),
			order = inMainMenu and 111 or nil,
			args = {
				["color"] = {
					type = "color",
					name = L["Color"],
					desc = string.format(L["Color for %s"], desc),
					order = 90,
					hasAlpha = true,
					get = function ()
						      local color = module.db.profile[status].color
						      return color.r, color.g, color.b, color.a
					      end,
					set = function (r, g, b, a)
						      local color = module.db.profile[status].color
						      color.r = r
						      color.g = g
						      color.b = b
						      color.a = a or 1
					      end,
				},
				["priority"] = {
					type = "range",
					name = L["Priority"],
					desc = string.format(L["Priority for %s"], desc),
					order = 91,
					max = 99,
					min = 0,
					step = 1,
					get = function ()
						      return module.db.profile[status].priority
					      end,
					set = function (v)
						      module.db.profile[status].priority = v
					      end,
				},
				["Header"] = {
					type = "header",
					order = 110,
				},
				["range"] = {
					type = "toggle",
					name = L["Range filter"],
					desc = string.format(L["Range filter for %s"], desc),
					order = 111,
					get = function() return module.db.profile[status].range end,
					set = function()
						module.db.profile[status].range = not module.db.profile[status].range
					end,
				},
				["enable"] = {
					type = "toggle",
					name = L["Enable"],
					desc = string.format(L["Enable %s"], desc),
					order = 112,
					get = function ()
						      return module.db.profile[status].enable
					      end,
					set = function (v)
						      module.db.profile[status].enable = v
					      end,
				},
			},
		}

		if options then
			for name, option in pairs(options) do
				if not option then
					optionMenu[status].args[name] = nil
				else
					optionMenu[status].args[name] = option
				end
			end
		end
	end
end

function GridStatus.modulePrototype:UnregisterStatus(status)
	GridStatus:UnregisterStatus(status, (self.name or true))
end

--}}}

--{{{ AceDB defaults

GridStatus.defaultDB = {
	debug = false,
	range = false,
}

--}}}
--{{{ AceOptions table

GridStatus.options = {
	type = "group",
	name = L["Status"],
	desc = string.format(L["Options for %s."], GridStatus.name),
	args = {
		["Header"] = {
			type = "header",
			order = 110,
		},
	},
}

--}}}

function GridStatus:OnInitialize()
	self.super.OnInitialize(self)
	self.registry = {}
	self.registryDescriptions = {}
	self.cache = {}
end

--{{{ Status registry

function GridStatus:RegisterStatus(status, description, moduleName)
	if not self.registry[status] then
		self:Debug("Registered", status, "("..description..")", "for", moduleName)
		self.registry[status] = (moduleName or true)
		self.registryDescriptions[status] = description
		self:TriggerEvent("Grid_StatusRegistered", status, description, moduleName)
	else
		-- error if status is already registered?
		self:Debug("RegisterStatus:", status, "is already registered.")
	end
end

function GridStatus:UnregisterStatus(status, moduleName)
	local name

	if self:IsStatusRegistered(status) then
		self:Debug("Unregistered", status, "for", moduleName)
		-- need to remove from cache
		for name in pairs(self.cache) do
			self:SendStatusLost(name, status)
		end

		-- now we can remove from registry
		self.registry[status] = nil
		self.registryDescriptions[status] = nil
		self:TriggerEvent("Grid_StatusUnregistered", status)
	end
end

function GridStatus:IsStatusRegistered(status)
	return (self.registry and
		self.registry[status] and
		true)
end

function GridStatus:RegisteredStatusIterator()
	local status
	local gsreg = self.registry
	local gsregdescr = self.registryDescriptions
	return function ()
		status = next(gsreg, status)
		return status, gsreg[status], gsregdescr[status]
	end
end

--}}}
--{{{ Caching status functions

function GridStatus:SendStatusGained(name, status, priority, range, color, text,  value, maxValue, texture)
	local u = RL:GetUnitObjectFromName(name)
	local cached

	-- ignore unit if it is not in the roster
	if not u then
		return
	end

	if color and not type(color) == "table" then
		self:Debug("color is not a table for", status)
	end

	if range and type(range) ~= "number" then
		self:Debug("Range is not a number for", status)
	end

	-- create cache for unit if needed
	if not self.cache[name] then
		self.cache[name] = {}
	end

	if not self.cache[name][status] then
		self.cache[name][status] = {}
	end

	cached = self.cache[name][status]

	-- if no changes were made, return rather than triggering an event
	if cached and
		cached.priority == priority and
		cached.range == range and
		cached.color == color and
		cached.text == text and
		cached.value == value and
		cached.maxValue == maxValue and
		cached.texture == texture then

		return
	end

	-- update cache
	cached.priority = priority
	cached.range = range
	cached.color = color
	cached.text = (text or "")
	cached.value = value
	cached.maxValue = maxValue
	cached.texture = texture

	self:TriggerEvent("Grid_StatusGained", name, status,
			  priority, range, color, text, value, maxValue,
			  texture)

end

function GridStatus:SendStatusLost(name, status)

	-- if status isn't cached, don't send status lost event
	if (not self.cache[name]) or (not self.cache[name][status]) then
		return
	end

	self.cache[name][status] = nil

	self:TriggerEvent("Grid_StatusLost", name, status)
end

function GridStatus:GetCachedStatus(name, status)
	return (self.cache[name] and self.cache[name][status])
end

function GridStatus:CachedStatusIterator(status)
	local cache = self.cache
	local name

	if status then
		-- iterator for a specific status
		return function ()
			name = next(cache, name)

			-- we reached the end early?
			if name == nil then
				return nil
			end
			
			while cache[name][status] == nil do
				name = next(cache, name)
				
				if name == nil then
					return nil
				end
			end
			
			return name, status, cache[name][status]
		end
	else
		-- iterator for all units, all statuses
		return function ()
			status = next(cache[name], status)
			
			-- find the next unit with a status
			while not status do
				name = next(cache, name)
				
				if name then
					status = next(cache[name], status)
				else
					return nil
				end
			end
			
			return name, status, cache[name][status]
		end
	end
end

--}}}
--}}}

