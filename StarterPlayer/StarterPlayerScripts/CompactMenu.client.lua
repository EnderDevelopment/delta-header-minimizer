-- Creates a compact, draggable in-game menu with its header at the bottom.
-- Place this LocalScript in StarterPlayer > StarterPlayerScripts.

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local existing = playerGui:FindFirstChild("CompactMenu")
if existing then
	existing:Destroy()
end

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "CompactMenu"
screenGui.ResetOnSpawn = false
screenGui.IgnoreGuiInset = false
screenGui.Parent = playerGui

local panel = Instance.new("Frame")
panel.Name = "Panel"
panel.Size = UDim2.fromOffset(280, 190)
panel.Position = UDim2.new(1, -300, 1, -220)
panel.BackgroundColor3 = Color3.fromRGB(28, 31, 38)
panel.BorderSizePixel = 0
panel.ClipsDescendants = true
panel.Parent = screenGui

local panelCorner = Instance.new("UICorner")
panelCorner.CornerRadius = UDim.new(0, 10)
panelCorner.Parent = panel

local panelStroke = Instance.new("UIStroke")
panelStroke.Color = Color3.fromRGB(69, 76, 91)
panelStroke.Thickness = 1
panelStroke.Parent = panel

local stack = Instance.new("UIListLayout")
stack.Name = "VerticalOrder"
stack.FillDirection = Enum.FillDirection.Vertical
stack.SortOrder = Enum.SortOrder.LayoutOrder
stack.Padding = UDim.new(0, 0)
stack.Parent = panel

local body = Instance.new("Frame")
body.Name = "Body"
body.LayoutOrder = 1
body.Size = UDim2.new(1, 0, 0, 146)
body.BackgroundTransparency = 1
body.Parent = panel

local bodyPadding = Instance.new("UIPadding")
bodyPadding.PaddingTop = UDim.new(0, 14)
bodyPadding.PaddingBottom = UDim.new(0, 12)
bodyPadding.PaddingLeft = UDim.new(0, 14)
bodyPadding.PaddingRight = UDim.new(0, 14)
bodyPadding.Parent = body

local title = Instance.new("TextLabel")
title.Name = "Title"
title.Size = UDim2.new(1, 0, 0, 24)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.Text = "Compact Menu"
title.TextColor3 = Color3.fromRGB(245, 247, 250)
title.TextSize = 16
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = body

local status = Instance.new("TextLabel")
status.Name = "Status"
status.Position = UDim2.fromOffset(0, 34)
status.Size = UDim2.new(1, 0, 0, 34)
status.BackgroundTransparency = 1
status.Font = Enum.Font.Gotham
status.Text = "Ready"
status.TextColor3 = Color3.fromRGB(179, 187, 201)
status.TextSize = 13
status.TextXAlignment = Enum.TextXAlignment.Left
status.Parent = body

local actionButton = Instance.new("TextButton")
actionButton.Name = "ActionButton"
actionButton.Position = UDim2.fromOffset(0, 78)
actionButton.Size = UDim2.new(1, 0, 0, 38)
actionButton.BackgroundColor3 = Color3.fromRGB(55, 111, 214)
actionButton.BorderSizePixel = 0
actionButton.Font = Enum.Font.GothamSemibold
actionButton.Text = "Run Sample Action"
actionButton.TextColor3 = Color3.new(1, 1, 1)
actionButton.TextSize = 13
actionButton.AutoButtonColor = true
actionButton.Parent = body

local buttonCorner = Instance.new("UICorner")
buttonCorner.CornerRadius = UDim.new(0, 7)
buttonCorner.Parent = actionButton

local header = Instance.new("Frame")
header.Name = "Header"
header.LayoutOrder = 2
header.Size = UDim2.new(1, 0, 0, 44)
header.BackgroundColor3 = Color3.fromRGB(39, 43, 52)
header.BorderSizePixel = 0
header.Parent = panel

local headerTitle = Instance.new("TextLabel")
headerTitle.Name = "HeaderTitle"
headerTitle.Position = UDim2.fromOffset(14, 0)
headerTitle.Size = UDim2.new(1, -68, 1, 0)
headerTitle.BackgroundTransparency = 1
headerTitle.Font = Enum.Font.GothamSemibold
headerTitle.Text = "MENU"
headerTitle.TextColor3 = Color3.fromRGB(222, 227, 235)
headerTitle.TextSize = 12
headerTitle.TextXAlignment = Enum.TextXAlignment.Left
headerTitle.Parent = header

local minimizeButton = Instance.new("TextButton")
minimizeButton.Name = "MinimizeButton"
minimizeButton.AnchorPoint = Vector2.new(1, 0.5)
minimizeButton.Position = UDim2.new(1, -10, 0.5, 0)
minimizeButton.Size = UDim2.fromOffset(30, 28)
minimizeButton.BackgroundColor3 = Color3.fromRGB(56, 62, 74)
minimizeButton.BorderSizePixel = 0
minimizeButton.Font = Enum.Font.GothamBold
minimizeButton.Text = "−"
minimizeButton.TextColor3 = Color3.fromRGB(245, 247, 250)
minimizeButton.TextSize = 18
minimizeButton.Parent = header

local minimizeCorner = Instance.new("UICorner")
minimizeCorner.CornerRadius = UDim.new(0, 6)
minimizeCorner.Parent = minimizeButton

local expanded = true
local expandedHeight = 190
local headerHeight = 44
local tweenInfo = TweenInfo.new(0.18, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

minimizeButton.Activated:Connect(function()
	expanded = not expanded
	body.Visible = expanded
	minimizeButton.Text = expanded and "−" or "+"
	local targetHeight = expanded and expandedHeight or headerHeight
	TweenService:Create(panel, tweenInfo, { Size = UDim2.fromOffset(280, targetHeight) }):Play()
end)

actionButton.Activated:Connect(function()
	status.Text = "Sample action completed"
end)

local dragging = false
local dragStart
local startPosition

header.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		dragging = true
		dragStart = input.Position
		startPosition = panel.Position
	end
end)

UserInputService.InputChanged:Connect(function(input)
	if not dragging then
		return
	end
	if input.UserInputType ~= Enum.UserInputType.MouseMovement and input.UserInputType ~= Enum.UserInputType.Touch then
		return
	end
	local delta = input.Position - dragStart
	panel.Position = UDim2.new(
		startPosition.X.Scale, startPosition.X.Offset + delta.X,
		startPosition.Y.Scale, startPosition.Y.Offset + delta.Y
	)
end)

UserInputService.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		dragging = false
	end
end)
