extends CanvasLayer

var settings_open = false

## Ready function
func _ready() -> void:
	Setup.connect_buttons()
	Setup.dim_ambient()

## Process function
func _process(_delta) -> void:
	if Input.is_action_just_pressed("menu"):
		if $Listen.visible: return
		if settings_open: _on_back()
		else: _on_resume()

## Resume game
func _on_resume() -> void:
	$Animate.play("paused_close")
	Setup.undim_ambient()

## Close settings
func _on_back() -> void:
	settings_open = false
	$Animate.play("settings_close")

## Open options
func _on_options() -> void:
	settings_open = true
	$Animate.play("settings_open")

## Exit game
func _on_exit() -> void:
	get_tree().quit()

## Animate close
func _on_animate(anim_name: StringName) -> void:
	if anim_name == "paused_close":
		queue_free()
		get_tree().paused = false
