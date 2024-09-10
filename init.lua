--Privs
--Admin Priv
dofile(minetest.get_modpath("imstaff") .. "/privs/admin.lua")

--Scripts for commands files
--/spectate and /unspectate commands
dofile(minetest.get_modpath("imstaff") .. "/scripts/spectate.lua")
--/announce command
dofile(minetest.get_modpath("imstaff") .. "/scripts/announce.lua")
--/heal command
dofile(minetest.get_modpath("imstaff") .. "/scripts/heal.lua")
--/openinv and /openec commands
dofile(minetest.get_modpath("imstaff") .. "/scripts/openinvec.lua")
--/rename command
dofile(minetest.get_modpath("imstaff") .. "/scripts/rename.lua")
--/quests and /createquest commands
dofile(minetest.get_modpath("imstaff") .. "/scripts/quests.lua")
--/rickastley command
dofile(minetest.get_modpath("imstaff") .. "/scripts/rickroll.lua")
--/textbox command
dofile(minetest.get_modpath("imstaff") .. "/scripts/textbox.lua")
--/lookup command
dofile(minetest.get_modpath("imstaff") .. "/scripts/lookup.lua")
--/doas command dont work
--dofile(minetest.get_modpath("imstaff") .. "/scripts/doas.lua")

--Items
--Spear
dofile(minetest.get_modpath("imstaff") .. "/items/spear.lua")
--Baguette
dofile(minetest.get_modpath("imstaff") .. "/items/baguette.lua")

--Scripts
--AdminNotify
dofile(minetest.get_modpath("imstaff") .. "/scripts/adminnotify.lua")
