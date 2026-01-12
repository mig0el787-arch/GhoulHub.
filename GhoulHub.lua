if not game:IsLoaded() then
	game.Loaded:Wait()
end

local Players = game:GetService("Players")
local Player = Players.LocalPlayer

-- Proteção
if Player.PlayerGui:FindFirstChild("GhoulHub") then
	return
end

-- URL base
local BASE = "https://raw.githubusercontent.com/mig0el787-arch/GhoulHub/main/"

local function load(file)
	return loadstring(game:HttpGet(BASE .. file))()
end

-- Música (5s)
pcall(function()
	load("Music.lua")
end)

-- UI
pcall(function()
	load("UI.lua")
end)

-- Funções
pcall(function()
	load("Movement.lua")
	load("Extras.lua")
end)

print("GhoulHub carregado com sucesso")
