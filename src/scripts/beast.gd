extends Control

func _ready() -> void:
	get_parent().move_child(self, 0)
