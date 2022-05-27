extends Control


onready var cutternum = $Margin/Grid/Woodcutters/VBox/HBoxWorkers/Num
onready var woodnum = $Margin/Grid/Woodcutters/VBox/HBoxResource/Num
onready var woodprogressbar = $Margin/Grid/Woodcutters/VBox/ProgressBar

onready var workersnum = $Margin/Grid/Statistics/VBox/HBoxWorkers/Num
onready var populationnum = $Margin/Grid/Statistics/VBox/HBoxPopulation/Num
onready var housespacenum = $Margin/Grid/Statistics/VBox/HBoxHousing/Num
onready var foodsurplusnum = $Margin/Grid/Statistics/VBox/HBoxFood/Num

onready var buildernum = $Margin/Grid/Construction/VBox/HBoxWorkers/Num
onready var housenum = $Margin/Grid/Construction/VBox/VBoxHouses/HBox/Num
onready var houseprogressbar = $Margin/Grid/Construction/VBox/VBoxHouses/ProgressBar
onready var farmnum = $Margin/Grid/Construction/VBox/VBoxFarms/HBox/Num
onready var farmprogressbar = $Margin/Grid/Construction/VBox/VBoxFarms/ProgressBar

onready var migrationprogressbar = $Margin/Grid/Migration/VBox/ProgressBar


var cuttermulti = 20
var buildermulti = 10
var housemulti = 1
var farmmulti = 1
var migrationmulti = 5

var cutter = 0
var wood = 0
var woodprogress = 0

var workers = 4
var population = 4
var housespace = 0
var foodsurplus = 6

var builder = 0
var buildindex = 0
var house = 1
var houseprogress = 0
var farm = 1
var farmprogress = 0

var migrationprogress = 0


func _process(delta):
	game_process(delta)
	update_ui()


func game_process(delta):
	woodcutting_process(delta)
	building_process(delta)
	migration_process(delta)


func woodcutting_process(delta):
	woodprogress += delta*cutter*cuttermulti
	if woodprogress >= 100:
		woodprogress = 0
		wood += 1


func building_process(delta):
	match(buildindex):
		1: #house
			if houseprogress == 0:
				if wood < 10:
					return
				if builder > 0:
					wood -= 10
			houseprogress += delta*builder*buildermulti*housemulti
			if houseprogress >= 100:
				houseprogress = 0
				house += 1
				housespace += 4
		2: #farm
			if farmprogress == 0:
				if wood < 20:
					return
				if builder > 0:
					wood -= 20
			farmprogress += delta*builder*buildermulti*farmmulti
			if farmprogress >= 100:
				farmprogress = 0
				farm += 1
				foodsurplus += 10


func migration_process(delta):
	if housespace > 0 and foodsurplus > 0:
		migrationprogress += delta*migrationmulti
		if migrationprogress >= 100:
			migrationprogress = 0
			population += 1
			workers += 1
			housespace -= 1
			foodsurplus -= 1


func update_ui():
	cutternum.set_text(str(cutter))
	woodnum.set_text(str(wood))
	woodprogressbar.set_value(woodprogress)
	
	workersnum.set_text(str(workers))
	populationnum.set_text(str(population))
	housespacenum.set_text(str(housespace))
	foodsurplusnum.set_text(str(foodsurplus))
	
	buildernum.set_text(str(builder))
	housenum.set_text(str(house))
	houseprogressbar.set_value(houseprogress)
	farmnum.set_text(str(farm))
	farmprogressbar.set_value(farmprogress)
	
	migrationprogressbar.set_value(migrationprogress)


func _on_CutterMinus_pressed():
	if cutter > 0:
		cutter -= 1
		workers += 1


func _on_CutterPlus_pressed():
	if workers > 0:
		workers -= 1
		cutter += 1


func _on_BuilderMinus_pressed():
	if builder > 0:
		builder -= 1
		workers += 1


func _on_BuilderPlus_pressed():
	if workers > 0:
		workers -= 1
		builder += 1


func _on_BuildSelector_item_selected(index):
	buildindex = index
