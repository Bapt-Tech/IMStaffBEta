local messages = {
    minetest.colorize("#00FF00", "ImperTip : Use the /p create clanname to create your own clan !"),
    minetest.colorize("#00FF00", "ImperTip : To sell items, take the item in your hand and type /sell <price> !"),
    minetest.colorize("#00FF00", "ImperTip : Make money by selling Diamonds in /market !"),
    minetest.colorize("#00FF00", "ImperTip : Check /shop to buy a lot of cool items !")
}

-- Variable pour suivre le dernier message envoyé
local message_index = 1
local message_timer = 0
local message_interval = 300 -- 300 secondes = 5 minutes

-- Fonction pour envoyer le message actuel
local function send_tip_message()
    minetest.chat_send_all(messages[message_index])
    -- Passer au message suivant
    message_index = message_index + 1
    if message_index > #messages then
        message_index = 1 -- Revenir au premier message
    end
end

-- Appeler la fonction à intervalles réguliers
minetest.register_globalstep(function(dtime)
    message_timer = message_timer + dtime
    if message_timer >= message_interval then
        send_tip_message()
        message_timer = 0 -- Réinitialiser le timer
    end
end)

