# ✨ LUX UI – مكتبة الواجهات الاحترافية

## 📌 نبذة عن المكتبة

**LUX UI** هي مكتبة واجهات رسومية (GUI) مبنية من الصفر لمشاريع **Roblox Lua**، مستوحاة من تصميم **Balenciaga** الأنيق (الأبيض والأسود). تم تطويرها لتكون:

- **قابلة للبرمجة بالكامل** – لا تحتوي على أي عناصر جاهزة، أنت من يبني كل شيء.
- **خفيفة وسريعة** – لا تستهلك موارد الجهاز.
- **جميلة وعصرية** – تصميم نظيف ومتناسق.
- **شاملة** – تحتوي على جميع أدوات الواجهة التي قد تحتاجها.

- 🔹 **المطور**: مجتمع LUX (مستخلص من BALENCIAGA.VS)
- 🔹 **الإصدار**: 3.1
- 🔹 **الترخيص**: مفتوح المصدر

---

## 🚀 البدء السريع

لتحميل المكتبة، استخدم الأمر التالي:

```lua
local LUX = loadstring(game:HttpGet("https://raw.githubusercontent.com/your-username/LUX/main.lua"))()
```

### إنشاء نافذة

```lua
local Window = LUX:MakeWindow({
  Title = "مركز التحكم",
  SubTitle = "الإصدار 1.0",
  Tabs = {"الرئيسية", "الإعدادات"}
})
```

---

## 📚 وثائق الـ API

### 1. النافذة (`Window`)

#### `LUX:MakeWindow(Configs) -> Window`

تُنشئ نافذة جديدة.

| الخاصية | النوع | إلزامي | الوصف |
|---------|-------|--------|-------|
| `Title` | `string` | ✅ | عنوان النافذة |
| `SubTitle` | `string` | ❌ | عنوان فرعي |
| `Tabs` | `table` | ✅ | أسماء التبويبات (مثال: `{"الرئيسية", "الإعدادات"}`) |
| `SizeX` | `number` | ❌ | العرض (افتراضي: 260) |
| `SizeY` | `number` | ❌ | الارتفاع (افتراضي: 370) |

---

#### دوال النافذة

##### `Window:AddTab(Title: string) -> Tab`

يضيف تبويباً جديداً.

```lua
local MainTab = Window:AddTab("الرئيسية")
```

##### `Window:AddSideButton(Configs: { Label: string, Callback: function }) -> Button`

يضيف زراً جانبياً (قابل للسحب عند فتح القفل).

```lua
Window:AddSideButton({
  Label = "تشغيل",
  Callback = function()
    print("تم التشغيل")
  end
})
```

##### `Window:SetSideButtonsLocked(State: boolean)`

يقفل أو يفتح سحب الأزرار الجانبية.

```lua
Window:SetSideButtonsLocked(true)  -- قفل
Window:SetSideButtonsLocked(false) -- فتح
```

##### `Window:ToggleSideButtonsVisible(State: boolean)`

يُظهر أو يُخفي جميع الأزرار الجانبية.

```lua
Window:ToggleSideButtonsVisible(true)  -- إظهار
Window:ToggleSideButtonsVisible(false) -- إخفاء
```

##### `Window:ResetSideButtonsPosition()`

يعيد الأزرار الجانبية إلى مواقعها الافتراضية.

```lua
Window:ResetSideButtonsPosition()
```

##### `Window:Notify(Configs: { Title: string, Content: string, Duration: number? }) -> Notification`

يعرض إشعاراً منبثقاً.

```lua
Window:Notify({
  Title = "نجاح",
  Content = "تمت العملية!",
  Duration = 3
})
```

##### `Window:Dialog(Configs: { Title: string, Content: string, Options: { { Name: string, Callback: function? } } }) -> Dialog`

يعرض نافذة حوار تفاعلية.

```lua
Window:Dialog({
  Title = "تأكيد الحذف",
  Content = "هل أنت متأكد؟",
  Options = {
    { Name = "نعم", Callback = function() print("تم الحذف") end },
    { Name = "لا" }
  }
})
```

##### `Window:SetTitle(Title: string)`

تغيير عنوان النافذة.

```lua
Window:SetTitle("عنوان جديد")
```

##### `Window:GetTitle() -> string`

استرجاع العنوان الحالي.

```lua
print(Window:GetTitle())
```

##### `Window:SetSubTitle(SubTitle: string)`

تغيير العنوان الفرعي.

```lua
Window:SetSubTitle("الإصدار 2.0")
```

##### `Window:GetSubTitle() -> string`

استرجاع العنوان الفرعي.

```lua
print(Window:GetSubTitle())
```

##### `Window:SetFlag(Key: string, Value: any)`

حفظ قيمة تحت مفتاح معين (تُحفظ تلقائياً في ملف JSON).

```lua
Window:SetFlag("my_setting", 100)
```

##### `Window:GetFlag(Key: string, Default: any?) -> any`

استرجاع القيمة المحفوظة أو القيمة الافتراضية.

```lua
local val = Window:GetFlag("my_setting", 0)
```

##### `Window:DeleteFlags() -> boolean`

مسح جميع الإعدادات المحفوظة.

```lua
Window:DeleteFlags()
```

##### `Window:Destroy()`

إغلاق النافذة وإزالتها بالكامل.

```lua
Window:Destroy()
```

---

### 2. التبويب (`Tab`)

#### دوال التبويب

##### `Tab:AddSection(Title: string)`

يضيف عنواناً فرعياً (قسم) داخل التبويب.

```lua
MainTab:AddSection("الإعدادات العامة")
```

##### `Tab:AddButton(Configs: { Name: string, Text: string?, Callback: function }) -> Button`

يضيف زراً عادياً.

```lua
MainTab:AddButton({
  Name = "تشغيل السكربت",
  Text = "ابدأ",
  Callback = function()
    print("تم التشغيل")
  end
})
```

##### `Tab:AddToggle(Configs: { Name: string, Default: boolean?, Callback: function?, Flag: string? }) -> Toggle`

يضيف مفتاح تبديل (ON/OFF) بتصميم أنيق (دائرة متحركة).

```lua
local Toggle = MainTab:AddToggle({
  Name = "الميزة الذكية",
  Default = false,
  Callback = function(Value)
    print(Value)
  end,
  Flag = "smart_feature"
})

-- تغيير القيمة برمجياً
Toggle:SetValue(true)
```

##### `Tab:AddSlider(Configs: { Name: string, Min: number, Max: number, Increment: number?, Default: number?, Callback: function?, Flag: string? }) -> Slider`

يضيف منزلقاً لاختيار قيمة رقمية.

```lua
local Slider = MainTab:AddSlider({
  Name = "مستوى الصوت",
  Min = 0,
  Max = 100,
  Increment = 5,
  Default = 50,
  Callback = function(Value)
    print(Value)
  end,
  Flag = "volume"
})

Slider:SetValue(75)
```

##### `Tab:AddDropdown(Configs: { Name: string, Options: {string}, Default: string | table?, MultiSelect: boolean?, Callback: function?, Flag: string? }) -> Dropdown`

يضيف قائمة منسدلة (اختيار مفرد أو متعدد).

```lua
-- اختيار مفرد
local Dropdown = MainTab:AddDropdown({
  Name = "الوضع",
  Options = {"سهل", "عادي", "صعب"},
  Default = "عادي",
  Callback = function(Value)
    print(Value)
  end,
  Flag = "mode"
})

-- اختيار متعدد
local MultiDrop = MainTab:AddDropdown({
  Name = "الميزات",
  Options = {"سرعة", "قفز", "طيران"},
  Default = {"سرعة", "قفز"},
  MultiSelect = true,
  Callback = function(Value)
    print(table.concat(Value, ", "))
  end
})

-- دوال إضافية
Dropdown:Add("خيار جديد")   -- إضافة خيار
Dropdown:Remove("سهل")      -- حذف خيار
Dropdown:Clear()            -- تفريغ الكل
```

##### `Tab:AddTextBox(Configs: { Name: string, Placeholder: string?, Default: string?, ClearOnFocus: boolean?, Callback: function?, Flag: string? }) -> TextBox`

يضيف مربع إدخال نص.

```lua
local TextBox = MainTab:AddTextBox({
  Name = "اسم المستخدم",
  Placeholder = "اكتب اسمك...",
  Default = "اللاعب",
  ClearOnFocus = true,
  Callback = function(Value)
    print(Value)
  end,
  Flag = "username"
})

TextBox:SetText("اسم جديد")
local text = TextBox:GetText()
```

##### `Tab:AddParagraph(Title: string, Content: string)`

يضيف فقرة نصية.

```lua
MainTab:AddParagraph("معلومات", "هذه فقرة نصية.\nيمكنك استخدام السطر الجديد.")
```

##### `Tab:AddKeybind(Configs: { Name: string, Default: KeyCode?, Callback: function?, Flag: string? }) -> Keybind`

يضيف مفتاح اختصار قابل للتغيير.

```lua
local Keybind = MainTab:AddKeybind({
  Name = "اختصار السرعة",
  Default = Enum.KeyCode.Q,
  Callback = function(Key)
    print(Key.Name)
  end,
  Flag = "speed_key"
})

Keybind:SetKey(Enum.KeyCode.E)
```

##### `Tab:AddExternalButton(Configs: { Name: string, Text: string?, External: string, Callback: function? }) -> Button`

يضيف زراً ينفذ كود Lua مخصص (نص برمجي).

```lua
MainTab:AddExternalButton({
  Name = "تغيير السرعة",
  Text = "تشغيل",
  External = [[
    local LP = game:GetService("Players").LocalPlayer
    if LP and LP.Character then
      LP.Character:FindFirstChild("Humanoid").WalkSpeed = 50
    end
  ]],
  Callback = function()
    Window:Notify({Title = "تم", Content = "تم التغيير"})
  end
})
```

##### `Tab:AddDiscordInvite(Configs: { Title: string, Description: string?, Invite: string, Members: number?, Online: number?, Banner: Color3? })`

يضيف بطاقة دعوة ديسكورد.

```lua
MainTab:AddDiscordInvite({
  Title = "مجتمع التطوير",
  Description = "انضم للحصول على الدعم",
  Invite = "https://discord.gg/your-server",
  Members = 1250,
  Online = 320,
  Banner = Color3.fromRGB(40, 40, 40)
})
```

---

### 3. دوال عامة (`LUX`)

#### `LUX:SetTheme(ThemeName: string)`

تغيير الثيم الحالي (القيم المتاحة: `"Balenciaga"`، `"Dark"`).

```lua
LUX:SetTheme("Dark")
```

#### `LUX:GetTheme() -> string`

إرجاع اسم الثيم الحالي.

```lua
print(LUX:GetTheme()) -- "Balenciaga"
```

#### `LUX:GetThemes() -> { string }`

إرجاع قائمة بجميع الثيمات المتاحة.

```lua
for _, theme in ipairs(LUX:GetThemes()) do
  print(theme)
end
```

#### `LUX:SaveConfig()` / `LUX:LoadConfig()`

حفظ أو تحميل الإعدادات يدوياً (تُنفذ تلقائياً كل 5 ثوانٍ).

```lua
LUX:SaveConfig()  -- حفظ فوري
LUX:LoadConfig()  -- تحميل فوري
```

---

## 📝 أمثلة عملية

### مثال شامل للواجهة

```lua
local LUX = loadstring(game:HttpGet("رابط المكتبة"))()

local Window = LUX:MakeWindow({
  Title = "أدواتي المتقدمة",
  SubTitle = "الإصدار 1.0",
  Tabs = {"الرئيسية", "الإعدادات", "معلومات"}
})

-- الأزرار الجانبية
Window:AddSideButton({
  Label = "تشغيل",
  Callback = function()
    Window:Notify({Title = "تم", Content = "تم التشغيل!"})
  end
})

Window:AddSideButton({
  Label = "نسخ\nالنص",
  Callback = function()
    if setclipboard then
      setclipboard("نص مخصص")
      Window:Notify({Title = "نسخ", Content = "تم النسخ!"})
    end
  end
})

-- التبويب الرئيسي
local MainTab = Window:AddTab("الرئيسية")

MainTab:AddSection("التحكم الأساسي")

MainTab:AddButton({
  Name = "زر تجريبي",
  Text = "اضغط",
  Callback = function()
    print("تم الضغط!")
  end
})

MainTab:AddToggle({
  Name = "الميزة الذكية",
  Default = false,
  Callback = function(Value)
    print("الميزة:", Value)
  end,
  Flag = "smart_feature"
})

MainTab:AddSlider({
  Name = "مستوى الصوت",
  Min = 0,
  Max = 100,
  Increment = 5,
  Default = 50,
  Callback = function(Value)
    print("الصوت:", Value)
  end,
  Flag = "volume"
})

MainTab:AddDropdown({
  Name = "الوضع",
  Options = {"سهل", "عادي", "صعب"},
  Default = "عادي",
  Callback = function(Value)
    print("الوضع:", Value)
  end,
  Flag = "mode"
})

MainTab:AddTextBox({
  Name = "اسم المستخدم",
  Placeholder = "اكتب اسمك...",
  Default = "اللاعب",
  ClearOnFocus = true,
  Callback = function(Value)
    print("الاسم:", Value)
  end,
  Flag = "username"
})

MainTab:AddKeybind({
  Name = "اختصار سريع",
  Default = Enum.KeyCode.F,
  Callback = function(Key)
    print("ضغطت:", Key.Name)
  end,
  Flag = "hotkey"
})

MainTab:AddExternalButton({
  Name = "تنفيذ كود",
  Text = "تشغيل",
  External = [[
    print("مرحباً من الكود الخارجي!")
  ]],
  Callback = function()
    Window:Notify({Title = "تم", Content = "تم التنفيذ!"})
  end
})

MainTab:AddDiscordInvite({
  Title = "مجتمع التطوير",
  Description = "انضم للحصول على الدعم",
  Invite = "https://discord.gg/your-server",
  Members = 1250,
  Online = 320
})

MainTab:AddParagraph("معلومات", "هذه مكتبة LUX UI الإصدار 3.1")

-- التبويب الثاني: الإعدادات
local SettingsTab = Window:AddTab("الإعدادات")

SettingsTab:AddSection("مظهر الواجهة")

SettingsTab:AddToggle({
  Name = "الوضع الداكن",
  Default = false,
  Callback = function(Value)
    LUX:SetTheme(Value and "Dark" or "Balenciaga")
    Window:SetFlag("_theme", Value and "Dark" or "Balenciaga")
  end,
  Flag = "dark_mode"
})

SettingsTab:AddToggle({
  Name = "إخفاء الأزرار الجانبية",
  Default = false,
  Callback = function(Value)
    Window:ToggleSideButtonsVisible(not Value)
  end,
  Flag = "hide_side_buttons"
})

SettingsTab:AddButton({
  Name = "إعادة تعيين الأزرار الجانبية",
  Text = "إعادة",
  Callback = function()
    Window:ResetSideButtonsPosition()
    Window:Notify({Title = "تم", Content = "تم إعادة التعيين"})
  end
})

-- التبويب الثالث: معلومات
local InfoTab = Window:AddTab("معلومات")

InfoTab:AddParagraph("LUX UI v3.1",
  "مكتبة واجهات رسومية أنيقة\n" ..
  "جميع العناصر قابلة للبرمجة\n" ..
  "تصميم Balenciaga الأبيض والأسود")

InfoTab:AddButton({
  Name = "مسح الإعدادات المحفوظة",
  Text = "مسح",
  Callback = function()
    Window:Dialog({
      Title = "تحذير",
      Content = "هل تريد مسح جميع الإعدادات؟",
      Options = {
        { Name = "نعم", Callback = function()
            Window:DeleteFlags()
            Window:Notify({Title = "تم", Content = "تم المسح!"})
          end
        },
        { Name = "إلغاء" }
      }
    })
  end
})

-- إشعار ترحيبي
Window:Notify({
  Title = "مرحباً في LUX UI",
  Content = "المكتبة جاهزة للاستخدام!",
  Duration = 4
})
```

---

## 💾 حفظ الإعدادات (Flags)

جميع العناصر التي تحتوي على خاصية `Flag` تحفظ قيمتها تلقائياً في ملف `LUX_Config.json`، وتُسترجَع عند إعادة تشغيل السكربت.

**مثال:**
```lua
Tab:AddToggle({
  Name = "الميزة",
  Flag = "my_feature",
  Default = false,
  Callback = function(Value) end
})
```

يمكنك أيضاً حفظ واسترجاع قيم مخصصة يدوياً:
```lua
Window:SetFlag("custom_value", 123)
local v = Window:GetFlag("custom_value", 0)
```

---

## 🎨 الثيمات والإضافات

### الثيمات المضمنة

| الاسم | الألوان |
|-------|---------|
| `"Balenciaga"` | أبيض، أسود، رمادي (افتراضي) |
| `"Dark"` | داكن مع لمسات زرقاء |

### إضافة ثيم جديد

يمكنك إضافة ثيمك الخاص عبر تعديل جدول `LUX.Themes`:

```lua
LUX.Themes.MyTheme = {
  BG = Color3.fromRGB(30, 30, 30),
  ROW = Color3.fromRGB(40, 40, 40),
  BORDER = Color3.fromRGB(60, 60, 60),
  PRIMARY_TEXT = Color3.fromRGB(255, 255, 255),
  SECONDARY_TEXT = Color3.fromRGB(180, 180, 180),
  ACCENT = Color3.fromRGB(255, 200, 0),
  TOGGLE_ON = Color3.fromRGB(255, 200, 0),
  TOGGLE_OFF = Color3.fromRGB(60, 60, 60),
  TOGGLE_DOT = Color3.fromRGB(255, 255, 255),
  SLIDER_BG = Color3.fromRGB(50, 50, 50),
  SLIDER_FILL = Color3.fromRGB(255, 200, 0),
  INPUT_BG = Color3.fromRGB(0, 0, 0),
  DROPDOWN_BG = Color3.fromRGB(40, 40, 40),
  NOTIFY_BG = Color3.fromRGB(30, 30, 30),
  DIALOG_BG = Color3.fromRGB(30, 30, 30),
}

LUX:SetTheme("MyTheme")
```

---

## ⚠️ الأسئلة الشائعة

### 1. كيف أغير حجم الأزرار الجانبية؟
يمكنك تعديل قيمة `circleButtonSize` في كائن النافذة (داخل الكود المصدري) أو إضافة واجهة لذلك.

### 2. كيف أجعل الأزرار الجانبية دائرية؟
المكتبة تدعم ذلك عبر إعداد `circleButtonsEnabled`، يمكنك تفعيله يدوياً في الكود.

### 3. كيف أمنع المستخدم من تحريك النافذة؟
يمكنك تعطيل سحب النافذة عن طريق تعديل دالة السحب في الكود المصدري.

### 4. هل تدعم المكتبة أزرار الجيم باد؟
حالياً لا تدعم، لكن يمكن إضافة هذه الميزة في المستقبل.

### 5. كيف أضيف أيقونات للتبويبات؟
المكتبة الحالية لا تدعم الأيقونات، لكن يمكنك إضافتها يدوياً عبر تعديل الكود المصدري.

---

## 📄 الترخيص والمطورين

- **المطور**: مجتمع LUX (مستخلص من BALENCIAGA.VS)
- **الترخيص**: مفتوح المصدر – يمكنك استخدامه وتعديله بحرية.
- **الدعم**: للإبلاغ عن مشكلة أو اقتراح ميزة، يرجى فتح Issue في مستودع GitHub.

---

**شكراً لاستخدامك LUX UI!** 🚀
