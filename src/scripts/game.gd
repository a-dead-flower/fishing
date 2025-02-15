extends CanvasLayer

@export var fish_strength = 1.0
@export var reel_speed = 1.1
@onready var game = $Control/Game/Game0
@onready var prog = $Control/Prog/Prog

@export var bar_min = 40
@export var bar_max = 60
@export var prog_speed = 25
@export var escape_speed = 20

var fish_name
var started = false

#region BUILT-IN

## Ready function
func _ready() -> void:
	
	## Green bar upgrades
	if Globals.upgrade_bar == 0:
		game = $Control/Game/Game0
		game.visible = true
		bar_min = 40
		bar_max = 60
	elif Globals.upgrade_bar == 1:
		game = $Control/Game/Game1
		game.visible = true
		bar_min = 37
		bar_max = 63
	elif Globals.upgrade_bar == 2:
		game = $Control/Game/Game2
		game.visible = true
		bar_min = 34
		bar_max = 66
	elif Globals.upgrade_bar == 3:
		game = $Control/Game/Game3
		game.visible = true
		bar_min = 31
		bar_max = 69
	
	## Progress upgrade
	if Globals.upgrade_prog == 0: prog_speed = 29
	elif Globals.upgrade_prog == 1: prog_speed = 31
	elif Globals.upgrade_prog == 2: prog_speed = 33
	elif Globals.upgrade_prog == 3: prog_speed = 35
	elif Globals.upgrade_prog == 4: prog_speed = 37
	
	## Loss speed
	if Globals.upgrade_loss == 0: escape_speed = 20
	elif Globals.upgrade_loss == 1: escape_speed = 16
	elif Globals.upgrade_loss == 2: escape_speed = 12
	elif Globals.upgrade_loss == 3: escape_speed = 10
	elif Globals.upgrade_loss == 4: escape_speed = 9
	
	
#endregion

#region CONDITIONS

## Win function
func win():
	for i in Globals.bait:
		if i[0] == Globals.current_bait:
			if i[1] - 1 <= 0:
				i[1] = 0
				Globals.current_bait = ""
			else: i[1] = i[1] - 1
	
	for i in Globals.lure:
		if i[0] == Globals.current_lure:
			if i[1] - 1 <= 0:
				Globals.lure.erase(i)
				Globals.current_lure = ""
			else: i[1] = i[1] - 10
	
	get_node("/root/Scene/Player").can_cast = false
	get_node("/root/Scene/Player").is_catching = false
	get_node("/root/Scene/Player").remove_line()
	Spawn.create_fish()
	queue_free()

## Lose function
func lose():
	get_node("/root/Scene/Player").can_cast = false
	get_node("/root/Scene/Player").is_catching = false
	get_node("/root/Scene/Player").remove_line()
	Globals.fish.pop_back()
	queue_free()

#endregion

#region NORMAL

## Start struggle
func _on_open(_anim_name):
	$Animation.play(fish_name)
	started = true

## Process function
func _physics_process(_delta: float) -> void:
	if !started: return
	game.value = game.value + fish_strength
	
	
	## If in green zone
	if game.value > bar_min and game.value < bar_max:
		prog.value = prog.value + (prog_speed - 20)
	else: prog.value = prog.value - escape_speed
	
	## Adjust game slider
	if Input.is_action_pressed("fish"):
		$Control/Game/Rod.speed_scale = 1
		$Control/Game/Rod.play("default")
		game.value = game.value - reel_speed
	
	if Input.is_action_just_released("fish"):
		$Control/Game/Rod.speed_scale = 2
		$Control/Game/Rod.play_backwards("default")
	
	## Win conditions
	if prog.value == 8000: win()
	elif prog.value == 0: lose()

#endregion
