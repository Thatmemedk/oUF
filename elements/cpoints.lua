local parent = debugstack():match[[\AddOns\(.-)\]]
local global = GetAddOnMetadata(parent, 'X-oUF')
assert(global, 'X-oUF needs to be defined in the parent add-on.')
local oUF = _G[global]

local GetComboPoints = GetComboPoints
local MAX_COMBO_POINTS = MAX_COMBO_POINTS

-- TODO: Fix it.
function oUF:UNIT_COMBO_POINTS(event, unit)
	local cp = GetComboPoints('player', 'target')
	local cpoints = self.CPoints

	if(#cpoints == 0) then
		cpoints:SetText((cp > 0) and cp)
	else
		for i=1, MAX_COMBO_POINTS do
			if(i <= cp) then
				cpoints[i]:Show()
			else
				cpoints[i]:Hide()
			end
		end
	end
end

table.insert(oUF.subTypes, function(self, unit)
	if(self.CPoints and unit == "target") then
		self:RegisterEvent(ename)
	end
end)
oUF:RegisterSubTypeMapping(ename)
