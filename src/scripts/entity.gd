extends Node2D

func _ready() -> void:
	$Box/Control.visible = false

func _process(delta: float) -> void:
	position = position.lerp(get_node("/root/Scene/Player").position, delta * 7)

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		$Sprite.visible = false
		$Box/Control.visible = true
		$Box/Slide.play("Open")

func _on_finished(_anim_name): queue_free()
func allow_cast(): Globals.stop_cast = false
	
