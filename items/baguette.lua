minetest.register_craftitem("imstaff:baguette", {
	description = S("BAguette"),
	_doc_items_longdesc = S("This is a food item which can be eaten."),
	inventory_image = "baguette.png",
	groups = {food = 2, eatable = 6, compostability = 85},
	_mcl_saturation = 9.0,
	on_place = minetest.item_eat(5),
	on_secondary_use = minetest.item_eat(5),
})
