-- Ghoul Hub Loader ☠️ (SEM MÚSICA)

print("Ghoul Hub Loader iniciado")

if not game:IsLoaded() then
	game.Loaded:Wait()
end

local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

-- Evitar duplicar
if PlayerGui:FindFirstChild("GhoulHub") then
	warn("Ghoul Hub já está carregado")
	return
end

-- Carregar UI
local success, err = pcall(function()
	loadstring(game:HttpGet(
		"https://raw.githubusercontent.com/mig0el787-arch/GhoulHub/main/UI.lua"
	))()
end)

if success then
	print("Ghoul Hub carregado com sucesso")
else
	warn("Erro ao carregar Ghoul Hub:", err)
end
