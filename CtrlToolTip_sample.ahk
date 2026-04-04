; This sample demonstrates the usage of CtrlToolTip.
; It creates a main window with various controls, each having its own tooltip.
; A button allows changing its tooltip text on click,
; and another button opens a second window with its own controls and tooltips.

#Requires AutoHotkey v2.0
#Include CtrlToolTip.ahk

mainGui := Gui(, "Control Tooltip")
mainGui.MarginX := 12
mainGui.MarginY := 12

; Add controls with tooltips
txtAbout := mainGui.AddText("w250", "CtrlToolTip(ctrl, text) adds a standard Windows tooltip to a Gui control.")
CtrlToolTip(txtAbout, "This text control also uses a tooltip.")

editName := mainGui.AddEdit("w250", "")
CtrlToolTip(editName, "Enter your name.")

chkOption := mainGui.AddCheckBox(, "Enable option")
CtrlToolTip(chkOption, "Turn this option on or off.")

radChoiceA := mainGui.AddRadio("x+5 Checked", "Choice A")
CtrlToolTip(radChoiceA, "Select Choice A.")

radChoiceB := mainGui.AddRadio("x+5", "Choice B")
CtrlToolTip(radChoiceB, "Select Choice B.")

ddlColor := mainGui.AddDropDownList("xm w250 Choose1", ["Red", "Green", "Blue"])
CtrlToolTip(ddlColor, "Choose a color from the list.")

comboCity := mainGui.AddComboBox("w250", ["Windows", "Linux", "MacOS", "Other"])
CtrlToolTip(comboCity, "Type or select an operating system.")

listItems := mainGui.AddListBox("w250 r4", ["Item 1", "Item 2", "Item 3", "Item 4"])
CtrlToolTip(listItems, "Select one item from the list.")

dateStart := mainGui.AddDateTime("w250", "yyyy-MM-dd")
CtrlToolTip(dateStart, "Pick a date.")

sliderLevel := mainGui.AddSlider("w250 Range0-100 ToolTip", 35)
CtrlToolTip(sliderLevel, "Adjust the level.")

progressBar := mainGui.AddProgress("w250", 60)
CtrlToolTip(progressBar, "Current progress is 60 percent.")

btnChangeTip := mainGui.AddButton("w250", "Change my tooltip")
CtrlToolTip(btnChangeTip, "Click to change this tooltip.")
btnChangeTip.OnEvent("Click", ChangeOwnToolTip)

btnOpenChild := mainGui.AddButton("w250", "Open second window")
CtrlToolTip(btnOpenChild, "Open a second window`nwith its own tooltips.")
btnOpenChild.OnEvent("Click", OpenSecondWindow)

link := mainGui.AddLink("w250", '<a href="https://github.com/akcansoft/CtrlToolTip">GitHub repo</a>')
CtrlToolTip(link, "Open the GitHub page.")

btnClose := mainGui.AddButton("w100 Default", "Close")
btnClose.OnEvent("Click", (*) => mainGui.Destroy())
CtrlToolTip(btnClose, "Close the window.")

mainGui.Show()
btnClose.GetPos(, &closeY, &closeW, &closeH)
mainGui.GetClientPos(, , &clientW, &clientH)
btnClose.Move(clientW - mainGui.MarginX - closeW, clientH - mainGui.MarginY - closeH)

; Change the tooltip text of the button that was clicked.
ChangeOwnToolTip(ctrl, *) {
	static changed := false
	changed := !changed
	CtrlToolTip(ctrl, changed ? "Tooltip changed after the click." : "Click to change this tooltip.")
}

; Open a second window with its own controls and tooltips.
OpenSecondWindow(*) {
	childGui := Gui(, "Second Window")
	childGui.MarginX := 12
	childGui.MarginY := 12

	childText := childGui.AddText("w220", "Second window controls")
	CtrlToolTip(childText, "Tooltip on a text control in the second window.")

	childEdit := childGui.AddEdit("w220", "")
	CtrlToolTip(childEdit, "Type something in the second window.")

	childClose := childGui.AddButton("w100 Default", "Close")
	childClose.OnEvent("Click", (*) => childGui.Destroy())
	CtrlToolTip(childClose, "Close the second window.")

	childGui.Show("AutoSize")
}