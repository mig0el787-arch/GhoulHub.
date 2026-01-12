-- GHOUL HUB ☠️ | Single File UI
if not game:IsLoaded() then game.Loaded:Wait() end

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")

local player = Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local hrp = char:WaitForChild("HumanoidRootPart")

-- PROTEÇÃO
if player.PlayerGui:FindFirstChild("GhoulHub") then return end

-- GUI
local gui = Instance.new("ScreenGui")
gui.Name = "GhoulHub"
gui.Parent = player.PlayerGui
gui.ResetOnSpawn = false

------------------------------------------------
-- BOTÃO FLUTUANTE (CÍRCULO)
------------------------------------------------
local float = Instance.new("ImageButton", gui)
float.Size = UDim2.new(0,60,0,60)
float.Position = UDim2.new(0,20,0.5,-30)
float.Image = "rbxassetid://74356605425526"
float.BackgroundColor3 = Color3.fromRGB(90,0,140)
float.AutoButtonColor = false
Instance.new("UICorner", float).CornerRadius = UDim.new(1,0)

-- Drag
do
	local dragging, dragStart, startPos
	float.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			dragging = true
			dragStart = input.Position
			startPos = float.Position
		end
	end)
	float.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			dragging = false
		end
	end)
	UIS.InputChanged:Connect(function(input)
		if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
			local delta = input.Position - dragStart
			float.Position = UDim2.new(
				startPos.X.Scale,
				startPos.X.Offset + delta.X,
				startPos.Y.Scale,
				startPos.Y.Offset + delta.Y
			)
		end
	end)
end

------------------------------------------------
-- MAIN UI
------------------------------------------------
local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0,520,0,330)
main.Position = UDim2.new(0.5,-260,0.5,-165)
main.BackgroundColor3 = Color3.fromRGB(15,15,20)
main.Visible = false
Instance.new("UICorner", main).CornerRadius = UDim.new(0,14)

float.MouseButton1Click:Connect(function()
	main.Visible = not main.Visible
end)

------------------------------------------------
-- SIDEBAR
------------------------------------------------
local side = Instance.new("Frame", main)
side.Size = UDim2.new(0,130,1,0)
side.BackgroundColor3 = Color3.fromRGB(255,255,255)
Instance.new("UICorner", side).CornerRadius = UDim.new(0,14)

local content = Instance.new("Frame", main)
content.Position = UDim2.new(0,130,0,0)
content.Size = UDim2.new(1,-130,1,0)
content.BackgroundTransparency = 1

local tabs = {}

local function createTab(name, order)
	local btn = Instance.new("TextButton", side)
	btn.Size = UDim2.new(1,0,0,45)
	btn.Position = UDim2.new(0,0,0,(order-1)*50)
	btn.Text = name
	btn.Font = Enum.Font.GothamBold
	btn.TextSize = 14
	btn.TextColor3 = Color3.fromRGB(120,0,180)
	btn.BackgroundTransparency = 1

	local frame = Instance.new("Frame", content)
	frame.Size = UDim2.new(1,0,1,0)
	frame.Visible = false
	frame.BackgroundTransparency = 1

	btn.MouseButton1Click:Connect(function()
		for _,v in pairs(tabs) do v.Visible = false end
		frame.Visible = true
	end)

	table.insert(tabs, frame)
	return frame
end

-- TABS
local tabPlayer   = createTab("Player",1)
local tabMovement = createTab("Movement",2)
local tabWorld    = createTab("World",3)
local tabFun      = createTab("Fun",4)
local tabSettings = createTab("Settings",5)

tabs[1].Visible = true

------------------------------------------------
-- BOTÃO PADRÃO
------------------------------------------------
local function makeButton(parent, text, y, callback)
	local b = Instance.new("TextButton", parent)
	b.Size = UDim2.new(0,220,0,40)
	b.Position = UDim2.new(0,20,0,y)
	b.Text = text
	b.Font = Enum.Font.GothamBold
	b.TextSize = 14
	b.TextColor3 = Color3.fromRGB(255,255,255)
	b.BackgroundColor3 = Color3.fromRGB(120,0,180)
	Instance.new("UICorner", b).CornerRadius = UDim.new(0,10)
	b.MouseButton1Click:Connect(callback)
end

------------------------------------------------
-- FUNÇÕES
------------------------------------------------

-- RESET
makeButton(tabPlayer,"Reset Character",30,function()
	char:BreakJoints()
end)

-- FLY
local flying = false
makeButton(tabMovement,"Fly",30,function()
	flying = not flying
	if flying then
		local bv = Instance.new("BodyVelocity", hrp)
		bv.Name = "FlyForce"
		bv.MaxForce = Vector3.new(1,1,1)*1e5
		RunService.RenderStepped:Connect(function()
			if flying and bv.Parent then
				bv.Velocity = workspace.CurrentCamera.CFrame.LookVector * 60
			end
		end)
	else
		if hrp:FindFirstChild("FlyForce") then
			hrp.FlyForce:Destroy()
		end
	end
end)

-- NOCLIP
local noclip = false
makeButton(tabMovement,"Noclip",80,function()
	noclip = not noclip
end)

RunService.Stepped:Connect(function()
	if noclip and char then
		for _,v in pairs(char:GetDescendants()) do
			if v:IsA("BasePart") then
				v.CanCollide = false
			end
		end
	end
end)

-- CLOSE UI (não pediu remover script)
makeButton(tabSettings,"Hide UI",30,function()
	main.Visible = false
end)

print("Ghoul Hub ☠️ carregado com sucesso")
