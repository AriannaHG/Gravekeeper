gravekeeperSkullSubtraction

-- Removes 150 skull-type items from the player, in priority order.
-- Call this via a TriggerEffect with effectID=script and sValue="gravekeeperSkullSubtraction"

    local need = 150

    -- Priority order of skull types
    local skullTypes = {
        "skull",
        "skull2", 
        "skull_elephant1",
        "skull_elephant2",
        "skull_dog1",
        "skull_dog2"
    }
	
	for _, x in ipairs(skullTypes) do
		if need <= 0 then break end

        -- How many of this item the player has
        local have = formula(player(),player(),'partyItem:' .. x)

        if have ~= nil and have > 0 then
            -- Take as many as possible, but not more than needed
            local take = math.min(have, need)

            -- Remove them
			setGlobal('ari_gk_gvar_' .. x, take)

            -- Reduce remaining requirement
            need = need - take
	        end
    end