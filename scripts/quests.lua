local quests = {}
local quest_timers = {}
local global_quests = {}  -- Nouvelle table pour stocker toutes les quêtes globales
local QUEST_DURATION = 24 * 60 * 60 -- 24 heures en secondes

-- Fonction pour initialiser les quêtes pour un joueur spécifique
local function init_quest(player_name, quest_text, item_to_get, amount, reward_item, reward_amount)
    quests[player_name] = quests[player_name] or {}
    table.insert(quests[player_name], {
        text = quest_text,
        item_to_get = item_to_get,
        amount = amount,
        reward_item = reward_item,
        reward_amount = reward_amount,
        progress = 0,
        completed = false
    })
    -- Mettre à jour le timer de la quête
    quest_timers[player_name] = os.time() + QUEST_DURATION
end

-- Fonction pour initialiser une quête pour tous les joueurs
local function init_quest_for_all(quest_text, item_to_get, amount, reward_item, reward_amount)
    -- Stocker la quête dans la table globale
    table.insert(global_quests, {
        text = quest_text,
        item_to_get = item_to_get,
        amount = amount,
        reward_item = reward_item,
        reward_amount = reward_amount
    })

    -- Attribuer la quête à tous les joueurs actuellement connectés
    for _, player in ipairs(minetest.get_connected_players()) do
        local player_name = player:get_player_name()
        init_quest(player_name, quest_text, item_to_get, amount, reward_item, reward_amount)
    end
end

-- Fonction pour vérifier et mettre à jour la progression de la quête
local function update_quest(player_name, item_name, count)
    local player_quests = quests[player_name]
    if not player_quests then return end

    for _, quest in ipairs(player_quests) do
        if not quest.completed and quest.item_to_get == item_name then
            quest.progress = quest.progress + count
            if quest.progress >= quest.amount then
                quest.completed = true
                minetest.chat_send_player(player_name, "Quest completed: " .. quest.text)
                -- Donne la récompense au joueur
                minetest.chat_send_player(player_name, "You have received " .. quest.reward_amount .. " " .. quest.reward_item)
                minetest.add_item(minetest.get_player_by_name(player_name):get_pos(), quest.reward_item .. " " .. quest.reward_amount)
            else
                minetest.chat_send_player(player_name, "Quest progress: " .. quest.progress .. "/" .. quest.amount)
            end
        end
    end
end

-- Fonction pour réinitialiser les quêtes après 24 heures
local function reset_quests(player_name)
    local end_time = quest_timers[player_name]
    if end_time and os.time() > end_time then
        quests[player_name] = {}
        minetest.chat_send_player(player_name, "All your quests have been reset after 24 hours.")
        quest_timers[player_name] = os.time() + QUEST_DURATION -- Réinitialiser le timer
    end
end

-- Fonction pour attribuer les quêtes globales à un joueur lors de sa connexion
local function assign_global_quests_to_player(player_name)
    for _, quest in ipairs(global_quests) do
        init_quest(player_name, quest.text, quest.item_to_get, quest.amount, quest.reward_item, quest.reward_amount)
    end
end

-- Événement lorsque le joueur se connecte
minetest.register_on_joinplayer(function(player)
    local player_name = player:get_player_name()
    reset_quests(player_name)
    assign_global_quests_to_player(player_name) -- Attribuer les quêtes globales au joueur qui se connecte
    minetest.chat_send_player(player_name, "Welcome back, " .. player_name .. "! Check your quests with /quests.")
end)

-- Événement lorsque le joueur obtient un item
minetest.register_on_craft(function(itemstack, player, old_craft_grid, craft_inv)
    local player_name = player:get_player_name()
    local item_name = itemstack:get_name()
    local count = itemstack:get_count()
    update_quest(player_name, item_name, count)
end)

-- Commande pour créer une quête
minetest.register_chatcommand("createquest", {
    params = "<text> <item_to_get> <amount> <reward_item> <reward_amount>",
    description = "Create a new quest",
    privs = {admin=true},
    func = function(name, param)
        local text, item_to_get, amount, reward_item, reward_amount = param:match("^(%S+) (%S+) (%d+) (%S+) (%d+)$")
        if not (text and item_to_get and amount and reward_item and reward_amount) then
            return false, "Invalid parameters. Usage: /createquest <text> <item_to_get> <amount> <reward_item> <reward_amount>"
        end
        amount = tonumber(amount)
        reward_amount = tonumber(reward_amount)

        -- Initialiser la quête pour tous les joueurs
        init_quest_for_all(text, item_to_get, amount, reward_item, reward_amount)

        return true, "Quest created and assigned to all players successfully."
    end,
})

-- Commande pour vérifier les quêtes en cours
minetest.register_chatcommand("quests", {
    description = "Show your current quests",
    func = function(name)
        local player_quests = quests[name]
        if not player_quests or #player_quests == 0 then
            return false, "You have no quests."
        end
        local msg = "Your quests:\n"
        for _, quest in ipairs(player_quests) do
            msg = msg .. quest.text .. " - Progress: " .. quest.progress .. "/" .. quest.amount .. "\n"
        end
        return true, msg
    end,
})

