-- ============================================================
-- LUX UI Library
-- ============================================================
-- This is a complete UI library inspired by Wand UI (Redz Library V5)
-- with enhanced features, better performance, and a sleek design.
--
-- 🔹 Made by: real_redz
-- 🔹 Version: 1.0.0
-- 🔹 Open-Source & Lightweight
-- ============================================================

local LUX = {}
LUX.Version = "1.0.0"
LUX.Author = "real_redz"
LUX.Repository = "https://github.com/tlredz/LUX"

-- ============================================================
-- SERVICES
-- ============================================================
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")
local CoreGui = game:GetService("CoreGui")
local Lighting = game:GetService("Lighting")

local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

-- ============================================================
-- UTILITY FUNCTIONS
-- ============================================================
local function clone(ref)
    return ref and ref:Clone() or nil
end

local function isFileExists(path)
    if isfile then return isfile(path) end
    return false
end

local function readFile(path)
    if readfile then return readfile(path) end
    return nil
end

local function writeFile(path, content)
    if writefile then writefile(path, content) end
end

local function makeFolder(path)
    if makefolder then makefolder(path) end
end

local function deleteFile(path)
    if delfile then delfile(path) end
end

local function deleteFolder(path)
    if delfolder then delfolder(path) end
end

-- ============================================================
-- THEMES
-- ============================================================
LUX.Themes = {
    Dark = {
        Colors = {
            Background = ColorSequence.new({
                ColorSequenceKeypoint.new(0, Color3.fromRGB(20, 20, 20)),
                ColorSequenceKeypoint.new(0.5, Color3.fromRGB(28, 28, 28)),
                ColorSequenceKeypoint.new(1, Color3.fromRGB(20, 20, 20))
            }),
            Primary = Color3.fromRGB(88, 101, 242),
            OnPrimary = Color3.fromRGB(61, 67, 135),
            Secondary = Color3.fromRGB(45, 45, 45),
            Stroke = Color3.fromRGB(60, 60, 60),
            Text = Color3.fromRGB(255, 255, 255),
            TextDark = Color3.fromRGB(200, 200, 200),
            TextDarker = Color3.fromRGB(160, 160, 160),
            Error = Color3.fromRGB(255, 80, 80),
            Success = Color3.fromRGB(80, 255, 80),
            Warning = Color3.fromRGB(255, 200, 0),
            Info = Color3.fromRGB(80, 180, 255),
            ScrollBar = Color3.fromRGB(80, 80, 80),
            ButtonDefault = Color3.fromRGB(30, 30, 30),
            ButtonHover = Color3.fromRGB(45, 45, 45),
            ButtonActive = Color3.fromRGB(60, 60, 60),
            ToggleOn = Color3.fromRGB(88, 101, 242),
            ToggleOff = Color3.fromRGB(60, 60, 60),
            ToggleDot = Color3.fromRGB(255, 255, 255),
            SliderBar = Color3.fromRGB(88, 101, 242),
            SliderBackground = Color3.fromRGB(60, 60, 60),
            DropdownBackground = Color3.fromRGB(30, 30, 30),
            DropdownHover = Color3.fromRGB(45, 45, 45),
            DialogBackground = Color3.fromRGB(25, 25, 25),
            NotificationBackground = Color3.fromRGB(30, 30, 30),
            Border = Color3.fromRGB(50, 50, 50),
            BorderHover = Color3.fromRGB(70, 70, 70),
            Icon = Color3.fromRGB(220, 220, 220),
        },
        Fonts = {
            Normal = Enum.Font.Gotham,
            Medium = Enum.Font.GothamMedium,
            Bold = Enum.Font.GothamBold,
            ExtraBold = Enum.Font.GothamBlack,
            Mono = Enum.Font.Code,
        },
        BackgroundTransparency = 0.03,
        CornerRadius = UDim.new(0, 8),
        StrokeThickness = 1.5,
    },
    
    Light = {
        Colors = {
            Background = ColorSequence.new({
                ColorSequenceKeypoint.new(0, Color3.fromRGB(245, 245, 245)),
                ColorSequenceKeypoint.new(0.5, Color3.fromRGB(240, 240, 240)),
                ColorSequenceKeypoint.new(1, Color3.fromRGB(245, 245, 245))
            }),
            Primary = Color3.fromRGB(88, 101, 242),
            OnPrimary = Color3.fromRGB(61, 67, 135),
            Secondary = Color3.fromRGB(220, 220, 220),
            Stroke = Color3.fromRGB(200, 200, 200),
            Text = Color3.fromRGB(0, 0, 0),
            TextDark = Color3.fromRGB(60, 60, 60),
            TextDarker = Color3.fromRGB(100, 100, 100),
            Error = Color3.fromRGB(200, 50, 50),
            Success = Color3.fromRGB(50, 200, 50),
            Warning = Color3.fromRGB(200, 150, 0),
            Info = Color3.fromRGB(50, 150, 200),
            ScrollBar = Color3.fromRGB(180, 180, 180),
            ButtonDefault = Color3.fromRGB(235, 235, 235),
            ButtonHover = Color3.fromRGB(220, 220, 220),
            ButtonActive = Color3.fromRGB(200, 200, 200),
            ToggleOn = Color3.fromRGB(88, 101, 242),
            ToggleOff = Color3.fromRGB(200, 200, 200),
            ToggleDot = Color3.fromRGB(255, 255, 255),
            SliderBar = Color3.fromRGB(88, 101, 242),
            SliderBackground = Color3.fromRGB(200, 200, 200),
            DropdownBackground = Color3.fromRGB(245, 245, 245),
            DropdownHover = Color3.fromRGB(230, 230, 230),
            DialogBackground = Color3.fromRGB(245, 245, 245),
            NotificationBackground = Color3.fromRGB(245, 245, 245),
            Border = Color3.fromRGB(200, 200, 200),
            BorderHover = Color3.fromRGB(180, 180, 180),
            Icon = Color3.fromRGB(60, 60, 60),
        },
        Fonts = {
            Normal = Enum.Font.Gotham,
            Medium = Enum.Font.GothamMedium,
            Bold = Enum.Font.GothamBold,
            ExtraBold = Enum.Font.GothamBlack,
            Mono = Enum.Font.Code,
        },
        BackgroundTransparency = 0.02,
        CornerRadius = UDim.new(0, 8),
        StrokeThickness = 1,
    },
    
    Balenciaga = {
        Colors = {
            Background = ColorSequence.new({
                ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
                ColorSequenceKeypoint.new(0.5, Color3.fromRGB(250, 250, 250)),
                ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255))
            }),
            Primary = Color3.fromRGB(0, 0, 0),
            OnPrimary = Color3.fromRGB(50, 50, 50),
            Secondary = Color3.fromRGB(240, 240, 240),
            Stroke = Color3.fromRGB(0, 0, 0),
            Text = Color3.fromRGB(0, 0, 0),
            TextDark = Color3.fromRGB(80, 80, 80),
            TextDarker = Color3.fromRGB(120, 120, 120),
            Error = Color3.fromRGB(200, 50, 50),
            Success = Color3.fromRGB(50, 200, 50),
            Warning = Color3.fromRGB(200, 150, 0),
            Info = Color3.fromRGB(50, 150, 200),
            ScrollBar = Color3.fromRGB(0, 0, 0),
            ButtonDefault = Color3.fromRGB(255, 255, 255),
            ButtonHover = Color3.fromRGB(240, 240, 240),
            ButtonActive = Color3.fromRGB(220, 220, 220),
            ToggleOn = Color3.fromRGB(0, 0, 0),
            ToggleOff = Color3.fromRGB(220, 220, 220),
            ToggleDot = Color3.fromRGB(255, 255, 255),
            SliderBar = Color3.fromRGB(0, 0, 0),
            SliderBackground = Color3.fromRGB(200, 200, 200),
            DropdownBackground = Color3.fromRGB(255, 255, 255),
            DropdownHover = Color3.fromRGB(240, 240, 240),
            DialogBackground = Color3.fromRGB(255, 255, 255),
            NotificationBackground = Color3.fromRGB(255, 255, 255),
            Border = Color3.fromRGB(0, 0, 0),
            BorderHover = Color3.fromRGB(60, 60, 60),
            Icon = Color3.fromRGB(0, 0, 0),
        },
        Fonts = {
            Normal = Enum.Font.Gotham,
            Medium = Enum.Font.GothamMedium,
            Bold = Enum.Font.GothamBold,
            ExtraBold = Enum.Font.GothamBlack,
            Mono = Enum.Font.Code,
        },
        BackgroundTransparency = 0,
        CornerRadius = UDim.new(0, 6),
        StrokeThickness = 1.5,
    }
}

-- ============================================================
-- ICONS
-- ============================================================
LUX.Icons = {
    Home = "10734953451",
    Settings = "10734943674",
    Info = "10734943712",
    Error = "10709752996",
    Close = "10747384394",
    Search = "10734943674",
    Keybind = "10734982144",
    DropdownOpen = "10709791523",
    DropdownClose = "10709790948",
    Check = "10709790873",
    Plus = "10709790961",
    Minus = "10709790980",
    ArrowRight = "10709791216",
    ArrowLeft = "10709791203",
    Discord = "10734943674",
    Copy = "10734943712",
    Link = "10734943712",
}

-- ============================================================
-- CORE STATE
-- ============================================================
LUX._state = {
    currentTheme = "Dark",
    screenGui = nil,
    windows = {},
    connections = {},
    flags = {},
    isRendering = true,
    minScale = 0.6,
    maxScale = 1.6,
    defaultScale = 1.0,
}

-- ============================================================
-- HELPERS
-- ============================================================
local function getColor(theme, path)
    local parts = {}
    for part in path:gmatch("[^%.]+") do
        table.insert(parts, part)
    end
    local current = LUX.Themes[theme]
    for _, part in ipairs(parts) do
        if not current then return nil end
        current = current[part]
    end
    return current
end

local function getIcon(id)
    if id:match("^%d+$") then
        return "rbxassetid://" .. id
    end
    if LUX.Icons[id] then
        return "rbxassetid://" .. LUX.Icons[id]
    end
    return id
end

local function isImage(id)
    return id:match("^rbxassetid://") or id:match("^rbxasset://")
end

local function createInstance(className, properties, children)
    local instance = Instance.new(className)
    for prop, value in pairs(properties or {}) do
        instance[prop] = value
    end
    if children then
        for _, child in ipairs(children) do
            child.Parent = instance
        end
    end
    return instance
end

local function tweenObject(obj, properties, duration, style, direction)
    style = style or Enum.EasingStyle.Quad
    direction = direction or Enum.EasingDirection.Out
    local tweenInfo = TweenInfo.new(duration, style, direction)
    local tween = TweenService:Create(obj, tweenInfo, properties)
    return tween
end

-- ============================================================
-- UI ELEMENTS
-- ============================================================
local UIElement = {}
UIElement.__index = UIElement

function UIElement:new(parent, config)
    local self = setmetatable({}, UIElement)
    self.parent = parent
    self.config = config or {}
    self.children = {}
    self.connections = {}
    self.isVisible = true
    self.isDestroyed = false
    return self
end

function UIElement:createFrame(properties, children)
    local frame = createInstance("Frame", properties, children)
    self.instance = frame
    return frame
end

function UIElement:createButton(properties, children)
    local button = createInstance("TextButton", properties, children)
    self.instance = button
    return button
end

function UIElement:createLabel(properties, children)
    local label = createInstance("TextLabel", properties, children)
    self.instance = label
    return label
end

function UIElement:createImage(properties, children)
    local image = createInstance("ImageLabel", properties, children)
    self.instance = image
    return image
end

function UIElement:createTextBox(properties, children)
    local textBox = createInstance("TextBox", properties, children)
    self.instance = textBox
    return textBox
end

function UIElement:createScrollingFrame(properties, children)
    local scroll = createInstance("ScrollingFrame", properties, children)
    self.instance = scroll
    return scroll
end

function UIElement:applyTheme(themePath)
    local theme = LUX.Themes[LUX._state.currentTheme]
    if not theme then return end
    
    local function apply(obj, path)
        local parts = {}
        for part in path:gmatch("[^%.]+") do
            table.insert(parts, part)
        end
        local current = theme
        for _, part in ipairs(parts) do
            if not current then return end
            current = current[part]
        end
        return current
    end
    
    -- Apply to self.instance if it exists
    if self.instance then
        -- Handle color sequences
        if themePath:match("Background") and type(apply(themePath)) == "table" then
            -- ColorSequence
        else
            local value = apply(themePath)
            if value ~= nil then
                self.instance[themePath] = value
            end
        end
    end
end

function UIElement:setVisible(visible)
    self.isVisible = visible
    if self.instance then
        self.instance.Visible = visible
    end
    for _, child in ipairs(self.children) do
        if child.setVisible then
            child:setVisible(visible)
        end
    end
end

function UIElement:destroy()
    if self.isDestroyed then return end
    self.isDestroyed = true
    for _, conn in ipairs(self.connections) do
        conn:Disconnect()
    end
    if self.instance then
        self.instance:Destroy()
    end
    for _, child in ipairs(self.children) do
        if child.destroy then
            child:destroy()
        end
    end
    table.clear(self.children)
    table.clear(self.connections)
end

function UIElement:addChild(child)
    table.insert(self.children, child)
    if child.instance then
        child.instance.Parent = self.instance or self.parent
    end
    return child
end

function UIElement:connect(event, callback)
    if not self.instance then return end
    local conn = self.instance[event]:Connect(callback)
    table.insert(self.connections, conn)
    return conn
end

-- ============================================================
-- WINDOW CLASS
-- ============================================================
local Window = {}
Window.__index = Window
Window.__tostring = function() return "LUX Window" end

function Window:new(config)
    config = config or {}
    local self = setmetatable({}, Window)
    
    self.title = config.Title or "LUX UI"
    self.subtitle = config.SubTitle or ""
    self.folder = config.ScriptFolder or "LUX"
    self.minSize = config.MinSize or {400, 300}
    self.maxSize = config.MaxSize or {800, 600}
    self.defaultSize = config.Size or {550, 400}
    self.tabs = {}
    self.activeTab = nil
    self.flags = {}
    self.notifications = {}
    self.isMinimized = false
    self.isDestroyed = false
    self.connections = {}
    
    -- Build the GUI
    self:buildGUI()
    
    return self
end

function Window:buildGUI()
    -- Main ScreenGui
    local guiName = "LUX_" .. tostring(math.random(100000, 999999))
    self.screenGui = createInstance("ScreenGui", {
        Name = guiName,
        ResetOnSpawn = false,
        IgnoreGuiInset = true,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
    })
    
    local success, err = pcall(function()
        self.screenGui.Parent = CoreGui
    end)
    if not success then
        self.screenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
    end
    
    -- Main Frame
    local size = UDim2.new(0, self.defaultSize[1], 0, self.defaultSize[2])
    self.mainFrame = createInstance("Frame", {
        Name = "MainFrame",
        Size = size,
        Position = UDim2.new(0.5, -size.X.Offset/2, 0.5, -size.Y.Offset/2),
        BackgroundTransparency = 1,
        Active = true,
        ClipsDescendants = true,
        Parent = self.screenGui,
    })
    
    -- Background
    self.bgFrame = createInstance("Frame", {
        Name = "Background",
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundColor3 = getColor(LUX._state.currentTheme, "Colors.ButtonDefault"),
        BorderSizePixel = 0,
        Parent = self.mainFrame,
    })
    
    -- Corner
    self.corner = createInstance("UICorner", {
        CornerRadius = LUX.Themes[LUX._state.currentTheme].CornerRadius,
        Parent = self.bgFrame,
    })
    
    -- Stroke
    self.stroke = createInstance("UIStroke", {
        Color = getColor(LUX._state.currentTheme, "Colors.Stroke"),
        Thickness = LUX.Themes[LUX._state.currentTheme].StrokeThickness,
        Parent = self.bgFrame,
    })
    
    -- Title Bar
    self.titleBar = createInstance("Frame", {
        Name = "TitleBar",
        Size = UDim2.new(1, 0, 0, 35),
        BackgroundTransparency = 1,
        Parent = self.mainFrame,
    })
    
    -- Title
    self.titleLabel = createInstance("TextLabel", {
        Name = "Title",
        Size = UDim2.new(1, -80, 1, 0),
        Position = UDim2.new(0, 15, 0, 0),
        BackgroundTransparency = 1,
        Text = self.title,
        TextColor3 = getColor(LUX._state.currentTheme, "Colors.Text"),
        TextSize = 14,
        Font = LUX.Themes[LUX._state.currentTheme].Fonts.Bold,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = self.titleBar,
    })
    
    -- Subtitle
    if self.subtitle and self.subtitle ~= "" then
        self.subtitleLabel = createInstance("TextLabel", {
            Name = "SubTitle",
            Size = UDim2.new(1, -80, 0, 14),
            Position = UDim2.new(0, 15, 1, -4),
            BackgroundTransparency = 1,
            Text = self.subtitle,
            TextColor3 = getColor(LUX._state.currentTheme, "Colors.TextDark"),
            TextSize = 9,
            Font = LUX.Themes[LUX._state.currentTheme].Fonts.Normal,
            TextXAlignment = Enum.TextXAlignment.Left,
            Parent = self.titleBar,
        })
    end
    
    -- Close Button
    self.closeBtn = createInstance("TextButton", {
        Name = "Close",
        Size = UDim2.new(0, 28, 0, 28),
        Position = UDim2.new(1, -8, 0.5, 0),
        AnchorPoint = Vector2.new(1, 0.5),
        BackgroundColor3 = Color3.fromRGB(255, 60, 60),
        Text = "✕",
        TextColor3 = Color3.fromRGB(255, 255, 255),
        TextSize = 14,
        Font = Enum.Font.GothamBold,
        AutoButtonColor = false,
        BorderSizePixel = 0,
        Parent = self.titleBar,
    })
    createInstance("UICorner", {CornerRadius = UDim.new(0, 4)}, self.closeBtn)
    
    -- Minimize Button
    self.minimizeBtn = createInstance("TextButton", {
        Name = "Minimize",
        Size = UDim2.new(0, 28, 0, 28),
        Position = UDim2.new(1, -42, 0.5, 0),
        AnchorPoint = Vector2.new(1, 0.5),
        BackgroundColor3 = getColor(LUX._state.currentTheme, "Colors.ButtonDefault"),
        Text = "─",
        TextColor3 = getColor(LUX._state.currentTheme, "Colors.Text"),
        TextSize = 18,
        Font = Enum.Font.GothamBold,
        AutoButtonColor = false,
        BorderSizePixel = 0,
        Parent = self.titleBar,
    })
    createInstance("UICorner", {CornerRadius = UDim.new(0, 4)}, self.minimizeBtn)
    createInstance("UIStroke", {
        Color = getColor(LUX._state.currentTheme, "Colors.Stroke"),
        Thickness = 1,
    }, self.minimizeBtn)
    
    -- Divider
    self.divider = createInstance("Frame", {
        Name = "Divider",
        Size = UDim2.new(1, -20, 0, 1),
        Position = UDim2.new(0, 10, 0, 35),
        BackgroundColor3 = getColor(LUX._state.currentTheme, "Colors.Stroke"),
        BorderSizePixel = 0,
        Parent = self.mainFrame,
    })
    
    -- Tab Bar
    self.tabBar = createInstance("Frame", {
        Name = "TabBar",
        Size = UDim2.new(1, 0, 0, 30),
        Position = UDim2.new(0, 0, 0, 36),
        BackgroundTransparency = 1,
        Parent = self.mainFrame,
    })
    
    -- Tab Container (for tab buttons)
    self.tabContainer = createInstance("ScrollingFrame", {
        Name = "TabContainer",
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ScrollBarThickness = 0,
        AutomaticCanvasSize = Enum.AutomaticSize.X,
        CanvasSize = UDim2.new(0, 0, 0, 0),
        ScrollingDirection = Enum.ScrollingDirection.X,
        Parent = self.tabBar,
    })
    
    -- Tab List Layout
    self.tabLayout = createInstance("UIListLayout", {
        FillDirection = Enum.FillDirection.Horizontal,
        HorizontalAlignment = Enum.HorizontalAlignment.Left,
        VerticalAlignment = Enum.VerticalAlignment.Center,
        Padding = UDim.new(0, 5),
        Parent = self.tabContainer,
    })
    
    -- Content Area
    self.contentArea = createInstance("ScrollingFrame", {
        Name = "ContentArea",
        Size = UDim2.new(1, 0, 1, -67),
        Position = UDim2.new(0, 0, 0, 67),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ScrollBarThickness = 3,
        ScrollBarImageColor3 = getColor(LUX._state.currentTheme, "Colors.ScrollBar"),
        AutomaticCanvasSize = Enum.AutomaticSize.Y,
        CanvasSize = UDim2.new(0, 0, 0, 0),
        Parent = self.mainFrame,
    })
    
    -- Content Padding
    self.contentPadding = createInstance("UIPadding", {
        PaddingLeft = UDim.new(0, 10),
        PaddingRight = UDim.new(0, 10),
        PaddingTop = UDim.new(0, 10),
        PaddingBottom = UDim.new(0, 10),
        Parent = self.contentArea,
    })
    
    -- Content Layout
    self.contentLayout = createInstance("UIListLayout", {
        SortOrder = Enum.SortOrder.LayoutOrder,
        Padding = UDim.new(0, 8),
        Parent = self.contentArea,
    })
    
    -- Make draggable
    self:makeDraggable()
    
    -- Setup connections
    self:setupConnections()
    
    -- Setup scale
    self:setupScale()
end

function Window:makeDraggable()
    local dragData = {
        dragging = false,
        startPos = nil,
        startMouse = nil,
    }
    
    self.titleBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragData.dragging = true
            dragData.startPos = self.mainFrame.Position
            dragData.startMouse = input.Position
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if dragData.dragging and (input.UserInputType == Enum.UserInputType.MouseMovement) then
            local delta = input.Position - dragData.startMouse
            self.mainFrame.Position = UDim2.new(
                dragData.startPos.X.Scale,
                dragData.startPos.X.Offset + delta.X,
                dragData.startPos.Y.Scale,
                dragData.startPos.Y.Offset + delta.Y
            )
        end
    end)
    
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragData.dragging = false
        end
    end)
end

function Window:setupConnections()
    -- Close
    self.closeBtn.MouseButton1Click:Connect(function()
        self:destroy()
    end)
    
    -- Minimize
    self.minimizeBtn.MouseButton1Click:Connect(function()
        self:minimize()
    end)
    
    -- Hover effects
    self.closeBtn.MouseEnter:Connect(function()
        tweenObject(self.closeBtn, {BackgroundColor3 = Color3.fromRGB(200, 40, 40)}, 0.15):Play()
    end)
    self.closeBtn.MouseLeave:Connect(function()
        tweenObject(self.closeBtn, {BackgroundColor3 = Color3.fromRGB(255, 60, 60)}, 0.15):Play()
    end)
    
    self.minimizeBtn.MouseEnter:Connect(function()
        tweenObject(self.minimizeBtn, {BackgroundColor3 = getColor(LUX._state.currentTheme, "Colors.ButtonHover")}, 0.15):Play()
    end)
    self.minimizeBtn.MouseLeave:Connect(function()
        tweenObject(self.minimizeBtn, {BackgroundColor3 = getColor(LUX._state.currentTheme, "Colors.ButtonDefault")}, 0.15):Play()
    end)
end

function Window:setupScale()
    local scale = createInstance("UIScale", {
        Scale = 1,
        Parent = self.mainFrame,
    })
    self.scaleObject = scale
end

function Window:minimize()
    self.isMinimized = not self.isMinimized
    
    if self.isMinimized then
        local targetSize = UDim2.new(0, 200, 0, 35)
        tweenObject(self.mainFrame, {Size = targetSize}, 0.3):Play()
        self.minimizeBtn.Text = "□"
        self.bgFrame.Visible = false
        self.tabBar.Visible = false
        self.contentArea.Visible = false
        self.divider.Visible = false
    else
        local targetSize = UDim2.new(0, self.defaultSize[1], 0, self.defaultSize[2])
        tweenObject(self.mainFrame, {Size = targetSize}, 0.3):Play()
        self.minimizeBtn.Text = "─"
        self.bgFrame.Visible = true
        self.tabBar.Visible = true
        self.contentArea.Visible = true
        self.divider.Visible = true
    end
end

function Window:setTitle(title)
    self.title = title
    self.titleLabel.Text = title
end

function Window:setSubtitle(subtitle)
    self.subtitle = subtitle
    if self.subtitleLabel then
        self.subtitleLabel.Text = subtitle
    end
end

function Window:getTitle()
    return self.title
end

function Window:getSubtitle()
    return self.subtitle
end

function Window:makeTab(config)
    local tab = {}
    tab.title = config.Title or "Tab"
    tab.icon = config.Icon or ""
    tab.parent = self
    tab.elements = {}
    tab.order = #self.tabs + 1
    tab.isActive = false
    tab.container = nil
    
    -- Create tab button
    local button = createInstance("TextButton", {
        Name = "Tab_" .. tab.title,
        Size = UDim2.new(0, 80, 0, 28),
        BackgroundColor3 = getColor(LUX._state.currentTheme, "Colors.ButtonDefault"),
        Text = tab.title,
        TextColor3 = getColor(LUX._state.currentTheme, "Colors.TextDark"),
        TextSize = 11,
        Font = LUX.Themes[LUX._state.currentTheme].Fonts.Medium,
        AutoButtonColor = false,
        BorderSizePixel = 0,
        Parent = self.tabContainer,
    })
    createInstance("UICorner", {CornerRadius = UDim.new(0, 4)}, button)
    createInstance("UIStroke", {
        Color = getColor(LUX._state.currentTheme, "Colors.Stroke"),
        Thickness = 1,
    }, button)
    
    -- Tab content container
    local container = createInstance("Frame", {
        Name = "Tab_" .. tab.title .. "_Container",
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1,
        Visible = false,
        Parent = self.contentArea,
    })
    
    -- Content layout for elements
    local layout = createInstance("UIListLayout", {
        SortOrder = Enum.SortOrder.LayoutOrder,
        Padding = UDim.new(0, 6),
        Parent = container,
    })
    
    local padding = createInstance("UIPadding", {
        PaddingLeft = UDim.new(0, 2),
        PaddingRight = UDim.new(0, 2),
        Parent = container,
    })
    
    tab.button = button
    tab.container = container
    tab.layout = layout
    
    -- Store tab
    table.insert(self.tabs, tab)
    
    -- Select first tab by default
    if #self.tabs == 1 then
        self:selectTab(tab)
    end
    
    -- Button click handler
    button.MouseButton1Click:Connect(function()
        self:selectTab(tab)
    end)
    
    -- Hover effects
    button.MouseEnter:Connect(function()
        if not tab.isActive then
            tweenObject(button, {BackgroundColor3 = getColor(LUX._state.currentTheme, "Colors.ButtonHover")}, 0.15):Play()
        end
    end)
    button.MouseLeave:Connect(function()
        if not tab.isActive then
            tweenObject(button, {BackgroundColor3 = getColor(LUX._state.currentTheme, "Colors.ButtonDefault")}, 0.15):Play()
        end
    end)
    
    -- Return tab API
    return setmetatable({
        title = tab.title,
        icon = tab.icon,
        container = container,
        button = button,
        elements = {},
        parent = self,
        __index = function(t, k)
            if k == "AddSection" then return function(...) return t:addSection(...) end end
            if k == "AddToggle" then return function(...) return t:addToggle(...) end end
            if k == "AddButton" then return function(...) return t:addButton(...) end end
            if k == "AddSlider" then return function(...) return t:addSlider(...) end end
            if k == "AddDropdown" then return function(...) return t:addDropdown(...) end end
            if k == "AddTextBox" then return function(...) return t:addTextBox(...) end end
            if k == "AddParagraph" then return function(...) return t:addParagraph(...) end end
            if k == "AddDiscordInvite" then return function(...) return t:addDiscordInvite(...) end end
            if k == "AddExternalButton" then return function(...) return t:addExternalButton(...) end end
            if k == "Select" then return function() self:selectTab(t) end end
            if k == "Destroy" then return function() t:destroy() end end
            return nil
        end
    }, {__index = function(t, k)
        if k == "title" then return tab.title end
        if k == "icon" then return tab.icon end
        if k == "container" then return tab.container end
        if k == "button" then return tab.button end
        return nil
    end})
end

function Window:selectTab(tab)
    -- Hide all tabs
    for _, t in ipairs(self.tabs) do
        t.isActive = false
        if t.container then
            t.container.Visible = false
        end
        if t.button then
            tweenObject(t.button, {
                BackgroundColor3 = getColor(LUX._state.currentTheme, "Colors.ButtonDefault"),
                TextColor3 = getColor(LUX._state.currentTheme, "Colors.TextDark"),
            }, 0.15):Play()
        end
    end
    
    -- Show selected tab
    tab.isActive = true
    if tab.container then
        tab.container.Visible = true
    end
    if tab.button then
        tweenObject(tab.button, {
            BackgroundColor3 = getColor(LUX._state.currentTheme, "Colors.Primary"),
            TextColor3 = Color3.fromRGB(255, 255, 255),
        }, 0.15):Play()
    end
    
    self.activeTab = tab
end

function Window:selectTabByIndex(index)
    if self.tabs[index] then
        self:selectTab(self.tabs[index])
    end
end

function Window:selectTabByTitle(title)
    for _, tab in ipairs(self.tabs) do
        if tab.title == title then
            self:selectTab(tab)
            return true
        end
    end
    return false
end

function Window:setFlag(key, value)
    self.flags[key] = value
    -- Save to file if folder is set
    if self.folder and self.folder ~= "" then
        pcall(function()
            makeFolder(self.folder)
            writeFile(self.folder .. "/flags.json", HttpService:JSONEncode(self.flags))
        end)
    end
end

function Window:getFlag(key, defaultValue)
    if self.flags[key] ~= nil then
        return self.flags[key]
    end
    return defaultValue
end

function Window:deleteFlags()
    self.flags = {}
    if self.folder and self.folder ~= "" then
        pcall(function()
            deleteFile(self.folder .. "/flags.json")
        end)
    end
end

function Window:destroy()
    if self.isDestroyed then return end
    self.isDestroyed = true
    
    for _, conn in ipairs(self.connections) do
        conn:Disconnect()
    end
    
    if self.screenGui then
        self.screenGui:Destroy()
    end
    
    -- Remove from global windows
    for i, w in ipairs(LUX._state.windows) do
        if w == self then
            table.remove(LUX._state.windows, i)
            break
        end
    end
end

function Window:setUIScale(scale)
    scale = math.clamp(scale, LUX._state.minScale, LUX._state.maxScale)
    if self.scaleObject then
        tweenObject(self.scaleObject, {Scale = scale}, 0.3):Play()
    end
end

-- ============================================================
-- TAB ELEMENTS
-- ============================================================
function Window:createElement(parent, type, config)
    local element = {}
    element.parent = parent
    element.config = config
    element.instance = nil
    element.isDestroyed = false
    
    local function createBase()
        local frame = createInstance("Frame", {
            Size = UDim2.new(1, 0, 0, 38),
            BackgroundColor3 = getColor(LUX._state.currentTheme, "Colors.ButtonDefault"),
            BorderSizePixel = 0,
            Parent = parent,
        })
        createInstance("UICorner", {CornerRadius = UDim.new(0, 6)}, frame)
        createInstance("UIStroke", {
            Color = getColor(LUX._state.currentTheme, "Colors.Stroke"),
            Thickness = 1,
        }, frame)
        return frame
    end
    
    local function addLabel(frame, text)
        local label = createInstance("TextLabel", {
            Size = UDim2.new(0.65, 0, 1, 0),
            Position = UDim2.new(0, 12, 0, 0),
            BackgroundTransparency = 1,
            Text = text,
            TextColor3 = getColor(LUX._state.currentTheme, "Colors.Text"),
            TextSize = 12,
            Font = LUX.Themes[LUX._state.currentTheme].Fonts.Medium,
            TextXAlignment = Enum.TextXAlignment.Left,
            Parent = frame,
        })
        return label
    end
    
    local function addDescription(frame, text)
        local label = createInstance("TextLabel", {
            Size = UDim2.new(0.65, 0, 1, 0),
            Position = UDim2.new(0, 12, 0, 0),
            BackgroundTransparency = 1,
            Text = text or "",
            TextColor3 = getColor(LUX._state.currentTheme, "Colors.TextDark"),
            TextSize = 10,
            Font = LUX.Themes[LUX._state.currentTheme].Fonts.Normal,
            TextXAlignment = Enum.TextXAlignment.Left,
            Visible = text and text ~= "",
            Parent = frame,
        })
        return label
    end
    
    if type == "Section" then
        local frame = createInstance("Frame", {
            Size = UDim2.new(1, 0, 0, 22),
            BackgroundTransparency = 1,
            Parent = parent,
        })
        
        local label = createInstance("TextLabel", {
            Size = UDim2.new(1, 0, 1, 0),
            Position = UDim2.new(0, 6, 0, 0),
            BackgroundTransparency = 1,
            Text = config.Title or "",
            TextColor3 = getColor(LUX._state.currentTheme, "Colors.TextDark"),
            TextSize = 13,
            Font = LUX.Themes[LUX._state.currentTheme].Fonts.Bold,
            TextXAlignment = Enum.TextXAlignment.Left,
            Parent = frame,
        })
        
        return {
            frame = frame,
            label = label,
            destroy = function()
                frame:Destroy()
            end
        }
    end
    
    if type == "Toggle" then
        local frame = createBase()
        local label = addLabel(frame, config.Name or "Toggle")
        local desc = addDescription(frame, config.Description)
        
        local toggleFrame = createInstance("Frame", {
            Name = "Toggle",
            Size = UDim2.new(0, 40, 0, 22),
            Position = UDim2.new(1, -10, 0.5, 0),
            AnchorPoint = Vector2.new(1, 0.5),
            BackgroundColor3 = config.Default and getColor(LUX._state.currentTheme, "Colors.ToggleOn") or getColor(LUX._state.currentTheme, "Colors.ToggleOff"),
            BorderSizePixel = 0,
            Parent = frame,
        })
        createInstance("UICorner", {CornerRadius = UDim.new(1, 0)}, toggleFrame)
        
        local dot = createInstance("Frame", {
            Size = UDim2.new(0, 16, 0, 16),
            Position = config.Default and UDim2.new(1, -18, 0.5, 0) or UDim2.new(0, 2, 0.5, 0),
            AnchorPoint = Vector2.new(0, 0.5),
            BackgroundColor3 = getColor(LUX._state.currentTheme, "Colors.ToggleDot"),
            BorderSizePixel = 0,
            Parent = toggleFrame,
        })
        createInstance("UICorner", {CornerRadius = UDim.new(1, 0)}, dot)
        
        local value = config.Default or false
        local callbacks = {}
        if config.Callback then table.insert(callbacks, config.Callback) end
        
        local function setValue(newValue)
            value = newValue
            local targetColor = newValue and getColor(LUX._state.currentTheme, "Colors.ToggleOn") or getColor(LUX._state.currentTheme, "Colors.ToggleOff")
            local targetPos = newValue and UDim2.new(1, -18, 0.5, 0) or UDim2.new(0, 2, 0.5, 0)
            
            tweenObject(toggleFrame, {BackgroundColor3 = targetColor}, 0.2):Play()
            tweenObject(dot, {Position = targetPos}, 0.2):Play()
            
            for _, cb in ipairs(callbacks) do
                pcall(cb, newValue)
            end
            
            if config.Flag then
                parent.parent:setFlag(config.Flag, newValue)
            end
        end
        
        local clickBtn = createInstance("TextButton", {
            Size = UDim2.new(1, 0, 1, 0),
            BackgroundTransparency = 1,
            Text = "",
            Parent = frame,
        })
        
        clickBtn.MouseButton1Click:Connect(function()
            setValue(not value)
        end)
        
        -- Load flag
        if config.Flag then
            local flagValue = parent.parent:getFlag(config.Flag)
            if flagValue ~= nil then
                setValue(flagValue)
            end
        end
        
        return {
            frame = frame,
            label = label,
            desc = desc,
            toggle = toggleFrame,
            dot = dot,
            value = value,
            setValue = setValue,
            addCallback = function(cb)
                table.insert(callbacks, cb)
            end,
            destroy = function()
                frame:Destroy()
            end
        }
    end
    
    if type == "Button" then
        local frame = createBase()
        local label = addLabel(frame, config.Name or "Button")
        local desc = addDescription(frame, config.Description)
        
        local button = createInstance("TextButton", {
            Size = UDim2.new(0, 80, 0, 26),
            Position = UDim2.new(1, -10, 0.5, 0),
            AnchorPoint = Vector2.new(1, 0.5),
            BackgroundColor3 = getColor(LUX._state.currentTheme, "Colors.Primary"),
            Text = config.Text or "Click",
            TextColor3 = Color3.fromRGB(255, 255, 255),
            TextSize = 11,
            Font = LUX.Themes[LUX._state.currentTheme].Fonts.Medium,
            AutoButtonColor = false,
            BorderSizePixel = 0,
            Parent = frame,
        })
        createInstance("UICorner", {CornerRadius = UDim.new(0, 4)}, button)
        
        local callbacks = {}
        if config.Callback then table.insert(callbacks, config.Callback) end
        
        button.MouseButton1Click:Connect(function()
            -- Visual feedback
            tweenObject(button, {BackgroundColor3 = getColor(LUX._state.currentTheme, "Colors.OnPrimary")}, 0.1):Play()
            task.wait(0.1)
            tweenObject(button, {BackgroundColor3 = getColor(LUX._state.currentTheme, "Colors.Primary")}, 0.1):Play()
            
            for _, cb in ipairs(callbacks) do
                pcall(cb)
            end
        end)
        
        button.MouseEnter:Connect(function()
            tweenObject(button, {BackgroundColor3 = getColor(LUX._state.currentTheme, "Colors.OnPrimary")}, 0.15):Play()
        end)
        button.MouseLeave:Connect(function()
            tweenObject(button, {BackgroundColor3 = getColor(LUX._state.currentTheme, "Colors.Primary")}, 0.15):Play()
        end)
        
        return {
            frame = frame,
            label = label,
            desc = desc,
            button = button,
            addCallback = function(cb)
                table.insert(callbacks, cb)
            end,
            destroy = function()
                frame:Destroy()
            end
        }
    end
    
    if type == "Slider" then
        local frame = createInstance("Frame", {
            Size = UDim2.new(1, 0, 0, 50),
            BackgroundColor3 = getColor(LUX._state.currentTheme, "Colors.ButtonDefault"),
            BorderSizePixel = 0,
            Parent = parent,
        })
        createInstance("UICorner", {CornerRadius = UDim.new(0, 6)}, frame)
        createInstance("UIStroke", {
            Color = getColor(LUX._state.currentTheme, "Colors.Stroke"),
            Thickness = 1,
        }, frame)
        
        local label = createInstance("TextLabel", {
            Size = UDim2.new(1, -100, 0, 16),
            Position = UDim2.new(0, 12, 0, 4),
            BackgroundTransparency = 1,
            Text = config.Name or "Slider",
            TextColor3 = getColor(LUX._state.currentTheme, "Colors.Text"),
            TextSize = 12,
            Font = LUX.Themes[LUX._state.currentTheme].Fonts.Medium,
            TextXAlignment = Enum.TextXAlignment.Left,
            Parent = frame,
        })
        
        local desc = createInstance("TextLabel", {
            Size = UDim2.new(1, -100, 0, 14),
            Position = UDim2.new(0, 12, 0, 22),
            BackgroundTransparency = 1,
            Text = config.Description or "",
            TextColor3 = getColor(LUX._state.currentTheme, "Colors.TextDark"),
            TextSize = 10,
            Font = LUX.Themes[LUX._state.currentTheme].Fonts.Normal,
            TextXAlignment = Enum.TextXAlignment.Left,
            Visible = config.Description and config.Description ~= "",
            Parent = frame,
        })
        
        local valueLabel = createInstance("TextLabel", {
            Size = UDim2.new(0, 60, 0, 20),
            Position = UDim2.new(1, -10, 0.5, 0),
            AnchorPoint = Vector2.new(1, 0.5),
            BackgroundTransparency = 1,
            Text = tostring(config.Default or config.Min or 0),
            TextColor3 = getColor(LUX._state.currentTheme, "Colors.Text"),
            TextSize = 12,
            Font = LUX.Themes[LUX._state.currentTheme].Fonts.Bold,
            TextXAlignment = Enum.TextXAlignment.Right,
            Parent = frame,
        })
        
        local sliderTrack = createInstance("Frame", {
            Size = UDim2.new(0.65, -20, 0, 4),
            Position = UDim2.new(0, 10, 1, -8),
            BackgroundColor3 = getColor(LUX._state.currentTheme, "Colors.SliderBackground"),
            BorderSizePixel = 0,
            Parent = frame,
        })
        createInstance("UICorner", {CornerRadius = UDim.new(1, 0)}, sliderTrack)
        
        local sliderFill = createInstance("Frame", {
            Size = UDim2.new(0.5, 0, 1, 0),
            BackgroundColor3 = getColor(LUX._state.currentTheme, "Colors.SliderBar"),
            BorderSizePixel = 0,
            Parent = sliderTrack,
        })
        createInstance("UICorner", {CornerRadius = UDim.new(1, 0)}, sliderFill)
        
        local min = config.Min or 0
        local max = config.Max or 100
        local increment = config.Increment or 1
        local value = config.Default or min
        
        local callbacks = {}
        if config.Callback then table.insert(callbacks, config.Callback) end
        
        local function setValue(newValue)
            newValue = math.round(newValue / increment) * increment
            newValue = math.clamp(newValue, min, max)
            value = newValue
            
            local percent = (value - min) / (max - min)
            sliderFill.Size = UDim2.new(percent, 0, 1, 0)
            valueLabel.Text = tostring(value)
            
            for _, cb in ipairs(callbacks) do
                pcall(cb, value)
            end
            
            if config.Flag then
                parent.parent:setFlag(config.Flag, value)
            end
        end
        
        -- Load flag
        if config.Flag then
            local flagValue = parent.parent:getFlag(config.Flag)
            if flagValue ~= nil then
                setValue(flagValue)
            end
        end
        
        -- Slider dragging
        local isDragging = false
        sliderTrack.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                isDragging = true
            end
        end)
        sliderTrack.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                isDragging = false
            end
        end)
        
        UserInputService.InputChanged:Connect(function(input)
            if isDragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                local mousePos = input.Position.X
                local trackPos = sliderTrack.AbsolutePosition.X
                local trackWidth = sliderTrack.AbsoluteSize.X
                
                local percent = math.clamp((mousePos - trackPos) / trackWidth, 0, 1)
                local newValue = min + (max - min) * percent
                setValue(newValue)
            end
        end)
        
        setValue(value)
        
        return {
            frame = frame,
            label = label,
            desc = desc,
            valueLabel = valueLabel,
            sliderTrack = sliderTrack,
            sliderFill = sliderFill,
            value = value,
            setValue = setValue,
            addCallback = function(cb)
                table.insert(callbacks, cb)
            end,
            destroy = function()
                frame:Destroy()
            end
        }
    end
    
    if type == "Dropdown" then
        local frame = createBase()
        local label = addLabel(frame, config.Name or "Dropdown")
        local desc = addDescription(frame, config.Description)
        
        local dropdownBtn = createInstance("TextButton", {
            Size = UDim2.new(0, 120, 0, 26),
            Position = UDim2.new(1, -10, 0.5, 0),
            AnchorPoint = Vector2.new(1, 0.5),
            BackgroundColor3 = getColor(LUX._state.currentTheme, "Colors.ButtonDefault"),
            Text = config.Default or "Select...",
            TextColor3 = getColor(LUX._state.currentTheme, "Colors.TextDark"),
            TextSize = 10,
            Font = LUX.Themes[LUX._state.currentTheme].Fonts.Medium,
            AutoButtonColor = false,
            BorderSizePixel = 0,
            Parent = frame,
        })
        createInstance("UICorner", {CornerRadius = UDim.new(0, 4)}, dropdownBtn)
        createInstance("UIStroke", {
            Color = getColor(LUX._state.currentTheme, "Colors.Stroke"),
            Thickness = 1,
        }, dropdownBtn)
        
        local dropdownArrow = createInstance("ImageLabel", {
            Size = UDim2.new(0, 12, 0, 12),
            Position = UDim2.new(1, -8, 0.5, 0),
            AnchorPoint = Vector2.new(1, 0.5),
            BackgroundTransparency = 1,
            Image = getIcon("DropdownOpen"),
            ImageColor3 = getColor(LUX._state.currentTheme, "Colors.Icon"),
            Parent = dropdownBtn,
        })
        
        local dropdownList = createInstance("ScrollingFrame", {
            Size = UDim2.new(0, 120, 0, 100),
            Position = UDim2.new(1, -10, 0.5, 0),
            AnchorPoint = Vector2.new(1, 0.5),
            BackgroundColor3 = getColor(LUX._state.currentTheme, "Colors.DropdownBackground"),
            BorderSizePixel = 0,
            Visible = false,
            ClipsDescendants = true,
            ScrollBarThickness = 2,
            AutomaticCanvasSize = Enum.AutomaticSize.Y,
            CanvasSize = UDim2.new(0, 0, 0, 0),
            Parent = frame,
        })
        createInstance("UICorner", {CornerRadius = UDim.new(0, 4)}, dropdownList)
        createInstance("UIStroke", {
            Color = getColor(LUX._state.currentTheme, "Colors.Stroke"),
            Thickness = 1,
        }, dropdownList)
        
        local listLayout = createInstance("UIListLayout", {
            SortOrder = Enum.SortOrder.LayoutOrder,
            Padding = UDim.new(0, 2),
            Parent = dropdownList,
        })
        
        local options = config.Options or {}
        local multiSelect = config.MultiSelect or false
        local selected = {}
        local callbacks = {}
        if config.Callback then table.insert(callbacks, config.Callback) end
        
        local function updateDropdown()
            local text
            if multiSelect then
                if #selected == 0 then
                    text = "Select..."
                else
                    text = table.concat(selected, ", ")
                end
            else
                text = selected[1] or "Select..."
            end
            dropdownBtn.Text = text
        end
        
        local function createOption(optionText)
            local optionBtn = createInstance("TextButton", {
                Size = UDim2.new(1, 0, 0, 24),
                BackgroundColor3 = getColor(LUX._state.currentTheme, "Colors.ButtonDefault"),
                Text = optionText,
                TextColor3 = getColor(LUX._state.currentTheme, "Colors.TextDark"),
                TextSize = 10,
                Font = LUX.Themes[LUX._state.currentTheme].Fonts.Medium,
                AutoButtonColor = false,
                BorderSizePixel = 0,
                Parent = dropdownList,
            })
            createInstance("UICorner", {CornerRadius = UDim.new(0, 3)}, optionBtn)
            
            optionBtn.MouseEnter:Connect(function()
                tweenObject(optionBtn, {BackgroundColor3 = getColor(LUX._state.currentTheme, "Colors.ButtonHover")}, 0.15):Play()
            end)
            optionBtn.MouseLeave:Connect(function()
                tweenObject(optionBtn, {BackgroundColor3 = getColor(LUX._state.currentTheme, "Colors.ButtonDefault")}, 0.15):Play()
            end)
            
            optionBtn.MouseButton1Click:Connect(function()
                if multiSelect then
                    local found = false
                    for i, v in ipairs(selected) do
                        if v == optionText then
                            table.remove(selected, i)
                            found = true
                            break
                        end
                    end
                    if not found then
                        table.insert(selected, optionText)
                    end
                    updateDropdown()
                    for _, cb in ipairs(callbacks) do
                        pcall(cb, selected)
                    end
                else
                    selected = {optionText}
                    updateDropdown()
                    dropdownList.Visible = false
                    dropdownArrow.Image = getIcon("DropdownOpen")
                    for _, cb in ipairs(callbacks) do
                        pcall(cb, optionText)
                    end
                end
            end)
            
            return optionBtn
        end
        
        -- Create initial options
        for _, opt in ipairs(options) do
            createOption(opt)
        end
        
        -- Handle default selection
        if config.Default then
            if multiSelect then
                if type(config.Default) == "table" then
                    selected = config.Default
                else
                    selected = {config.Default}
                end
            else
                selected = {config.Default}
            end
            updateDropdown()
        end
        
        -- Toggle dropdown
        dropdownBtn.MouseButton1Click:Connect(function()
            dropdownList.Visible = not dropdownList.Visible
            dropdownArrow.Image = dropdownList.Visible and getIcon("DropdownClose") or getIcon("DropdownOpen")
            if dropdownList.Visible then
                dropdownList.CanvasSize = UDim2.new(0, 0, 0, #options * 26 + 10)
            end
        end)
        
        return {
            frame = frame,
            label = label,
            desc = desc,
            dropdownBtn = dropdownBtn,
            dropdownList = dropdownList,
            selected = selected,
            addCallback = function(cb)
                table.insert(callbacks, cb)
            end,
            destroy = function()
                frame:Destroy()
            end
        }
    end
    
    if type == "TextBox" then
        local frame = createBase()
        local label = addLabel(frame, config.Name or "Text Box")
        local desc = addDescription(frame, config.Description)
        
        local textBox = createInstance("TextBox", {
            Size = UDim2.new(0, 150, 0, 26),
            Position = UDim2.new(1, -10, 0.5, 0),
            AnchorPoint = Vector2.new(1, 0.5),
            BackgroundColor3 = getColor(LUX._state.currentTheme, "Colors.ButtonDefault"),
            Text = config.Default or "",
            PlaceholderText = config.Placeholder or "Type...",
            TextColor3 = getColor(LUX._state.currentTheme, "Colors.Text"),
            TextSize = 11,
            Font = LUX.Themes[LUX._state.currentTheme].Fonts.Medium,
            ClearTextOnFocus = config.ClearOnFocus or false,
            BorderSizePixel = 0,
            Parent = frame,
        })
        createInstance("UICorner", {CornerRadius = UDim.new(0, 4)}, textBox)
        createInstance("UIStroke", {
            Color = getColor(LUX._state.currentTheme, "Colors.Stroke"),
            Thickness = 1,
        }, textBox)
        
        local callbacks = {}
        if config.Callback then table.insert(callbacks, config.Callback) end
        
        textBox.FocusLost:Connect(function()
            for _, cb in ipairs(callbacks) do
                pcall(cb, textBox.Text)
            end
            if config.Flag then
                parent.parent:setFlag(config.Flag, textBox.Text)
            end
        end)
        
        -- Load flag
        if config.Flag then
            local flagValue = parent.parent:getFlag(config.Flag)
            if flagValue ~= nil then
                textBox.Text = flagValue
            end
        end
        
        return {
            frame = frame,
            label = label,
            desc = desc,
            textBox = textBox,
            setText = function(text)
                textBox.Text = text
            end,
            getText = function()
                return textBox.Text
            end,
            addCallback = function(cb)
                table.insert(callbacks, cb)
            end,
            destroy = function()
                frame:Destroy()
            end
        }
    end
    
    if type == "Paragraph" then
        local frame = createInstance("Frame", {
            Size = UDim2.new(1, 0, 0, 30 + (#config.Content or 0) * 3),
            BackgroundColor3 = getColor(LUX._state.currentTheme, "Colors.ButtonDefault"),
            BorderSizePixel = 0,
            Parent = parent,
        })
        createInstance("UICorner", {CornerRadius = UDim.new(0, 6)}, frame)
        createInstance("UIStroke", {
            Color = getColor(LUX._state.currentTheme, "Colors.Stroke"),
            Thickness = 1,
        }, frame)
        
        local label = createInstance("TextLabel", {
            Size = UDim2.new(1, -20, 0, 18),
            Position = UDim2.new(0, 12, 0, 4),
            BackgroundTransparency = 1,
            Text = config.Title or "",
            TextColor3 = getColor(LUX._state.currentTheme, "Colors.Text"),
            TextSize = 13,
            Font = LUX.Themes[LUX._state.currentTheme].Fonts.Bold,
            TextXAlignment = Enum.TextXAlignment.Left,
            Parent = frame,
        })
        
        local content = createInstance("TextLabel", {
            Size = UDim2.new(1, -20, 0, 0),
            Position = UDim2.new(0, 12, 0, 22),
            BackgroundTransparency = 1,
            Text = config.Content or "",
            TextColor3 = getColor(LUX._state.currentTheme, "Colors.TextDark"),
            TextSize = 11,
            Font = LUX.Themes[LUX._state.currentTheme].Fonts.Normal,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextYAlignment = Enum.TextYAlignment.Top,
            TextWrapped = true,
            AutomaticSize = Enum.AutomaticSize.Y,
            Parent = frame,
        })
        
        return {
            frame = frame,
            label = label,
            content = content,
            destroy = function()
                frame:Destroy()
            end
        }
    end
    
    if type == "DiscordInvite" then
        local frame = createInstance("Frame", {
            Size = UDim2.new(1, 0, 0, 120),
            BackgroundColor3 = getColor(LUX._state.currentTheme, "Colors.ButtonDefault"),
            BorderSizePixel = 0,
            Parent = parent,
        })
        createInstance("UICorner", {CornerRadius = UDim.new(0, 8)}, frame)
        createInstance("UIStroke", {
            Color = getColor(LUX._state.currentTheme, "Colors.Stroke"),
            Thickness = 1,
        }, frame)
        
        -- Banner
        local banner = createInstance("ImageLabel", {
            Size = UDim2.new(1, 0, 0.45, 0),
            BackgroundColor3 = config.Banner and (typeof(config.Banner) == "Color3" and config.Banner or nil) or Color3.fromRGB(88, 101, 242),
            BackgroundTransparency = config.Banner and typeof(config.Banner) == "string" and 1 or 0,
            Image = typeof(config.Banner) == "string" and config.Banner or "",
            ScaleType = Enum.ScaleType.Crop,
            Parent = frame,
        })
        createInstance("UICorner", {CornerRadius = UDim.new(0, 8)}, banner)
        
        -- Logo
        local logo = createInstance("ImageLabel", {
            Size = UDim2.new(0, 40, 0, 40),
            Position = UDim2.new(0, 12, 0.45, 0),
            AnchorPoint = Vector2.new(0, 0.5),
            BackgroundColor3 = getColor(LUX._state.currentTheme, "Colors.ButtonDefault"),
            Image = config.Logo or getIcon("Discord"),
            BorderSizePixel = 0,
            Parent = frame,
        })
        createInstance("UICorner", {CornerRadius = UDim.new(0, 6)}, logo)
        createInstance("UIStroke", {
            Color = getColor(LUX._state.currentTheme, "Colors.Stroke"),
            Thickness = 1,
        }, logo)
        
        -- Title
        local title = createInstance("TextLabel", {
            Size = UDim2.new(1, -70, 0, 18),
            Position = UDim2.new(0, 60, 0.45, 0),
            AnchorPoint = Vector2.new(0, 0.5),
            BackgroundTransparency = 1,
            Text = config.Title or "Discord Server",
            TextColor3 = getColor(LUX._state.currentTheme, "Colors.Text"),
            TextSize = 14,
            Font = LUX.Themes[LUX._state.currentTheme].Fonts.Bold,
            TextXAlignment = Enum.TextXAlignment.Left,
            Parent = frame,
        })
        
        -- Members
        local members = createInstance("TextLabel", {
            Size = UDim2.new(1, -70, 0, 14),
            Position = UDim2.new(0, 60, 0.6, 0),
            AnchorPoint = Vector2.new(0, 0.5),
            BackgroundTransparency = 1,
            Text = (config.Members and tostring(config.Members) .. " members" or "") .. (config.Online and " • " .. tostring(config.Online) .. " online" or ""),
            TextColor3 = getColor(LUX._state.currentTheme, "Colors.TextDark"),
            TextSize = 10,
            Font = LUX.Themes[LUX._state.currentTheme].Fonts.Normal,
            TextXAlignment = Enum.TextXAlignment.Left,
            Parent = frame,
        })
        
        -- Description
        local desc = createInstance("TextLabel", {
            Size = UDim2.new(1, -70, 0, 16),
            Position = UDim2.new(0, 60, 0.7, 0),
            AnchorPoint = Vector2.new(0, 0.5),
            BackgroundTransparency = 1,
            Text = config.Description or "",
            TextColor3 = getColor(LUX._state.currentTheme, "Colors.TextDark"),
            TextSize = 9,
            Font = LUX.Themes[LUX._state.currentTheme].Fonts.Normal,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextWrapped = true,
            Parent = frame,
        })
        
        -- Join button
        local joinBtn = createInstance("TextButton", {
            Size = UDim2.new(0, 100, 0, 28),
            Position = UDim2.new(1, -12, 1, -12),
            AnchorPoint = Vector2.new(1, 1),
            BackgroundColor3 = getColor(LUX._state.currentTheme, "Colors.Primary"),
            Text = "Join Server",
            TextColor3 = Color3.fromRGB(255, 255, 255),
            TextSize = 11,
            Font = LUX.Themes[LUX._state.currentTheme].Fonts.Medium,
            AutoButtonColor = false,
            BorderSizePixel = 0,
            Parent = frame,
        })
        createInstance("UICorner", {CornerRadius = UDim.new(0, 6)}, joinBtn)
        
        joinBtn.MouseButton1Click:Connect(function()
            if config.Invite then
                setclipboard(config.Invite)
                joinBtn.Text = "Copied!"
                task.wait(2)
                joinBtn.Text = "Join Server"
            end
        end)
        
        joinBtn.MouseEnter:Connect(function()
            tweenObject(joinBtn, {BackgroundColor3 = getColor(LUX._state.currentTheme, "Colors.OnPrimary")}, 0.15):Play()
        end)
        joinBtn.MouseLeave:Connect(function()
            tweenObject(joinBtn, {BackgroundColor3 = getColor(LUX._state.currentTheme, "Colors.Primary")}, 0.15):Play()
        end)
        
        return {
            frame = frame,
            banner = banner,
            logo = logo,
            title = title,
            members = members,
            desc = desc,
            joinBtn = joinBtn,
            destroy = function()
                frame:Destroy()
            end
        }
    end
    
    if type == "ExternalButton" then
        local frame = createBase()
        local label = addLabel(frame, config.Name or "External Button")
        local desc = addDescription(frame, config.Description)
        
        local button = createInstance("TextButton", {
            Size = UDim2.new(0, 90, 0, 28),
            Position = UDim2.new(1, -10, 0.5, 0),
            AnchorPoint = Vector2.new(1, 0.5),
            BackgroundColor3 = getColor(LUX._state.currentTheme, "Colors.Primary"),
            Text = config.Text or "Execute",
            TextColor3 = Color3.fromRGB(255, 255, 255),
            TextSize = 11,
            Font = LUX.Themes[LUX._state.currentTheme].Fonts.Medium,
            AutoButtonColor = false,
            BorderSizePixel = 0,
            Parent = frame,
        })
        createInstance("UICorner", {CornerRadius = UDim.new(0, 4)}, button)
        
        -- External functionality: can run custom code, execute scripts, etc.
        local callbacks = {}
        if config.Callback then table.insert(callbacks, config.Callback) end
        if config.External then
            -- If external code is provided, execute it
            table.insert(callbacks, function()
                pcall(function()
                    loadstring(config.External)()
                end)
            end)
        end
        
        button.MouseButton1Click:Connect(function()
            tweenObject(button, {BackgroundColor3 = getColor(LUX._state.currentTheme, "Colors.OnPrimary")}, 0.1):Play()
            task.wait(0.1)
            tweenObject(button, {BackgroundColor3 = getColor(LUX._state.currentTheme, "Colors.Primary")}, 0.1):Play()
            
            for _, cb in ipairs(callbacks) do
                pcall(cb)
            end
        end)
        
        button.MouseEnter:Connect(function()
            tweenObject(button, {BackgroundColor3 = getColor(LUX._state.currentTheme, "Colors.OnPrimary")}, 0.15):Play()
        end)
        button.MouseLeave:Connect(function()
            tweenObject(button, {BackgroundColor3 = getColor(LUX._state.currentTheme, "Colors.Primary")}, 0.15):Play()
        end)
        
        return {
            frame = frame,
            label = label,
            desc = desc,
            button = button,
            addCallback = function(cb)
                table.insert(callbacks, cb)
            end,
            destroy = function()
                frame:Destroy()
            end
        }
    end
    
    return nil
end

-- ============================================================
-- TAB METHODS (added to tab objects)
-- ============================================================
function Window:addSection(tab, config)
    if type(config) == "string" then
        config = {Title = config}
    end
    return self:createElement(tab.container, "Section", config)
end

function Window:addToggle(tab, config)
    return self:createElement(tab.container, "Toggle", config)
end

function Window:addButton(tab, config)
    return self:createElement(tab.container, "Button", config)
end

function Window:addSlider(tab, config)
    return self:createElement(tab.container, "Slider", config)
end

function Window:addDropdown(tab, config)
    return self:createElement(tab.container, "Dropdown", config)
end

function Window:addTextBox(tab, config)
    return self:createElement(tab.container, "TextBox", config)
end

function Window:addParagraph(tab, config)
    if type(config) == "string" then
        config = {Title = config}
    end
    return self:createElement(tab.container, "Paragraph", config)
end

function Window:addDiscordInvite(tab, config)
    return self:createElement(tab.container, "DiscordInvite", config)
end

function Window:addExternalButton(tab, config)
    return self:createElement(tab.container, "ExternalButton", config)
end

-- ============================================================
-- NOTIFICATIONS
-- ============================================================
function Window:notify(config)
    local title = config.Title or "Notification"
    local content = config.Content or ""
    local duration = config.Duration or 5
    local icon = config.Icon or getIcon("Info")
    
    local container = self.notificationContainer
    if not container then
        container = createInstance("Frame", {
            Name = "Notifications",
            Size = UDim2.new(0, 350, 0, 0),
            Position = UDim2.new(1, -20, 0, 20),
            AnchorPoint = Vector2.new(1, 0),
            BackgroundTransparency = 1,
            Parent = self.screenGui,
        })
        self.notificationContainer = container
        
        local layout = createInstance("UIListLayout", {
            SortOrder = Enum.SortOrder.LayoutOrder,
            Padding = UDim.new(0, 8),
            HorizontalAlignment = Enum.HorizontalAlignment.Right,
            VerticalAlignment = Enum.VerticalAlignment.Top,
            Parent = container,
        })
    end
    
    local notification = createInstance("Frame", {
        Size = UDim2.new(1, 0, 0, 60),
        BackgroundColor3 = getColor(LUX._state.currentTheme, "Colors.NotificationBackground"),
        BorderSizePixel = 0,
        Parent = container,
    })
    createInstance("UICorner", {CornerRadius = UDim.new(0, 6)}, notification)
    createInstance("UIStroke", {
        Color = getColor(LUX._state.currentTheme, "Colors.Stroke"),
        Thickness = 1,
    }, notification)
    
    -- Icon
    if icon and icon ~= "" then
        local iconImg = createInstance("ImageLabel", {
            Size = UDim2.new(0, 24, 0, 24),
            Position = UDim2.new(0, 10, 0.5, 0),
            AnchorPoint = Vector2.new(0, 0.5),
            BackgroundTransparency = 1,
            Image = icon,
            ImageColor3 = getColor(LUX._state.currentTheme, "Colors.Icon"),
            Parent = notification,
        })
    end
    
    -- Title
    local titleLabel = createInstance("TextLabel", {
        Size = UDim2.new(1, -50, 0, 20),
        Position = UDim2.new(0, 40, 0, 4),
        BackgroundTransparency = 1,
        Text = title,
        TextColor3 = getColor(LUX._state.currentTheme, "Colors.Text"),
        TextSize = 13,
        Font = LUX.Themes[LUX._state.currentTheme].Fonts.Bold,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = notification,
    })
    
    -- Content
    local contentLabel = createInstance("TextLabel", {
        Size = UDim2.new(1, -50, 0, 20),
        Position = UDim2.new(0, 40, 0, 26),
        BackgroundTransparency = 1,
        Text = content,
        TextColor3 = getColor(LUX._state.currentTheme, "Colors.TextDark"),
        TextSize = 10,
        Font = LUX.Themes[LUX._state.currentTheme].Fonts.Normal,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextWrapped = true,
        Parent = notification,
    })
    
    -- Close button
    local closeBtn = createInstance("TextButton", {
        Size = UDim2.new(0, 20, 0, 20),
        Position = UDim2.new(1, -6, 0, 6),
        AnchorPoint = Vector2.new(1, 0),
        BackgroundTransparency = 1,
        Text = "✕",
        TextColor3 = getColor(LUX._state.currentTheme, "Colors.TextDark"),
        TextSize = 10,
        Font = Enum.Font.GothamBold,
        Parent = notification,
    })
    
    local function destroyNotification()
        if notification and notification.Parent then
            local tween = tweenObject(notification, {Size = UDim2.new(1, 0, 0, 0)}, 0.2)
            tween:Play()
            tween.Completed:Connect(function()
                notification:Destroy()
            end)
        end
    end
    
    closeBtn.MouseButton1Click:Connect(destroyNotification)
    
    -- Auto close
    task.delay(duration, destroyNotification)
    
    -- Slide in animation
    notification.Position = UDim2.new(0, 400, 0, 0)
    tweenObject(notification, {Position = UDim2.new(0, 0, 0, 0)}, 0.3):Play()
    
    return {
        notification = notification,
        close = destroyNotification,
    }
end

function Window:newNotifyGroup(config)
    local group = {}
    group.Title = config.Title or ""
    group.Content = config.Content or ""
    group.Icon = config.Icon or ""
    group.Duration = config.Duration or 5
    
    function group:notify(overrideConfig)
        local finalConfig = {
            Title = overrideConfig.Title or self.Title,
            Content = overrideConfig.Content or self.Content,
            Icon = overrideConfig.Icon or self.Icon,
            Duration = overrideConfig.Duration or self.Duration,
        }
        return self.parent:notify(finalConfig)
    end
    
    return group
end

-- ============================================================
-- DIALOG
-- ============================================================
function Window:dialog(config)
    local title = config.Title or "Dialog"
    local content = config.Content or ""
    local options = config.Options or {}
    
    local overlay = createInstance("Frame", {
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundColor3 = Color3.fromRGB(0, 0, 0),
        BackgroundTransparency = 0.5,
        Visible = true,
        Parent = self.screenGui,
    })
    
    local dialog = createInstance("Frame", {
        Size = UDim2.new(0, 400, 0, 200),
        Position = UDim2.new(0.5, -200, 0.5, -100),
        BackgroundColor3 = getColor(LUX._state.currentTheme, "Colors.DialogBackground"),
        BorderSizePixel = 0,
        Parent = overlay,
    })
    createInstance("UICorner", {CornerRadius = UDim.new(0, 10)}, dialog)
    createInstance("UIStroke", {
        Color = getColor(LUX._state.currentTheme, "Colors.Stroke"),
        Thickness = 1.5,
    }, dialog)
    
    -- Title
    local titleLabel = createInstance("TextLabel", {
        Size = UDim2.new(1, -20, 0, 30),
        Position = UDim2.new(0, 10, 0, 10),
        BackgroundTransparency = 1,
        Text = title,
        TextColor3 = getColor(LUX._state.currentTheme, "Colors.Text"),
        TextSize = 18,
        Font = LUX.Themes[LUX._state.currentTheme].Fonts.Bold,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = dialog,
    })
    
    -- Content
    local contentLabel = createInstance("TextLabel", {
        Size = UDim2.new(1, -20, 0, 60),
        Position = UDim2.new(0, 10, 0, 50),
        BackgroundTransparency = 1,
        Text = content,
        TextColor3 = getColor(LUX._state.currentTheme, "Colors.TextDark"),
        TextSize = 12,
        Font = LUX.Themes[LUX._state.currentTheme].Fonts.Normal,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextYAlignment = Enum.TextYAlignment.Top,
        TextWrapped = true,
        Parent = dialog,
    })
    
    -- Options
    local optionContainer = createInstance("Frame", {
        Size = UDim2.new(1, -20, 0, 40),
        Position = UDim2.new(0, 10, 1, -50),
        BackgroundTransparency = 1,
        Parent = dialog,
    })
    
    local optionLayout = createInstance("UIListLayout", {
        FillDirection = Enum.FillDirection.Horizontal,
        HorizontalAlignment = Enum.HorizontalAlignment.Right,
        VerticalAlignment = Enum.VerticalAlignment.Center,
        Padding = UDim.new(0, 8),
        Parent = optionContainer,
    })
    
    local dialogObject = {
        overlay = overlay,
        dialog = dialog,
        isClosed = false,
        close = function(self)
            if self.isClosed then return end
            self.isClosed = true
            local tween = tweenObject(dialog, {Size = UDim2.new(0, 300, 0, 150)}, 0.2)
            tween:Play()
            tween.Completed:Connect(function()
                overlay:Destroy()
            end)
        end,
        newOption = function(self, optConfig)
            local btn = createInstance("TextButton", {
                Size = UDim2.new(0, 80, 0, 32),
                BackgroundColor3 = getColor(LUX._state.currentTheme, "Colors.Primary"),
                Text = optConfig.Name or "Option",
                TextColor3 = Color3.fromRGB(255, 255, 255),
                TextSize = 11,
                Font = LUX.Themes[LUX._state.currentTheme].Fonts.Medium,
                AutoButtonColor = false,
                BorderSizePixel = 0,
                Parent = optionContainer,
            })
            createInstance("UICorner", {CornerRadius = UDim.new(0, 6)}, btn)
            
            btn.MouseButton1Click:Connect(function()
                if optConfig.Callback then
                    pcall(optConfig.Callback)
                end
                dialogObject:close()
            end)
            
            btn.MouseEnter:Connect(function()
                tweenObject(btn, {BackgroundColor3 = getColor(LUX._state.currentTheme, "Colors.OnPrimary")}, 0.15):Play()
            end)
            btn.MouseLeave:Connect(function()
                tweenObject(btn, {BackgroundColor3 = getColor(LUX._state.currentTheme, "Colors.Primary")}, 0.15):Play()
            end)
            
            return btn
        end
    }
    
    -- Create options
    for _, opt in ipairs(options) do
        dialogObject:newOption(opt)
    end
    
    return dialogObject
end

-- ============================================================
-- LIBRARY API
-- ============================================================
function LUX:MakeWindow(config)
    local window = Window:new(config)
    table.insert(LUX._state.windows, window)
    return window
end

function LUX:SetTheme(themeName)
    if not LUX.Themes[themeName] then
        error("Theme '" .. themeName .. "' not found")
    end
    LUX._state.currentTheme = themeName
    
    -- Update all windows
    for _, window in ipairs(LUX._state.windows) do
        window:refreshTheme()
    end
end

function LUX:GetTheme()
    return LUX._state.currentTheme
end

function LUX:GetThemes()
    local themes = {}
    for name, _ in pairs(LUX.Themes) do
        table.insert(themes, name)
    end
    return themes
end

function LUX:IsValidTheme(themeName)
    return LUX.Themes[themeName] ~= nil
end

function LUX:SetUIScale(scale)
    scale = math.clamp(scale, LUX._state.minScale, LUX._state.maxScale)
    for _, window in ipairs(LUX._state.windows) do
        window:setUIScale(scale)
    end
end

function LUX:GetMinScale()
    return LUX._state.minScale
end

function LUX:GetMaxScale()
    return LUX._state.maxScale
end

function LUX:GetIconByName(iconName)
    return getIcon(iconName)
end

function LUX:Destroy()
    for _, window in ipairs(LUX._state.windows) do
        window:destroy()
    end
    table.clear(LUX._state.windows)
end

-- ============================================================
-- LOAD SAVED FLAGS
-- ============================================================
function LUX:loadFlags(folder)
    if folder and folder ~= "" then
        pcall(function()
            local data = readFile(folder .. "/flags.json")
            if data then
                local parsed = HttpService:JSONDecode(data)
                if type(parsed) == "table" then
                    for key, value in pairs(parsed) do
                        LUX._state.flags[key] = value
                    end
                end
            end
        end)
    end
end

-- ============================================================
-- RETURN LIBRARY
-- ============================================================
return LUX
