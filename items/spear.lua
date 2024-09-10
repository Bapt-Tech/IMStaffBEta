-- Enregistrer une nouvelle entité pour le spear lancé
minetest.register_entity("imstaff:thrown_spear", {
    initial_properties = {
        physical = true,
        collide_with_objects = true,
        collisionbox = {0, 0, 0, 0, 0, 0},
        visual = "wielditem",
        visual_size = {x=0.5, y=0.5},
        textures = {"imstaff:spear"},
    },
    timer = 0,
    lastpos = {},
    damage = 8, -- Dégâts infligés par le spear

    on_step = function(self, dtime)
        self.timer = self.timer + dtime
        local pos = self.object:get_pos()

        if self.lastpos.x ~= nil then
            -- Vérifier la collision avec les entités
            local objs = minetest.get_objects_inside_radius(pos, 1)
            for _, obj in ipairs(objs) do
                if obj:is_player() or obj:get_luaentity() then
                    if obj ~= self.object then
                        local damage = self.damage
                        obj:punch(self.object, 1.0, {
                            full_punch_interval = 1.0,
                            damage_groups = {fleshy = damage},
                        }, nil)
                        -- Faire rebondir le spear et le transformer en item
                        minetest.add_item(self.lastpos, "imstaff:spear")
                        self.object:remove()
                        return
                    end
                end
            end

            -- Vérifier la collision avec les blocs
            if minetest.registered_nodes[minetest.get_node(self.lastpos).name].walkable then
                -- Planter le spear dans le sol et le transformer en item
                minetest.add_item(self.lastpos, "imstaff:spear")
                self.object:remove()
                return
            end
        end

        self.lastpos = vector.round(pos)
    end,
})

-- Déclaration du spear
minetest.register_tool("imstaff:spear", {
    description = "spear",
    inventory_image = "spear.png",
    wield_image = "spear.png",
    on_use = function(itemstack, user, pointed_thing)
        -- Retirer un spear de l'inventaire
        itemstack:take_item()
        
        -- Lancer le spear
        local player_pos = user:get_pos()
        local dir = user:get_look_dir()
        local obj = minetest.add_entity(vector.add(player_pos, {x=0, y=1.5, z=0}), "imstaff:thrown_spear")
        obj:set_velocity(vector.multiply(dir, 50)) -- La vitesse du spear
        obj:set_acceleration({x=0, y=-9.8, z=0}) -- Simulation de la gravité
        obj:set_yaw(user:get_look_horizontal())
        return itemstack
    end,
    wield_scale = {x=1, y=1, z=1}, -- Échelle du spear dans la main du joueur
})

-- Déclaration du craft du spear avec des bâtons de Mineclonia
minetest.register_craft({
    output = "imstaff:spear",
    recipe = {
        {"mcl_nether:netherite_ingot", "mcl_nether:netherite_ingot", "mcl_nether:netherite_ingot"},
        {"mcl_mobitems:blaze_rod", "mcl_nether:netherite_ingot", "mcl_mobitems:blaze_rod"},
        {"", "mcl_mobitems:blaze_rod", ""}
    }
})

