local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/NgHuyZzZ/lol/main/MM2Library.txt"))()
library.rank = "developer"
local Wm = library:Watermark("" .. library:GetUsername() .. "")
local FpsWm = Wm:AddWatermark("fps: " .. library.fps)
coroutine.wrap(function()
    while wait(.75) do
        FpsWm:Text("fps: " .. library.fps)
    end
end)()
library:Introduction()
wait(0)
loadstring(game:HttpGet(("https://raw.githubusercontent.com/REDzHUB/LibraryV2/main/redzLib")))()
MakeWindow({
  Hub = {
    Title = "FREE FIRE | HUB",
    Animation = "By Duc Designer"
  },
  Key = {
    KeySystem = false,
    Title = "Key System",
    Description = "",
    KeyLink = "",
    Keys = {"1234"},
    Notifi = {
      Notifications = true,
      CorrectKey = "Running the Script...",
      Incorrectkey = "The key is incorrect",
      CopyKeyLink = "Copied to Clipboard"
    }
  }
})


MinimizeButton({
  Image = "",
  Size = {40, 40},
  Color = Color3.fromRGB(10, 10, 10),
  Corner = true,
  Stroke = false,
  StrokeColor = Color3.fromRGB(255, 0, 0)
})

local Main = MakeTab({Name = "Main"})

local section = AddSection(Main, {"Kill"})


local Part = Instance.new("Part", workspace)
Part.Name = "Running Part"
Part.Position = Vector3.new(0, 1000, 0)
Part.Anchored = true
Part.CanCollide = true
Part.Size = Vector3.new(5, 1, 5)

local Plr = game:GetService("Players").LocalPlayer

local vim = game:GetService("VirtualInputManager")

function GetMurderer()
 for i, v in game:GetService("Players"):GetChildren() do
  if v.Backpack:FindFirstChild"Knife" or v.Character and v.Character:FindFirstChild("Knife") then return v.Character end
 end
 return nil
end

AddButton(Main, {
  Name = "Giết tất cả(Dành cho murder)",
  Callback = function()
    for i, v in game:GetService("Players"):GetChildren() do
  if Plr.Backpack:FindFirstChild("Knife") then Plr.Backpack.Knife.Parent = Plr.Character end
   Plr.Character.HumanoidRootPart.CFrame = v.Character.HumanoidRootPart.CFrame
   vim:SendMouseButtonEvent(0,0,0,true,game,false,0)
   task.wait()
   vim:SendMouseButtonEvent(0,0,0,false,game,false,0)
   task.wait(.75)
  end
  end
})

AddButton(Main, {
  Name = "Fling tất cả",
  Callback = function()
local Targets = {"All"} -- "All", "Target Name", "arian_was_here"

local Players = game:GetService("Players")
local Player = Players.LocalPlayer

local AllBool = false

local GetPlayer = function(Name)
    Name = Name:lower()
    if Name == "all" or Name == "others" then
        AllBool = true
        return
    elseif Name == "random" then
        local GetPlayers = Players:GetPlayers()
        if table.find(GetPlayers,Player) then table.remove(GetPlayers,table.find(GetPlayers,Player)) end
        return GetPlayers[math.random(#GetPlayers)]
    elseif Name ~= "random" and Name ~= "all" and Name ~= "others" then
        for _,x in next, Players:GetPlayers() do
            if x ~= Player then
                if x.Name:lower():match("^"..Name) then
                    return x;
                elseif x.DisplayName:lower():match("^"..Name) then
                    return x;
                end
            end
        end
    else
        return
    end
end

local Message = function(_Title, _Text, Time)
    game:GetService("StarterGui"):SetCore("SendNotification", {Title = _Title, Text = _Text, Duration = Time})
end

local SkidFling = function(TargetPlayer)
    local Character = Player.Character
    local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")
    local RootPart = Humanoid and Humanoid.RootPart

    local TCharacter = TargetPlayer.Character
    local THumanoid
    local TRootPart
    local THead
    local Accessory
    local Handle

    if TCharacter:FindFirstChildOfClass("Humanoid") then
        THumanoid = TCharacter:FindFirstChildOfClass("Humanoid")
    end
    if THumanoid and THumanoid.RootPart then
        TRootPart = THumanoid.RootPart
    end
    if TCharacter:FindFirstChild("Head") then
        THead = TCharacter.Head
    end
    if TCharacter:FindFirstChildOfClass("Accessory") then
        Accessory = TCharacter:FindFirstChildOfClass("Accessory")
    end
    if Accessoy and Accessory:FindFirstChild("Handle") then
        Handle = Accessory.Handle
    end

    if Character and Humanoid and RootPart then
        if RootPart.Velocity.Magnitude < 50 then
            getgenv().OldPos = RootPart.CFrame
        end
        if THumanoid and THumanoid.Sit and not AllBool then
            return Message("Error Occurred", "Targeting is sitting", 5) -- u can remove dis part if u want lol
        end
        if THead then
            workspace.CurrentCamera.CameraSubject = THead
        elseif not THead and Handle then
            workspace.CurrentCamera.CameraSubject = Handle
        elseif THumanoid and TRootPart then
            workspace.CurrentCamera.CameraSubject = THumanoid
        end
        if not TCharacter:FindFirstChildWhichIsA("BasePart") then
            return
        end
        
        local FPos = function(BasePart, Pos, Ang)
            RootPart.CFrame = CFrame.new(BasePart.Position) * Pos * Ang
            Character:SetPrimaryPartCFrame(CFrame.new(BasePart.Position) * Pos * Ang)
            RootPart.Velocity = Vector3.new(9e7, 9e7 * 10, 9e7)
            RootPart.RotVelocity = Vector3.new(9e8, 9e8, 9e8)
        end
        
        local SFBasePart = function(BasePart)
            local TimeToWait = 2
            local Time = tick()
            local Angle = 0

            repeat
                if RootPart and THumanoid then
                    if BasePart.Velocity.Magnitude < 50 then
                        Angle = Angle + 100

                        FPos(BasePart, CFrame.new(0, 1.5, 0) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle),0 ,0))
                        task.wait()

                        FPos(BasePart, CFrame.new(0, -1.5, 0) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle), 0, 0))
                        task.wait()

                        FPos(BasePart, CFrame.new(2.25, 1.5, -2.25) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle), 0, 0))
                        task.wait()

                        FPos(BasePart, CFrame.new(-2.25, -1.5, 2.25) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle), 0, 0))
                        task.wait()

                        FPos(BasePart, CFrame.new(0, 1.5, 0) + THumanoid.MoveDirection,CFrame.Angles(math.rad(Angle), 0, 0))
                        task.wait()

                        FPos(BasePart, CFrame.new(0, -1.5, 0) + THumanoid.MoveDirection,CFrame.Angles(math.rad(Angle), 0, 0))
                        task.wait()
                    else
                        FPos(BasePart, CFrame.new(0, 1.5, THumanoid.WalkSpeed), CFrame.Angles(math.rad(90), 0, 0))
                        task.wait()

                        FPos(BasePart, CFrame.new(0, -1.5, -THumanoid.WalkSpeed), CFrame.Angles(0, 0, 0))
                        task.wait()

                        FPos(BasePart, CFrame.new(0, 1.5, THumanoid.WalkSpeed), CFrame.Angles(math.rad(90), 0, 0))
                        task.wait()
                        
                        FPos(BasePart, CFrame.new(0, 1.5, TRootPart.Velocity.Magnitude / 1.25), CFrame.Angles(math.rad(90), 0, 0))
                        task.wait()

                        FPos(BasePart, CFrame.new(0, -1.5, -TRootPart.Velocity.Magnitude / 1.25), CFrame.Angles(0, 0, 0))
                        task.wait()

                        FPos(BasePart, CFrame.new(0, 1.5, TRootPart.Velocity.Magnitude / 1.25), CFrame.Angles(math.rad(90), 0, 0))
                        task.wait()

                        FPos(BasePart, CFrame.new(0, -1.5, 0), CFrame.Angles(math.rad(90), 0, 0))
                        task.wait()

                        FPos(BasePart, CFrame.new(0, -1.5, 0), CFrame.Angles(0, 0, 0))
                        task.wait()

                        FPos(BasePart, CFrame.new(0, -1.5 ,0), CFrame.Angles(math.rad(-90), 0, 0))
                        task.wait()

                        FPos(BasePart, CFrame.new(0, -1.5, 0), CFrame.Angles(0, 0, 0))
                        task.wait()
                    end
                else
                    break
                end
            until BasePart.Velocity.Magnitude > 500 or BasePart.Parent ~= TargetPlayer.Character or TargetPlayer.Parent ~= Players or not TargetPlayer.Character == TCharacter or THumanoid.Sit or Humanoid.Health <= 0 or tick() > Time + TimeToWait
        end
        
        workspace.FallenPartsDestroyHeight = 0/0
        
        local BV = Instance.new("BodyVelocity")
        BV.Name = "EpixVel"
        BV.Parent = RootPart
        BV.Velocity = Vector3.new(9e8, 9e8, 9e8)
        BV.MaxForce = Vector3.new(1/0, 1/0, 1/0)
        
        Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, false)
        
        if TRootPart and THead then
            if (TRootPart.CFrame.p - THead.CFrame.p).Magnitude > 5 then
                SFBasePart(THead)
            else
                SFBasePart(TRootPart)
            end
        elseif TRootPart and not THead then
            SFBasePart(TRootPart)
        elseif not TRootPart and THead then
            SFBasePart(THead)
        elseif not TRootPart and not THead and Accessory and Handle then
            SFBasePart(Handle)
        else
            return Message("Error Occurred", "Target is missing everything", 5)
        end
        
        BV:Destroy()
        Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, true)
        workspace.CurrentCamera.CameraSubject = Humanoid
        
        repeat
            RootPart.CFrame = getgenv().OldPos * CFrame.new(0, .5, 0)
            Character:SetPrimaryPartCFrame(getgenv().OldPos * CFrame.new(0, .5, 0))
            Humanoid:ChangeState("GettingUp")
            table.foreach(Character:GetChildren(), function(_, x)
                if x:IsA("BasePart") then
                    x.Velocity, x.RotVelocity = Vector3.new(), Vector3.new()
                end
            end)
            task.wait()
        until (RootPart.Position - getgenv().OldPos.p).Magnitude < 25
        workspace.FallenPartsDestroyHeight = getgenv().FPDH
    else
        return Message("Error Occurred", "Random error", 5)
    end
end

if not Welcome then Message("Success ez", "Enjoy!", 5) end
getgenv().Welcome = true
if Targets[1] then for _,x in next, Targets do GetPlayer(x) end else return end

if AllBool then
    for _,x in next, Players:GetPlayers() do
        SkidFling(x)
    end
end

for _,x in next, Targets do
    if GetPlayer(x) and GetPlayer(x) ~= Player then
        if GetPlayer(x).UserId ~= 1414978355 then
            local TPlayer = GetPlayer(x)
            if TPlayer then
                SkidFling(TPlayer)
            end
        else
            Message("Error Occurred", "This user is whitelisted! (Owner)", 5)
        end
    elseif not GetPlayer(x) and not AllBool then
        Message("Error Occurred", "Username Invalid", 5)
    end
end
 end
})

local section = AddSection(Main, {"🤨 Note antireport player"})


AddButton(Main, {
  Name = "Teleport to lobby",
  Callback = function()
    Plr.Character.HumanoidRootPart.CFrame = workspace.Lobby.Spawns.Spawn.CFrame
  end
})




AddButton(Main, {
  Name = "Nhặt súng AK-47",
  Callback = function()
    Plr.Character.HumanoidRootPart.CFrame = workspace.GunDrop.CFrame
  end
})


local section = AddSection(Main, {"Fun"})

AddToggle(Main, {
  Name = "Tự động trốn murder",
  Callback = function(state)
AE = state
 end
})



AddToggle(Main, {
  Name = "Auto bắn vỡ đầu murder",
  Callback = function(state)
ASM = state
 end
})

AddToggle(Main, {
  Name = "Tự động bắn",
  Callback = function(state)
ASM = state
 end
})


AddToggle(Main, {
  Name = "Tự động nhặt súng",
  Callback = function(state)
ATG = state
 end
})



workspace.ChildAdded:Connect(function(child)
task.delay(.25, function()
if child.Name == "GunDrop" and ATG then
local c = Plr.Character.HumanoidRootPart.CFrame
Plr.Character.HumanoidRootPart.CFrame = child.CFrame
Plr.Character.HumanoidRootPart.CFrame = c
end
end)
end)
function MurdererLoop()
 if ASM and Plr.Character and GetMurderer() and Plr.Character:FindFirstChild("Gun") or Plr.Backpack:FindFirstChild("Gun") then
  if Plr.Backpack:FindFirstChild("Gun") then Plr.Backpack.Gun.Parent = Plr.Character end
  local Murd = GetMurderer()
  Plr.Character.HumanoidRootPart.CFrame = Murd.HumanoidRootPart.CFrame + Vector3.new(11, 0, 0)
  Plr.Character.Gun.KnifeServer.ShootGun:InvokeServer(1, Murd.HumanoidRootPart.Position, "AH")
 end
 task.wait(.5)
end
function SecondLoop()
 if GetMurderer() == Plr.Character or GetMurderer() == nil or not AE then return end
 if (GetMurderer().HumanoidRootPart.Position-Plr.Character.HumanoidRootPart.Position).magnitude < 11 then
  Plr.Character.HumanoidRootPart.CFrame = Part.CFrame + Vector3.new(0, 3, 0)
 end
end




getgenv().God = false
AddToggle(Main, {
  Name = "Bất tử",
  Callback = function(value)
getgenv().God = value
if getgenv().God == true then
while getgenv().God == true do
wait()
game:GetService("Players").LocalPlayer.Character.Humanoid.Health = 100
end
end
 end
})

getgenv().Autofarm = false
AddToggle(Main, {
  Name = "Tự động thắng",
  Callback = function(value)
getgenv().Autofarm = value
 
if getgenv().Autofarm == true then
while getgenv().Autofarm == true do
wait()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(0, 14, 0)
end
end
 end
})



local Main = MakeTab({Name = "Visual"})

local section = AddSection(Main, {"Player"})



AddToggle(Main, {
  Name = "No clip",
  Callback = function(s)
getgenv().Noclip = s
    game:GetService("RunService").Heartbeat:Connect(function()
        if Noclip == true then
            game:GetService("RunService").Stepped:wait()
            game.Players.LocalPlayer.Character.Head.CanCollide = false
            game.Players.LocalPlayer.Character.Torso.CanCollide = false
        end
    end)
 end
})

 
AddToggle(Main, {
  Name = "Nhảy vô hạn",
  Callback = function(s)
getgenv().InfJ = s
    game:GetService("UserInputService").JumpRequest:connect(function()
        if InfJ == true then
            game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass'Humanoid':ChangeState("Jumping")
        end
    end)
 end
})


local section = AddSection(Main, {"Aim"})



AddToggle(Main, {
  Name = "Aim súng",
  Callback = function(s)
local Players = game.Players
local LocalPlayer = Players.LocalPlayer
local GetPlayers = Players.GetPlayers
local Camera = workspace.CurrentCamera
local WTSP = Camera.WorldToScreenPoint
local FindFirstChild = game.FindFirstChild
local Vector2_new = Vector2.new
local Mouse = LocalPlayer.GetMouse(LocalPlayer)
function ClosestChar()
    local Max, Close = math.huge
    for I,V in pairs(GetPlayers(Players)) do
        if V ~= LocalPlayer and V.Team ~= LocalPlayer.Team and V.Character then
            local Head = FindFirstChild(V.Character, "Head")
            if Head then
                local Pos, OnScreen = WTSP(Camera, Head.Position)
                if OnScreen then
                    local Dist = (Vector2_new(Pos.X, Pos.Y) - Vector2_new(Mouse.X, Mouse.Y)).Magnitude
                    if Dist < Max then
                        Max = Dist
                        Close = V.Character
                    end
                end
            end
        end
    end
    return Close
end

local MT = getrawmetatable(game)
local __namecall = MT.__namecall
setreadonly(MT, false)
MT.__namecall = newcclosure(function(self, ...)
    local Method = getnamecallmethod()
    if Method == "FindPartOnRay" and not checkcaller() and tostring(getfenv(0).script) == "GunInterface" then
        local Character = ClosestChar()
        if Character then
            return Character.Head, Character.Head.Position
        end
    end

    return __namecall(self, ...)
end)
setreadonly(MT, true)
 end
})



AddToggle(Main, {
  Name = "Aim dao",
  Callback = function(s)
local Players = game.Players
local LocalPlayer = Players.LocalPlayer
local GetPlayers = Players.GetPlayers
local Camera = workspace.CurrentCamera
local WTSP = Camera.WorldToScreenPoint
local FindFirstChild = game.FindFirstChild
local Vector2_new = Vector2.new
local Mouse = LocalPlayer.GetMouse(LocalPlayer)
function ClosestChar()
    local Max, Close = math.huge
    for I,V in pairs(GetPlayers(Players)) do
        if V ~= LocalPlayer and V.Team ~= LocalPlayer.Team and V.Character then
            local Head = FindFirstChild(V.Character, "Head")
            if Head then
                local Pos, OnScreen = WTSP(Camera, Head.Position)
                if OnScreen then
                    local Dist = (Vector2_new(Pos.X, Pos.Y) - Vector2_new(Mouse.X, Mouse.Y)).Magnitude
                    if Dist < Max then
                        Max = Dist
                        Close = V.Character
                    end
                end
            end
        end
    end
    return Close
end

local MT = getrawmetatable(game)
local __namecall = MT.__namecall
setreadonly(MT, false)
MT.__namecall = newcclosure(function(self, ...)
    local Method = getnamecallmethod()
    if Method == "FindPartOnRay" and not checkcaller() and tostring(getfenv(0).script) == "GunInterface" then
        local Character = ClosestChar()
        if Character then
            return Character.Head, Character.Head.Position
        end
    end

    return __namecall(self, ...)
end)
setreadonly(MT, true)
 end
})


AddButton(Main, {
  Name = "Hitbox",
  Callback = function()
function getplrsname()
for i,v in pairs(game:GetChildren()) do
if v.ClassName == "Players" then
return v.Name
end
end
end
local players = getplrsname()
local plr = game[players].LocalPlayer
coroutine.resume(coroutine.create(function()
while  wait(1) do
coroutine.resume(coroutine.create(function()
for _,v in pairs(game[players]:GetPlayers()) do
if v.Name ~= plr.Name and v.Character then
v.Character.LowerTorso.CanCollide = false
v.Character.LowerTorso.Material = "Neon"
v.Character.LowerTorso.Size = Vector3.new(5,5,5)
v.Character.HumanoidRootPart.Size = Vector3.new(5,5,5)
end
end
end))
end
end))
 end
})

AddButton(Main, {
  Name = "Súng cầu vòng",
  Callback = function(s)
local c = 1 function zigzag(X)  return math.acos(math.cos(X * math.pi)) / math.pi end game:GetService("RunService").RenderStepped:Connect(function()  if game.Workspace.Camera:FindFirstChild('Arms') then   for i,v in pairs(game.Workspace.Camera.Arms:GetDescendants()) do    if v.ClassName == 'MeshPart' then      v.Color = Color3.fromHSV(zigzag(c),1,1)     c = c + .0001    end   end  end end)
net = true 
notify = true
 end
})

AddButton(Main, {
  Name = "Lấy boombox",
  Callback = function(s)
_G.boomboxb = game:GetObjects('rbxassetid://740618400')[1]
_G.boomboxb.Parent = game:GetService'Players'.LocalPlayer.Backpack
loadstring(_G.boomboxb.Client.Source)() 
loadstring(_G.boomboxb.Server.Source)()
 end
})

AddButton(Main, {
  Name = "Skin giả",
  Callback = function(s)
local WeaponOwnRange = {
min=1,
max=5
}

local DataBase, PlayerData = getrenv()._G.Database, getrenv()._G.PlayerData

local newOwned = {}

for i,v in next, DataBase.Item do
newOwned[i] = math.random(WeaponOwnRange.min, WeaponOwnRange.max) -- newOwned[Weapon]: ItemCount
end

local PlayerWeapons = PlayerData.Weapons

game:GetService("RunService"):BindToRenderStep("InventoryUpdate", 0, function()
PlayerWeapons.Owned = newOwned
end)

game.Players.LocalPlayer.Character.Humanoid.Health = 0
end
})

local Main = MakeTab({Name = "Player"})

local Slider = AddSlider(Main, {
  Name = "Tốc độ",
  MinValue = 25,
  MaxValue = 300,
  Default = 0,
  Increase = 1,
  Callback = function(value)
    getgenv().Walkspeed = value
    pcall(function() game:GetService("Players").LocalPlayer.Character.Humanoid.WalkSpeed = value
    end)
  end
})


AddToggle(Main, {
  Name = "Loop tốc độ",
  Callback = function(state)
getgenv().loopW = state
    game:GetService("RunService").Heartbeat:Connect(function()
        if loopW == true then
            pcall(function()
                game:GetService("Players").LocalPlayer.Character.Humanoid.WalkSpeed = Walkspeed
            end)
        end
    end)
 end
})

local Slider = AddSlider(Main, {
  Name = "Nhảy",
  MinValue = 25,
  MaxValue = 300,
  Default = 0,
  Increase = 1,
  Callback = function(value)
    getgenv().Jumppower = value
    pcall(function()
        game:GetService("Players").LocalPlayer.Character.Humanoid.JumpPower = value
    end)
  end
})

AddToggle(Main, {
  Name = "Loop nhảy",
  Callback = function(state)
getgenv().loopJ = state
    game:GetService("RunService").Heartbeat:Connect(function()
        if loopJ == true then
            pcall(function()
                game:GetService("Players").LocalPlayer.Character.Humanoid.JumpPower = Jumppower
            end)
        end
    end)
 end
})



local Main = MakeTab({Name = "Esp"})


local section = AddSection(Main, {"Esp highlight"})



AddButton(Main, {
  Name = "Định vị murder",
  Callback = function()
loadstring(game:HttpGet('https://raw.githubusercontent.com/kelve123/Ken_Murder_Mystery_esp/main/Ken%20Murder%20Mystery%202%20Esp'))()
end
})

AddButton(Main, {
  Name = "Định vị tất cả",
  Callback = function()
local FillColor = Color3.fromRGB(65,255,0)
local DepthMode = "AlwaysOnTop"
local FillTransparency = 0.5
local OutlineColor = Color3.fromRGB(255,255,255)
local OutlineTransparency = 0

local CoreGui = game:FindService("CoreGui")
local Players = game:FindService("Players")
local lp = Players.LocalPlayer
local connections = {}

local Storage = Instance.new("Folder")
Storage.Parent = CoreGui
Storage.Name = "Highlight_Storage"

local function Highlight(plr)
    local Highlight = Instance.new("Highlight")
    Highlight.Name = plr.Name
    Highlight.FillColor = FillColor
    Highlight.DepthMode = DepthMode
    Highlight.FillTransparency = FillTransparency
    Highlight.OutlineColor = OutlineColor
    Highlight.OutlineTransparency = 0
    Highlight.Parent = Storage
    
    local plrchar = plr.Character
    if plrchar then
        Highlight.Adornee = plrchar
    end

    connections[plr] = plr.CharacterAdded:Connect(function(char)
        Highlight.Adornee = char
    end)
end

Players.PlayerAdded:Connect(Highlight)
for i,v in next, Players:GetPlayers() do
    Highlight(v)
end

Players.PlayerRemoving:Connect(function(plr)
    local plrname = plr.Name
    if Storage[plrname] then
        Storage[plrname]:Destroy()
    end
    if connections[plr] then
        connections[plr]:Disconnect()
    end
end)
end
})

local section = AddSection(Main, {"Esp người chơi"})

AddButton(Main, {
  Name = "Định vị hộp",
  Callback = function()
local Player = game:GetService("Players").LocalPlayer
local Camera = game:GetService("Workspace").CurrentCamera
local Mouse = Player:GetMouse()

local function DrawESP(plr)
    local Box = Drawing.new("Quad")
    Box.Visible = false
    Box.PointA = Vector2.new(0, 0)
    Box.PointB = Vector2.new(0, 0)
    Box.PointC = Vector2.new(0, 0)
    Box.PointD = Vector2.new(0, 0)
    Box.Color = Color3.fromRGB(255, 255, 255)
    Box.Thickness = 1
    Box.Transparency = 1

    local function Update()
        local c
        c = game:GetService("RunService").RenderStepped:Connect(function()
            if plr.Character ~= nil and plr.Character:FindFirstChildOfClass("Humanoid") ~= nil and plr.Character.PrimaryPart ~= nil and plr.Character:FindFirstChildOfClass("Humanoid").Health > 0 then
                local pos, vis = Camera:WorldToViewportPoint(plr.Character.PrimaryPart.Position)
                if vis then 
                    local points = {}
                    local c = 0
                    for _,v in pairs(plr.Character:GetChildren()) do
                        if v:IsA("BasePart") then
                            c = c + 1
                            local p, vis = Camera:WorldToViewportPoint(v.Position)
                            if v == plr.Character.PrimaryPart then
                                p, vis = Camera:WorldToViewportPoint((v.CFrame * CFrame.new(0, 0, -v.Size.Z)).p)
                            elseif v.Name == "Head" then
                                p, vis = Camera:WorldToViewportPoint((v.CFrame * CFrame.new(0, v.Size.Y/2, v.Size.Z/1.25)).p)
                            elseif string.match(v.Name, "Left") then
                                p, vis = Camera:WorldToViewportPoint((v.CFrame * CFrame.new(-v.Size.X/2, 0, 0)).p)
                            elseif string.match(v.Name, "Right") then
                                p, vis = Camera:WorldToViewportPoint((v.CFrame * CFrame.new(v.Size.X/2, 0, 0)).p)
                            end
                            points[c] = {p, vis}
                        end
                    end

                    local TopY = math.huge
                    local DownY = -math.huge
                    local LeftX = math.huge
                    local RightX = -math.huge

                    local Left
                    local Right
                    local Top
                    local Bottom

                    local closest = nil
                    for _,v in pairs(points) do
                        if v[2] == true then
                            local p = v[1]
                            if p.Y < TopY then
                                Top = p
                                TopY = p.Y
                            end
                            if p.Y > DownY then
                                Bottom = p
                                DownY = p.Y
                            end
                            if p.X > RightX then
                                Right = p
                                RightX = p.X
                            end
                            if p.X < LeftX then
                                Left = p
                                LeftX = p.X
                            end
                        end
                    end

                    if Left ~= nil and Right ~= nil and Top ~= nil and Bottom ~= nil then
                        Box.PointA = Vector2.new(Right.X, Top.Y)
                        Box.PointB = Vector2.new(Left.X, Top.Y)
                        Box.PointC = Vector2.new(Left.X, Bottom.Y)
                        Box.PointD = Vector2.new(Right.X, Bottom.Y)

                        Box.Visible = true
                    else 
                        Box.Visible = false
                    end
                else 
                    Box.Visible = false
                end
            else
                Box.Visible = false
                if game.Players:FindFirstChild(plr.Name) == nil then
                    c:Disconnect()
                end
            end
        end)
    end
    coroutine.wrap(Update)()
end

for _,v in pairs(game:GetService("Players"):GetChildren()) do
    if v.Name ~= Player.Name then 
        DrawESP(v)
    end
end

game:GetService("Players").PlayerAdded:Connect(function(v)
    DrawESP(v)
end)
end
})


AddButton(Main, {
  Name = "Định vị tên",
  Callback = function()
local c = workspace.CurrentCamera
local ps = game:GetService("Players")
local lp = ps.LocalPlayer
local rs = game:GetService("RunService")

local function esp(p,cr)
	local h = cr:WaitForChild("Humanoid")
	local hrp = cr:WaitForChild("Head")

	local text = Drawing.new("Text")
	text.Visible = false
	text.Center = true
	text.Outline = false 
	text.Font = 3
	text.Size = 16.16
	text.Color = Color3.new(170,170,170)

	local conection
	local conection2
	local conection3

	local function dc()
		text.Visible = false
		text:Remove()
		if conection then
			conection:Disconnect()
			conection = nil 
		end
		if conection2 then
			conection2:Disconnect()
			conection2 = nil 
		end
		if conection3 then
			conection3:Disconnect()
			conection3 = nil 
		end
	end

	conection2 = cr.AncestryChanged:Connect(function(_,parent)
		if not parent then
			dc()
		end
	end)

	conection3 = h.HealthChanged:Connect(function(v)
		if (v<=0) or (h:GetState() == Enum.HumanoidStateType.Dead) then
			dc()
		end
	end)

	conection = rs.RenderStepped:Connect(function()
		local hrp_pos,hrp_onscreen = c:WorldToViewportPoint(hrp.Position)
		if hrp_onscreen then
			text.Position = Vector2.new(hrp_pos.X, hrp_pos.Y - 27)
			text.Text = "[ "..p.Name.." ]"
			text.Visible = true
		else
			text.Visible = false
		end
	end)
end

local function p_added(p)
	if p.Character then
		esp(p,p.Character)
	end
	p.CharacterAdded:Connect(function(cr)
		esp(p,cr)
	end)
end

for i,p in next, ps:GetPlayers() do 
	if p ~= lp then
		p_added(p)
	end
end

ps.PlayerAdded:Connect(p_added)
 end
})

local Main = MakeTab({Name = "Misc"})

local section = AddSection(Main, {"Chat"})


function SpamChat()
			while autochat == true do
				local ohString1 = "NgHuy Hub On Top"
				local ohString2 = "All"	game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(ohString1, ohString2)
				wait(1)
			end
		end

AddToggle(Main, {
  Name = "Spam tin nhắn",
  Callback = function()
autochat = Value
				SpamChat()
 end
})


local section = AddSection(Main, {"Sever"})

AddButton(Main, {
  Name = "Thay server",
  Callback = function()
local Http = game:GetService("HttpService")
local TPS = game:GetService("TeleportService")
local Api = "https://games.roblox.com/v1/games/"
local _place = game.PlaceId
local _servers = Api.._place.."/servers/Public?sortOrder=Asc&limit=100"
function ListServers(cursor)
   local Raw = game:HttpGet(_servers .. ((cursor and "&cursor="..cursor) or ""))
   return Http:JSONDecode(Raw)
end
local Server, Next; repeat
   local Servers = ListServers(Next)
   Server = Servers.data[1]
   Next = Servers.nextPageCursor
until Server
TPS:TeleportToPlaceInstance(_place,Server.id,game.Players.LocalPlayer)
end
})


AddButton(Main, {
  Name = "Vào lại server",
  Callback = function()
local ts = game:GetService("TeleportService")
local p = game:GetService("Players").LocalPlayer
ts:Teleport(game.PlaceId, p)
end
})


local section = AddSection(Main, {"Fps"})

AddButton(Main, {
  Name = "Fps cap",
  Callback = function()
local ToDisable = {
	Textures = false,
	VisualEffects = true,
	Parts = true,
	Particles = true,
	Sky = true
}

local ToEnable = {
	FullBright = false
}

local Stuff = {}

for _, v in next, game:GetDescendants() do
	if ToDisable.Parts then
		if v:IsA("Part") or v:IsA("Union") or v:IsA("BasePart") then
			v.Material = Enum.Material.SmoothPlastic
			table.insert(Stuff, 1, v)
		end
	end
	
	if ToDisable.Particles then
		if v:IsA("ParticleEmitter") or v:IsA("Smoke") or v:IsA("Explosion") or v:IsA("Sparkles") or v:IsA("Fire") then
			v.Enabled = false
			table.insert(Stuff, 1, v)
		end
	end
	
	if ToDisable.VisualEffects then
		if v:IsA("BloomEffect") or v:IsA("BlurEffect") or v:IsA("DepthOfFieldEffect") or v:IsA("SunRaysEffect") then
			v.Enabled = false
			table.insert(Stuff, 1, v)
		end
	end
	
	if ToDisable.Textures then
		if v:IsA("Decal") or v:IsA("Texture") then
			v.Texture = ""
			table.insert(Stuff, 1, v)
		end
	end
	
	if ToDisable.Sky then
		if v:IsA("Sky") then
			v.Parent = nil
			table.insert(Stuff, 1, v)
		end
	end
end
end
})

local Main = MakeTab({Name = "Credits"})

local section = AddSection(Main, {"By Duc Designer"})

local section = AddSection(Main, {"Thích xem live sex của yaya0720"})

local section = AddSection(Main, {"YTB : Duc Share Link"})
