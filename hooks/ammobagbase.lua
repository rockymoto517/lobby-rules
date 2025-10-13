local old_ammobag_spawn = AmmoBagBase.spawn
function AmmoBagBase.spawn(pos, rot, ammo_upgrade_lvl, peer_id, bullet_storm_level)
	if LobbyRules.settings.no_bullet_storm then
		bullet_storm_level = 0
	end

	return old_ammobag_spawn(pos, rot, ammo_upgrade_lvl, peer_id, bullet_storm_level)
end
