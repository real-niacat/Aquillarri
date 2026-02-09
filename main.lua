aquill = {}
aquill = SMODS.current_mod
aquill.config = SMODS.current_mod.config

aquill.triggers = {}
aquill.enums = {}

SMODS.current_mod.optional_features = {
	retrigger_joker = true
}

if not SMODS.ScreenShader then
	aquill.can_load = false
	aquill.load_issues = {
		dependencies = {
			"SMODS.ScreenShader"
		},
		conflicts = {},

	}
	return
end

SMODS.Atlas {
	px = 34,
	py = 34,
	key = "modicon",
	path = "modicon.png",
}

---@param name string
---@param enum table
--enum is a table of strings for names
-- eg aquill.add_enum("test", {"a", "b"}) → aquill.enums.test.a/b
function aquill.add_enum(name, enum)
	aquill.enums[name] = {}
	for i, entry in ipairs(enum) do
		aquill.enums[name][entry] = i
	end
end

local blacklist = {
	assets = true,
	lovely = true,
	[".github"] = true,
	[".git"] = true,
	["localization"] = true
}

local function load_file_native(path, id)
	if not path or path == "" then
		error("No path was provided to load.")
	end
	local file_path = path
	local file_content, err = SMODS.NFS.read(file_path)
	if not file_content then
		return nil,
			"Error reading file '" .. path .. "' for mod with ID '" .. SMODS.current_mod.id .. "': " .. err
	end
	local chunk, loaderr = load(file_content, "=[SMODS " .. SMODS.current_mod.id .. ' "' .. path .. '"]')
	if not chunk then
		return nil,
			"Error processing file '" .. path .. "' for mod with ID '" .. SMODS.current_mod.id .. "': " .. loaderr
	end
	return chunk
end
local function load_files(path, dirs_only, initial)
	local info = SMODS.NFS.getDirectoryItemsInfo(path)
	local to_load = {}
	if initial == nil then initial = true end
	for i, v in pairs(info) do
		if v.type == "directory" and not blacklist[v.name] then
			to_load = SMODS.merge_lists({ to_load, load_files(path .. "/" .. v.name, false, false) })
		elseif not dirs_only then
			if string.find(v.name, ".lua") and not string.find(v.name, ".ignore_") then -- no X.lua.txt files or whatever unless they are also lua files
				table.insert(to_load, path .. "/" .. v.name)
			end
		end
	end

	-- print(to_load)
	if not initial then
		-- print("returning")
		return to_load
	end

	-- print("sorting and loading")
	table.sort(to_load, function(a, b)
		local prio = "p_"
		local fa = a:find(prio)
		local fb = b:find(prio)

		if fa and not fb then return true end
		if fb and not fa then return false end

		return a < b
	end)

	for _, file in pairs(to_load) do
		local f, err = load_file_native(file)
		if f then
			f()
		else
			error("error in file " .. file .. ": " .. err)
		end
	end
end
local path = SMODS.current_mod.path

load_files(path, true)

aquill.config.disable_corruption = false

if not G.E_MANAGER then return end

G.E_MANAGER:add_event(Event({
	trigger = 'after',
	func = function()
		if G.FUNCS and G.FUNCS.openModUI_aquillarri and (not aquill.get_current_profile().played_aqu_before) then
			G.FUNCS.openModUI_aquillarri()
			aquill.get_current_profile().played_aqu_before = true
			return true
		end
	end,
	blockable = true,
	blocking = false,
}))