-- Vida Prisao Script
print("[VidaPrisao] Iniciando...")

local player = game.Players.LocalPlayer
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TeleportService = game:GetService("TeleportService")

pcall(function()
    if game.CoreGui:FindFirstChild("VidaPrisaoGui") then
        game.CoreGui:FindFirstChild("VidaPrisaoGui"):Destroy()
    end
end)

local character = player.Character or player.CharacterAdded:Wait()
task.wait(1)

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "VidaPrisaoGui"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = game.CoreGui

local MainFrame = Instance.new("Frame")
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
MainFrame.Position = UDim2.new(0.02, 0, 0.3, 0)
MainFrame.Size = UDim2.new(0, 220, 0, 395)

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 8)
UICorner.Parent = MainFrame

local UIStroke = Instance.new("UIStroke")
UIStroke.Parent = MainFrame
UIStroke.Color = Color3.fromRGB(0, 0, 0)
UIStroke.Thickness = 3

local Title = Instance.new("TextLabel")
Title.Parent = MainFrame
Title.BackgroundTransparency = 1
Title.Size = UDim2.new(1, -75, 0, 40)
Title.Font = Enum.Font.GothamBold
Title.Text = "Arabe Scripts"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 18
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Position = UDim2.new(0, 10, 0, 0)
Title.Active = true

local rejoinBtn = Instance.new("TextButton")
rejoinBtn.Parent = MainFrame
rejoinBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
rejoinBtn.Position = UDim2.new(1, -70, 0, 5)
rejoinBtn.Size = UDim2.new(0, 35, 0, 30)
rejoinBtn.Font = Enum.Font.GothamBold
rejoinBtn.Text = "R"
rejoinBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
rejoinBtn.TextSize = 14

local rejoinCorner = Instance.new("UICorner")
rejoinCorner.CornerRadius = UDim.new(0, 6)
rejoinCorner.Parent = rejoinBtn

rejoinBtn.MouseButton1Click:Connect(function()
    TeleportService:Teleport(game.PlaceId, player)
end)

local SettingsBtn = Instance.new("TextButton")
SettingsBtn.Parent = MainFrame
SettingsBtn.BackgroundTransparency = 1
SettingsBtn.Position = UDim2.new(1, -35, 0, 5)
SettingsBtn.Size = UDim2.new(0, 30, 0, 30)
SettingsBtn.Font = Enum.Font.GothamBold
SettingsBtn.Text = "⚙"
SettingsBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
SettingsBtn.TextSize = 20

local SettingsFrame = Instance.new("Frame")
SettingsFrame.Parent = ScreenGui
SettingsFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
SettingsFrame.Position = UDim2.new(0.02, 230, 0.3, 0)
SettingsFrame.Size = UDim2.new(0, 180, 0, 160)
SettingsFrame.Visible = false

local SettingsCorner = Instance.new("UICorner")
SettingsCorner.CornerRadius = UDim.new(0, 8)
SettingsCorner.Parent = SettingsFrame

local SettingsStroke = Instance.new("UIStroke")
SettingsStroke.Parent = SettingsFrame
SettingsStroke.Color = Color3.fromRGB(0, 0, 0)
SettingsStroke.Thickness = 3

local KeyLabel = Instance.new("TextLabel")
KeyLabel.Parent = SettingsFrame
KeyLabel.BackgroundTransparency = 1
KeyLabel.Position = UDim2.new(0, 10, 0, 10)
KeyLabel.Size = UDim2.new(1, -20, 0, 25)
KeyLabel.Font = Enum.Font.Gotham
KeyLabel.Text = "Tecla Menu:"
KeyLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
KeyLabel.TextSize = 12
KeyLabel.TextXAlignment = Enum.TextXAlignment.Left

local KeyBox = Instance.new("TextBox")
KeyBox.Parent = SettingsFrame
KeyBox.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
KeyBox.Position = UDim2.new(0, 10, 0, 45)
KeyBox.Size = UDim2.new(1, -20, 0, 35)
KeyBox.Font = Enum.Font.Gotham
KeyBox.Text = "Z"
KeyBox.TextColor3 = Color3.fromRGB(255, 255, 255)
KeyBox.TextSize = 14

local btnCorner = Instance.new("UICorner")
btnCorner.CornerRadius = UDim.new(0, 6)
btnCorner.Parent = KeyBox

local toggleKey = Enum.KeyCode.Z
local flySpeed = 65

SettingsBtn.MouseButton1Click:Connect(function()
    SettingsFrame.Visible = not SettingsFrame.Visible
end)

local dragging, dragInput, dragStart, startPos

Title.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

Title.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInput = input
    end
end)

UIS.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

local SpeedLabel = Instance.new("TextLabel")
SpeedLabel.Parent = SettingsFrame
SpeedLabel.BackgroundTransparency = 1
SpeedLabel.Position = UDim2.new(0, 10, 0, 90)
SpeedLabel.Size = UDim2.new(1, -20, 0, 20)
SpeedLabel.Font = Enum.Font.Gotham
SpeedLabel.Text = "Velocidade Fly: 65"
SpeedLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
SpeedLabel.TextSize = 11
SpeedLabel.TextXAlignment = Enum.TextXAlignment.Left

local SpeedSliderBG = Instance.new("Frame")
SpeedSliderBG.Parent = SettingsFrame
SpeedSliderBG.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
SpeedSliderBG.Position = UDim2.new(0, 10, 0, 115)
SpeedSliderBG.Size = UDim2.new(1, -20, 0, 8)
SpeedSliderBG.BorderSizePixel = 0

local SpeedSliderBGCorner = Instance.new("UICorner")
SpeedSliderBGCorner.CornerRadius = UDim.new(1, 0)
SpeedSliderBGCorner.Parent = SpeedSliderBG

local SpeedSliderFill = Instance.new("Frame")
SpeedSliderFill.Parent = SpeedSliderBG
SpeedSliderFill.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
SpeedSliderFill.Size = UDim2.new(0.217, 0, 1, 0)
SpeedSliderFill.BorderSizePixel = 0

local SpeedSliderFillCorner = Instance.new("UICorner")
SpeedSliderFillCorner.CornerRadius = UDim.new(1, 0)
SpeedSliderFillCorner.Parent = SpeedSliderFill

local SpeedSliderButton = Instance.new("TextButton")
SpeedSliderButton.Parent = SettingsFrame
SpeedSliderButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
SpeedSliderButton.Position = UDim2.new(0, 10 + (160 * 0.217) - 6, 0, 111)
SpeedSliderButton.Size = UDim2.new(0, 16, 0, 16)
SpeedSliderButton.Text = ""
SpeedSliderButton.AutoButtonColor = false

local SpeedSliderButtonCorner = Instance.new("UICorner")
SpeedSliderButtonCorner.CornerRadius = UDim.new(1, 0)
SpeedSliderButtonCorner.Parent = SpeedSliderButton

local draggingSpeed = false

SpeedSliderButton.MouseButton1Down:Connect(function()
    draggingSpeed = true
end)

UIS.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        draggingSpeed = false
    end
end)

RunService.RenderStepped:Connect(function()
    if draggingSpeed then
        local mousePos = UIS:GetMouseLocation()
        local sliderPos = SpeedSliderBG.AbsolutePosition.X
        local sliderSize = SpeedSliderBG.AbsoluteSize.X
        local relativePos = math.clamp(mousePos.X - sliderPos, 0, sliderSize)
        local percentage = relativePos / sliderSize
        
        flySpeed = math.floor(percentage * 300)
        SpeedLabel.Text = "Velocidade Fly: " .. flySpeed
        SpeedSliderFill.Size = UDim2.new(percentage, 0, 1, 0)
        SpeedSliderButton.Position = UDim2.new(0, 10 + (160 * percentage) - 6, 0, 111)
    end
end)

KeyBox.FocusLost:Connect(function()
    local text = KeyBox.Text:upper()
    local success, key = pcall(function() return Enum.KeyCode[text] end)
    if success and key then
        toggleKey = key
        KeyBox.Text = text
    else
        KeyBox.Text = "Z"
        toggleKey = Enum.KeyCode.Z
    end
end)

-- Sistema de Tabs
local TabContainer = Instance.new("ScrollingFrame")
TabContainer.Parent = MainFrame
TabContainer.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
TabContainer.Position = UDim2.new(0, 5, 0, 45)
TabContainer.Size = UDim2.new(1, -10, 0, 35)
TabContainer.CanvasSize = UDim2.new(0, 0, 0, 0)
TabContainer.ScrollBarThickness = 0
TabContainer.ScrollingDirection = Enum.ScrollingDirection.X
TabContainer.BorderSizePixel = 0

local TabCorner = Instance.new("UICorner")
TabCorner.CornerRadius = UDim.new(0, 6)
TabCorner.Parent = TabContainer

local TabLayout = Instance.new("UIListLayout")
TabLayout.Parent = TabContainer
TabLayout.FillDirection = Enum.FillDirection.Horizontal
TabLayout.Padding = UDim.new(0, 5)
TabLayout.SortOrder = Enum.SortOrder.LayoutOrder

local ContentFrame = Instance.new("Frame")
ContentFrame.Parent = MainFrame
ContentFrame.BackgroundTransparency = 1
ContentFrame.Position = UDim2.new(0, 5, 0, 85)
ContentFrame.Size = UDim2.new(1, -10, 1, -90)

local tabs = {}
local currentTab = nil

local function createTab(name, index)
    local TabButton = Instance.new("TextButton")
    TabButton.Parent = TabContainer
    TabButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    TabButton.Size = UDim2.new(0, 65, 1, 0)
    TabButton.Font = Enum.Font.Gotham
    TabButton.Text = name
    TabButton.TextColor3 = Color3.fromRGB(200, 200, 200)
    TabButton.TextSize = 13
    TabButton.BorderSizePixel = 0
    TabButton.LayoutOrder = index
    
    local BtnCorner = Instance.new("UICorner")
    BtnCorner.CornerRadius = UDim.new(0, 6)
    BtnCorner.Parent = TabButton
    
    local TabContent = Instance.new("ScrollingFrame")
    TabContent.Parent = ContentFrame
    TabContent.BackgroundTransparency = 1
    TabContent.Size = UDim2.new(1, 0, 1, 0)
    TabContent.CanvasSize = UDim2.new(0, 0, 0, 0)
    TabContent.ScrollBarThickness = 4
    TabContent.Visible = false
    TabContent.BorderSizePixel = 0
    
    local Layout = Instance.new("UIListLayout")
    Layout.Parent = TabContent
    Layout.Padding = UDim.new(0, 8)
    Layout.SortOrder = Enum.SortOrder.LayoutOrder
    
    Layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        TabContent.CanvasSize = UDim2.new(0, 0, 0, Layout.AbsoluteContentSize.Y + 10)
    end)
    
    tabs[name] = {button = TabButton, content = TabContent}
    
    TabButton.MouseButton1Click:Connect(function()
        for _, tab in pairs(tabs) do
            tab.button.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
            tab.button.TextColor3 = Color3.fromRGB(200, 200, 200)
            tab.content.Visible = false
        end
        TabButton.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
        TabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        TabContent.Visible = true
        currentTab = name
    end)
    
    return TabContent
end

local function createButton(parent, text, callback)
    local Button = Instance.new("TextButton")
    Button.Parent = parent
    Button.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
    Button.Size = UDim2.new(1, 0, 0, 35)
    Button.Font = Enum.Font.Gotham
    Button.Text = text
    Button.TextColor3 = Color3.fromRGB(255, 255, 255)
    Button.TextSize = 13
    
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 6)
    Corner.Parent = Button
    
    local Indicator = Instance.new("Frame")
    Indicator.Parent = Button
    Indicator.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
    Indicator.Position = UDim2.new(1, -20, 0.5, -6)
    Indicator.Size = UDim2.new(0, 12, 0, 12)
    Indicator.BorderSizePixel = 0
    
    local IndCorner = Instance.new("UICorner")
    IndCorner.CornerRadius = UDim.new(1, 0)
    IndCorner.Parent = Indicator
    
    Button.MouseButton1Click:Connect(function()
        if callback then
            local active = callback()
            if active ~= nil then
                Indicator.BackgroundColor3 = active and Color3.fromRGB(50, 255, 50) or Color3.fromRGB(255, 50, 50)
            end
        end
    end)
    
    return Button, Indicator
end

local function createSmallButton(text, position)
    local Button = Instance.new("TextButton")
    Button.Parent = MainFrame
    Button.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
    Button.Position = position
    Button.Size = UDim2.new(0, 90, 0, 35)
    Button.Font = Enum.Font.Gotham
    Button.Text = text
    Button.TextColor3 = Color3.fromRGB(255, 255, 255)
    Button.TextSize = 12
    
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 6)
    Corner.Parent = Button
    
    local Indicator = Instance.new("Frame")
    Indicator.Parent = Button
    Indicator.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
    Indicator.Position = UDim2.new(1, -20, 0.5, -6)
    Indicator.Size = UDim2.new(0, 12, 0, 12)
    Indicator.BorderSizePixel = 0
    
    local IndCorner = Instance.new("UICorner")
    IndCorner.CornerRadius = UDim.new(1, 0)
    IndCorner.Parent = Indicator
    
    return Button, Indicator
end

-- Criar Tabs
local FireTab = createTab("Fire", 1)
local TpTab = createTab("TP's", 2)
local OthersTab = createTab("Others", 3)

TabLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    TabContainer.CanvasSize = UDim2.new(0, TabLayout.AbsoluteContentSize.X + 10, 0, 0)
end)

-- Tab 1: Fire
local aimbotActive = false
local espActive = false

createButton(FireTab, "Aimbot", function()
    aimbotActive = not aimbotActive
    print("Aimbot:", aimbotActive)
    return aimbotActive
end)

createButton(FireTab, "ESP", function()
    espActive = not espActive
    print("ESP:", espActive)
    return espActive
end)

-- Tab 2: TP's
local clickTpActive = false

createButton(TpTab, "Click TP", function()
    clickTpActive = not clickTpActive
    print("Click TP:", clickTpActive)
    return clickTpActive
end)

createButton(TpTab, "Criminal", function()
    pcall(function()
        if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            player.Character.HumanoidRootPart.CFrame = CFrame.new(-943, 95, 2063)
            print("TP Criminal executado!")
        end
    end)
end)

createButton(TpTab, "Camper", function()
    pcall(function()
        if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            player.Character.HumanoidRootPart.CFrame = CFrame.new(726, 122, 2587)
            print("TP Camper executado!")
        end
    end)
end)

createButton(TpTab, "Players", function()
    print("TP Players")
    -- Adicionar código de TP aqui
end)

-- Tab 3: Others
local godmodeActive = false
local ghostActive = false
local flyActive = false

createButton(OthersTab, "Godmode", function()
    godmodeActive = not godmodeActive
    print("Godmode:", godmodeActive)
    return godmodeActive
end)

createButton(OthersTab, "Ghost", function()
    ghostActive = not ghostActive
    print("Ghost:", ghostActive)
    return ghostActive
end)

createButton(OthersTab, "Fly", function()
    flyActive = not flyActive
    print("Fly:", flyActive)
    return flyActive
end)

-- Ativar primeira tab
tabs["Fire"].button.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
tabs["Fire"].button.TextColor3 = Color3.fromRGB(255, 255, 255)
tabs["Fire"].content.Visible = true
currentTab = "Fire"

-- Toggle Menu com tecla
UIS.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed and input.KeyCode == toggleKey then
        MainFrame.Visible = not MainFrame.Visible
    end
end)



local function createKeyBox(text, position)
    local Box = Instance.new("TextBox")
    Box.Parent = MainFrame
    Box.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    Box.Position = position
    Box.Size = UDim2.new(0, 35, 0, 35)
    Box.Font = Enum.Font.Gotham
    Box.Text = text
    Box.TextColor3 = Color3.fromRGB(255, 255, 255)
    Box.TextSize = 10
    Box.ClearTextOnFocus = false
    
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 6)
    Corner.Parent = Box
    return Box
end

local flyKey = Enum.KeyCode.E
local espKey = Enum.KeyCode.J
local aimbotKey = Enum.KeyCode.X
local ghostKey = Enum.KeyCode.G
local tpMouseKey = Enum.KeyCode.Q
local tpMouseEnabled = false

-- Indicadores (para compatibilidade)
local flyIndicator = nil
local espIndicator = nil
local aimbotIndicator = nil
local noclipIndicator = nil
godmodeIndicator = nil
autoCardIndicator = nil
tpCriminalIndicator = nil
tpCamperIndicator = nil

local aimbotEnabled = false
local aimbotFOV = 300
local aimbotSmoothness = 1
local rightMouseDown = false

local ghostEnabled = false
local ghostPart = nil
local ghostConnection = nil
local originalCFrame = nil
local ghostOverlay = nil

local flying = false
local bodyVelocity, bodyGyro

godmodeEnabled = nil
local godmodeConnections = {}

local autoCardEnabled = false

local function startFly()
    flying = true
    pcall(function()
        if not player.Character then return end
        local root = player.Character:FindFirstChild("HumanoidRootPart")
        local humanoid = player.Character:FindFirstChild("Humanoid")
        if not root or not humanoid then return end
        
        if bodyVelocity then bodyVelocity:Destroy() end
        if bodyGyro then bodyGyro:Destroy() end
        
        humanoid.PlatformStand = true
        
        bodyVelocity = Instance.new("BodyVelocity")
        bodyVelocity.Velocity = Vector3.zero
        bodyVelocity.MaxForce = Vector3.new(9e9, 9e9, 9e9)
        bodyVelocity.P = 1250
        bodyVelocity.Parent = root
        
        bodyGyro = Instance.new("BodyGyro")
        bodyGyro.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
        bodyGyro.P = 9000
        bodyGyro.D = 500
        bodyGyro.CFrame = root.CFrame
        bodyGyro.Parent = root
    end)
end

local function stopFly()
    flying = false
    pcall(function()
        if bodyVelocity then bodyVelocity:Destroy() bodyVelocity = nil end
        if bodyGyro then bodyGyro:Destroy() bodyGyro = nil end
        if player.Character then
            local humanoid = player.Character:FindFirstChild("Humanoid")
            if humanoid then humanoid.PlatformStand = false end
        end
    end)
end

RunService.Heartbeat:Connect(function()
    if not flying or not player.Character then return end
    local textBoxFocused = UIS:GetFocusedTextBox()
    if textBoxFocused then return end
    
    pcall(function()
        local root = player.Character:FindFirstChild("HumanoidRootPart")
        if not root then return end
        if not bodyVelocity or not bodyGyro or not bodyVelocity.Parent then
            startFly()
            return
        end
        
        local moveDir = Vector3.zero
        local cam = workspace.CurrentCamera
        local speed = flySpeed
        
        if UIS:IsKeyDown(Enum.KeyCode.LeftShift) then speed = speed * 2 end
        if UIS:IsKeyDown(Enum.KeyCode.W) then moveDir = moveDir + cam.CFrame.LookVector end
        if UIS:IsKeyDown(Enum.KeyCode.S) then moveDir = moveDir - cam.CFrame.LookVector end
        if UIS:IsKeyDown(Enum.KeyCode.A) then moveDir = moveDir - cam.CFrame.RightVector end
        if UIS:IsKeyDown(Enum.KeyCode.D) then moveDir = moveDir + cam.CFrame.RightVector end
        if UIS:IsKeyDown(Enum.KeyCode.Space) then moveDir = moveDir + Vector3.new(0,1,0) end
        if UIS:IsKeyDown(Enum.KeyCode.LeftControl) then moveDir = moveDir - Vector3.new(0,1,0) end
        
        bodyVelocity.Velocity = moveDir.Magnitude > 0 and moveDir.Unit * speed or Vector3.zero
        bodyGyro.CFrame = cam.CFrame
    end)
end)

local espEnabled = false
local espBoxes = {}
local espConnections = {}

local function addESP(plr)
    if plr == player or not espEnabled then return end
    
    local function createHighlight(char)
        task.wait(0.1)
        if not espEnabled then return end
        
        pcall(function()
            if not plr.Team or not player.Team then return end
            
            local myTeam = player.Team.Name
            local theirTeam = plr.Team.Name
            local shouldMark = false
            
            if myTeam == "Guards" and theirTeam == "Criminals" then
                shouldMark = true
            elseif myTeam == "Criminals" and theirTeam == "Guards" then
                shouldMark = true
            end
            
            if not shouldMark then return end
            
            local head = char:FindFirstChild("Head")
            if not head then return end
            
            local color = Color3.fromRGB(255, 0, 0)
            
            local highlight = Instance.new("Highlight")
            highlight.FillColor = color
            highlight.OutlineColor = color
            highlight.FillTransparency = 0.7
            highlight.OutlineTransparency = 0.2
            highlight.Adornee = char
            highlight.Parent = char
            
            local billboard = Instance.new("BillboardGui")
            billboard.Adornee = head
            billboard.Size = UDim2.new(0, 100, 0, 50)
            billboard.StudsOffset = Vector3.new(0, 3, 0)
            billboard.AlwaysOnTop = true
            billboard.Parent = head
            
            local nameLabel = Instance.new("TextLabel")
            nameLabel.Size = UDim2.new(1, 0, 1, 0)
            nameLabel.BackgroundTransparency = 1
            nameLabel.Text = plr.Name
            nameLabel.TextColor3 = color
            nameLabel.TextStrokeTransparency = 0.5
            nameLabel.Font = Enum.Font.GothamBold
            nameLabel.TextSize = 14
            nameLabel.Parent = billboard
            
            if not espBoxes[plr] then espBoxes[plr] = {} end
            table.insert(espBoxes[plr], highlight)
            table.insert(espBoxes[plr], billboard)
        end)
    end
    
    if plr.Character then createHighlight(plr.Character) end
    espConnections[plr] = plr.CharacterAdded:Connect(function(char)
        if espEnabled then createHighlight(char) end
    end)
end

local function removeESP(plr)
    if espBoxes[plr] then
        for _, v in pairs(espBoxes[plr]) do
            pcall(function() v:Destroy() end)
        end
        espBoxes[plr] = nil
    end
    if espConnections[plr] then
        espConnections[plr]:Disconnect()
        espConnections[plr] = nil
    end
end

local function enableESP()
    for _, plr in pairs(game.Players:GetPlayers()) do addESP(plr) end
    espConnections.playerAdded = game.Players.PlayerAdded:Connect(function(plr)
        if espEnabled then addESP(plr) end
    end)
    espConnections.playerRemoving = game.Players.PlayerRemoving:Connect(function(plr)
        removeESP(plr)
    end)
end

local function disableESP()
    for plr, _ in pairs(espBoxes) do removeESP(plr) end
    if espConnections.playerAdded then
        espConnections.playerAdded:Disconnect()
        espConnections.playerAdded = nil
    end
    if espConnections.playerRemoving then
        espConnections.playerRemoving:Disconnect()
        espConnections.playerRemoving = nil
    end
end



local function enableGhostMode()
    if not player.Character or not player.Character:FindFirstChild("HumanoidRootPart") then return end
    
    originalCFrame = player.Character.HumanoidRootPart.CFrame
    
    local humanoid = player.Character:FindFirstChild("Humanoid")
    if humanoid then
        humanoid.WalkSpeed = 0
        humanoid.JumpPower = 0
    end
    
    ghostPart = Instance.new("Part")
    ghostPart.Name = "GhostPart"
    ghostPart.Shape = Enum.PartType.Ball
    ghostPart.Size = Vector3.new(4, 4, 4)
    ghostPart.Transparency = 0.3
    ghostPart.Color = Color3.fromRGB(255, 255, 255)
    ghostPart.Material = Enum.Material.Neon
    ghostPart.CanCollide = false
    ghostPart.Anchored = true
    ghostPart.CFrame = originalCFrame
    ghostPart.Parent = workspace
    
    ghostOverlay = Instance.new("Frame")
    ghostOverlay.Name = "GhostOverlay"
    ghostOverlay.Size = UDim2.new(1, 0, 1, 0)
    ghostOverlay.Position = UDim2.new(0, 0, 0, 0)
    ghostOverlay.BackgroundColor3 = Color3.fromRGB(0, 50, 100)
    ghostOverlay.BackgroundTransparency = 0.8
    ghostOverlay.BorderSizePixel = 0
    ghostOverlay.ZIndex = -1
    ghostOverlay.Parent = ScreenGui
    
    workspace.CurrentCamera.CameraSubject = ghostPart
    workspace.CurrentCamera.CameraType = Enum.CameraType.Custom
    
    ghostConnection = RunService.Heartbeat:Connect(function()
        if not ghostEnabled or not ghostPart or not ghostPart.Parent then return end
        local textBoxFocused = UIS:GetFocusedTextBox()
        if textBoxFocused then return end
        
        if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            player.Character.HumanoidRootPart.CFrame = originalCFrame
        end
        
        local moveDir = Vector3.zero
        local cam = workspace.CurrentCamera
        local speed = flySpeed / 60
        
        if UIS:IsKeyDown(Enum.KeyCode.LeftShift) then speed = speed * 2 end
        if UIS:IsKeyDown(Enum.KeyCode.W) then moveDir = moveDir + cam.CFrame.LookVector end
        if UIS:IsKeyDown(Enum.KeyCode.S) then moveDir = moveDir - cam.CFrame.LookVector end
        if UIS:IsKeyDown(Enum.KeyCode.A) then moveDir = moveDir - cam.CFrame.RightVector end
        if UIS:IsKeyDown(Enum.KeyCode.D) then moveDir = moveDir + cam.CFrame.RightVector end
        if UIS:IsKeyDown(Enum.KeyCode.Space) then moveDir = moveDir + Vector3.new(0, 1, 0) end
        if UIS:IsKeyDown(Enum.KeyCode.LeftControl) then moveDir = moveDir - Vector3.new(0, 1, 0) end
        
        if moveDir.Magnitude > 0 then
            ghostPart.CFrame = ghostPart.CFrame + (moveDir.Unit * speed)
        end
    end)
end

local function disableGhostMode(teleport)
    if ghostConnection then
        ghostConnection:Disconnect()
        ghostConnection = nil
    end
    
    if ghostOverlay then
        ghostOverlay:Destroy()
        ghostOverlay = nil
    end
    
    if player.Character then
        local humanoid = player.Character:FindFirstChild("Humanoid")
        if humanoid then
            humanoid.WalkSpeed = 16
            humanoid.JumpPower = 50
        end
    end
    
    if ghostPart then
        local ghostPosition = ghostPart.CFrame
        ghostPart:Destroy()
        ghostPart = nil
        
        if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            workspace.CurrentCamera.CameraSubject = player.Character.Humanoid
            
            if teleport then
                player.Character.HumanoidRootPart.CFrame = ghostPosition
            end
        end
    end
end

local function enableGodmode()
    for _, conn in pairs(godmodeConnections) do
        if conn then conn:Disconnect() end
    end
    godmodeConnections = {}
    
    local function protectCharacter(char)
        if not char then return end
        
        local humanoid = char:FindFirstChild("Humanoid")
        if not humanoid then return end
        
        godmodeConnections[#godmodeConnections + 1] = humanoid:GetPropertyChangedSignal("Health"):Connect(function()
            if godmodeEnabled and humanoid.Health < humanoid.MaxHealth then
                humanoid.Health = humanoid.MaxHealth
            end
        end)
        
        godmodeConnections[#godmodeConnections + 1] = humanoid.HealthChanged:Connect(function(health)
            if godmodeEnabled and health < humanoid.MaxHealth then
                humanoid.Health = humanoid.MaxHealth
            end
        end)
        
        godmodeConnections[#godmodeConnections + 1] = RunService.Heartbeat:Connect(function()
            if not godmodeEnabled or not humanoid or not humanoid.Parent then return end
            if humanoid.Health < humanoid.MaxHealth then
                humanoid.Health = humanoid.MaxHealth
            end
        end)
        
        local healthScript = char:FindFirstChild("Health")
        if healthScript and healthScript:IsA("Script") then
            healthScript.Disabled = true
        end
    end
    
    if player.Character then
        protectCharacter(player.Character)
    end
    
    godmodeConnections[#godmodeConnections + 1] = player.CharacterAdded:Connect(function(char)
        if godmodeEnabled then
            task.wait(0.1)
            protectCharacter(char)
        end
    end)
end

local function disableGodmode()
    for _, conn in pairs(godmodeConnections) do
        if conn then conn:Disconnect() end
    end
    godmodeConnections = {}
    
    if player.Character then
        local healthScript = player.Character:FindFirstChild("Health")
        if healthScript and healthScript:IsA("Script") then
            healthScript.Disabled = false
        end
    end
end

local function hasKeyCard()
    if player.Backpack:FindFirstChild("Key card") then return true end
    if player.Character and player.Character:FindFirstChild("Key card") then return true end
    return false
end

local function findKeyCardInWorkspace()
    for _, item in pairs(workspace:GetDescendants()) do
        if item:IsA("Tool") and item.Name == "Key card" then
            local handle = item:FindFirstChild("Handle")
            if handle and handle:IsA("BasePart") then
                return handle
            end
        end
    end
    return nil
end

local function findKeyCardInReplicatedStorage()
    local tools = game:GetService("ReplicatedStorage"):FindFirstChild("Tools")
    if tools then
        return tools:FindFirstChild("Key card")
    end
    return nil
end

local function enableAutoCard()
    if autoCardLoop then return end
    autoCardLoop = task.spawn(function()
        while autoCardEnabled do
            task.wait(1)
            pcall(function()
                if not player.Character or not player.Character:FindFirstChild("HumanoidRootPart") then return end
                
                if hasKeyCard() then
                    autoCardEnabled = false
                    autoCardIndicator.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
                    autoCardLoop = nil
                    return
                end
                
                local cardHandle = findKeyCardInWorkspace()
                if cardHandle then
                    local originalCFrame = player.Character.HumanoidRootPart.CFrame
                    player.Character.HumanoidRootPart.CFrame = cardHandle.CFrame
                    task.wait(0.2)
                    
                    local clickDetector = cardHandle.Parent:FindFirstChildOfClass("ClickDetector")
                    if clickDetector then
                        fireclickdetector(clickDetector)
                    end
                    
                    task.wait(0.2)
                    player.Character.HumanoidRootPart.CFrame = originalCFrame
                else
                    local cardTool = findKeyCardInReplicatedStorage()
                    if cardTool then
                        local clonedCard = cardTool:Clone()
                        clonedCard.Parent = player.Backpack
                    end
                end
            end)
        end
        autoCardLoop = nil
    end)
end

local function disableAutoCard()
    autoCardEnabled = false
    if autoCardLoop then
        task.cancel(autoCardLoop)
        autoCardLoop = nil
    end
end



local function getClosestEnemy()
    local mouse = player:GetMouse()
    local mousePos = Vector2.new(mouse.X, mouse.Y)
    local closest = nil
    local shortestDistance = aimbotFOV
    
    for _, plr in pairs(game.Players:GetPlayers()) do
        if plr ~= player and plr.Character and plr.Team and player.Team then
            local myTeam = player.Team.Name
            local theirTeam = plr.Team.Name
            local isTarget = false
            
            if myTeam == "Guards" and theirTeam == "Criminals" then
                isTarget = true
            elseif myTeam == "Criminals" and theirTeam == "Guards" then
                isTarget = true
            end
            
            if isTarget then
                local humanoid = plr.Character:FindFirstChild("Humanoid")
                local head = plr.Character:FindFirstChild("Head")
                
                if humanoid and head and humanoid.Health > 0 then
                    local screenPos, onScreen = workspace.CurrentCamera:WorldToViewportPoint(head.Position)
                    if onScreen then
                        local distance = (Vector2.new(screenPos.X, screenPos.Y) - mousePos).Magnitude
                        if distance < shortestDistance then
                            local ray = Ray.new(workspace.CurrentCamera.CFrame.Position, (head.Position - workspace.CurrentCamera.CFrame.Position).Unit * 1000)
                            local hit = workspace:FindPartOnRayWithIgnoreList(ray, {player.Character})
                            if hit and hit:IsDescendantOf(plr.Character) then
                                shortestDistance = distance
                                closest = head
                            end
                        end
                    end
                end
            end
        end
    end
    return closest
end

RunService.RenderStepped:Connect(function()
    if not aimbotEnabled or not rightMouseDown then return end
    local target = getClosestEnemy()
    if target then
        local cam = workspace.CurrentCamera
        local targetPos = target.Position
        cam.CFrame = CFrame.new(cam.CFrame.Position, targetPos)
    end
end)



rejoinBtn.MouseButton1Click:Connect(function()
    TeleportService:Teleport(game.PlaceId, player)
end)

UIS.InputBegan:Connect(function(input, gameProcessed)
    if input.UserInputType == Enum.UserInputType.MouseButton2 then
        rightMouseDown = true
    end
    
    if gameProcessed then return end
    
    if input.KeyCode == toggleKey then
        if ghostEnabled then
            ghostEnabled = false
            disableGhostMode(false)
            noclipIndicator.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
        else
            MainFrame.Visible = not MainFrame.Visible
            SettingsFrame.Visible = false
        end
    elseif input.KeyCode == tpMouseKey and tpMouseEnabled then
        pcall(function()
            local mouse = player:GetMouse()
            if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                player.Character.HumanoidRootPart.CFrame = CFrame.new(mouse.Hit.Position + Vector3.new(0, 3, 0))
            end
        end)
    elseif input.KeyCode == flyKey then
        flying = not flying
        if flying then
            startFly()
            flyIndicator.BackgroundColor3 = Color3.fromRGB(50, 255, 50)
        else
            stopFly()
            flyIndicator.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
        end
    elseif input.KeyCode == espKey then
        espEnabled = not espEnabled
        if espEnabled then
            enableESP()
            espIndicator.BackgroundColor3 = Color3.fromRGB(50, 255, 50)
        else
            disableESP()
            espIndicator.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
        end
    elseif input.KeyCode == aimbotKey then
        aimbotEnabled = not aimbotEnabled
        if aimbotEnabled then
            aimbotIndicator.BackgroundColor3 = Color3.fromRGB(50, 255, 50)
        else
            aimbotIndicator.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
        end
    elseif input.KeyCode == ghostKey then
        if not ghostEnabled then
            ghostEnabled = true
            enableGhostMode()
            noclipIndicator.BackgroundColor3 = Color3.fromRGB(50, 255, 50)
        else
            ghostEnabled = false
            disableGhostMode(true)
            noclipIndicator.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
        end
    end
end)

ScreenGui.Parent = game.CoreGui

player.CharacterAdded:Connect(function()
    if ghostEnabled then
        ghostEnabled = false
        disableGhostMode(false)
        noclipIndicator.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
    end
end)

godmodeEnabled = true
enableGodmode()
godmodeIndicator.BackgroundColor3 = Color3.fromRGB(50, 255, 50)

UIS.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton2 then
        rightMouseDown = false
    end
end)

print("[VidaPrisao] Carregado! Z=Menu E=Fly J=ESP X=Aimbot G=Ghost Q=TPMouse")
