minetest.register_chatcommand("spectate", {
    params = "",
    description = "Enter spectator mode (invisible)",
    privs = {admin=true},
    func = function(name)
        local player = minetest.get_player_by_name(name)
        if player then
            -- Rendre le joueur invisible
            player:set_properties({pointable = false, visual_size = {x = 0, y = 0}})
            -- Cacher le nametag du joueur
            player:set_nametag_attributes({color = {a = 0, r = 255, g = 255, b = 255}})
            return true, "You are now invisible in spectator mode and your nametag is hidden."
        else
            return false, "Failed to enter spectator mode."
        end
    end,
})

-- Commande pour quitter le mode spectateur (visibilité et afficher le nametag)
minetest.register_chatcommand("unspectate", {
    params = "",
    description = "Exit spectator mode",
    privs = {admin=true},
    func = function(name)
        local player = minetest.get_player_by_name(name)
        if player then
            -- Rendre le joueur à nouveau visible
            player:set_properties({pointable = true, visual_size = {x = 1, y = 1}})
            -- Afficher à nouveau le nametag du joueur
            player:set_nametag_attributes({color = {a = 255, r = 255, g = 255, b = 255}})
            return true, "You have exited spectator mode and your nametag is visible again."
        else
            return false, "Failed to exit spectator mode."
        end
    end,
})
