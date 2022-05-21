extends Control


onready var countlabel = $Margin/VBoxContainer/HBoxContainer/Label

var count = 0


func _process(_delta):
	countlabel.set_text("%d" % count)


func _on_Button_pressed():
	count += 1
