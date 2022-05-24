extends Control


onready var countlabel = $Margin/VBoxContainer/HBoxContainer/Label
onready var countprogress = $Margin/VBoxContainer/HBoxContainer/ProgressBar

var count = 0
var count_bar = 0
var count_on = false


func _process(_delta):
	countlabel.set_text("%d" % count)
	if count_on:
		run_count_bar()
		countprogress.set_value(count_bar)


func _on_Button_toggled(button_pressed):
	count_on = button_pressed


func run_count_bar():
	count_bar += 1
	if count_bar >= 100:
		count += 1
		count_bar = 0
