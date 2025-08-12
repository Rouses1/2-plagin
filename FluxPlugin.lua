-- URL второго репозитория с плеер-листом
local playerListUrl = "https://raw.githubusercontent.com/Rouses1/2-plagin/refs/heads/main/FluxPlugin.lua"

-- Переменные для плагина
local playerListPlugin = nil
local playerListLoaded = false

-- Создаем кнопку в меню рядом с остальными
local playerListBtn = createToggleButton("Player List", 0.05, 85 + 3 * btnSpacingY, function()
    if not playerListLoaded then
        local success, plugin = pcall(function()
            return loadstring(game:HttpGet(playerListUrl))()
        end)
        if success and type(plugin) == "table" and plugin.Window then
            playerListPlugin = plugin
            playerListPlugin.Window.Parent = screenGui  -- добавляем в основное GUI
            playerListPlugin.Window.Position = UDim2.new(0.5, -100, 0.5, -120) -- Позиция окна, подкорректируй по вкусу
            playerListPlugin.Window.Visible = true
            playerListLoaded = true
        else
            warn("Не удалось загрузить Player List плагин")
            return false
        end
        return true
    else
        -- Переключаем видимость окна
        playerListPlugin.Window.Visible = not playerListPlugin.Window.Visible
        return playerListPlugin.Window.Visible
    end
end)
