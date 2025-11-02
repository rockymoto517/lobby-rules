local old_upgrade_value = HuskPlayerBase.upgrade_value
function HuskPlayerBase:upgrade_value(category, upgrade)
	local val = old_upgrade_value(self, category, upgrade)
	if NetworkHelper:IsClient() then
		return val
	end

	-- Crew chief check
	-- Lots of extra checks cause it's needed
	local peer = managers.network:session():peer_by_unit(self._unit)
	local deck_id = 0
	if peer then
		local skills_deck_info = string.split(peer:skills(), "-")
		if skills_deck_info then
			local deck = skills_deck_info[2]
			deck_id = tonumber(string.split(deck, "_")[1])
		end
	end

	if LobbyRules.settings.no_second_joker and deck_id ~= 1 then
		if category == "player" and upgrade == "convert_enemies_max_minions" then
			val = val and 1 or 0
		end
	end

	return val
end
