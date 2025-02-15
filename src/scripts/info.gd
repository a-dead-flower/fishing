extends Control

@export var fish_index = 0

var delete = false

func _ready() -> void:
	Setup.connect_buttons()

func _on_close() -> void:
	if delete:
		$Panel/Trash/Focus.play("unfocus")
		delete = false
	else: queue_free()

func _on_trash() -> void:
	if delete == false: 
		delete = true
		$Panel/Trash/Focus.play("focus")
		return
	get_node("/root/Scene/Player/Canvas").remove_fish(fish_index)
	get_node("/root/Scene/Player/Canvas")._redraw_fish()
	queue_free()
