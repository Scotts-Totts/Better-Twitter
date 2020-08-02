--defining arrays and variables to use 
combination = {"0:this stall is occupied"} -- stores ID and Twitter handle match, values separated by a :
local playerID = GetPlayerServerId(PlayerId(-1))
local handle = " "
local message = ""
local cont = true
local comboSize = #combination

RegisterCommand("atwt", function(source,args) -- anonymous tweet using alternate handle
    comboSize = #combination --update comboSize for each command activation
    if string.sub(tostring(args[1]), 0, 1)=="@" then --check for @ in args[1] to use as handle 
        handle = args[1]
        table.remove(args, 1)
    else -- no handle provided
        if comboSize == 1 then 
            handle = "@"..twitterHandles[getRandHandle()]
            table.insert(combination, 2, playerID..":"..handle)
        else 
            for i=1, comboSize, 1 do
                local index = string.find(combination[i],":")
                if tonumber(string.sub(combination[i], 0, index-1))==playerID then --if ID in combination array equals playerID then set handle to second half of combination index (as separated by the :)
                    handle = string.sub(combination[i], index+1)
                    cont = false -- cont = false signifies that no new name needs to be generated
                    break
                end
            end
            if cont then -- if cont true then generate new handle and assign it into combination array
                handle = "@"..twitterHandles[getRandHandle()]
                table.insert(combination, comboSize+1, playerID..":"..handle)
            else -- concat @ symbol infront of handle
                handle = "@"..handle
            end
        end
    end
    message = handle .. "^0: "..table.concat(args," ")
    TriggerServerEvent("tweet", message)
end)

RegisterCommand("sethandle", function(source,args) -- set twitter handle for atwt
    local acont=true
    comboSize = #combination --update comboSize for each command activation
    if args[1] == nil then
        notify("~r~Improper usage, you must provide a single username, with no spaces.")
    elseif args[2] then
        notify("~r~Improper usage, you must provide a single username, with no spaces.")
    else
        for i=1, comboSize, 1 do
            local index = string.find(combination[i],":")
            if tonumber(string.sub(combination[i], 0, index-1))==playerID then --if ID in combination array equals playerID then set handle to second half of combination index (as separated by the :)
                combination[i] = string.sub(combination[i], 0, index-1)..":"..table.concat(args," ")
                handle = string.sub(combination[i], index+1)
                acont = false -- acont = false signifies that player not already in table with different username
                break
            end
        end
        if acont then -- if cont true then insert handle at end of table combination
            handle = table.concat(args," ")
            table.insert(combination, comboSize+1, playerID..":"..handle)
        end
        notify("~g~A new Twitter handle has been set!")
    end
end)

RegisterCommand("twt", function(source, args) --normal tweet using player name as handle
    TriggerServerEvent("tweet", "@"..GetPlayerName(source).."^0: "..table.concat(args," "))
end)