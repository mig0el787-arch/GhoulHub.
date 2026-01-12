-- Ghoul Hub Loader ☠️

if not game:IsLoaded() then
	game.Loaded:Wait()
end

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local SoundService = game:GetService("SoundService")
local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

-- Proteção (não duplica)
if PlayerGui:FindFirstChild("GhoulLoader") then return end

-- CONFIG
local IMAGE_ID = "rbxassetid://74356605425526" -- foto do Ghoul
local MUSIC_ID = "rbxassetid://1843529634" -- música emo (funciona)
local LOAD_TIME = 5

-- GUI
local LoaderGui = Instance.new("ScreenGui")
LoaderGui.Name = "GhoulLoader"
LoaderGui.IgnoreGuiInset = true
LoaderGui.Parent = PlayerGui

-- Background
local BG = Instance.new("Frame", LoaderGui)
BG.Size = UDim2.fromScale(1,1)
BG.BackgroundColor3 = Color3.fromRGB(0,0,0)
BG.BorderSizePixel = 0

-- Image fullscreen
local Img = Instance.new("ImageLabel", BG)
Img.Size = UDim2.fromScale(1,1)
Img.Image = IMAGE_ID
Img.BackgroundTransparency = 1
Img.ScaleType = Enum.ScaleType.Crop

-- Overlay
local Overlay = Instance.new("Frame", BG)
Overlay.Size = UDim2.fromScale(1,1)
Overlay.BackgroundColor3 = Color3.fromRGB(0,0,0)
Overlay.BackgroundTransparency = 0.4

-- Loading bar bg
local BarBG = Instance.new("Frame", BG)
BarBG.Size = UDim2.new(0.4,0,0,16)
BarBG.Position = UDim2.new(0.3,0,0.85,0)
BarBG.BackgroundColor3 = Color3.fromRGB(30,30,30)
Instance.new("UICorner", BarBG).CornerRadius = UDim.new(1,0)

-- Bar
local Bar = Instance.new("Frame", BarBG)
Bar.Size = UDim2.new(0,0,1,0)
Bar.BackgroundColor3 = Color3.fromRGB(170,0,255)
Instance.new("UICorner", Bar).CornerRadius = UDim.new(1,0)

-- Text
local Txt = Instance.new("TextLabel", BG)
Txt.Size = UDim2.new(1,0,0,30)
Txt.Position = UDim2.new(0,0,0.8,0)
Txt.BackgroundTransparency = 1
Txt.Text = "Carregando 0%"
Txt.Font = Enum.Font.GothamBold
Txt.TextSize = 18
Txt.TextColor3 = Color3.fromRGB(200,150,255)

-- Music
local Sound = Instance.new("Sound", SoundService)
Sound.SoundId = MUSIC_ID
Sound.Volume = 2
Sound.Looped = false
Sound:Play()

-- Loading anim
local start = tick()
while tick() - start < LOAD_TIME do
	local p = math.clamp((tick() - start) / LOAD_TIME, 0, 1)
	Bar.Size = UDim2.new(p,0,1,0)
	Txt.Text = "Carregando "..math.floor(p*100).."%"
	task.wait()
end

-- Stop music
Sound:Stop()
Sound:Destroy()

-- Fade out
TweenService:Create(BG, TweenInfo.new(0.6), {
	BackgroundTransparency = 1
}):Play()

task.wait(0.6)
LoaderGui:Destroy()

-- Load UI
loadstring(game:HttpGet(
	"https://raw.githubusercontent.com/SEU_USUARIO/GhoulHub/main/UI.lua"
))()
