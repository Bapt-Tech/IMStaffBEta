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

