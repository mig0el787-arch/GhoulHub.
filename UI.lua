-- Ghoul Hub UI ☠️

local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

-- GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "GhoulHub"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = PlayerGui

-- Main
local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.fromScale(0.55, 0.6)
Main.Position = UDim2.fromScale(0.22, 0.2)
Main.BackgroundColor3 = Color3.fromRGB(10,10,10)
Main.BorderSizePixel = 0
Main.Active = true
Main.Draggable = true
Main.Name = "Main"

-- Corner
Instance.new("UICorner", Main).CornerRadius = UDim.new(0,12)

-- TopBar
local Top = Instance.new("Frame", Main)
Top.Size = UDim2.new(1,0,0,45)
Top.BackgroundColor3 = Color3.fromRGB(20,20,20)
Top.BorderSizePixel = 0
Instance.new("UICorner", Top).CornerRadius = UDim.new(0,12)

-- Title
local Title = Instance.new("TextLabel", Top)
Title.Size = UDim2.new(1,-60,1,0)
Title.Position = UDim2.new(0,15,0,0)
Title.BackgroundTransparency = 1
Title.Text = "Ghoul Hub ☠️"
Title.Font = Enum.Font.GothamBold
Title.TextSize = 20
Title.TextColor3 = Color3.fromRGB(170,0,255)
Title.TextXAlignment = Left

-- Close
local Close = Instance.new("TextButton", Top)
Close.Size = UDim2.new(0,40,0,40)
Close.Position = UDim2.new(1,-45,0,2)
Close.Text = "X"
Close.Font = Enum.Font.GothamBold
Close.TextSize = 18
Close.TextColor3 = Color3.fromRGB(255,80,80)
Close.BackgroundTransparency = 1

Close.MouseButton1Click:Connect(function()
	ScreenGui:Destroy()
end)

-- Sidebar
local Side = Instance.new("Frame", Main)
Side.Size = UDim2.new(0,160,1,-45)
Side.Position = UDim2.new(0,0,0,45)
Side.BackgroundColor3 = Color3.fromRGB(15,15,15)
Side.BorderSizePixel = 0

-- Pages
local Pages = Instance.new("Folder", Main)
Pages.Name = "Pages"

-- Create Page
local function createPage(name)
	local page = Instance.new("Frame", Pages)
	page.Name = name
	page.Size = UDim2.new(1,-170,1,-55)
	page.Position = UDim2.new(0,165,0,50)
	page.BackgroundTransparency = 1
	page.Visible = false
	return page
end

-- Pages
local Fun = createPage("Fun")
local Avatar = createPage("Avatar")
local House = createPage("House")
local Car = createPage("Car")

Fun.Visible = true

-- Buttons
local function sidebarButton(text, page)
	local btn = Instance.new("TextButton", Side)
	btn.Size = UDim2.new(1,0,0,40)
	btn.Text = text
	btn.Font = Enum.Font.Gotham
	btn.TextSize = 14
	btn.TextColor3 = Color3.fromRGB(200,200,200)
	btn.BackgroundTransparency = 1

	btn.MouseButton1Click:Connect(function()
		for _,v in pairs(Pages:GetChildren()) do
			v.Visible = false
		end
		page.Visible = true
	end)
end

sidebarButton("Fun", Fun)
sidebarButton("Avatar", Avatar)
sidebarButton("House", House)
sidebarButton("Car", Car)

-- Example content
local label = Instance.new("TextLabel", Fun)
label.Size = UDim2.new(1,0,0,30)
label.Position = UDim2.new(0,0,0,0)
label.BackgroundTransparency = 1
label.Text = "Funções em breve..."
label.Font = Enum.Font.Gotham
label.TextSize = 16
label.TextColor3 = Color3.fromRGB(180,120,255)

print("UI carregada")
-- Services
local UIS = game:GetService("UserInputService")
local Humanoid = Player.Character:WaitForChild("Humanoid")

Player.CharacterAdded:Connect(function(char)
	Humanoid = char:WaitForChild("Humanoid")
end)

-- Helper criar botão
local function createButton(parent, text, callback)
	local btn = Instance.new("TextButton", parent)
	btn.Size = UDim2.new(0.9,0,0,40)
	btn.BackgroundColor3 = Color3.fromRGB(25,25,25)
	btn.Text = text
	btn.Font = Enum.Font.Gotham
	btn.TextSize = 14
	btn.TextColor3 = Color3.fromRGB(180,120,255)
	btn.BorderSizePixel = 0
	Instance.new("UICorner", btn).CornerRadius = UDim.new(0,8)

	btn.MouseButton1Click:Connect(callback)
	return btn
end

-- Layout
local layout = Instance.new("UIListLayout", Fun)
layout.Padding = UDim.new(0,10)

-- SPEED
createButton(Fun, "Speed +", function()
	Humanoid.WalkSpeed = Humanoid.WalkSpeed + 5
end)

createButton(Fun, "Speed -", function()
	Humanoid.WalkSpeed = math.max(16, Humanoid.WalkSpeed - 5)
end)

-- JUMP
createButton(Fun, "Jump +", function()
	Humanoid.JumpPower = Humanoid.JumpPower + 10
end)

createButton(Fun, "Jump -", function()
	Humanoid.JumpPower = math.max(50, Humanoid.JumpPower - 10)
end)

-- GRAVITY
createButton(Fun, "Gravity Low", function()
	workspace.Gravity = 80
end)

createButton(Fun, "Gravity Normal", function()
	workspace.Gravity = 196
end)

-- INFINITE JUMP
local infJump = false

createButton(Fun, "Infinite Jump (Toggle)", function()
	infJump = not infJump
end)

UIS.JumpRequest:Connect(function()
	if infJump then
		Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
	end
end)
-- CAR FUNCTIONS

local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local Player = Players.LocalPlayer

local carFly = false
local carSpeed = 0
local carConn

-- Pega o carro atual
local function getCar()
	if Player.Character and Player.Character:FindFirstChild("Humanoid") then
		local seat = Player.Character.Humanoid.SeatPart
		if seat and seat:IsA("VehicleSeat") then
			return seat.Parent
		end
	end
	return nil
end

-- Layout Car
local carLayout = Instance.new("UIListLayout", Car)
carLayout.Padding = UDim.new(0,10)

-- Botão helper (usa o mesmo estilo)
local function carButton(text, callback)
	local btn = Instance.new("TextButton", Car)
	btn.Size = UDim2.new(0.9,0,0,40)
	btn.BackgroundColor3 = Color3.fromRGB(25,25,25)
	btn.Text = text
	btn.Font = Enum.Font.Gotham
	btn.TextSize = 14
	btn.TextColor3 = Color3.fromRGB(180,120,255)
	btn.BorderSizePixel = 0
	Instance.new("UICorner", btn).CornerRadius = UDim.new(0,8)
	btn.MouseButton1Click:Connect(callback)
	return btn
end

-- FLY CAR
carButton("Fly Car (Toggle)", function()
	carFly = not carFly
	local car = getCar()
	if not car then return end

	if carFly then
		local bv = Instance.new("BodyVelocity")
		bv.Name = "GhoulCarFly"
		bv.MaxForce = Vector3.new(1e6,1e6,1e6)
		bv.Velocity = Vector3.new(0,0,0)
		bv.Parent = car.PrimaryPart or car:FindFirstChildWhichIsA("BasePart")

		carConn = RunService.RenderStepped:Connect(function()
			if not carFly or not bv.Parent then return end
			local cam = workspace.CurrentCamera
			bv.Velocity = cam.CFrame.LookVector * (60 + carSpeed)
		end)
	else
		if carConn then carConn:Disconnect() end
		for _,v in pairs(car:GetDescendants()) do
			if v.Name == "GhoulCarFly" then
				v:Destroy()
			end
		end
	end
end)

-- CAR SPEED +
carButton("Car Speed +", function()
	carSpeed = carSpeed + 20
end)

-- CAR SPEED -
carButton("Car Speed -", function()
	carSpeed = math.max(0, carSpeed - 20)
end)

-- RESET SPEED
carButton("Reset Car Speed", function()
	carSpeed = 0
end)
