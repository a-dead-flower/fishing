extends Control


func _ready() -> void:
	$Inform.visible = false

func _on_mouse_entered() -> void:
	if !Globals.mechs_info: return
	$Inform.visible = true

func _on_mouse_exited() -> void:
	if !Globals.mechs_info: return
	$Inform.visible = false

func _process(_delta: float) -> void:
	if not visible: return
	$Inform.position = get_global_mouse_position() + Vector2(10,15)
