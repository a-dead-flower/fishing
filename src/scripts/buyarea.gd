extends Area2D

@export var type = ""

## Body entered
func _on_body_entered(body: Node2D) -> void:
	if body.name != "Player": return
	Globals.shop_type = type

## Body exited
func _on_body_exited(body: Node2D) -> void:
	if body.name != "Player": return
	Globals.shop_type = ""
