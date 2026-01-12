-- Ghoul Hub ☠️ (Chaos Hub Style | Universal)

if not game:IsLoaded() then
	game.Loaded:Wait()
end

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local player = Players.LocalPlayer

if player.PlayerGui:FindFirstChild("GhoulHub") then
	return
end

-- GUI
local gui = Instance.new("ScreenGui")
gui.Name = "GhoulHub"
gui.ResetOnSpawn = false
gui.Parent = player.PlayerGui

-- MAIN
local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0,520,0,320)
main.Position = UDim2.new(0.5,-260,0.5,-160)
main.BackgroundColor3 = Color3.fromRGB(18,18,18)
main.BorderSizePixel = 0
Instance.new("UICorner", main).CornerRadius = UDim.new(0,10)

-- SIDEBAR
local sidebar = Instance.new("Frame", main)
sidebar.Size = UDim2.new(0,140,1,0)
sidebar.BackgroundColor3 = Color3.fromRGB(25,25,25)
sidebar.BorderSizePixel = 0

local title = Instance.new("TextLabel", sidebar)
title.Size = UDim2.new(1,0,0,50)
title.Text = "Ghoul Hub ☠️"
title.TextColor3 = Color3.fromRGB(170,0,255)
title.Font = Enum.Font.GothamBold
title.TextSize = 16
title.BackgroundTransparency = 1

-- CONTENT
local content = Instance.new("Frame", main)
content.Position = UDim2.new(0,140,0,0)
content.Size = UDim2.new(1,-140,1,0)
content.BackgroundTransparency = 1

-- DRAG
local dragging, dragStart, startPos
main.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = true
		dragStart = input.Position
		startPos = main.Position
	end
end)

UIS.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = false
	end
end)

UIS.InputChanged:Connect(function(input)
	if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
		local delta = input.Position - dragStart
		main.Position = UDim2.new(
			startPos.X.Scale,
			startPos.X.Offset + delta.X,
			startPos.Y.Scale,
			startPos.Y.Offset + delta.Y
		)
	end
end)

-- BUTTON CREATOR
local function createButton(text, y, callback)
	local btn = Instance.new("TextButton", content)
	btn.Size = UDim2.new(0,220,0,38)
	btn.Position = UDim2.new(0,30,0,y)
	btn.Text = text
	btn.Font = Enum.Font.GothamBold
	btn.TextSize = 14
	btn.TextColor3 = Color3.new(1,1,1)
	btn.BackgroundColor3 = Color3.fromRGB(170,0,255)
	btn.BorderSizePixel = 0
	Instance.new("UICorner", btn).CornerRadius = UDim.new(0,8)
	btn.MouseButton1Click:Connect(callback)
end

-- CHARACTER
local function getChar()
	return player.Character or player.CharacterAdded:Wait()
end

-- FUNCTIONS
local fly = false
local noclip = false
local infJump = false

createButton("Fly", 30, function()
	fly = not fly
	local char = getChar()
	local hrp = char:WaitForChild("HumanoidRootPart")

	if fly then
		local bv = Instance.new("BodyVelocity", hrp)
		bv.Name = "GhoulFly"
		bv.MaxForce = Vector3.new(1,1,1) * 1e5

		RunService.RenderStepped:Connect(function()
			if fly and bv.Parent then
				bv.Velocity = workspace.CurrentCamera.CFrame.LookVector * 60
			end
		end)
	else
		if hrp:FindFirstChild("GhoulFly") then
			hrp.GhoulFly:Destroy()
		end
	end
end)

createButton("Noclip", 80, function()
	noclip = not noclip
	RunService.Stepped:Connect(function()
		if noclip then
			for _,v in pairs(getChar():GetDescendants()) do
				if v:IsA("BasePart") then
					v.CanCollide = false
				end
			end
		end
	end)
end)

createButton("Speed", 130, function()
	getChar():FindFirstChildOfClass("Humanoid").WalkSpeed = 50
end)

createButton("Jump Power", 180, function()
	getChar():FindFirstChildOfClass("Humanoid").JumpPower = 100
end)

createButton("Infinite Jump", 230, function()
	infJump = not infJump
end)

UIS.JumpRequest:Connect(function()
	if infJump then
		getChar():FindFirstChildOfClass("Humanoid"):ChangeState(Enum.HumanoidStateType.Jumping)
	end
end)
