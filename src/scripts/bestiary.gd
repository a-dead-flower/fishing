extends CanvasLayer

var current_page = 0

## Ready function
func _ready():
	Setup.dim_ambient()
	Setup.connect_buttons()
	var children = $Menu/Fish/Pond/Margin/Grid.get_children()
	$Menu/Fish/Pond.clip_contents = true
	for i in Globals.pond_caught:
		for j in children:
			if i[0] == j.name:
				var button = j.get_node(str(j.name))
				button.best_size = i[1]
				button.num_caught = i[2]
				button.fish_found = true
				button.get_node("Icon/Icon").visible = true
				button.get_node("Active").play("enabled")
				if i[3] == true:
					var new = Globals.beast.instantiate()
					button.get_parent().add_child(new)
					i[3] = false
					
					
					

## Process function
func _process(_delta: float) -> void:
	
	## Scrollbar shadow max-13
	if $Menu/Fish/Pond.scroll_vertical > 427:
		$Menu/Fish/Shadow.visible = false
	else: $Menu/Fish/Shadow.visible = true
	
	## Open and close animation
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
