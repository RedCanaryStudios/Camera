-- settings

local speed = 20
local rotspeed = 0.5

-- camera

local RS = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local camera = workspace.CurrentCamera

wait()

camera.CameraType = Enum.CameraType.Scriptable

game:GetService("RunService").RenderStepped:Connect(function(dt)
    local MD = UIS:GetMouseDelta()
    
    if UIS:IsMouseButtonPressed(Enum.UserInputType.MouseButton2) then
        camera.CFrame = (CFrame.Angles(0, -MD.X/50*rotspeed, 0) * (camera.CFrame - camera.CFrame.Position)) + camera.CFrame.Position
        camera.CFrame = camera.CFrame * CFrame.Angles(-MD.Y/50*rotspeed, 0, 0)
    end
    
    local zero = Vector3.new()
    
    camera.CFrame += (UIS:IsKeyDown(Enum.KeyCode.W) and camera.CFrame.LookVector or zero) * dt * speed
    camera.CFrame += (UIS:IsKeyDown(Enum.KeyCode.S) and -camera.CFrame.LookVector or zero) * dt * speed
    camera.CFrame += (UIS:IsKeyDown(Enum.KeyCode.A) and -camera.CFrame.RightVector or zero) * dt * speed
    camera.CFrame += (UIS:IsKeyDown(Enum.KeyCode.D) and camera.CFrame.RightVector or zero) * dt * speed
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
