extends Button

@export var item_best: PackedScene

@export var best_size = ""
@export var num_caught = 0
@export var fish_found = false

func _on_button_up() -> void: $Press.play("up")
func _on_button_down() -> void: $Press.play("down")

func _on_pressed() -> void:
	get_node("../../../../../Best").name = "DELETE"
	get_node("../../../../../DELETE").queue_free()
	var panel = item_best.instantiate()
	panel.get_node("Best/Best").text = str(best_size)
	panel.get_node("Caught/Caught").text = str(num_caught)
	get_node("../../../../../").add_child(panel)
	if !fish_found:
		panel.get_node("Disable/Disable").play("disable")
