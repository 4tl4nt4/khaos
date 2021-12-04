superJump = false

FiveX.CreateXui("https://github.com/4tl4nt4/khaos", 250, 250)

FiveX.OnXuiMessage(function(message)
  message = json.decode(message)
  if(message.superJump ~= nil) then
    print("Super jump new value: ", message.superJump)
    superJump = message.superJump
  end
end)

-- Super jump executor thread
Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0)
    if superJump then
      SetSuperJumpThisFrame(PlayerId(-1))
    end
  end
end)

-- Send random string thread

local charset = {}

-- qwertyuiopasdfghjklzxcvbnmQWERTYUIOPASDFGHJKLZXCVBNM1234567890
for i = 48,  57 do table.insert(charset, string.char(i)) end
for i = 65,  90 do table.insert(charset, string.char(i)) end
for i = 97, 122 do table.insert(charset, string.char(i)) end

function string.random(length)
  math.randomseed(GetGameTimer())

  if length > 0 then
    return string.random(length - 1) .. charset[math.random(1, #charset)]
  else
    return ""
  end
end

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(2000)
    FiveX.SendXuiMessage(json.encode( {
      randomMsg = string.random(10)
    }))
  end
end)
