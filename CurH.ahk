/*
Cursor Highlight
----------------
F12 - Show/Hide Settings
Color - can be color name or color code
For code explanation contact James Pogi
*/


#NoEnv
#SingleInstance, Force
#MaxThreadsPerHotkey, 2
#Warn

title = Cursor Highlight
version = v1.0

CoordMode, Mouse, Screen
	Toggle := 0
	Diameter := 2 * (Radius := 40)
	Gui, Curx: +AlwaysOnTop -Caption +LastFound +Owner E0x20
	Gui, Curx: Color, 00FFFF
	SysGet, VirtualScreenX, 76
	SysGet, VirtualScreenY, 77
	SysGet, VirtualWidth, 78
	SysGet, VirtualHeight, 79
	Gui, Curx: Show, Hide x%VirtualScreenX% y%VirtualScreenY% w%VirtualWidth% h%VirtualHeight%, Curx
	WinSet, Transparent, 60, Curx

Gui, GuiMenu: Font, cGreen s10, Courier
Gui, GuiMenu: Color, 202020

Gui, GuiMenu: Add, Text,,SETTINGS
Gui, GuiMenu: Add, Text,y+1,------------------
Gui, GuiMenu: Add, Checkbox, vHCur gHCurSet, Enable Highlight
Gui, GuiMenu: Add, Text,y+1,------------------
Gui, GuiMenu: Add, Text,,Color
Gui, GuiMenu: Add, Edit,vHColor Limit6,00FFFF
Gui, GuiMenu: Add, Text,,Hightlight Size
Gui, GuiMenu: Add, Slider, vHSize Range1-200, 40
Gui, GuiMenu: Add, Text,,Transparency
Gui, GuiMenu: Add, Slider, vHTrans Range1-200, 60
Gui, GuiMenu: Add, Text,y+1,------------------
Gui, GuiMenu: Add, Text,y+1,[F12] Show/Hide
Gui, GuiMenu: +ToolWindow
Gui, GuiMenu: Show, x1500 y150, %title% %version%
Return

HCurset:
	GuiControlGet, HCur, GuiMenu:
	Gui, Curx: Show, NA, Curx
	Gui, Curx: +LastFound
	While HCur {
		GuiControlGet, HCur, GuiMenu:
		GuiControlGet, HSize, GuiMenu:
		GuiControlGet, HTrans, GuiMenu:
		GuiControlGet, HColor, GuiMenu:
		Gui, Curx: Color, %HColor%
		WinSet, Transparent, %HTrans%, Curx
        	MouseGetPos, x, y
        	x -= HSize, y -= HSize
		Diameter := 2 * HSize
        	WinSet, Region, E %x%-%y% w%Diameter% h%Diameter%, Curx
	}
	Gui, Curx: Show, Hide, NA
Return

F12::
Toggle := !Toggle
If toggle
	Gui, GuiMenu: Show
Else
	Gui, GuiMenu: Hide
Return

GuiMenuGuiClose:
ExitApp
