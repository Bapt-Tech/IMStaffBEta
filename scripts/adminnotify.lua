-- imstaff/adminnotify.lua

-- Liste des mots-clés à surveiller
local keywords = {
    -- Anglais
    "asshole", "bastard", "bitch", "crap", "cunt", "dick", "douchebag", 
    "fuck", "motherfucker", "nigga", "shit", "slut", "tits", "twat", "wanker",
    -- Français
    "abruti", "connard", "conne", "couillon", "dégueulasse", "enfoiré", 
    "putain", "salope", "salaud", "tête de con", "va te faire foutre",
    -- Espagnol
    "cabrón", "culo", "estúpido", "hijo de puta", "mamón", "mierda", 
    "pendejo", "puto", "puta", "zorro",
    -- Russe (translittéré)
    "mudak", "pidoras", "suka", "kher", "khui", "yob tvoyu mat", "idiot", "urod",
    -- Mots "limites"
    "jerk", "stupid", "dumb", "idiot", "moron", "fool", "loser", "crazy", "mad",
}

-- Fonction pour normaliser le texte en enlevant les accents et en mettant en minuscule
local function normalize_text(text)
    -- Convertir en minuscule
    text = text:lower()
    -- Enlever les accents
    text = text:gsub("[àáâãäå]", "a")
    text = text:gsub("[èéêë]", "e")
    text = text:gsub("[ìíîï]", "i")
    text = text:gsub("[òóôõö]", "o")
    text = text:gsub("[ùúûü]", "u")
    text = text:gsub("[ç]", "c")
    return text
end

-- Fonction pour calculer la distance de Levenshtein
local function levenshtein(a, b)
    local m = #a
    local n = #b
    local d = {}
    
    for i = 0, m do
        d[i] = {}
        d[i][0] = i
    end
    
    for j = 0, n do
        d[0][j] = j
    end
    
    for i = 1, m do
        for j = 1, n do
            local cost = (a:sub(i, i) == b:sub(j, j)) and 0 or 1
            d[i][j] = math.min(
                d[i-1][j] + 1,
                d[i][j-1] + 1,
                d[i-1][j-1] + cost
            )
        end
    end
    
    return d[m][n]
end

-- Fonction pour vérifier si un message contient un mot-clé ou un mot similaire
local function contains_keyword(message)
    local normalized_message = normalize_text(message)
    for _, keyword in ipairs(keywords) do
        local normalized_keyword = normalize_text(keyword)
        if normalized_message:find(normalized_keyword, 1, true) then
            return true
        end
        -- Vérification pour des mots similaires (distance de Levenshtein)
        local similarity_threshold = 3 -- Ajuste ce seuil en fonction des besoins
        if levenshtein(normalized_message, normalized_keyword) <= similarity_threshold then
            return true
        end
    end
    return false
end

-- Fonction pour obtenir l'heure actuelle en UTC
local function get_current_utc_time()
    return os.date("!%Y-%m-%d %H:%M:%S UTC")
end

-- Fonction pour vérifier si un joueur a le privilège "admin"
local function is_admin(player_name)
    return minetest.get_player_privs(player_name).admin
end

-- Fonction pour envoyer un message aux admins
local function notify_admins(name, message)
    local timestamp = get_current_utc_time()
    -- Le texte "Admin Notify" en rouge
    local red_text = minetest.colorize("#FF0000", "[Bad Word]")
    local notification = string.format(
        "%s Player: %s | Message: \"%s\" | Date and Hour : %s",
        red_text, name, message, timestamp
    )
    for _, player in ipairs(minetest.get_connected_players()) do
        local admin_name = player:get_player_name()
        if is_admin(admin_name) then
            minetest.chat_send_player(admin_name, notification)
        end
    end
end

-- Callback pour écouter les messages dans le chat
minetest.register_on_chat_message(function(name, message)
    if contains_keyword(message) then
        notify_admins(name, message)
    end
end)

