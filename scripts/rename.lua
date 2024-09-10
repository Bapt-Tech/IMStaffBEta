local valid_colors = {
    "white", "black", "red", "green", "blue", "cyan", "magenta", "yellow",
    "orange", "violet", "brown", "pink", "dark_green", "grey", "dark_grey", "dodgerblue"
}

-- Fonction pour vérifier si la couleur est valide
local function is_valid_color(color)
    for _, c in ipairs(valid_colors) do
        if c == color then
            return true
        end
    end
    return false
end

-- Déclare la commande /rename <color> <name>
minetest.register_chatcommand("rename", {
    params = "<color> <name>",
    privs = {admin = true},
    description = "Rename and change the color of an item in your hand",
    func = function(name, param)
        -- Sépare le paramètre en deux parties : la couleur et le nom
        local color, new_name = string.match(param, "([^ ]+) (.+)")
        if not color or not new_name then
            return false, "Use : /rename <color> <name>"
        end

        -- Vérifie si la couleur est valide
        if not is_valid_color(color) then
            return false, "Invalid color. Colors available: " .. table.concat(valid_colors, ", ")
        end

        -- Récupère l'objet que le joueur tient dans la main
        local player = minetest.get_player_by_name(name)
        local itemstack = player:get_wielded_item()

        -- Vérifie si le joueur tient quelque chose
        if itemstack:is_empty() then
            return false, "You don't have an item in your hand."
        end

        -- Récupère le méta des données de l'item pour modifier son nom
        local meta = itemstack:get_meta()
        meta:set_string("description", minetest.colorize(color, new_name))

        -- Met à jour l'objet dans l'inventaire du joueur
        player:set_wielded_item(itemstack)
        return true, "Item renamed to '" .. new_name .. "' with the color '" .. color .. "'."
    end
})
