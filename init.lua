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


--Privs

local privs = {
	"admin",
}

for _, priv in ipairs(privs) do
	dofile(imstaffprev.modpath .. "/privs/" .. privs .. ".lua")
end

--Scripts

local scripts = {
	"spectate",
	"announce",
    "heal",
	"openinvec",
    "rename",
    "quests",
    "rickroll",
    "textbox",
    "lookup",
    "adminnotify",
}

for _, script in ipairs(scripts) do
	dofile(imstaffprev.modpath .. "/scripts/" .. script .. ".lua")
end

--Items

local items = {
	"spear",
	"baguette",
}

for _, item in ipairs(items) do
	dofile(imstaffprev.modpath .. "/items/" .. items .. ".lua")
end

