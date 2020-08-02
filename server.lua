RegisterNetEvent("tweet")
AddEventHandler("tweet", function(nameMsg)
    print("tweet | "..nameMsg) -- logs to console the handle and message
    TriggerClientEvent("chat:addMessage", -1, {
        color = {66, 206, 245}, -- color light blue
        multiline = true,
        args = {"[Tweet] ".. nameMsg} -- add prefix, handle, and message into message
    }) 
end)