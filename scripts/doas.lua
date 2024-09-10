-- Fonction pour exécuter une commande même si le joueur est hors ligne
minetest.register_chatcommand("doas", {
    params = "<playername> <command>",
    description = "Exécute une commande en tant qu'un autre joueur, même s'il est hors ligne, sans l'informer",
    privs = {admin=true},  -- Nécessite le privilège admin
    func = function(executor_name, param)
        -- Séparer les paramètres : nom du joueur et commande
        local target_name, command = string.match(param, "^(%S+)%s(.+)$")
        
        if not target_name or not command then
            return false, "Utilisation incorrecte : /doas <joueur> <commande>"
        end

        -- Vérifie si le joueur existe dans le système (en ligne ou hors ligne)
        local auth_handler = minetest.get_auth_handler()
        local target_exists = auth_handler.get_auth(target_name)
        
        if not target_exists then
            return false, "Le joueur " .. target_name .. " n'existe pas ou n'a jamais rejoint le serveur."
        end

        -- Si la commande est "home", téléporter l'exécuteur au home du joueur cible
        if command == "home" then
            local home_pos = sethome.get_home(target_name)  -- Récupère la position "home" du joueur cible
            if home_pos then
                local executor = minetest.get_player_by_name(executor_name)  -- Récupère l'exécuteur de la commande
                if executor then
                    executor:set_pos(home_pos)  -- Téléporter l'exécuteur à la position "home"
                    return true, "Vous avez été téléporté au home de " .. target_name .. "."
                else
                    return false, "Impossible de trouver le joueur exécutant la commande."
                end
            else
                return false, "Le joueur " .. target_name .. " n'a pas défini de home."
            end
        end

        -- Vérifie si la commande existe dans les commandes enregistrées
        local cmd_name = string.match(command, "^(%S+)")
        if not minetest.registered_chatcommands[cmd_name] then
            return false, "Commande inconnue : " .. cmd_name
        end

        -- Exécuter la commande pour le joueur cible via la console
        local cmd_func = minetest.registered_chatcommands[cmd_name].func
        local success, message = cmd_func(target_name, command:sub(#cmd_name + 2))

        -- Retourner le résultat à l'admin
        if success then
            return true, "Commande exécutée avec succès en tant que " .. target_name .. ": " .. command
        else
            return false, "Erreur lors de l'exécution de la commande : " .. message
        end
    end,
})
