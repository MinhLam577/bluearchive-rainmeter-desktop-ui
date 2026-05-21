[Variables]
@includeHubs=#@#user\hubpaths.inc

UnloadHome=[&HubScript:ToggleCommand("DeactivateConfig",true)][!CommandMeasure "HubScript" "ToggleHubCommand('ActivateConfig', false)" "BlueArchive\Controller"][!DeactivateConfig "BlueArchive\ToggleSwitch\ToggleOn"][!ActivateConfig "BlueArchive\ToggleSwitchHub\ToggleOnHub"]

LoadHome=#WHome#[&HubScript:ToggleCommand("DeactivateConfig",true)][!CommandMeasure "HubScript" "SetCurrentHubVariant('home')" "BlueArchive\Controller"][&HubScript:ToggleCommand("ActivateConfig",false)][!DeactivateConfig "BlueArchive\ToggleSwitchHub\ToggleOnHub"][!ActivateConfig "BlueArchive\ToggleSwitch\ToggleOn"][!ActivateConfig "BlueArchive\mii power\power+uptime" "B+days.ini"]

QSTS=#WQuest#[!CommandMeasure "HubScript" "SetCurrentHubVariant('questlist')" "BlueArchive\Controller"]#UnloadHome#[!ActivateConfig "#ROOTCONFIG#\List" "questlist.ini"]

RAID=#WRaid#[!CommandMeasure "HubScript" "SetCurrentHubVariant('raidlist')" "BlueArchive\Controller"]#UnloadHome#[!ActivateConfig "BlueArchive\mii power\power+uptime" "B+days.ini"]

GRID=#WGrid#[!CommandMeasure "HubScript" "SetCurrentHubVariant('aronagrid')" "BlueArchive\Controller"]#UnloadHome#[!ActivateConfig "BlueArchive\mii power\power+uptime" "B+days.ini"]

SHOP=#WShop#[!CommandMeasure "HubScript" "SetCurrentHubVariant('shoplist')" "BlueArchive\Controller"]#UnloadHome#

DNGN=#WDungeon#[!CommandMeasure "HubScript" "SetCurrentHubVariant('dungeonlist')" "BlueArchive\Controller"]#UnloadHome#

LSCR=[!ActivateConfig "#ROOTCONFIG#\0_LoadScreen"][!ZPos "0" "#ROOTCONFIG#\0_LoadScreen"][!Delay 600]

[HubScript]
Measure=Script
ScriptFile=#@#lua\toggleswitch.lua

[HubStartup]
Measure=Calc
Formula=1
IfEqualValue=1
UpdateDivider=-1