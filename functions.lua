function getRandHandle() -- get a random, unoccupied twitter handle index from twitterHandles.lua 
    local handleTableSize = #twitterHandles
    local rand = math.floor(math.random(0,handleTableSize))
    while true do 
        Citizen.Wait(1)
        for i=1, #combination, 1 do
            for j=1, #combination[i], 1 do 
                if string.sub(combination[i],j,j) == ":" then
                    if string.sub(combination[i],j+1) == twitterHandles[rand] then 
                        rand = math.floor(math.random(0,handleTableSize))
                    else 
                        return rand
                    end
                end 
            end
        end
    end
end

function notify(msg)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(msg)
    DrawNotification(true, false)
end

function clientMessage(msg)
    TriggerEvent("chat:addMessage", -1,msg)
end
