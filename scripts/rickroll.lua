-- Commande /rickastley pour envoyer un Rickroll en message privé
minetest.register_chatcommand("rickastley", {
    params = "",
    description = "Rickroll yourself!",
    func = function(name)
        -- Le message de Rickroll en plusieurs lignes
        local rickroll_message = 
            "🎵 Never gonna give you up, \n" ..
            "Never gonna let you down, \n" ..
            "Never gonna run around and desert you! 🎵"

        -- Envoie le message uniquement au joueur qui a utilisé la commande
        minetest.chat_send_player(name, minetest.colorize("#FF69B4", "[Rick Astley] ") .. rickroll_message)
        
        -- Retourne un message de confirmation au joueur
        return true, "You've successfully Rickrolled yourself!"
    end,
})

