extends CharacterBody2D

const pause_menu = preload("res://res/player/paused.tscn")
const inventory = preload("res://res/player/inventory.tscn")
const bestiary = preload("res://res/player/bestiary.tscn")
const upgrade = preload("res://res/player/upgrade.tscn")
const shops = preload("res://res/player/shops.tscn")

var walking = false
var can_cast = false
var is_casting = false
var is_catching = false
var is_searching = false
var bobber_landed = false

#region BUILT-IN

## Ready function
func _ready() -> void:
	$Rope.visible = false
	$Bobber.visible = false
	$Sprite/Cursor.visible = false


## physics process
func _physics_process(delta) -> void:
	var direction = Input.get_vector("left", "right", "up", "down")
	velocity = direction * Globals.speed
	if direction != Vector2(0,0):
		start_sound()
	if !is_searching:
		move_and_slide()
		animate(direction)
	if !Globals.stop_cast:
		cast_line(delta)


## process function
func _process(_delta):
	if Input.is_action_just_pressed("menu"):
		add_child(pause_menu.instantiate())
		get_tree().paused = true
	if Input.is_action_just_pressed("inventory"):
		add_child(inventory.instantiate())
		get_tree().paused = true
	if Input.is_action_just_pressed("interact"):
		if Globals.shop_type != "":
			if Globals.shop_type == "Bestiary":
				add_child(bestiary.instantiate())
				get_tree().paused = true
			elif Globals.shop_type == "Upgrade":
				add_child(upgrade.instantiate())
				get_tree().paused = true
			elif Globals.shop_type != "Bestiary":
				add_child(shops.instantiate())
				get_tree().paused = true

#endregion

#region CASTING

## Function for casting line
func cast_line(delta):
	
	## Mose L held
	if Input.is_action_pressed("fish"):
		
		## Check equip and inventory avail
		if Globals.fish.size() != Globals.inv_space and \
		Globals.current_rod != "":
			
			if is_casting: return
			is_searching = true
			point_cast()
			var mouse_pos = get_global_mouse_position()
			var distance = global_position.distance_to($Sprite/Cursor.position)
			$Sprite/Cursor.position = $Sprite/Cursor.position.move_toward(
				mouse_pos, delta * (Globals.cast_speed - distance))
		
	## Mouse L pressed
	if Input.is_action_just_pressed("fish"):
		
		## Is currently catching
		if is_catching: return
		
		## No rod equiped
		if Globals.current_rod == "":
			if !$Display/Control/Missing/Panel.visible:
				$Display/Control/Missing/Panel/Popup.play("start")
			return ## Stop play
			
		## Inventory is full
		if Globals.fish.size() == Globals.inv_space:
			if !$Display/Control/Inventory/Panel.visible:
				$Display/Control/Inventory/Panel/Popup.play("start")
			return ## Stop play
		
		## Reel in line
		if is_casting:
			$Rope.visible = false
			$Bobber.visible = false
		else:
			$Bobber.position = position
			$Sprite/Cursor.visible = true
			$Sprite/Cursor.position = position
			
	## Mouse L released
	if Input.is_action_just_released("fish"):
		if is_catching: return
		$Sprite/Cursor.visible = false
		
		## Line in water
		if is_casting:
			Spawn.start_game()
			is_catching = true
		
		## Avail for cast
		elif can_cast:
			is_casting = true
			bobber_landed = true
			$Rope.visible = true
			$Bobber.visible = true
		
		## Cancel cast
		elif !can_cast:
			is_searching = false
	
	## Throw bobber
	if is_casting:
		$Bobber.position = $Bobber.position.lerp($Sprite/Cursor.position, delta * 10)
		if snapped($Bobber.position.x,100) == snapped($Sprite/Cursor.position.x,100) and \
		snapped($Bobber.position.y,100) == snapped($Sprite/Cursor.position.y,100):
			if bobber_landed:
				$Bobber/Handle/Sound.play()
				bobber_landed = false

## Remove casting line
func remove_line():
	is_casting = false
	is_searching = false
	$Rope.visible = false
	$Bobber.visible = false


## Check avail for fishing
func _on_water_entered(area):
	if area.name != "Water": return
	can_cast = true
	$Sprite/Cursor.play("water")
func _on_water_exited(area):
	if area.name != "Water": return
	can_cast = false
	$Sprite/Cursor.play("floor")

#endregion

#region ANIMATION

## Face direction of cast
func point_cast():
	stop_sound()
	if Input.is_action_pressed("fish"):
		var angle = rad_to_deg(get_angle_to(get_global_mouse_position()))
		if angle < 0: angle += 360  ## Convert to radial
		
		## Point north
		if angle < 315 && angle > 225:
			$Sprite.play("idle_up")
			$Sprite.scale.x = 4
			
		## Point south
		elif angle < 135 && angle > 45:
			$Sprite.play("idle_down")
			$Sprite.scale.x = 4
			
		## Point left
		elif angle < 255 && angle > 135:
			$Sprite.play("idle_side")
			$Sprite.scale.x = -4
			
		else: ## Point right
			$Sprite.play("idle_side")
			$Sprite.scale.x = 4

## Animate walking
func animate(direction):
	
	if direction == Vector2(0,1):
		$Sprite.play("down")
		$Sprite.scale.x = 4
		
	elif direction == Vector2(0,-1):
		$Sprite.play("up")
		$Sprite.scale.x = 4
		
	elif direction == Vector2(-1,0):
		$Sprite.play("side")
		$Sprite.scale.x = -4
		
	elif direction == Vector2(1,0):
		$Sprite.play("side")
		$Sprite.scale.x = 4
		
	elif direction == Vector2(-cos(PI/4),cos(PI/4)) or \
		direction == Vector2(-cos(PI/4),-cos(PI/4)):
		$Sprite.play("side")
		$Sprite.scale.x = -4
		
	elif direction == Vector2(cos(PI/4),cos(PI/4)) or \
		direction == Vector2(cos(PI/4),-cos(PI/4)):
		$Sprite.play("side")
		$Sprite.scale.x = 4
		
	elif direction == Vector2(0,0):
		stop_sound()
		if !$Sprite.animation.contains("idle_"):
			$Sprite.play(str("idle_", $Sprite.animation))

## Stop sounds
func stop_sound():
	if walking:
		$Sounds/Walk.pause()
		walking = false

## Start walking
func start_sound():
	if !walking:
		$Sounds/Walk.play("RESET")
		$Sounds/Walk.play("walk")
		walking = true

#endregion
