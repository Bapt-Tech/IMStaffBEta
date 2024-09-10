-- Register the /textbox chat command
minetest.register_chatcommand("textbox", {
    params = "<playername> <text>",
    description = "Show a textbox with the given text to the specified player",
    privs = {admin = true},
    func = function(name, param)
        local target_name, text = param:match("^(%S+)%s+(.+)$")
        if not target_name or not text then
            return false, "Usage: /textbox <playername> <text>"
        end

        local target_player = minetest.get_player_by_name(target_name)
        if not target_player then
            return false, "Player not found."
        end

        -- Show a formspec (popup) to the target player
        local formspec = "formspec_version[4]" ..
                         "size[6,4]" ..
                         "label[0.5,0.5;" .. minetest.formspec_escape(text) .. "]" ..
                         "button_exit[2,3;2,1;exit;Close]"

        minetest.show_formspec(target_name, "imstaff:textbox_popup", formspec)

        -- Callback when the player closes the formspec
        minetest.register_on_player_receive_fields(function(player, formname, fields)
            if formname == "imstaff:textbox_popup" then
                if player:get_player_name() == target_name then
                    minetest.chat_send_player(name, "Player " .. target_name .. " has closed the popup.")
                end
            end
        end)

        return true, "Textbox sent to " .. target_name .. "."
    end,
})
