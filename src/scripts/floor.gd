extends Area2D

@export var floor_type = ""

func _on_area_entered(area: Area2D) -> void:
	if area.name != "Feet": return
	var anim = area.get_node("../../Sounds/Walk").get_animation("walk")
	anim.track_set_enabled(0,false)
	anim.track_set_enabled(1,false)
	anim.track_set_enabled(2,false)
	
	match floor_type:
		"dirt": anim.track_set_enabled(0,true)
		"grass": anim.track_set_enabled(1,true)
		"planks": anim.track_set_enabled(2,true)
