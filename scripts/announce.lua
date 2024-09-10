minetest.register_chatcommand("announce", {
    params = "<message>",
    description = "Make a global announcement",
    privs = {admin=true},
    func = function(name, message)
        if message and message ~= "" then
            -- Envoie le message avec la couleur rouge
            minetest.chat_send_all(minetest.colorize("#FF0000", "[Announcement] " .. message))
            return true, "Announcement sent"
        else
            return false, "Invalid message"
        end
    end,
})

