extends Control


onready var cutternum = $Margin/Grid/Woodcutters/VBox/HBoxWorkers/Num
onready var woodnum = $Margin/Grid/Woodcutters/VBox/HBoxResource/Num
onready var woodprogressbar = $Margin/Grid/Woodcutters/VBox/ProgressBar

onready var workersnum = $Margin/Grid/PanelContainer2/VBox/HBoxResource/Num
onready var housenum = $Margin/Grid/PanelContainer2/VBox/HBoxResource2/Num

var cuttermulti = 10

var cutter = 1
var wood = 2
var woodprogress = 5
var workers = 3
var house = 4


func _process(delta):
	game_process(delta)
	update_ui()


func game_process(delta):
	woodprogress += delta*cutter*cuttermulti
	if woodprogress >= 100:
		woodprogress = 0
		wood += 1


func update_ui():
	cutternum.set_text(str(cutter))
	woodnum.set_text(str(wood))
	woodprogressbar.set_value(woodprogress)
	workersnum.set_text(str(workers))
	housenum.set_text(str(house))


func _on_CutterMinus_pressed():
	if cutter > 0:
		cutter -= 1
		workers += 1


func _on_CutterPlus_pressed():
	if workers > 0:
		workers -= 1
		cutter += 1
