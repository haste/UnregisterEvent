local registered = true

local frame = CreateFrame('Frame', 'UnregisterEventFrame')
frame:SetScript('OnEvent', function(self, event)
	self:UnregisterEvent(event)
	print(date(), event, 'fired')

	-- Have to prevent infinite loops as :UnregisterEvent doesn't.
	if(registered) then
		-- Generate some additional UPDATE_BINDINGS events.
		local cmd = GetBindingByKey'F'
		SetBinding('F', nil)
		SetBinding('F', cmd)
	end

	registered = nil
end)
frame:RegisterEvent('UPDATE_BINDINGS')

-- The following will return `1` in-game:
-- /run print(UnregisterEventFrame:IsEventRegistered('UPDATE_BINDINGS'))
