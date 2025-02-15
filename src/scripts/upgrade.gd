extends CanvasLayer

func _ready():
	Setup.connect_buttons()
	Setup.dim_ambient()

## Process function
func _process(_delta):
	$Menu/Panel/Money/Price.text = Setup.get_money(Globals.money)
	if Input.is_action_just_pressed("menu"):
		$Blur/Animate.play("close")
		Setup.undim_ambient()
	if Input.is_action_just_pressed("inventory"):
		$Blur/Animate.play("close")
		Setup.undim_ambient()
	if Input.is_action_just_pressed("interact"):
		$Blur/Animate.play("close")
		Setup.undim_ambient()

## Animation finished
func _on_animate(anim_name: StringName) -> void:
	if anim_name == "close":
		queue_free()
		get_tree().paused = false

## Open info pages
func _on_info() -> void:
	if Globals.mechs_info:
		Globals.mechs_info = false
	else: Globals.mechs_info = true

## Add commas to money
