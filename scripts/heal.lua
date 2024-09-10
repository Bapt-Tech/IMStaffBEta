minetest.register_chatcommand("heal", {
    params = "<player>",
    description = "Heal a player",
    privs = {admin=true},
    func = function(name, param)
        local target = minetest.get_player_by_name(param)
        if target then
            target:set_hp(40)
            minetest.chat_send_player(param, "You have been healed by an admin")
            return true, param .. " has been healed"
        else
            return false, "Player not found"
        end
    end,
})
