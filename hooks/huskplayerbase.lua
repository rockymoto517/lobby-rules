local old_upgrade_value = HuskPlayerBase.upgrade_value
function HuskPlayerBase:upgrade_value(category, upgrade)
	local val = old_upgrade_value(self, category, upgrade)
	if LobbyRules.settings.no_second_joker then
		if category == "player" and upgrade == "convert_enemies_max_minions" then
			val = val and 1 or 0
		end
	end

	return val
end
