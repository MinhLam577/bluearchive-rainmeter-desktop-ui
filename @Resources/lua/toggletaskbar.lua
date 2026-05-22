-- =========================================================
-- CONFIG
-- =========================================================

local TASKBAR_EXE

local SKINS

local TRAY_APPS

-- =========================================================
-- INITIALIZE
-- =========================================================

function Initialize()

    -- =====================================================
    -- TASKBAR
    -- =====================================================

    TASKBAR_EXE =
        SKIN:GetVariable("ROOTCONFIGPATH") ..
        "\\RunAndHide\\RunAndHide.exe"

    -- =====================================================
    -- NORMAL SKINS
    -- =====================================================

    SKINS = {
        Tray = {
            path = "BlueArchive\\Tray",
            x = 20,
            showY = 736,
            hideY = 776,
        },

        EventBanner = {
            path = "BlueArchive\\EventBanner",
            x = 40,
            showY = 504,
            hideY = 544,
        },

        SchaleFolder = {
            path = "BlueArchive\\SchaleFolder",
            x = 1296,
            showY = 496,
            hideY = 536,
        }

    }

    -- =====================================================
    -- TRAY APPS
    -- =====================================================

    TRAY_APPS = {

        basePath =
            "BlueArchive\\TrayApps\\",

        defaultX = 40,

        spacing = 100,

        showY = 680,
        hideY = 720,

        configs = {

            { name = "App0" },
            { name = "App1" },
            { name = "App2" },
            { name = "App3" },
            { name = "App4" },
            { name = "App5" },
            { name = "App6" },
            { name = "App7" },
            { name = "App8" },
            { name = "App9" },

            {
                name = "MusicApp",
                x = 1040
            },

            {
                name = "App10",
                x = 1140
            },

        }

    }

end

-- =========================================================
-- HELPERS
-- =========================================================

local function ExecuteTaskbar()

    SKIN:Bang(
        '["' .. TASKBAR_EXE .. '"]'
    )

end



local function MoveSkin(xPos, yPos, config)
    SKIN:Bang(
        '!Move',
        tostring(xPos),
        tostring(yPos),
        config
    )

end

-- =========================================================
-- TRAY APPS
-- =========================================================

local function MoveTrayApps(yPos)

    for i, app in ipairs(TRAY_APPS.configs) do

        local x =
            app.x or
            (
                TRAY_APPS.defaultX +
                ((i - 1) * TRAY_APPS.spacing)
            )

        local config =
            TRAY_APPS.basePath ..
            app.name

        MoveSkin(
            x,
            yPos,
            config
        )

    end

end

-- =========================================================
-- CORE
-- =========================================================

local function SetHidden(hidden)

    ExecuteTaskbar()

    local mode =
        hidden and "hide" or "show"

    -- =====================================================
    -- NORMAL SKINS
    -- =====================================================

    for _, skin in pairs(SKINS) do

        MoveSkin(
            skin.x,
            skin[mode .. "Y"],
            skin.path
        )

    end

    -- =====================================================
    -- TRAY APPS
    -- =====================================================

    MoveTrayApps(
        TRAY_APPS[mode .. "Y"]
    )

    -- =====================================================
    -- STATE
    -- =====================================================

    SKIN:Bang(
        '!SetVariable',
        'TrayHidden',
        hidden and 1 or 0
    )
end

function HideTaskbar()
    SetHidden(true)
end

function ShowTaskbar()
    SetHidden(false)
end

function GetTrayState()

    local root = SKIN:GetVariable("ROOTCONFIGPATH")
    local resultPath = root .. "\\RunAndHide\\result.txt"
    local file = io.open(resultPath, "r")
    if not file then
        return false
    end
    local content = file:read("*a")
    file:close()
    content = tostring(content):match("^%s*(.-)%s*$")
    -- previous|current
    local previous, current = content:match("(%d+)|(%d+)")
    if not current then
        return false
    end
    return current == "1"
end

function GetHiddenStatus()
    local root = SKIN:GetVariable("ROOTCONFIGPATH")
    local resultPath = root .. "\\RunAndHide\\result.txt"
    local file = io.open(resultPath, "r")
    if not file then
        return false, false
    end
    local content = file:read("*a")
    file:close()
    local previous, current = content:match("(%d+)|(%d+)")
    return previous == "1", current == "1"
end

checkMode = "current"

function SetCheckMode(mode)
    checkMode = mode
end

function GetHiddenStatus()
    local root = SKIN:GetVariable("ROOTCONFIGPATH")
    local resultPath = root .. "\\RunAndHide\\result.txt"
    local file = io.open(resultPath, "r")
    if not file then
        print("Error: result.txt not found")
        return false, false
    end
    local content = file:read("*a")
    file:close()
    local previous, current = content:match("(%d+)|(%d+)")
    if not previous or not current then
        return false, false
    end
    return previous == "1", current == "1"
end


function OnCheckComplete()
    local previousVisible, currentVisible = GetHiddenStatus()
    if checkMode == "previous" then
        if previousVisible then
            ExecuteTaskbar()
        end
    elseif checkMode == "current" then
        if currentVisible then
            ExecuteTaskbar()
        end
    end
end

function ToggleTaskbar()
    if GetTrayState() then
        HideTaskbar()
    else
        ShowTaskbar()
    end
end