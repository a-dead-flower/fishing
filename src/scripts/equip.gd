extends Control

@export var item_name = ""
@export var ammount = 0
@export var type = ""


## Ready function
func _ready() -> void:
	Setup.connect_buttons()
	if type == "Bait":
		$Down/Num.text = str("x",ammount)


## Act on press
func _on_pressed() -> void:
	if type == "Bait":
		Globals.current_bait = item_name
		get_node("../../../../../../")._redraw_bait()
	elif type == "Rod":
		Globals.current_rod = item_name
		get_node("../../../../../../")._redraw_rods()
	elif type == "Lure":
		Globals.current_lure = item_name
		get_node("../../../../../../")._redraw_lure()


## Button press
func _on_button_up() -> void: $Press.play("up")
func _on_button_down() -> void: $Press.play("down")
