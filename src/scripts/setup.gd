extends Node
var lights

#region GENERAL SETUP

## Ready function
func _ready():
	connect_buttons()
	lights = get_tree().get_nodes_in_group("Lights")
	$Cycle.play("cycle")
	$Cycle.advance(Globals.time_of_day)
	if Globals.time_of_day < 39 or Globals.time_of_day > 111: turn_on()
	else: turn_off()

## Connect button group
func connect_buttons():
	var buttons: Array = get_tree().get_nodes_in_group("Button")
	for inst in buttons:
		if not inst.button_down.is_connected(func play(): $Click.play()):
			inst.button_down.connect(func play(): $Click.play())

## Connect self
func connect_self(path):
	var inst = get_node(path)
	if not inst.button_down.is_connected(func play(): $Click.play()):
		inst.button_down.connect(func play(): $Click.play())

## Add commas to money
func get_money(money):
	var text = ""
	while money >= 1000:
		text += ",%03d" % (money % 1000)
		money /= 1000
	return str(money,text)

#endregion

#region LIGHTS SETUP

## Tween lights on
func turn_on():
	for i in lights:
		var tween = get_tree().create_tween()
		tween.tween_property(i, "energy", 1, 1)

## Tween lights off
func turn_off():
	for i in lights:
		var tween = get_tree().create_tween()
		tween.tween_property(i, "energy", 0, 1)

#endregion

#region AUDIO SETUP

## Dim ambient volume
func dim_ambient():
	var volume = AudioServer.get_bus_volume_db(4)
	AudioServer.set_bus_volume_db(4, volume - 4)
	AudioServer.set_bus_effect_enabled(4, 0, true)

## Normal ambient volume
func undim_ambient():
	var volume = log(Globals.sett_ambi)*20
	AudioServer.set_bus_volume_db(4, volume)
	AudioServer.set_bus_effect_enabled(4, 0, false)

#endregion
