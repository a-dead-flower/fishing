extends Control

var force = false

#region SETUP

func _ready() -> void:
	if get_parent().player_has:
		get_node("../Able").queue_free()
		get_node("../Hover").queue_free()
		self.queue_free()
	visible = false

func _on_hover_mouse_entered() -> void:
	if force or !Globals.shops_info: return
	visible = true
	
func _on_hover_mouse_exited() -> void:
	if force or !Globals.shops_info: return
	visible = false

func _process(_delta: float) -> void:
	if not visible: return
	position = get_global_mouse_position() + Vector2(10,15)

#endregion
