-- settings

local speed = 20
local acceleration = 5
local maxspeed = 50
local curspeed = 20
local rotspeed = 0.5

local turned = 0

-- camera

local RS = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local camera = workspace.CurrentCamera

local moveLength = 0

wait()

camera.CameraType = Enum.CameraType.Scriptable

game:GetService("RunService").RenderStepped:Connect(function(dt)
    local MD = UIS:GetMouseDelta()
    
    if UIS:IsMouseButtonPressed(Enum.UserInputType.MouseButton2) then
        local deg = math.deg
        
        camera.CFrame = (CFrame.Angles(0, -MD.X/50*rotspeed, 0) * (camera.CFrame - camera.CFrame.Position)) + camera.CFrame.Position

        turned += math.deg(-MD.Y/50*rotspeed)
        
        if turned < -45 then
            turned = -45
        elseif turned > 90 then
            turned = 90
        else
            camera.CFrame *= CFrame.Angles(-MD.Y/50*rotspeed, 0, 0)
        end
    end
    
    local zero = Vector3.new()
    
    local keys = {
        W = UIS:IsKeyDown(Enum.KeyCode.W);
        A = UIS:IsKeyDown(Enum.KeyCode.A);
        S = UIS:IsKeyDown(Enum.KeyCode.S);
        D = UIS:IsKeyDown(Enum.KeyCode.D);
    }
    
    moveLength = (keys.W or keys.A or keys.S or keys.D) and moveLength + acceleration*dt or 0
    
    curspeed = speed + moveLength
    
    curspeed = math.clamp(curspeed, speed, maxspeed)
    
    camera.CFrame += (keys.W and camera.CFrame.LookVector or zero) * dt * curspeed
    camera.CFrame += (keys.S and -camera.CFrame.LookVector or zero) * dt * curspeed
    camera.CFrame += (keys.A and -camera.CFrame.RightVector or zero) * dt * curspeed
    camera.CFrame += (keys.D and camera.CFrame.RightVector or zero) * dt * curspeed
    
end)

UIS.InputBegan:Connect(function(input, gpe)
    if gpe then return end
    
    if input.UserInputType == Enum.UserInputType.MouseButton2 then
        UIS.MouseIconEnabled = false
        UIS.MouseBehavior = Enum.MouseBehavior.LockCurrentPosition
    end
end)

UIS.InputEnded:Connect(function(input, gpe)
    if gpe then return end
    
    if input.UserInputType == Enum.UserInputType.MouseButton2 then
        UIS.MouseIconEnabled = true
        UIS.MouseBehavior = Enum.MouseBehavior.Default
    end
end)
