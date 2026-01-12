-- GHOUL HUB ☠️ (DELTA COMPATÍVEL)

if not game:IsLoaded() then
	game.Loaded:Wait()
end

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer

-- Anti duplicar
if player.PlayerGui:FindFirstChild("GhoulHub") then
	return
end

-- ===== GUI =====
local gui = Instance.new("ScreenGui")
gui.Name = "GhoulHub"
gui.Parent = player.PlayerGui
gui.IgnoreGuiInset = true

-- ===== INTRO =====
local intro = Instance.new("Frame", gui)
intro.Size = UDim2.new(1,0,1,0)
intro.BackgroundColor3 = Color3.fromRGB(0,0,0)

local logo = Instance.new("ImageLabel", intro)
logo.Size = UDim2.new(0,200,0,200)
logo.Position = UDim2.new(0.5,-100,0.5,-100)
logo.Image = "rbxassetid://74356605425526" -- SUA FOTO
logo.BackgroundTransparency = 1

local music = Instance.new("Sound", intro)
music.SoundId = "rbxassetid://1843529274" -- música emo genérica
music.Volume = 2
music:Play()

task.wait(5)
intro:Destroy()
music:Destroy()

-- ===== HUB =====
local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0,520,0,330)
main.Position = UDim2.new(0.5,-260,0.5,-165)
main.BackgroundColor3 = Color3.fromRGB(15,15,15)

Instance.new("UICorner", main).CornerRadius = UDim.new(0,14)

-- SIDEBAR
local side = Instance.new("Frame", main)
side.Size = UDim2.new(0,130,1,0)
side.BackgroundColor3 = Color3.fromRGB(255,255,255)

-- TÍTULO
local title = Instance.new("TextLabel", side)
title.Size = UDim2.new(1,0,0,50)
title.Text = "Ghoul hub ☠️"
title.TextColor3 = Color3.fromRGB(140,0,255)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.TextSize = 16

-- CONTEÚDO
local content = Instance.new("Frame", main)
content.Position = UDim2.new(0,130,0,0)
content.Size = UDim2.new(1,-130,1,0)
content.BackgroundTransparency = 1

-- FUNÇÃO BOTÃO
local function button(text,y,callback)
	local b = Instance.new("TextButton", content)
	b.Size = UDim2.new(0,200,0,40)
	b.Position = UDim2.new(0,20,0,y)
	b.Text = text
	b.BackgroundColor3 = Color3.fromRGB(140,0,255)
	b.TextColor3 = Color3.new(1,1,1)
	b.Font = Enum.Font.GothamBold
	b.TextSize = 14
	b.MouseButton1Click:Connect(callback)
end

-- ===== FUNÇÕES =====
local char = player.Character or player.CharacterAdded:Wait()
local hrp = char:WaitForChild("HumanoidRootPart")

-- FLY
local flying = false
button("Fly",30,function()
	flying = not flying
	if flying then
		local bv = Instance.new("BodyVelocity", hrp)
		bv.Name = "Fly"
		bv.MaxForce = Vector3.new(1,1,1)*1e5
		RunService.RenderStepped:Connect(function()
			if flying then
				bv.Velocity = workspace.CurrentCamera.CFrame.LookVector * 60
			end
		end)
	else
		if hrp:FindFirstChild("Fly") then
			hrp.Fly:Destroy()
		end
	end
end)

-- NOCLIP
local noclip = false
button("Noclip",80,function()
	noclip = not noclip
	RunService.Stepped:Connect(function()
		if noclip then
			for _,v in pairs(char:GetDescendants()) do
				if v:IsA("BasePart") then
					v.CanCollide = false
				end
			end
		end
	end)
end)

-- FECHAR
button("Close",130,function()
	gui:Destroy()
end)
