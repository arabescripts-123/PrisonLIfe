-- Vida Prisao Script - Versão Integral Corrigida para Solara
print("[VidaPrisao] Iniciando...")

local player = game.Players.LocalPlayer
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TeleportService = game:GetService("TeleportService")

-- Limpeza de interface anterior
pcall(function()
    if game.CoreGui:FindFirstChild("VidaPrisaoGui") then
        game.CoreGui:FindFirstChild("VidaPrisaoGui"):Destroy()
    end
end)

local character = player.Character or player.CharacterAdded:Wait()
task.wait(0.5)

-- ESTADOS E VARIÁVEIS GLOBAIS
local toggleKey = Enum.KeyCode.Z
local flySpeed = 65
local flyKey = Enum.KeyCode.E
local espKey = Enum.KeyCode.J
local aimbotKey = Enum.KeyCode.X
local ghostKey = Enum.KeyCode.G
local tpMouseKey = Enum.KeyCode.Q

local flying = false
local aimbotEnabled = false
local espEnabled = false
local ghostEnabled = false
local godmodeEnabled = false
local autoCardEnabled = false
local tpMouseEnabled = false
local rightMouseDown = false

local aimbotFOV = 300
local bodyVelocity, bodyGyro
local ghostPart, ghostConnection, originalCFrame, ghostOverlay
local godmodeConnections = {}
local espBoxes = {}
local espConnections = {}
local autoCardLoop = nil

-- INTERFACE PRINCIPAL
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "VidaPrisaoGui"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = game.CoreGui

local MainFrame = Instance.new("Frame")
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
MainFrame.Position = UDim2.new(0.02, 0, 0.3, 0)
MainFrame.Size = UDim2.new(0, 220, 0, 395)

local function applyCorner(parent, radius)
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, radius or 8)
    corner.Parent = parent
end

applyCorner(MainFrame)

local Title = Instance.new("TextLabel")
Title.Parent = MainFrame
Title.BackgroundTransparency = 1
Title.Size = UDim2.new(1, -75, 0, 40)
Title.Font = Enum.Font.GothamBold
Title.Text = "Arabe Scripts"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 18
Title.Position = UDim2.new(0, 10, 0, 0)

-- BOTÕES DE FUNÇÃO (Criação Dinâmica para manter o visual original)
local function createButton(text, pos)
    local btn = Instance.new("TextButton")
    btn.Parent = MainFrame
    btn.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
    btn.Position = pos
    btn.Size = UDim2.new(0, 130, 0, 35)
    btn.Font = Enum.Font.Gotham
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 12
    applyCorner(btn, 6)
    
    local ind = Instance.new("Frame")
    ind.Parent = btn
    ind.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
    ind.Position = UDim2.new(1, -20, 0.5, -8)
    ind.Size = UDim2.new(0, 16, 0, 16)
    applyCorner(ind, 10)
    
    return btn, ind
end

local function createSmallButton(text, pos)
    local btn = Instance.new("TextButton")
    btn.Parent = MainFrame
    btn.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
    btn.Position = pos
    btn.Size = UDim2.new(0, 95, 0, 35)
    btn.Font = Enum.Font.Gotham
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 11
    applyCorner(btn, 6)
    
    local ind = Instance.new("Frame")
    ind.Parent = btn
    ind.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
    ind.Position = UDim2.new(1, -15, 0.5, -5)
    ind.Size = UDim2.new(0, 10, 0, 10)
    applyCorner(ind, 10)
    
    return btn, ind
end

local function createKeyBox(text, pos)
    local box = Instance.new("TextBox")
    box.Parent = MainFrame
    box.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    box.Position = pos
    box.Size = UDim2.new(0, 35, 0, 35)
    box.Font = Enum.Font.Gotham
    box.Text = text
    box.TextColor3 = Color3.fromRGB(255, 255, 255)
    box.TextSize = 12
    applyCorner(box, 6)
    return box
end

-- Layout original dos botões
local tpCriminalBtn, tpCriminalInd = createSmallButton("Criminals", UDim2.new(0, 10, 0, 50))
local tpCamperBtn, tpCamperInd = createSmallButton("Camper", UDim2.new(0, 110, 0, 50))
local flyBtn, flyInd = createButton("Fly", UDim2.new(0, 10, 0, 95))
local flyKeyBox = createKeyBox("E", UDim2.new(0, 145, 0, 95))
local espBtn, espInd = createButton("ESP", UDim2.new(0, 10, 0, 140))
local espKeyBox = createKeyBox("J", UDim2.new(0, 145, 0, 140))
local aimbotBtn, aimbotInd = createButton("Aimbot", UDim2.new(0, 10, 0, 185))
local aimbotKeyBox = createKeyBox("X", UDim2.new(0, 145, 0, 185))
local ghostBtn, ghostInd = createButton("Ghost", UDim2.new(0, 10, 0, 230))
local ghostKeyBox = createKeyBox("G", UDim2.new(0, 145, 0, 230))
local godmodeBtn, godmodeInd = createSmallButton("Godmode", UDim2.new(0, 10, 0, 275))
local autoCardBtn, autoCardInd = createSmallButton("Auto Card", UDim2.new(0, 110, 0, 275))

-- Lógica de Fly
local function startFly()
    flying = true
    local root = player.Character:FindFirstChild("HumanoidRootPart")
    if not root then return end
    bodyVelocity = Instance.new("BodyVelocity", root)
    bodyVelocity.MaxForce = Vector3.new(9e9, 9e9, 9e9)
    bodyVelocity.Velocity = Vector3.zero
    bodyGyro = Instance.new("BodyGyro", root)
    bodyGyro.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
    bodyGyro.CFrame = root.CFrame
    if player.Character:FindFirstChild("Humanoid") then player.Character.Humanoid.PlatformStand = true end
end

local function stopFly()
    flying = false
    if bodyVelocity then bodyVelocity:Destroy() end
    if bodyGyro then bodyGyro:Destroy() end
    if player.Character and player.Character:FindFirstChild("Humanoid") then player.Character.Humanoid.PlatformStand = false end
end

-- Lógica ESP
local function addESP(plr)
    if plr == player then return end
    local function createHighlight(char)
        if not espEnabled then return end
        local h = Instance.new("Highlight", char)
        h.Name = "ESP_H"
        h.FillTransparency = 0.6
        h.FillColor = (plr.Team == player.Team) and Color3.new(0,1,0) or Color3.new(1,0,0)
    end
    plr.CharacterAdded:Connect(createHighlight)
    if plr.Character then createHighlight(plr.Character) end
end

-- Lógica Godmode
local function toggleGodmode(state)
    godmodeEnabled = state
    if state then
        task.spawn(function()
            while godmodeEnabled do
                if player.Character and player.Character:FindFirstChild("Humanoid") then
                    player.Character.Humanoid.Health = 100
                end
                task.wait()
            end
        end)
    end
end

-- Lógica Aimbot
RunService.RenderStepped:Connect(function()
    if aimbotEnabled and rightMouseDown then
        local target = nil
        local dist = aimbotFOV
        for _, p in pairs(game.Players:GetPlayers()) do
            if p ~= player and p.Character and p.Character:FindFirstChild("Head") then
                local pos, onScreen = workspace.CurrentCamera:WorldToViewportPoint(p.Character.Head.Position)
                if onScreen then
                    local mDist = (Vector2.new(pos.X, pos.Y) - UIS:GetMouseLocation()).Magnitude
                    if mDist < dist then
                        dist = mDist
                        target = p.Character.Head
                    end
                end
            end
        end
        if target then
            workspace.CurrentCamera.CFrame = CFrame.new(workspace.CurrentCamera.CFrame.Position, target.Position)
        end
    end
    -- Movimento Fly
    if flying and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        local root = player.Character.HumanoidRootPart
        local cam = workspace.CurrentCamera
        local moveDir = Vector3.zero
        if UIS:IsKeyDown(Enum.KeyCode.W) then moveDir += cam.CFrame.LookVector end
        if UIS:IsKeyDown(Enum.KeyCode.S) then moveDir -= cam.CFrame.LookVector end
        if UIS:IsKeyDown(Enum.KeyCode.A) then moveDir -= cam.CFrame.RightVector end
        if UIS:IsKeyDown(Enum.KeyCode.D) then moveDir += cam.CFrame.RightVector end
        if bodyVelocity then bodyVelocity.Velocity = moveDir * flySpeed end
        if bodyGyro then bodyGyro.CFrame = cam.CFrame end
    end
end)

-- Botão Rejoin (R) no topo
local rejoinBtn = Instance.new("TextButton")
rejoinBtn.Parent = MainFrame
rejoinBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
rejoinBtn.Position = UDim2.new(1, -70, 0, 5)
rejoinBtn.Size = UDim2.new(0, 35, 0, 30)
rejoinBtn.Text = "R"
rejoinBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
applyCorner(rejoinBtn, 6)
rejoinBtn.MouseButton1Click:Connect(function() TeleportService:Teleport(game.PlaceId, player) end)

-- CONEXÕES DOS BOTÕES
flyBtn.MouseButton1Click:Connect(function()
    flying = not flying
    if flying then startFly() else stopFly() end
    flyInd.BackgroundColor3 = flying and Color3.new(0,1,0) or Color3.new(1,0,0)
end)

espBtn.MouseButton1Click:Connect(function()
    espEnabled = not espEnabled
    espInd.BackgroundColor3 = espEnabled and Color3.new(0,1,0) or Color3.new(1,0,0)
    if espEnabled then for _, p in pairs(game.Players:GetPlayers()) do addESP(p) end end
end)

aimbotBtn.MouseButton1Click:Connect(function()
    aimbotEnabled = not aimbotEnabled
    aimbotInd.BackgroundColor3 = aimbotEnabled and Color3.new(0,1,0) or Color3.new(1,0,0)
end)

godmodeBtn.MouseButton1Click:Connect(function()
    toggleGodmode(not godmodeEnabled)
    godmodeInd.BackgroundColor3 = godmodeEnabled and Color3.new(0,1,0) or Color3.new(1,0,0)
end)

tpCriminalBtn.MouseButton1Click:Connect(function()
    if player.Character then player.Character.HumanoidRootPart.CFrame = CFrame.new(-943, 95, 2063) end
end)

tpCamperBtn.MouseButton1Click:Connect(function()
    if player.Character then player.Character.HumanoidRootPart.CFrame = CFrame.new(726, 122, 2587) end
end)

ghostBtn.MouseButton1Click:Connect(function()
    ghostEnabled = not ghostEnabled
    ghostInd.BackgroundColor3 = ghostEnabled and Color3.new(0,1,0) or Color3.new(1,0,0)
    if player.Character then player.Character.HumanoidRootPart.Anchored = ghostEnabled end
end)

-- INPUTS E TECLAS
UIS.InputBegan:Connect(function(input, processed)
    if processed then return end
    if input.KeyCode == toggleKey then MainFrame.Visible = not MainFrame.Visible end
    if input.KeyCode == Enum.KeyCode.E then flyBtn:MouseButton1Click() end
    if input.KeyCode == Enum.KeyCode.X then aimbotBtn:MouseButton1Click() end
    if input.UserInputType == Enum.UserInputType.MouseButton2 then rightMouseDown = true end
end)

UIS.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton2 then rightMouseDown = false end
end)

print("[VidaPrisao] Carregado e Unificado para Solara!")
