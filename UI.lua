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
