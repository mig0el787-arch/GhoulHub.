print("Loader iniciou")

local UI_URL = "https://raw.githubusercontent.com/mig0el787-arch/GhoulHub/main/UI.lua"

local success, err = pcall(function()
	loadstring(game:HttpGet(UI_URL))()
end)

if success then
	print("UI carregada com sucesso")
else
	warn("Erro ao carregar UI:", err)
end
