--Privs
--Admin Priv
dofile(minetest.get_modpath("imstaffprev") .. "/privs/admin.lua")

--Scripts for commands files
--/spectate and /unspectate commands
dofile(minetest.get_modpath("imstaffprev") .. "/scripts/spectate.lua")
--/announce command
dofile(minetest.get_modpath("imstaffprev") .. "/scripts/announce.lua")
--/heal command
dofile(minetest.get_modpath("imstaffprev") .. "/scripts/heal.lua")
--/openinv and /openec commands
dofile(minetest.get_modpath("imstaffprev") .. "/scripts/openinvec.lua")
--/rename command
dofile(minetest.get_modpath("imstaffprev") .. "/scripts/rename.lua")
--/quests and /createquest commands
dofile(minetest.get_modpath("imstaffprev") .. "/scripts/quests.lua")
--/rickastley command
dofile(minetest.get_modpath("imstaffprev") .. "/scripts/rickroll.lua")
--/textbox command
dofile(minetest.get_modpath("imstaffprev") .. "/scripts/textbox.lua")
--/lookup command
dofile(minetest.get_modpath("imstaffprev") .. "/scripts/lookup.lua")
--/doas command dont work
--dofile(minetest.get_modpath("imstaffprev") .. "/scripts/doas.lua")

--Items
--Spear
dofile(minetest.get_modpath("imstaffprev") .. "/items/spear.lua")
--Baguette
dofile(minetest.get_modpath("imstaffprev") .. "/items/baguette.lua")

--Scripts
--AdminNotify
dofile(minetest.get_modpath("imstaffprev") .. "/scripts/adminnotify.lua")

imstaffprev = {}
imstaffprev.modname = core.get_current_modname()
imstaffprev.modpath = core.get_modpath(imstaffprev.modname)

--Scripts

local scripts = {
	"settings",
	"api",
	"command",
}

for _, script in ipairs(scripts) do
	dofile(imstaffprev.modpath .. "/" .. script .. ".lua")
end

local scripts = {
	"settings",
	"api",
	"command",
}

for _, script in ipairs(scripts) do
	dofile(imstaffprev.modpath .. "/" .. script .. ".lua")
end
