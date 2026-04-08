--// SAKZZ TP GUI FINAL (SAFE)

repeat task.wait() until game:IsLoaded()

-- ===== PROTECT RINGAN =====
local _sig = "Sakzz_tp"

local function _stop()
	warn("script stopped")
	return
end

-- check basic (jangan keras)
if not game then
	_stop()
end

-- checksum ringan
local function _h(s)
	local r = 0
	for i = 1,#s do
		r = (r + string.byte(s,i)*i) % 999999
	end
	return r
end

-- Updated to check against the new signature
if _h(_sig) ~= _h("Sakzz_tp") then
	_stop()
end

-- ===== SERVICES =====
local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local points = {TP1=nil, TP2=nil, TP3=nil}

-- ===== CHARACTER =====
local function getChar()
	local char = player.Character or player.CharacterAdded:Wait()
	while not char:FindFirstChild("HumanoidRootPart") do task.wait() end
	return char
end

-- ===== TELEPORT =====
local function teleportTo(cf)
	local hrp = getChar().HumanoidRootPart
	hrp.CFrame = cf + Vector3.new(0,3,0)
end

-- ===== GUI ROOT =====
local gui = Instance.new("ScreenGui")
gui.Name = "core_"..math.random(100,999)
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
pcall(function() gui.Parent = game.CoreGui end)

-- ===== MAIN FRAME =====
local frame = Instance.new("Frame", gui)
frame.Size = UDim2.fromOffset(180,120)
frame.Position = UDim2.fromOffset(20,200)
frame.BackgroundColor3 = Color3.fromRGB(15,15,15)
frame.BackgroundTransparency = 0.15
frame.BorderSizePixel = 0
frame.ClipsDescendants = true
frame.Active = true

-- ===== HEADER =====
local header = Instance.new("Frame", frame)
header.Size = UDim2.new(1,0,0,28)
header.BackgroundColor3 = Color3.fromRGB(25,25,25)
header.BorderSizePixel = 0
header.Active = true

local title = Instance.new("TextLabel", header)
title.Size = UDim2.new(1,-50,1,0)
title.Position = UDim2.fromOffset(6,0)
title.Text = "SAKZZ TP"
title.Font = Enum.Font.GothamBold
title.TextSize = 14
title.TextColor3 = Color3.new(1,1,1)
title.BackgroundTransparency = 1
title.TextXAlignment = Enum.TextXAlignment.Left

local mini = Instance.new("TextButton", header)
mini.Size = UDim2.fromOffset(24,24)
mini.Position = UDim2.new(1,-50,0,2)
mini.Text = "≡"
mini.Font = Enum.Font.GothamBold
mini.TextSize = 16
mini.BackgroundColor3 = Color3.fromRGB(60,60,60)
mini.TextColor3 = Color3.new(1,1,1)
mini.BorderSizePixel = 0

local close = Instance.new("TextButton", header)
close.Size = UDim2.fromOffset(24,24)
close.Position = UDim2.new(1,-26,0,2)
close.Text = "X"
close.Font = Enum.Font.GothamBold
close.TextSize = 14
close.BackgroundColor3 = Color3.fromRGB(120,40,40)
close.TextColor3 = Color3.new(1,1,1)
close.BorderSizePixel = 0

-- ===== CONTENT =====
local content = Instance.new("Frame", frame)
content.Position = UDim2.fromOffset(0,28)
content.Size = UDim2.new(1,0,1,-28)
content.BackgroundTransparency = 1

-- ===== UI HELPERS =====
local function label(text,y)
	local l = Instance.new("TextLabel", content)
	l.Size = UDim2.new(1,0,0,12)
	l.Position = UDim2.fromOffset(0,y)
	l.Text = text
	l.Font = Enum.Font.Gotham
	l.TextSize = 11
	l.TextColor3 = Color3.fromRGB(200,200,200)
	l.BackgroundTransparency = 1
	return l
end

local function btn(text,x,y)
	local b = Instance.new("TextButton", content)
	b.Size = UDim2.fromOffset(48,22)
	b.Position = UDim2.fromOffset(x,y)
	b.Text = text
	b.Font = Enum.Font.GothamBold
	b.TextSize = 11
	b.TextColor3 = Color3.new(1,1,1)
	b.BackgroundColor3 = Color3.fromRGB(60,60,60)
	b.BorderSizePixel = 0
	return b
end

-- ===== TP =====
label("Save TP",4)
local s1 = btn("TP1",12,18)
local s2 = btn("TP2",66,18)
local s3 = btn("TP3",120,18)

label("Load TP",46)
local l1 = btn("TP1",12,60)
local l2 = btn("TP2",66,60)
local l3 = btn("TP3",120,60)

s1.MouseButton1Click:Connect(function()
	points.TP1 = getChar().HumanoidRootPart.CFrame
end)

s2.MouseButton1Click:Connect(function()
	points.TP2 = getChar().HumanoidRootPart.CFrame
end)

s3.MouseButton1Click:Connect(function()
	points.TP3 = getChar().HumanoidRootPart.CFrame
end)

l1.MouseButton1Click:Connect(function()
	if points.TP1 then teleportTo(points.TP1) end
end)

l2.MouseButton1Click:Connect(function()
	if points.TP2 then teleportTo(points.TP2) end
end)

l3.MouseButton1Click:Connect(function()
	if points.TP3 then teleportTo(points.TP3) end
end)

-- ===== DRAG =====
do
	local dragging = false
	local dragStart, startPos

	header.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1
		or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true
			dragStart = input.Position
			startPos = frame.Position
		end
	end)

	UIS.InputChanged:Connect(function(input)
		if dragging then
			local delta = input.Position - dragStart
			frame.Position = startPos + UDim2.fromOffset(delta.X, delta.Y)
		end
	end)

	UIS.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1
		or input.UserInputType == Enum.UserInputType.Touch then
			dragging = false
		end
	end)
end

-- ===== MINI =====
local opened = true
mini.MouseButton1Click:Connect(function()
	opened = not opened

	content.Visible = opened

	TweenService:Create(frame, TweenInfo.new(0.25), {
		Size = opened and UDim2.fromOffset(180,120) or UDim2.fromOffset(180,28)
	}):Play()
end)

-- ===== CLOSE =====
close.MouseButton1Click:Connect(function()
	gui:Destroy()
end)
