local old_upgrade_value = HuskPlayerBase.upgrade_value
function HuskPlayerBase:upgrade_value(category, upgrade)
	local val = old_upgrade_value(self, category, upgrade)

	-- Crew chief check
	local peer = managers.network:session():peer_by_unit(self._unit)
	local deck_id = string.split(string.split(peer:skills(), "-")[2], "_")
	if LobbyRules.settings.no_second_joker and deck_id ~= 1 then
		if category == "player" and upgrade == "convert_enemies_max_minions" then
			val = val and 1 or 0
		end
	end

	return val
end
