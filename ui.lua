-- ================================================================
-- LUX UI v3.1 | مكتبة واجهات رسومية أنيقة (تصميم BALENCIAGA)
-- النسخة المعدلة: إزالة الوصف + تصميم Toggle أنيق
-- ================================================================

local LUX = {}
LUX.Version = "3.1"
LUX.Themes = {}
LUX.CurrentTheme = "Balenciaga"
LUX._windows = {}

-- ---------- المتغيرات العامة ----------
local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")
local CoreGui = game:GetService("CoreGui")
local LP = Players.LocalPlayer

-- ---------- دوال الملفات ----------
local _isfile = isfile or (syn and syn.isfile) or (getgenv and getgenv().isfile) or function() return false end
local _readfile = readfile or (syn and syn.readfile) or (getgenv and getgenv().readfile) or function() return nil end
local _writefile = writefile or (syn and syn.writefile) or (getgenv and getgenv().writefile) or function() end

-- ================================================================
-- 1. الثيمات
-- ================================================================
LUX.Themes.Balenciaga = {
    BG = Color3.fromRGB(255,255,255),
    ROW = Color3.fromRGB(245,245,245),
    BORDER = Color3.fromRGB(0,0,0),
    PRIMARY_TEXT = Color3.fromRGB(0,0,0),
    SECONDARY_TEXT = Color3.fromRGB(80,80,80),
    ACCENT = Color3.fromRGB(0,0,0),
    TOGGLE_ON = Color3.fromRGB(0, 120, 255),   -- أزرق جميل
    TOGGLE_OFF = Color3.fromRGB(200,200,200),  -- رمادي فاتح
    TOGGLE_DOT = Color3.fromRGB(255,255,255),  -- أبيض
    SLIDER_BG = Color3.fromRGB(220,220,220),
    SLIDER_FILL = Color3.fromRGB(0,0,0),
    INPUT_BG = Color3.fromRGB(0,0,0),
    DROPDOWN_BG = Color3.fromRGB(240,240,240),
    NOTIFY_BG = Color3.fromRGB(255,255,255),
    DIALOG_BG = Color3.fromRGB(255,255,255),
}

LUX.Themes.Dark = {
    BG = Color3.fromRGB(20,20,20),
    ROW = Color3.fromRGB(30,30,30),
    BORDER = Color3.fromRGB(60,60,60),
    PRIMARY_TEXT = Color3.fromRGB(220,220,220),
    SECONDARY_TEXT = Color3.fromRGB(150,150,150),
    ACCENT = Color3.fromRGB(100,100,255),
    TOGGLE_ON = Color3.fromRGB(70, 150, 255),  -- أزرق فاتح
    TOGGLE_OFF = Color3.fromRGB(60,60,60),
    TOGGLE_DOT = Color3.fromRGB(255,255,255),
    SLIDER_BG = Color3.fromRGB(50,50,50),
    SLIDER_FILL = Color3.fromRGB(100,100,255),
    INPUT_BG = Color3.fromRGB(40,40,40),
    DROPDOWN_BG = Color3.fromRGB(40,40,40),
    NOTIFY_BG = Color3.fromRGB(30,30,30),
    DIALOG_BG = Color3.fromRGB(30,30,30),
}

local function GetTheme(name)
    return LUX.Themes[name] or LUX.Themes.Balenciaga
end

function LUX:SetTheme(name)
    if self.Themes[name] then
        self.CurrentTheme = name
        for _, win in ipairs(self._windows or {}) do
            win:ApplyTheme()
        end
    end
end

function LUX:GetTheme() return self.CurrentTheme end
function LUX:GetThemes()
    local t = {}
    for k, _ in pairs(self.Themes) do t[#t+1] = k end
    return t
end

-- ================================================================
-- 2. دوال الحفظ
-- ================================================================
function LUX:SaveConfig()
    local cfg = {}
    for _, win in ipairs(self._windows or {}) do
        if win._flags then
            cfg[win._title or "Window"] = win._flags
            if win._sideBtnPositions then
                cfg[win._title .. "_sidePos"] = win._sideBtnPositions
            end
        end
    end
    pcall(function() _writefile("LUX_Config.json", HttpService:JSONEncode(cfg)) end)
end

function LUX:LoadConfig()
    local ok, data = pcall(function() return HttpService:JSONDecode(_readfile("LUX_Config.json")) end)
    if ok and data then
        for _, win in ipairs(self._windows or {}) do
            if data[win._title] then
                for k, v in pairs(data[win._title]) do
                    win._flags[k] = v
                end
            end
            if data[win._title .. "_sidePos"] then
                win._sideBtnPositions = data[win._title .. "_sidePos"]
                win:ApplySideBtnPositions()
            end
        end
    end
end

task.spawn(function()
    while task.wait(5) do
        pcall(LUX.SaveConfig, LUX)
    end
end)

-- ================================================================
-- 3. إنشاء النافذة الرئيسية
-- ================================================================
function LUX:MakeWindow(config)
    config = config or {}
    local title = config.Title or "LUX"
    local subtitle = config.SubTitle or ""
    local tabs = config.Tabs or {}
    local sizeX = config.SizeX or 260
    local sizeY = config.SizeY or 370

    -- إعدادات الأزرار الجانبية
    local sideDragLocked = true
    local sideBtnRefs = {}
    local sideBtnPositions = {}
    local CELL = 55
    local CELL_PAD = 6
    local circleButtonsEnabled = false
    local circleButtonSize = 55
    local sideButtonsHidden = false

    -- إنشاء ScreenGui
    local gui = Instance.new("ScreenGui")
    gui.Name = "LUX_GUI"
    gui.ResetOnSpawn = false
    gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    gui.DisplayOrder = 10
    pcall(function()
        if syn and syn.protect_gui then syn.protect_gui(gui) end
    end)
    if not pcall(function() gui.Parent = CoreGui end) then
        gui.Parent = LP:WaitForChild("PlayerGui")
    end

    -- النافذة الرئيسية
    local main = Instance.new("Frame", gui)
    main.Size = UDim2.new(0, sizeX, 0, sizeY)
    main.Position = UDim2.new(0.5, -sizeX/2, 0.5, -sizeY/2)
    main.BackgroundColor3 = GetTheme(LUX.CurrentTheme).BG
    main.BorderSizePixel = 0
    main.Active = true
    main.ClipsDescendants = true
    Instance.new("UICorner", main).CornerRadius = UDim.new(0, 13)
    local outerMain = Instance.new("UIStroke", main)
    outerMain.Color = GetTheme(LUX.CurrentTheme).BORDER
    outerMain.Thickness = 1.5

    -- الإطار الداخلي
    local ir = Instance.new("Frame", main)
    ir.Size = UDim2.new(1, -4, 1, -4)
    ir.Position = UDim2.new(0, 2, 0, 2)
    ir.BackgroundTransparency = 1
    Instance.new("UICorner", ir).CornerRadius = UDim.new(0, 11)
    Instance.new("UIStroke", ir).Color = GetTheme(LUX.CurrentTheme).BORDER

    -- سحب النافذة
    local mDn, mDi, mDs, mSp = false, nil, nil, nil
    main.InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
            mDn = true
            mDs = i.Position
            mSp = main.Position
            i.Changed:Connect(function() if i.UserInputState == Enum.UserInputState.End then mDn = false end end)
        end
    end)
    main.InputChanged:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch then
            mDi = i
        end
    end)
    UIS.InputChanged:Connect(function(i)
        if i == mDi and mDn then
            main.Position = UDim2.new(mSp.X.Scale, mSp.X.Offset + (i.Position.X - mDs.X),
                                      mSp.Y.Scale, mSp.Y.Offset + (i.Position.Y - mDs.Y))
        end
    end)

    -- Header
    local HEADER_H = 46
    local header = Instance.new("Frame", main)
    header.Size = UDim2.new(1, 0, 0, HEADER_H)
    header.BackgroundTransparency = 1
    header.ZIndex = 5

    -- النقاط الزخرفية
    local acc = Instance.new("Frame", header)
    acc.Size = UDim2.new(0, 3, 0, 16)
    acc.Position = UDim2.new(0, 13, 0.5, -8)
    acc.BackgroundColor3 = GetTheme(LUX.CurrentTheme).PRIMARY_TEXT
    acc.BorderSizePixel = 0
    Instance.new("UICorner", acc).CornerRadius = UDim.new(1, 0)

    local titleL = Instance.new("TextLabel", header)
    titleL.Size = UDim2.new(1, -80, 1, 0)
    titleL.Position = UDim2.new(0, 20, 0, 0)
    titleL.BackgroundTransparency = 1
    titleL.Text = title
    titleL.TextColor3 = GetTheme(LUX.CurrentTheme).PRIMARY_TEXT
    titleL.Font = Enum.Font.GothamBlack
    titleL.TextSize = 13
    titleL.TextXAlignment = Enum.TextXAlignment.Left
    titleL.ZIndex = 6

    local verL = Instance.new("TextLabel", header)
    verL.Size = UDim2.new(0, 80, 0, 12)
    verL.Position = UDim2.new(0, 20, 1, -14)
    verL.BackgroundTransparency = 1
    verL.Text = subtitle
    verL.TextColor3 = GetTheme(LUX.CurrentTheme).SECONDARY_TEXT
    verL.Font = Enum.Font.Gotham
    verL.TextSize = 8
    verL.TextXAlignment = Enum.TextXAlignment.Left
    verL.ZIndex = 6

    -- زر الإغلاق
    local closeB = Instance.new("TextButton", header)
    closeB.Size = UDim2.new(0, 22, 0, 22)
    closeB.AnchorPoint = Vector2.new(1, 0.5)
    closeB.Position = UDim2.new(1, -10, 0.5, 0)
    closeB.BackgroundColor3 = Color3.fromRGB(240,240,240)
    closeB.BorderSizePixel = 0
    closeB.Text = "✕"
    closeB.TextColor3 = GetTheme(LUX.CurrentTheme).PRIMARY_TEXT
    closeB.Font = Enum.Font.GothamBold
    closeB.TextSize = 10
    closeB.ZIndex = 8
    closeB.AutoButtonColor = false
    Instance.new("UICorner", closeB).CornerRadius = UDim.new(0, 6)
    Instance.new("UIStroke", closeB).Color = GetTheme(LUX.CurrentTheme).BORDER

    -- زر القفل
    local lockBtn = Instance.new("TextButton", header)
    lockBtn.Size = UDim2.new(0, 22, 0, 22)
    lockBtn.AnchorPoint = Vector2.new(1, 0.5)
    lockBtn.Position = UDim2.new(1, -37, 0.5, 0)
    lockBtn.BackgroundColor3 = Color3.fromRGB(240,240,240)
    lockBtn.BorderSizePixel = 0
    lockBtn.Text = "🔒"
    lockBtn.TextSize = 12
    lockBtn.ZIndex = 8
    lockBtn.AutoButtonColor = false
    Instance.new("UICorner", lockBtn).CornerRadius = UDim.new(0, 6)
    Instance.new("UIStroke", lockBtn).Color = GetTheme(LUX.CurrentTheme).BORDER

    lockBtn.MouseButton1Click:Connect(function()
        sideDragLocked = not sideDragLocked
        lockBtn.Text = sideDragLocked and "🔒" or "🔓"
        local col = sideDragLocked and GetTheme(LUX.CurrentTheme).BORDER or Color3.fromRGB(150,150,150)
        for _, btn in pairs(sideBtnRefs) do
            local s = btn:FindFirstChildOfClass("UIStroke")
            if s then s.Color = col end
        end
    end)

    -- زر التصغير
    local miniBtn = Instance.new("TextButton", gui)
    miniBtn.Name = "MiniRestore"
    miniBtn.Size = UDim2.new(0, 110, 0, 24)
    miniBtn.Position = UDim2.new(0.5, -55, 0.5, -12)
    miniBtn.BackgroundColor3 = GetTheme(LUX.CurrentTheme).BG
    miniBtn.BorderSizePixel = 0
    miniBtn.Text = title
    miniBtn.TextColor3 = GetTheme(LUX.CurrentTheme).PRIMARY_TEXT
    miniBtn.Font = Enum.Font.GothamBlack
    miniBtn.TextSize = 8
    miniBtn.ZIndex = 20
    miniBtn.Visible = false
    Instance.new("UICorner", miniBtn).CornerRadius = UDim.new(0, 7)
    local ms = Instance.new("UIStroke", miniBtn)
    ms.Color = GetTheme(LUX.CurrentTheme).BORDER
    ms.Thickness = 1.5

    local mBDn, mBDi, mBDs, mBSp = false, nil, nil, nil
    miniBtn.InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
            mBDn = true
            mBDs = i.Position
            mBSp = miniBtn.Position
            i.Changed:Connect(function() if i.UserInputState == Enum.UserInputState.End then mBDn = false end end)
        end
    end)
    miniBtn.InputChanged:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch then
            mBDi = i
        end
    end)
    UIS.InputChanged:Connect(function(i)
        if i == mBDi and mBDn then
            miniBtn.Position = UDim2.new(mBSp.X.Scale, mBSp.X.Offset + (i.Position.X - mBDs.X),
                                         mBSp.Y.Scale, mBSp.Y.Offset + (i.Position.Y - mBDs.Y))
        end
    end)

    closeB.MouseButton1Click:Connect(function()
        main.Visible = false
        miniBtn.Visible = true
    end)
    miniBtn.MouseButton1Click:Connect(function()
        main.Visible = true
        miniBtn.Visible = false
    end)

    -- الخط الفاصل
    local hdiv = Instance.new("Frame", main)
    hdiv.Size = UDim2.new(1, -24, 0, 1)
    hdiv.Position = UDim2.new(0, 12, 0, HEADER_H)
    hdiv.BackgroundColor3 = GetTheme(LUX.CurrentTheme).BORDER
    hdiv.BorderSizePixel = 0

    -- نظام التبويبات
    local TAB_H, TAB_Y = 28, HEADER_H + 1
    local tabBtns, pages = {}, {}
    local activePage = nil

    local tabBar = Instance.new("Frame", main)
    tabBar.Size = UDim2.new(1, 0, 0, TAB_H)
    tabBar.Position = UDim2.new(0, 0, 0, TAB_Y)
    tabBar.BackgroundTransparency = 1

    local tabDiv = Instance.new("Frame", main)
    tabDiv.Size = UDim2.new(1, 0, 0, 1)
    tabDiv.Position = UDim2.new(0, 0, 0, TAB_Y + TAB_H)
    tabDiv.BackgroundColor3 = GetTheme(LUX.CurrentTheme).BORDER
    tabDiv.BorderSizePixel = 0

    local ll = Instance.new("UIListLayout", tabBar)
    ll.FillDirection = Enum.FillDirection.Horizontal
    ll.SortOrder = Enum.SortOrder.LayoutOrder

    local CONTENT_Y = TAB_Y + TAB_H + 1
    local pageHost = Instance.new("Frame", main)
    pageHost.Size = UDim2.new(1, 0, 1, -CONTENT_Y)
    pageHost.Position = UDim2.new(0, 0, 0, CONTENT_Y)
    pageHost.BackgroundTransparency = 1
    pageHost.ClipsDescendants = true

    local function createTabPage(name)
        local sf = Instance.new("ScrollingFrame", pageHost)
        sf.Size = UDim2.new(1, 0, 1, 0)
        sf.BackgroundTransparency = 1
        sf.BorderSizePixel = 0
        sf.ScrollBarThickness = 2
        sf.ScrollBarImageColor3 = Color3.fromRGB(200,200,200)
        sf.AutomaticCanvasSize = Enum.AutomaticSize.Y
        sf.CanvasSize = UDim2.new(0, 0, 0, 0)
        sf.Visible = false
        local sll = Instance.new("UIListLayout", sf)
        sll.SortOrder = Enum.SortOrder.LayoutOrder
        sll.Padding = UDim.new(0, 3)
        local sp = Instance.new("UIPadding", sf)
        sp.PaddingLeft = UDim.new(0, 9)
        sp.PaddingRight = UDim.new(0, 9)
        sp.PaddingTop = UDim.new(0, 7)
        sp.PaddingBottom = UDim.new(0, 9)
        return sf
    end

    local TW = math.floor(sizeX / #tabs)
    for i, name in ipairs(tabs) do
        local col = Instance.new("Frame", tabBar)
        col.Size = UDim2.new(0, TW, 1, 0)
        col.BackgroundTransparency = 1
        col.LayoutOrder = i

        local lbl = Instance.new("TextLabel", col)
        lbl.Size = UDim2.new(1, 0, 1, 0)
        lbl.BackgroundTransparency = 1
        lbl.Text = name
        lbl.Font = Enum.Font.GothamBold
        lbl.TextSize = 8
        lbl.TextColor3 = (i == 1) and GetTheme(LUX.CurrentTheme).PRIMARY_TEXT or GetTheme(LUX.CurrentTheme).SECONDARY_TEXT
        lbl.TextXAlignment = Enum.TextXAlignment.Center

        local bar = Instance.new("Frame", col)
        bar.Size = UDim2.new(0.45, 0, 0, 2)
        bar.Position = UDim2.new(0.275, 0, 1, -2)
        bar.BackgroundColor3 = GetTheme(LUX.CurrentTheme).PRIMARY_TEXT
        bar.BorderSizePixel = 0
        bar.Visible = (i == 1)
        Instance.new("UICorner", bar).CornerRadius = UDim.new(1, 0)

        local clk = Instance.new("TextButton", col)
        clk.Size = UDim2.new(1, 0, 1, 0)
        clk.BackgroundTransparency = 1
        clk.Text = ""
        clk.ZIndex = 5

        local page = createTabPage(name)
        if i == 1 then
            page.Visible = true
            activePage = name
        end
        pages[name] = page

        clk.MouseButton1Click:Connect(function()
            if pages[activePage] then pages[activePage].Visible = false end
            activePage = name
            pages[name].Visible = true
            for n2, d in pairs(tabBtns) do
                local on = (n2 == name)
                TweenService:Create(d.lbl, TweenInfo.new(0.12), {TextColor3 = on and GetTheme(LUX.CurrentTheme).PRIMARY_TEXT or GetTheme(LUX.CurrentTheme).SECONDARY_TEXT}):Play()
                d.bar.Visible = on
            end
        end)

        tabBtns[name] = { lbl = lbl, bar = bar }
    end

    -- ================================================================
    -- 4. دوال بناء العناصر داخل التبويبات (بدون وصف)
    -- ================================================================
    local function getTabPage(tabName)
        return pages[tabName]
    end

    local function CreateTabObject(windowRef, name)
        local tabObj = {}
        local page = getTabPage(name)
        if not page then
            local col = Instance.new("Frame", tabBar)
            local count = #tabBar:GetChildren()
            col.Size = UDim2.new(0, sizeX / (count + 1), 1, 0)
            col.BackgroundTransparency = 1
            col.LayoutOrder = count + 1

            local lbl = Instance.new("TextLabel", col)
            lbl.Size = UDim2.new(1, 0, 1, 0)
            lbl.BackgroundTransparency = 1
            lbl.Text = name
            lbl.Font = Enum.Font.GothamBold
            lbl.TextSize = 8
            lbl.TextColor3 = GetTheme(LUX.CurrentTheme).SECONDARY_TEXT
            lbl.TextXAlignment = Enum.TextXAlignment.Center

            local bar = Instance.new("Frame", col)
            bar.Size = UDim2.new(0.45, 0, 0, 2)
            bar.Position = UDim2.new(0.275, 0, 1, -2)
            bar.BackgroundColor3 = GetTheme(LUX.CurrentTheme).PRIMARY_TEXT
            bar.BorderSizePixel = 0
            bar.Visible = false
            Instance.new("UICorner", bar).CornerRadius = UDim.new(1, 0)

            local clk = Instance.new("TextButton", col)
            clk.Size = UDim2.new(1, 0, 1, 0)
            clk.BackgroundTransparency = 1
            clk.Text = ""
            clk.ZIndex = 5

            page = createTabPage(name)
            pages[name] = page
            tabBtns[name] = { lbl = lbl, bar = bar }

            clk.MouseButton1Click:Connect(function()
                if pages[activePage] then pages[activePage].Visible = false end
                activePage = name
                pages[name].Visible = true
                for n2, d in pairs(tabBtns) do
                    local on = (n2 == name)
                    TweenService:Create(d.lbl, TweenInfo.new(0.12), {TextColor3 = on and GetTheme(LUX.CurrentTheme).PRIMARY_TEXT or GetTheme(LUX.CurrentTheme).SECONDARY_TEXT}):Play()
                    d.bar.Visible = on
                end
            end)
        end

        local rowOrder = 0
        local function nextOrder() rowOrder = rowOrder + 1; return rowOrder end

        function tabObj:AddSection(title)
            local f = Instance.new("Frame", page)
            f.Size = UDim2.new(1, 0, 0, 14)
            f.BackgroundTransparency = 1
            f.LayoutOrder = nextOrder()
            local dash = Instance.new("Frame", f)
            dash.Size = UDim2.new(0, 6, 0, 2)
            dash.Position = UDim2.new(0, 0, 0.5, -1)
            dash.BackgroundColor3 = GetTheme(windowRef._theme).PRIMARY_TEXT
            dash.BorderSizePixel = 0
            Instance.new("UICorner", dash).CornerRadius = UDim.new(1, 0)
            local l = Instance.new("TextLabel", f)
            l.Size = UDim2.new(1, -10, 1, 0)
            l.Position = UDim2.new(0, 10, 0, 0)
            l.BackgroundTransparency = 1
            l.Text = title:upper()
            l.TextColor3 = GetTheme(windowRef._theme).PRIMARY_TEXT
            l.Font = Enum.Font.GothamBold
            l.TextSize = 7
            l.TextXAlignment = Enum.TextXAlignment.Left
            return f
        end

        local ROW_H = 35 -- بدون وصف، أصبح الارتفاع أقل
        local function mkCard()
            local f = Instance.new("Frame", page)
            f.Size = UDim2.new(1, 0, 0, ROW_H)
            f.BackgroundColor3 = GetTheme(windowRef._theme).ROW
            f.BorderSizePixel = 0
            f.LayoutOrder = nextOrder()
            Instance.new("UICorner", f).CornerRadius = UDim.new(0, 7)
            local st = Instance.new("UIStroke", f)
            st.Color = GetTheme(windowRef._theme).BORDER
            st.Thickness = 1
            return f
        end

        local function addLabel(card, txt)
            local l = Instance.new("TextLabel", card)
            l.Size = UDim2.new(0, 155, 1, 0)
            l.Position = UDim2.new(0, 11, 0, 0)
            l.BackgroundTransparency = 1
            l.Text = txt
            l.TextColor3 = GetTheme(windowRef._theme).PRIMARY_TEXT
            l.Font = Enum.Font.GothamBold
            l.TextSize = 11
            l.TextXAlignment = Enum.TextXAlignment.Left
            return l
        end

        -- ============================================================
        -- تصميم Toggle الجديد (أنيق وجذاب)
        -- ============================================================
        local PILL_W, PILL_H = 46, 24
        local function addToggle(card, initOn)
            local pill = Instance.new("Frame", card)
            pill.Size = UDim2.new(0, PILL_W, 0, PILL_H)
            pill.AnchorPoint = Vector2.new(1, 0.5)
            pill.Position = UDim2.new(1, -11, 0.5, 0)
            pill.BackgroundColor3 = initOn and GetTheme(windowRef._theme).TOGGLE_ON or GetTheme(windowRef._theme).TOGGLE_OFF
            pill.BorderSizePixel = 0
            pill.ZIndex = 4
            pill.ClipsDescendants = false
            Instance.new("UICorner", pill).CornerRadius = UDim.new(1, 0)
            Instance.new("UIStroke", pill).Color = GetTheme(windowRef._theme).BORDER
            Instance.new("UIStroke", pill).Thickness = 1.2

            -- الدائرة الداخلية (تتحرك)
            local dot = Instance.new("Frame", pill)
            dot.Size = UDim2.new(0, 18, 0, 18)
            dot.BorderSizePixel = 0
            dot.ZIndex = 5
            dot.AnchorPoint = Vector2.new(0, 0.5)
            dot.Position = initOn and UDim2.new(1, -20, 0.5, 0) or UDim2.new(0, 3, 0.5, 0)
            dot.BackgroundColor3 = GetTheme(windowRef._theme).TOGGLE_DOT
            Instance.new("UICorner", dot).CornerRadius = UDim.new(1, 0)

            -- ظل للدائرة
            local shadow = Instance.new("Frame", pill)
            shadow.Size = UDim2.new(0, 18, 0, 18)
            shadow.Position = dot.Position + UDim2.new(0, 1, 0, 1)
            shadow.BackgroundColor3 = Color3.fromRGB(0,0,0)
            shadow.BackgroundTransparency = 0.2
            shadow.BorderSizePixel = 0
            shadow.ZIndex = 4
            Instance.new("UICorner", shadow).CornerRadius = UDim.new(1, 0)

            local function setV(on)
                TweenService:Create(pill, TweenInfo.new(0.2), {
                    BackgroundColor3 = on and GetTheme(windowRef._theme).TOGGLE_ON or GetTheme(windowRef._theme).TOGGLE_OFF
                }):Play()
                TweenService:Create(dot, TweenInfo.new(0.2), {
                    Position = on and UDim2.new(1, -20, 0.5, 0) or UDim2.new(0, 3, 0.5, 0)
                }):Play()
                TweenService:Create(shadow, TweenInfo.new(0.2), {
                    Position = on and UDim2.new(1, -20, 0.5, 0) + UDim2.new(0, 1, 0, 1) or UDim2.new(0, 3, 0.5, 0) + UDim2.new(0, 1, 0, 1)
                }):Play()
            end

            -- إعادة ترتيب الظل خلف الدائرة
            shadow.ZIndex = 4
            dot.ZIndex = 5

            local clk = Instance.new("TextButton", card)
            clk.Size = UDim2.new(0, PILL_W + 8, 0, ROW_H)
            clk.AnchorPoint = Vector2.new(1, 0.5)
            clk.Position = UDim2.new(1, -7, 0.5, 0)
            clk.BackgroundTransparency = 1
            clk.Text = ""
            clk.ZIndex = 8

            return setV, clk
        end

        -- ============================================================
        -- العناصر العامة (بدون وصف)
        -- ============================================================
        function tabObj:AddButton(config)
            local name = config.Name or "Button"
            local text = config.Text or "Run"
            local callback = config.Callback or function() end

            local card = mkCard()
            addLabel(card, name)

            local btn = Instance.new("TextButton", card)
            btn.Size = UDim2.new(0, 70, 0, 24)
            btn.AnchorPoint = Vector2.new(1, 0.5)
            btn.Position = UDim2.new(1, -11, 0.5, 0)
            btn.BackgroundColor3 = GetTheme(windowRef._theme).INPUT_BG
            btn.BorderSizePixel = 0
            btn.Text = text
            btn.TextColor3 = GetTheme(windowRef._theme).PRIMARY_TEXT
            btn.Font = Enum.Font.GothamBold
            btn.TextSize = 9
            btn.ZIndex = 5
            btn.AutoButtonColor = false
            Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
            Instance.new("UIStroke", btn).Color = GetTheme(windowRef._theme).BORDER

            btn.MouseButton1Click:Connect(function()
                if callback then callback() end
                TweenService:Create(btn, TweenInfo.new(0.08), {BackgroundColor3 = Color3.fromRGB(50,50,50)}):Play()
                task.delay(0.15, function()
                    TweenService:Create(btn, TweenInfo.new(0.12), {BackgroundColor3 = GetTheme(windowRef._theme).INPUT_BG}):Play()
                end)
            end)

            return { _frame = card, _btn = btn }
        end

        function tabObj:AddToggle(config)
            local name = config.Name or "Toggle"
            local default = config.Default or false
            local callback = config.Callback or function() end
            local flag = config.Flag

            local card = mkCard()
            addLabel(card, name)
            local setV, clk = addToggle(card, default)
            local isOn = default or false

            clk.MouseButton1Click:Connect(function()
                isOn = not isOn
                setV(isOn)
                if flag and windowRef.SetFlag then windowRef:SetFlag(flag, isOn) end
                if callback then callback(isOn) end
            end)

            if flag and windowRef.GetFlag then
                local saved = windowRef:GetFlag(flag, default)
                if saved ~= isOn then
                    isOn = saved
                    setV(isOn)
                    callback(isOn)
                end
            end

            local obj = { _frame = card, _setValue = setV }
            function obj:SetValue(val)
                isOn = val
                setV(val)
                if flag and windowRef.SetFlag then windowRef:SetFlag(flag, val) end
                callback(val)
            end
            return obj
        end

        function tabObj:AddSlider(config)
            local name = config.Name or "Slider"
            local min = config.Min or 0
            local max = config.Max or 100
            local inc = config.Increment or 1
            local default = config.Default or min
            local callback = config.Callback or function() end
            local flag = config.Flag

            local card = mkCard()
            card.Size = UDim2.new(1, 0, 0, 45)
            local label = addLabel(card, name)

            local valueLbl = Instance.new("TextLabel", card)
            valueLbl.Size = UDim2.new(0.3, -10, 0, 20)
            valueLbl.Position = UDim2.new(0.7, 0, 0, 0)
            valueLbl.BackgroundTransparency = 1
            valueLbl.Text = tostring(default)
            valueLbl.TextColor3 = GetTheme(windowRef._theme).SECONDARY_TEXT
            valueLbl.TextSize = 14
            valueLbl.Font = Enum.Font.Gotham
            valueLbl.TextXAlignment = Enum.TextXAlignment.Right

            local sliderBg = Instance.new("Frame", card)
            sliderBg.Size = UDim2.new(0.9, -10, 0, 8)
            sliderBg.Position = UDim2.new(0, 5, 0, 32)
            sliderBg.BackgroundColor3 = GetTheme(windowRef._theme).SLIDER_BG
            sliderBg.BorderSizePixel = 0
            Instance.new("UICorner", sliderBg).CornerRadius = UDim.new(1, 0)

            local sliderFill = Instance.new("Frame", sliderBg)
            sliderFill.Size = UDim2.new((default-min)/(max-min), 0, 1, 0)
            sliderFill.BackgroundColor3 = GetTheme(windowRef._theme).SLIDER_FILL
            sliderFill.BorderSizePixel = 0
            Instance.new("UICorner", sliderFill).CornerRadius = UDim.new(1, 0)

            local dragging = false
            local value = default

            local function updateSlider(mouseX)
                local relative = (mouseX - sliderBg.AbsolutePosition.X) / sliderBg.AbsoluteSize.X
                relative = math.clamp(relative, 0, 1)
                local newVal = min + (max - min) * relative
                newVal = math.round(newVal / inc) * inc
                newVal = math.clamp(newVal, min, max)
                value = newVal
                sliderFill.Size = UDim2.new((value-min)/(max-min), 0, 1, 0)
                valueLbl.Text = tostring(value)
                if flag and windowRef.SetFlag then windowRef:SetFlag(flag, value) end
                callback(value)
            end

            sliderBg.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    dragging = true
                    updateSlider(input.Position.X)
                end
            end)
            UIS.InputChanged:Connect(function(input)
                if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                    updateSlider(input.Position.X)
                end
            end)
            UIS.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    dragging = false
                end
            end)

            if flag and windowRef.GetFlag then
                local saved = windowRef:GetFlag(flag, default)
                if saved ~= value then
                    value = saved
                    sliderFill.Size = UDim2.new((value-min)/(max-min), 0, 1, 0)
                    valueLbl.Text = tostring(value)
                    callback(value)
                end
            end

            local obj = { _frame = card, _sliderFill = sliderFill, _valueLbl = valueLbl }
            function obj:SetValue(val)
                val = math.clamp(val, min, max)
                value = val
                sliderFill.Size = UDim2.new((value-min)/(max-min), 0, 1, 0)
                valueLbl.Text = tostring(value)
                if flag and windowRef.SetFlag then windowRef:SetFlag(flag, value) end
                callback(value)
            end
            return obj
        end

        function tabObj:AddDropdown(config)
            local name = config.Name or "Dropdown"
            local options = config.Options or {}
            local default = config.Default or (type(options[1]) == "string" and options[1] or "")
            local multi = config.MultiSelect or false
            local callback = config.Callback or function() end
            local flag = config.Flag

            local card = mkCard()
            local label = addLabel(card, name)

            local dropdownBtn = Instance.new("TextButton", card)
            dropdownBtn.Size = UDim2.new(0, 80, 0, 25)
            dropdownBtn.AnchorPoint = Vector2.new(1, 0.5)
            dropdownBtn.Position = UDim2.new(1, -11, 0.5, 0)
            dropdownBtn.BackgroundColor3 = GetTheme(windowRef._theme).DROPDOWN_BG
            dropdownBtn.Text = type(default) == "table" and table.concat(default, ", ") or tostring(default)
            dropdownBtn.TextColor3 = GetTheme(windowRef._theme).PRIMARY_TEXT
            dropdownBtn.TextSize = 11
            dropdownBtn.Font = Enum.Font.Gotham
            dropdownBtn.BorderSizePixel = 0
            Instance.new("UICorner", dropdownBtn).CornerRadius = UDim.new(0, 6)
            Instance.new("UIStroke", dropdownBtn).Color = GetTheme(windowRef._theme).BORDER

            local dropList = Instance.new("Frame", card)
            dropList.Size = UDim2.new(1, 0, 0, 0)
            dropList.Position = UDim2.new(0, 0, 1, 0)
            dropList.BackgroundColor3 = GetTheme(windowRef._theme).DROPDOWN_BG
            dropList.BorderSizePixel = 1
            dropList.BorderColor3 = GetTheme(windowRef._theme).BORDER
            dropList.Visible = false
            dropList.ClipsDescendants = true

            local listLayout = Instance.new("UIListLayout", dropList)
            listLayout.Padding = UDim.new(0, 2)
            listLayout.SortOrder = Enum.SortOrder.LayoutOrder

            local selected = default
            if type(selected) ~= "table" then selected = {selected} end

            local function updateDropdown()
                local text = multi and table.concat(selected, ", ") or selected[1] or ""
                dropdownBtn.Text = text
            end

            local function buildList()
                for _, child in ipairs(dropList:GetChildren()) do
                    if child:IsA("TextButton") then child:Destroy() end
                end
                for _, opt in ipairs(options) do
                    local btn = Instance.new("TextButton", dropList)
                    btn.Size = UDim2.new(1, -10, 0, 25)
                    btn.Position = UDim2.new(0, 5, 0, 0)
                    btn.BackgroundTransparency = 0
                    btn.BackgroundColor3 = GetTheme(windowRef._theme).ROW
                    btn.Text = opt
                    btn.TextColor3 = GetTheme(windowRef._theme).PRIMARY_TEXT
                    btn.TextSize = 13
                    btn.Font = Enum.Font.Gotham
                    btn.BorderSizePixel = 0
                    btn.MouseButton1Click:Connect(function()
                        if multi then
                            local idx = table.find(selected, opt)
                            if idx then table.remove(selected, idx)
                            else table.insert(selected, opt) end
                        else
                            selected = {opt}
                            dropList.Visible = false
                            card.Size = UDim2.new(1, 0, 0, ROW_H)
                        end
                        updateDropdown()
                        if flag and windowRef.SetFlag then windowRef:SetFlag(flag, multi and selected or selected[1]) end
                        callback(multi and selected or selected[1])
                    end)
                end
                dropList.Size = UDim2.new(1, 0, 0, #options * 27)
                card.Size = UDim2.new(1, 0, 0, ROW_H + #options * 27)
            end

            dropdownBtn.MouseButton1Click:Connect(function()
                dropList.Visible = not dropList.Visible
                if dropList.Visible then
                    buildList()
                else
                    card.Size = UDim2.new(1, 0, 0, ROW_H)
                end
            end)

            if flag and windowRef.GetFlag then
                local saved = windowRef:GetFlag(flag, default)
                if multi then
                    if type(saved) == "table" then selected = saved end
                else
                    selected = {saved or default}
                end
                updateDropdown()
                callback(multi and selected or selected[1])
            end

            local obj = { _frame = card, _dropdownBtn = dropdownBtn, _dropList = dropList }
            function obj:SetValue(val)
                if multi then selected = val else selected = {val} end
                updateDropdown()
                if flag and windowRef.SetFlag then windowRef:SetFlag(flag, multi and selected or selected[1]) end
                callback(multi and selected or selected[1])
            end
            function obj:Add(opt)
                table.insert(options, opt); buildList()
            end
            function obj:Remove(opt)
                for i, v in ipairs(options) do if v == opt then table.remove(options, i); break end end
                buildList()
            end
            function obj:Clear()
                options = {}; selected = {}; buildList()
            end
            return obj
        end

        function tabObj:AddTextBox(config)
            local name = config.Name or "Input"
            local placeholder = config.Placeholder or ""
            local default = config.Default or ""
            local clearOnFocus = config.ClearOnFocus or false
            local callback = config.Callback or function() end
            local flag = config.Flag

            local card = mkCard()
            local label = addLabel(card, name)

            local input = Instance.new("TextBox", card)
            input.Size = UDim2.new(0, 56, 0, 24)
            input.AnchorPoint = Vector2.new(1, 0.5)
            input.Position = UDim2.new(1, -11, 0.5, 0)
            input.BackgroundColor3 = GetTheme(windowRef._theme).INPUT_BG
            input.BorderSizePixel = 0
            input.Text = default
            input.PlaceholderText = placeholder
            input.TextColor3 = GetTheme(windowRef._theme).PRIMARY_TEXT
            input.PlaceholderColor3 = GetTheme(windowRef._theme).SECONDARY_TEXT
            input.TextSize = 10
            input.Font = Enum.Font.GothamBold
            input.ClearTextOnFocus = clearOnFocus
            Instance.new("UICorner", input).CornerRadius = UDim.new(0, 6)
            Instance.new("UIStroke", input).Color = GetTheme(windowRef._theme).BORDER

            input.FocusLost:Connect(function(enter)
                if enter then
                    local text = input.Text
                    if flag and windowRef.SetFlag then windowRef:SetFlag(flag, text) end
                    callback(text)
                end
            end)

            if flag and windowRef.GetFlag then
                local saved = windowRef:GetFlag(flag, default)
                if saved then input.Text = saved; callback(saved) end
            end

            local obj = { _frame = card, _input = input }
            function obj:SetText(text)
                input.Text = text
                if flag and windowRef.SetFlag then windowRef:SetFlag(flag, text) end
                callback(text)
            end
            function obj:GetText() return input.Text end
            return obj
        end

        function tabObj:AddParagraph(title, content)
            local card = Instance.new("Frame", page)
            card.Size = UDim2.new(1, 0, 0, 50)
            card.BackgroundColor3 = GetTheme(windowRef._theme).ROW
            card.BackgroundTransparency = 0.3
            card.BorderSizePixel = 0
            card.LayoutOrder = nextOrder()
            Instance.new("UICorner", card).CornerRadius = UDim.new(0, 7)
            Instance.new("UIStroke", card).Color = GetTheme(windowRef._theme).BORDER

            local titleLbl = Instance.new("TextLabel", card)
            titleLbl.Size = UDim2.new(1, -20, 0, 20)
            titleLbl.Position = UDim2.new(0, 10, 0, 0)
            titleLbl.BackgroundTransparency = 1
            titleLbl.Text = title
            titleLbl.TextColor3 = GetTheme(windowRef._theme).PRIMARY_TEXT
            titleLbl.TextSize = 15
            titleLbl.Font = Enum.Font.GothamBold
            titleLbl.TextXAlignment = Enum.TextXAlignment.Left

            local contentLbl = Instance.new("TextLabel", card)
            contentLbl.Size = UDim2.new(1, -20, 0, 30)
            contentLbl.Position = UDim2.new(0, 10, 0, 20)
            contentLbl.BackgroundTransparency = 1
            contentLbl.Text = content
            contentLbl.TextColor3 = GetTheme(windowRef._theme).SECONDARY_TEXT
            contentLbl.TextSize = 13
            contentLbl.Font = Enum.Font.Gotham
            contentLbl.TextXAlignment = Enum.TextXAlignment.Left
            contentLbl.TextWrapped = true

            local lines = #string.split(content, "\n")
            card.Size = UDim2.new(1, 0, 0, 20 + lines * 20)
            return card
        end

        function tabObj:AddKeybind(config)
            local name = config.Name or "Keybind"
            local default = config.Default or Enum.KeyCode.None
            local callback = config.Callback or function() end
            local flag = config.Flag

            local card = mkCard()
            addLabel(card, name)

            local keyBtn = Instance.new("TextButton", card)
            keyBtn.Size = UDim2.new(0, 60, 0, 24)
            keyBtn.AnchorPoint = Vector2.new(1, 0.5)
            keyBtn.Position = UDim2.new(1, -11, 0.5, 0)
            keyBtn.BackgroundColor3 = GetTheme(windowRef._theme).INPUT_BG
            keyBtn.BorderSizePixel = 0
            keyBtn.Text = default.Name or "None"
            keyBtn.TextColor3 = GetTheme(windowRef._theme).PRIMARY_TEXT
            keyBtn.TextSize = 9
            keyBtn.Font = Enum.Font.GothamBold
            Instance.new("UICorner", keyBtn).CornerRadius = UDim.new(0, 6)
            Instance.new("UIStroke", keyBtn).Color = GetTheme(windowRef._theme).BORDER

            local currentKey = default
            local listening = false
            local conn = nil

            keyBtn.MouseButton1Click:Connect(function()
                if listening then
                    listening = false
                    if conn then conn:Disconnect(); conn = nil end
                    keyBtn.Text = currentKey.Name
                    return
                end
                listening = true
                keyBtn.Text = "..."
                conn = UIS.InputBegan:Connect(function(inp, gp)
                    if gp then return end
                    if not listening then return end
                    if inp.KeyCode ~= Enum.KeyCode.Unknown then
                        currentKey = inp.KeyCode
                        keyBtn.Text = currentKey.Name
                        listening = false
                        if conn then conn:Disconnect(); conn = nil end
                        if flag and windowRef.SetFlag then windowRef:SetFlag(flag, currentKey.Name) end
                        callback(currentKey)
                    end
                end)
            end)

            if flag and windowRef.GetFlag then
                local saved = windowRef:GetFlag(flag, nil)
                if saved then
                    local key = Enum.KeyCode[saved]
                    if key then
                        currentKey = key
                        keyBtn.Text = key.Name
                        callback(key)
                    end
                end
            end

            local obj = { _frame = card, _keyBtn = keyBtn }
            function obj:SetKey(key)
                currentKey = key
                keyBtn.Text = key.Name
                if flag and windowRef.SetFlag then windowRef:SetFlag(flag, key.Name) end
                callback(key)
            end
            return obj
        end

        function tabObj:AddExternalButton(config)
            local name = config.Name or "External"
            local text = config.Text or "Run"
            local externalCode = config.External or ""
            local callback = config.Callback or function() end

            local card = mkCard()
            addLabel(card, name)

            local btn = Instance.new("TextButton", card)
            btn.Size = UDim2.new(0, 70, 0, 24)
            btn.AnchorPoint = Vector2.new(1, 0.5)
            btn.Position = UDim2.new(1, -11, 0.5, 0)
            btn.BackgroundColor3 = GetTheme(windowRef._theme).INPUT_BG
            btn.BorderSizePixel = 0
            btn.Text = text
            btn.TextColor3 = GetTheme(windowRef._theme).PRIMARY_TEXT
            btn.Font = Enum.Font.GothamBold
            btn.TextSize = 9
            Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
            Instance.new("UIStroke", btn).Color = GetTheme(windowRef._theme).BORDER

            btn.MouseButton1Click:Connect(function()
                if externalCode ~= "" then
                    local func = loadstring(externalCode)
                    if func then pcall(func) end
                end
                callback()
                TweenService:Create(btn, TweenInfo.new(0.08), {BackgroundColor3 = Color3.fromRGB(50,50,50)}):Play()
                task.delay(0.15, function()
                    TweenService:Create(btn, TweenInfo.new(0.12), {BackgroundColor3 = GetTheme(windowRef._theme).INPUT_BG}):Play()
                end)
            end)

            return { _frame = card, _btn = btn }
        end

        function tabObj:AddDiscordInvite(config)
            local title = config.Title or "Discord"
            local desc = config.Description or ""
            local invite = config.Invite or ""
            local members = config.Members or 0
            local online = config.Online or 0
            local banner = config.Banner or Color3.fromRGB(50,50,50)

            local card = Instance.new("Frame", page)
            card.Size = UDim2.new(1, 0, 0, 100)
            card.BackgroundColor3 = GetTheme(windowRef._theme).ROW
            card.BackgroundTransparency = 0.3
            card.BorderSizePixel = 1
            card.BorderColor3 = GetTheme(windowRef._theme).BORDER
            card.LayoutOrder = nextOrder()
            Instance.new("UICorner", card).CornerRadius = UDim.new(0, 7)

            local bannerFrame = Instance.new("Frame", card)
            bannerFrame.Size = UDim2.new(1, 0, 0, 40)
            bannerFrame.BackgroundColor3 = banner
            bannerFrame.BorderSizePixel = 0
            Instance.new("UICorner", bannerFrame).CornerRadius = UDim.new(0, 7)

            local titleLbl = Instance.new("TextLabel", bannerFrame)
            titleLbl.Size = UDim2.new(1, -20, 1, 0)
            titleLbl.Position = UDim2.new(0, 10, 0, 0)
            titleLbl.BackgroundTransparency = 1
            titleLbl.Text = title
            titleLbl.TextColor3 = GetTheme(windowRef._theme).PRIMARY_TEXT
            titleLbl.TextSize = 18
            titleLbl.Font = Enum.Font.GothamBold
            titleLbl.TextXAlignment = Enum.TextXAlignment.Left

            local inviteBtn = Instance.new("TextButton", bannerFrame)
            inviteBtn.Size = UDim2.new(0, 70, 0, 25)
            inviteBtn.Position = UDim2.new(1, -80, 0.5, -12.5)
            inviteBtn.BackgroundColor3 = GetTheme(windowRef._theme).ACCENT
            inviteBtn.Text = "Join"
            inviteBtn.TextColor3 = GetTheme(windowRef._theme).PRIMARY_TEXT
            inviteBtn.TextSize = 13
            inviteBtn.Font = Enum.Font.GothamBold
            inviteBtn.BorderSizePixel = 0
            Instance.new("UICorner", inviteBtn).CornerRadius = UDim.new(0, 6)
            inviteBtn.MouseButton1Click:Connect(function()
                if invite ~= "" and setclipboard then
                    setclipboard(invite)
                    windowRef:Notify({Title = "نسخ", Content = "تم نسخ رابط الديسكورد!", Duration = 2})
                end
            end)

            local infoFrame = Instance.new("Frame", card)
            infoFrame.Size = UDim2.new(1, 0, 0, 60)
            infoFrame.Position = UDim2.new(0, 0, 0, 40)
            infoFrame.BackgroundTransparency = 1

            local descLbl = Instance.new("TextLabel", infoFrame)
            descLbl.Size = UDim2.new(1, -20, 0, 25)
            descLbl.Position = UDim2.new(0, 10, 0, 0)
            descLbl.BackgroundTransparency = 1
            descLbl.Text = desc
            descLbl.TextColor3 = GetTheme(windowRef._theme).SECONDARY_TEXT
            descLbl.TextSize = 13
            descLbl.Font = Enum.Font.Gotham
            descLbl.TextXAlignment = Enum.TextXAlignment.Left

            if members > 0 then
                local membersLbl = Instance.new("TextLabel", infoFrame)
                membersLbl.Size = UDim2.new(0.5, -10, 0, 20)
                membersLbl.Position = UDim2.new(0, 10, 0, 25)
                membersLbl.BackgroundTransparency = 1
                membersLbl.Text = "👥 " .. members .. " members"
                membersLbl.TextColor3 = GetTheme(windowRef._theme).SECONDARY_TEXT
                membersLbl.TextSize = 12
                membersLbl.Font = Enum.Font.Gotham
                membersLbl.TextXAlignment = Enum.TextXAlignment.Left
            end
            if online > 0 then
                local onlineLbl = Instance.new("TextLabel", infoFrame)
                onlineLbl.Size = UDim2.new(0.5, -10, 0, 20)
                onlineLbl.Position = UDim2.new(0.5, 0, 0, 25)
                onlineLbl.BackgroundTransparency = 1
                onlineLbl.Text = "🟢 " .. online .. " online"
                onlineLbl.TextColor3 = GetTheme(windowRef._theme).SECONDARY_TEXT
                onlineLbl.TextSize = 12
                onlineLbl.Font = Enum.Font.Gotham
                onlineLbl.TextXAlignment = Enum.TextXAlignment.Left
            end
            return card
        end

        return tabObj
    end

    -- ================================================================
    -- 5. دوال النافذة (Window API)
    -- ================================================================
    local window = {
        _gui = gui,
        _main = main,
        _theme = LUX.CurrentTheme,
        _title = title,
        _subtitle = subtitle,
        _flags = {},
        _tabs = {},
        _sideButtons = sideBtnRefs,
        _sideBtnPositions = sideBtnPositions,
        _sideDragLocked = sideDragLocked,
        _lockBtn = lockBtn,
        _miniBtn = miniBtn,
        _closeB = closeB,
        _titleL = titleL,
        _verL = verL,
        _circleButtonsEnabled = circleButtonsEnabled,
        _circleButtonSize = circleButtonSize,
        _sideButtonsHidden = sideButtonsHidden,
        _header = header,
        _lockBtn = lockBtn,
    }

    function window:ApplyTheme()
        local theme = GetTheme(self._theme)
        self._main.BackgroundColor3 = theme.BG
        self._main.BorderColor3 = theme.BORDER
        self._titleL.TextColor3 = theme.PRIMARY_TEXT
        self._verL.TextColor3 = theme.SECONDARY_TEXT
        for _, btn in pairs(self._sideButtons) do
            local s = btn:FindFirstChildOfClass("UIStroke")
            if s then s.Color = theme.BORDER end
        end
    end

    function window:ApplySideBtnPositions()
        for _, btn in pairs(self._sideButtons) do
            local pos = self._sideBtnPositions[btn]
            if pos then
                btn.Position = UDim2.new(pos.xs, pos.xo, pos.ys, pos.yo)
            end
        end
    end

    function window:AddSideButton(config)
        local label = config.Label or "زر"
        local callback = config.Callback or function() end

        local sz = self._circleButtonsEnabled and self._circleButtonSize or CELL
        local btn = Instance.new("TextButton", gui)
        btn.Size = UDim2.new(0, sz, 0, sz)

        local count = #self._sideButtons + 1
        local col = (count % 2 == 1) and 1 or 2
        local row = math.floor((count - 1) / 2) + 1
        local xo = 12 - 138 + (col - 1) * (CELL + CELL_PAD)
        local yo = 0.47 * sizeY - 129 + (row - 1) * (CELL + CELL_PAD)
        btn.Position = UDim2.new(1, xo, 0.47, yo)

        btn.BackgroundColor3 = Color3.fromRGB(255,255,255)
        btn.TextColor3 = Color3.fromRGB(0,0,0)
        btn.TextStrokeTransparency = 0
        btn.TextStrokeColor3 = Color3.fromRGB(255,255,255)
        btn.Font = Enum.Font.GothamBold
        btn.TextSize = 10
        btn.LineHeight = 1.0
        btn.Text = label
        btn.ZIndex = 20
        btn.AutoButtonColor = false
        btn.ClipsDescendants = true

        local corner = Instance.new("UICorner", btn)
        corner.CornerRadius = self._circleButtonsEnabled and UDim.new(1, 0) or UDim.new(0, 12)
        local stroke = Instance.new("UIStroke", btn)
        stroke.Thickness = 1.5
        stroke.Color = GetTheme(self._theme).BORDER
        stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

        local bDragging, bDragInput, bDragStart, bStartPos = false, nil, nil, nil
        local wasDragged = false
        btn.InputBegan:Connect(function(inp)
            if self._sideDragLocked then return end
            if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
                bDragging = true
                wasDragged = false
                bDragStart = inp.Position
                bStartPos = btn.Position
                inp.Changed:Connect(function()
                    if inp.UserInputState == Enum.UserInputState.End then bDragging = false end
                end)
            end
        end)
        btn.InputChanged:Connect(function(inp)
            if inp.UserInputType == Enum.UserInputType.MouseMovement or inp.UserInputType == Enum.UserInputType.Touch then
                bDragInput = inp
            end
        end)
        UIS.InputChanged:Connect(function(inp)
            if inp == bDragInput and bDragging and not self._sideDragLocked then
                local dx = inp.Position.X - bDragStart.X
                local dy = inp.Position.Y - bDragStart.Y
                if math.abs(dx) > 3 or math.abs(dy) > 3 then wasDragged = true end
                btn.Position = UDim2.new(bStartPos.X.Scale, bStartPos.X.Offset + dx,
                                         bStartPos.Y.Scale, bStartPos.Y.Offset + dy)
                local p = btn.Position
                self._sideBtnPositions[btn] = { xs = p.X.Scale, xo = p.X.Offset, ys = p.Y.Scale, yo = p.Y.Offset }
            end
        end)

        btn.MouseButton1Click:Connect(function()
            if wasDragged then
                wasDragged = false
                return
            end
            if callback then callback() end
        end)

        self._sideButtons[#self._sideButtons + 1] = btn
        self._sideBtnPositions[btn] = {
            xs = btn.Position.X.Scale,
            xo = btn.Position.X.Offset,
            ys = btn.Position.Y.Scale,
            yo = btn.Position.Y.Offset
        }

        if self._sideButtonsHidden then btn.Visible = false end
        return btn
    end

    function window:SetSideButtonsLocked(locked)
        self._sideDragLocked = locked
        self._lockBtn.Text = locked and "🔒" or "🔓"
        local col = locked and GetTheme(self._theme).BORDER or Color3.fromRGB(150,150,150)
        for _, btn in pairs(self._sideButtons) do
            local s = btn:FindFirstChildOfClass("UIStroke")
            if s then s.Color = col end
        end
    end

    function window:ToggleSideButtonsVisible(visible)
        self._sideButtonsHidden = not visible
        for _, btn in pairs(self._sideButtons) do
            btn.Visible = visible
        end
    end

    function window:ResetSideButtonsPosition()
        local count = 0
        for _, btn in pairs(self._sideButtons) do
            count = count + 1
            local col = (count % 2 == 1) and 1 or 2
            local row = math.floor((count - 1) / 2) + 1
            local xo = 12 - 138 + (col - 1) * (CELL + CELL_PAD)
            local yo = 0.47 * sizeY - 129 + (row - 1) * (CELL + CELL_PAD)
            local newPos = UDim2.new(1, xo, 0.47, yo)
            TweenService:Create(btn, TweenInfo.new(0.25), {Position = newPos}):Play()
            self._sideBtnPositions[btn] = { xs = 1, xo = xo, ys = 0.47, yo = yo }
        end
    end

    function window:SetTitle(t)
        self._title = t
        self._titleL.Text = t
        self._miniBtn.Text = t
    end

    function window:GetTitle() return self._title end
    function window:SetSubTitle(st) self._subtitle = st; self._verL.Text = st end
    function window:GetSubTitle() return self._subtitle end
    function window:Destroy() self._gui:Destroy() end

    -- إشعارات
    function window:Notify(config)
        local title = config.Title or "Notify"
        local content = config.Content or ""
        local duration = config.Duration or 3

        local notify = Instance.new("Frame", gui)
        notify.Size = UDim2.new(0, 250, 0, 60)
        notify.Position = UDim2.new(0.5, -125, 1, -80)
        notify.BackgroundColor3 = GetTheme(self._theme).NOTIFY_BG
        notify.BorderSizePixel = 1
        notify.BorderColor3 = GetTheme(self._theme).BORDER
        notify.BackgroundTransparency = 0.1
        Instance.new("UICorner", notify).CornerRadius = UDim.new(0, 7)

        local titleLbl = Instance.new("TextLabel", notify)
        titleLbl.Size = UDim2.new(1, -20, 0, 20)
        titleLbl.Position = UDim2.new(0, 10, 0, 5)
        titleLbl.BackgroundTransparency = 1
        titleLbl.Text = title
        titleLbl.TextColor3 = GetTheme(self._theme).PRIMARY_TEXT
        titleLbl.TextSize = 16
        titleLbl.Font = Enum.Font.GothamBold
        titleLbl.TextXAlignment = Enum.TextXAlignment.Left

        local contentLbl = Instance.new("TextLabel", notify)
        contentLbl.Size = UDim2.new(1, -20, 0, 30)
        contentLbl.Position = UDim2.new(0, 10, 0, 25)
        contentLbl.BackgroundTransparency = 1
        contentLbl.Text = content
        contentLbl.TextColor3 = GetTheme(self._theme).SECONDARY_TEXT
        contentLbl.TextSize = 13
        contentLbl.Font = Enum.Font.Gotham
        contentLbl.TextXAlignment = Enum.TextXAlignment.Left

        notify.BackgroundTransparency = 1
        notify.Position = UDim2.new(0.5, -125, 1, -10)
        local tween = TweenService:Create(notify, TweenInfo.new(0.3), {BackgroundTransparency = 0.1, Position = UDim2.new(0.5, -125, 1, -80)})
        tween:Play()
        task.wait(duration)
        local tween2 = TweenService:Create(notify, TweenInfo.new(0.3), {BackgroundTransparency = 1, Position = UDim2.new(0.5, -125, 1, -10)})
        tween2:Play()
        tween2.Completed:Connect(function() notify:Destroy() end)
    end

    -- حوارات
    function window:Dialog(config)
        local title = config.Title or "Dialog"
        local content = config.Content or ""
        local options = config.Options or {}

        local dialog = Instance.new("Frame", gui)
        dialog.Size = UDim2.new(0, 280, 0, 150)
        dialog.Position = UDim2.new(0.5, -140, 0.5, -75)
        dialog.BackgroundColor3 = GetTheme(self._theme).DIALOG_BG
        dialog.BorderSizePixel = 1
        dialog.BorderColor3 = GetTheme(self._theme).BORDER
        Instance.new("UICorner", dialog).CornerRadius = UDim.new(0, 10)

        local titleLbl = Instance.new("TextLabel", dialog)
        titleLbl.Size = UDim2.new(1, -20, 0, 30)
        titleLbl.Position = UDim2.new(0, 10, 0, 5)
        titleLbl.BackgroundTransparency = 1
        titleLbl.Text = title
        titleLbl.TextColor3 = GetTheme(self._theme).PRIMARY_TEXT
        titleLbl.TextSize = 18
        titleLbl.Font = Enum.Font.GothamBold
        titleLbl.TextXAlignment = Enum.TextXAlignment.Center

        local contentLbl = Instance.new("TextLabel", dialog)
        contentLbl.Size = UDim2.new(1, -20, 0, 60)
        contentLbl.Position = UDim2.new(0, 10, 0, 35)
        contentLbl.BackgroundTransparency = 1
        contentLbl.Text = content
        contentLbl.TextColor3 = GetTheme(self._theme).SECONDARY_TEXT
        contentLbl.TextSize = 14
        contentLbl.Font = Enum.Font.Gotham
        contentLbl.TextWrapped = true

        local btnContainer = Instance.new("Frame", dialog)
        btnContainer.Size = UDim2.new(1, -20, 0, 35)
        btnContainer.Position = UDim2.new(0, 10, 1, -40)
        btnContainer.BackgroundTransparency = 1

        local btnCount = #options
        for i, opt in ipairs(options) do
            local btn = Instance.new("TextButton", btnContainer)
            btn.Size = UDim2.new(1/btnCount, -4, 1, 0)
            btn.Position = UDim2.new((i-1)/btnCount, 2, 0, 0)
            btn.BackgroundColor3 = GetTheme(self._theme).ROW
            btn.Text = opt.Name
            btn.TextColor3 = GetTheme(self._theme).PRIMARY_TEXT
            btn.TextSize = 14
            btn.Font = Enum.Font.GothamBold
            btn.BorderSizePixel = 0
            Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
            btn.MouseButton1Click:Connect(function()
                if opt.Callback then opt.Callback() end
                dialog:Destroy()
            end)
        end
    end

    -- Flags
    function window:SetFlag(key, value)
        self._flags[key] = value
        pcall(LUX.SaveConfig, LUX)
    end

    function window:GetFlag(key, default)
        return self._flags[key] or default
    end

    function window:DeleteFlags()
        self._flags = {}
        pcall(LUX.SaveConfig, LUX)
    end

    function window:AddTab(name)
        local tab = CreateTabObject(window, name)
        table.insert(self._tabs, tab)
        return tab
    end

    table.insert(self._windows, window)

    task.defer(function()
        LUX:LoadConfig()
        local savedTheme = window:GetFlag("_theme", LUX.CurrentTheme)
        if savedTheme and LUX:IsValidTheme(savedTheme) then
            LUX:SetTheme(savedTheme)
        end
        window:ApplySideBtnPositions()
    end)

    return window
end

return LUX
