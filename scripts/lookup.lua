-- Table pour suivre les informations de connexion
local player_data = {}

-- Fonction pour initialiser les données du joueur à la connexion
local function on_player_join(player)
    local name = player:get_player_name()
    player_data[name] = {
        join_time = minetest.get_gametime(),
        last_seen = os.date("%Y-%m-%d %H:%M:%S"),
        is_online = true
    }
end

-- Fonction pour mettre à jour les données du joueur à la déconnexion
local function on_player_leave(player)
    local name = player:get_player_name()
    if player_data[name] then
        player_data[name].last_seen = os.date("%Y-%m-%d %H:%M:%S")
        player_data[name].is_online = false
        player_data[name].play_time = minetest.get_gametime() - player_data[name].join_time
    end
end

-- Enregistrement des callbacks pour les événements de connexion et déconnexion
minetest.register_on_joinplayer(on_player_join)
minetest.register_on_leaveplayer(on_player_leave)

-- Fonction pour afficher les informations du joueur
local function lookup_player(name)
    local data = player_data[name]
    if data then
        local status = data.is_online and "Connecté" or "Déconnecté"
        local play_time = data.play_time and string.format("%.2f secondes", data.play_time) or "N/A"
        local info = "Informations sur le joueur " .. name .. ":\n"
        info = info .. "  - Nom: " .. name .. "\n"
        info = info .. "  - Statut: " .. status .. "\n"
        info = info .. "  - Dernière connexion: " .. data.last_seen .. "\n"
        info = info .. "  - Temps de jeu: " .. play_time .. "\n"
        -- Ajoute d'autres informations ici si nécessaire

        return info
    else
        return "Le joueur " .. name .. " n'existe pas ou n'a pas encore joué."
    end
end

-- Enregistrement de la commande
minetest.register_chatcommand("lookup", {
    description = "Affiche des informations sur le joueur spécifié",
    params = "<playername>",
    privs = {admin = true},
    func = function(name, param)
        local player_name = param:trim()
        if player_name == "" then
            return false, "Veuillez spécifier le nom du joueur."
        end

        local info = lookup_player(player_name)
        minetest.chat_send_player(name, info)
        return true
    end,
})

-- Affichage d'un message lors du chargement du mod
minetest.log("action", "[imstaff] Mod chargé avec succès.")

