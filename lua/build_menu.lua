if io.file_is_readable(LobbyRules.save_path) then
	local saved = io.load_as_json(LobbyRules.save_path)
	if saved then
		for k, v in pairs(saved) do
			if LobbyRules.settings[k] ~= nil then
				LobbyRules.settings[k] = v
			end
		end
	end
end

Hooks:Add("MenuManagerBuildCustomMenus", "LobbyRulesCustomMenu", function(_, nodes)
	local id = "LobbyRulesMenu"
	MenuHelper:NewMenu(id)

	function MenuCallbackHandler:lobbyrules_bulletstorm_toggle(item)
		LobbyRules.settings.no_bullet_storm = item:value() == "on"
	end

	function MenuCallbackHandler:lobbyrules_second_joker_toggle(item)
		LobbyRules.settings.no_second_joker = item:value() == "on"
	end

	function MenuCallbackHandler:lobbyrules_save()
		io.save_as_json(LobbyRules.settings, LobbyRules.save_path)
	end

	MenuHelper:AddToggle({
		id = "no_bulletstorm",
		title = "Disable Bulletstorm",
		desc = "Prevents placed ammo bags from having bulletstorm.",
		callback = "lobbyrules_bulletstorm_toggle",
		menu_id = id,
		localized = false,
		value = LobbyRules.settings.no_bullet_storm,
	})
	MenuHelper:AddToggle({
		id = "no_second_joker",
		title = "No Second Joker",
		desc = "Prevents clients from taking a second joker.",
		callback = "lobbyrules_second_joker_toggle",
		menu_id = id,
		localized = false,
		value = LobbyRules.settings.no_second_joker,
	})

	nodes[id] = MenuHelper:BuildMenu(id, { back_callback = "lobbyrules_save" })
	MenuHelper:AddMenuItem(nodes["blt_options"], id, "lobbyrules_menu")
end)

Hooks:Add("LocalizationManagerPostInit", "LobbyRulesLocalizationInit", function(loc)
	-- en-us only
	loc:add_localized_strings({
		["lobbyrules_menu"] = "Lobby Rules",
	})
end)
