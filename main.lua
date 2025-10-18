--[[ Hook to setup is required to load the menu in time :) ]]

if not LobbyRules then
	LobbyRules = {}
	LobbyRules.save_path = SavePath .. "lobby-rules.json"
	LobbyRules.mod_path = ModPath
	LobbyRules.settings = {
		no_bullet_storm = false,
		no_second_joker = false,
	}

	function LobbyRules:log_chat(...)
		managers.chat:_receive_message(managers.chat.GAME, "DEBUG", table.concat({ ... }, " "), Color.green)
	end

	-- Hook loading
	LobbyRules.required = {}

	function LobbyRules:load_module(m)
		local path = self.mod_path .. "lua/" .. m .. ".lua"
		return io.file_is_readable(path) and blt.vm.dofile(path)
	end

	dofile(LobbyRules.mod_path .. "lua/build_menu.lua")
end

if RequiredScript and not LobbyRules.required[RequiredScript] then
	local fname = LobbyRules.mod_path .. RequiredScript:gsub(".+/(.+)", "hooks/%1.lua")
	if io.file_is_readable(fname) then
		dofile(fname)
	end

	LobbyRules.required[RequiredScript] = true
end
