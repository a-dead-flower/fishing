extends CanvasLayer

var current_page = 0

## Ready function
func _ready():
	Setup.dim_ambient()
	Setup.connect_buttons()
	var children = $Menu/Fish/Pond/Grid.get_children()
	for i in Globals.pond_caught:
		for j in children:
			if i[0] == j.name:
				j.best_size = i[1]
				j.num_caught = i[2]
				j.fish_found = true
				j.get_node("Icon/Icon").visible = true
				j.get_node("Active").play("enabled")


## Process function
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("menu"):
		$Blur/Animate.play("close")
		Setup.undim_ambient()
	if Input.is_action_just_pressed("interact"):
		$Blur/Animate.play("close")
		Setup.undim_ambient()
	if Input.is_action_just_pressed("inventory"):
		$Blur/Animate.play("close")
		Setup.undim_ambient()

## Close animation finished
func _on_animate(anim_name: StringName) -> void:
	if anim_name == "close":
		get_tree().paused = false
		queue_free()

## Go back
func _on_left_pressed() -> void:
	if current_page == 0: return
	current_page -= 1

## Go forward
func _on_right_pressed() -> void:
	if current_page == 0: return
	current_page += 1
