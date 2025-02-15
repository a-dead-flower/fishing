extends Label

var window_menu_open = false
var window_menu_hover = false

var key_listening = false
var key_confirmed = ""
var key_changing = ""

#region SETUP

## Process function
func _process(_delta):
	if Input.is_action_just_pressed("fish"):
		if !window_menu_hover and window_menu_open:
			$Video/Video/Window/Window/Dropdown/Dropdown.play("close")
			window_menu_open = false

## Set values to UI
func _ready() -> void:
	if DisplayServer.window_get_mode() == 2:
		$Video/Video/Window/Window.text = "Maximised"
	elif DisplayServer.window_get_mode() == 0:
		$Video/Video/Window/Window.text = "Windowed"
	elif DisplayServer.window_get_mode() == 3:
		$Video/Video/Window/Window.text = "Fullscreen"
		
	$Video/Video/Zoom/Zoom.value = Globals.sett_zoom
	$Video/Video/Scale/Scale.value = Globals.sett_scale
	$Video/Video/Vsync/Vsync.button_pressed = Globals.sett_vsync
	
	$Audio/Audio/SFX/SFX.value = Globals.sett_sfx
	$Audio/Audio/Ambi/Ambi.value = Globals.sett_ambi
	$Audio/Audio/Music/Music.value = Globals.sett_music
	$Audio/Audio/Master/Master.value = Globals.sett_master
	$Audio/Audio/Player/Player.value = Globals.sett_player
	_mute_audio(Globals.sett_mute)
	
	$Keys/Keys/Up/Up.text = Globals.keys_up
	$Keys/Keys/Down/Down.text = Globals.keys_down
	$Keys/Keys/Left/Left.text = Globals.keys_left
	$Keys/Keys/Right/Right.text = Globals.keys_right
	$Keys/Keys/Menu/Menu.text = Globals.keys_inv
	$Keys/Keys/Interact/Interact.text = Globals.keys_int
	
	

## Set keybind
func _unhandled_input(event) -> void:
	if !key_listening: return
	if event.keycode != KEY_ESCAPE:
		key_confirmed = event.as_text()
		_set_keybind(key_changing, key_confirmed)
		key_listening = false
		get_node("../Listen").visible = false

#endregion

#region DESIGN

## Tabbed pane
func _on_audio() -> void: $Tabs.play("audio")
func _on_video() -> void: $Tabs.play("video")
func _on_keys() -> void: $Tabs.play("keys")
func _on_game() -> void: $Tabs.play("game")

## Dropdown mouse hover
func _on_mouse_entered() -> void: window_menu_hover = true
func _on_mouse_exited() -> void: window_menu_hover = false

func _on_mute_down() -> void: $Audio/Audio/Strike/Press.play("down")
func _on_mute_up() -> void: $Audio/Audio/Strike/Press.play("up")


## Window mode dropdown
func _on_window() -> void:
	if window_menu_open:
		$Video/Video/Window/Window/Dropdown/Dropdown.play("close")
		window_menu_open = false
	else:
		$Video/Video/Window/Window/Dropdown/Dropdown.play("open")
		window_menu_open = true

#endregion

#region SETTINGS

## UI Scale
func _on_scale(value_changed: bool) -> void:
	if !value_changed: return
	get_window().content_scale_factor = $Video/Video/Scale/Scale.value
	Globals.sett_scale = $Video/Video/Scale/Scale.value

func _on_zoom(value_changed: bool) -> void:
	if !value_changed: return
	get_node("/root/Scene/Player/Camera").zoom.x = $Video/Video/Zoom/Zoom.value
	get_node("/root/Scene/Player/Camera").zoom.y = $Video/Video/Zoom/Zoom.value
	Globals.sett_zoom = $Video/Video/Zoom/Zoom.value

## Master volume
func _on_master(value_changed: bool) -> void:
	if !value_changed: return
	AudioServer.set_bus_volume_db(0, log($Audio/Audio/Master/Master.value)*20)
	Globals.sett_master = $Audio/Audio/Master/Master.value

## Music volume
func _on_music(value_changed: bool) -> void:
	if !value_changed: return
	AudioServer.set_bus_volume_db(2, log($Audio/Audio/Music/Music.value)*20)
	Globals.sett_music = $Audio/Audio/Music/Music.value

## SFX Volume
func _on_sfx(value_changed: bool) -> void:
	if !value_changed: return
	AudioServer.set_bus_volume_db(3, log($Audio/Audio/SFX/SFX.value)*20)
	Globals.sett_sfx = $Audio/Audio/SFX/SFX.value

## Player Volume
func _on_player(value_changed: bool) -> void:
	if !value_changed: return
	AudioServer.set_bus_volume_db(1, log($Audio/Audio/Player/Player.value)*20)
	Globals.sett_player = $Audio/Audio/Player/Player.value

## Ambient Volume
func _on_ambi(value_changed: bool) -> void:
	if !value_changed: return
	AudioServer.set_bus_volume_db(4, log($Audio/Audio/Ambi/Ambi.value)*20)
	var volume = AudioServer.get_bus_volume_db(4)
	AudioServer.set_bus_volume_db(4, volume - 4)
	Globals.sett_ambi = $Audio/Audio/Ambi/Ambi.value

## Change to windowed
func _on_windowed() -> void:
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	$Video/Video/Window/Window.text = "Windowed"
	Globals.sett_window = "Windowed"

## Change to maximised
func _on_maximised() -> void:
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_MAXIMIZED)
	$Video/Video/Window/Window.text = "Maximised"
	Globals.sett_window = "Maximised"

## Change to fullscreen
func _on_fullscreen() -> void:
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	$Video/Video/Window/Window.text = "Fullscreen"
	Globals.sett_window = "Fullscreen"

## Change V-Sync settings
func _on_vsync() -> void:
	if $Video/Video/Vsync/Vsync.button_pressed:
		Globals.sett_vsync = true
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED)
	else:
		Globals.sett_vsync = false
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)

## Send to mute logid
func _on_mute() -> void:
	if !Globals.sett_mute: _mute_audio(true)
	elif Globals.sett_mute: _mute_audio(false)


## Mute busses and deactivate sliders
func _mute_audio(muted):
	if muted:
		$Audio/Audio/Strike.visible = true
		$Audio/Audio/SFX/SFX.editable = false
		$Audio/Audio/Ambi/Ambi.editable = false
		$Audio/Audio/Music/Music.editable = false
		$Audio/Audio/Master/Master.editable = false
		$Audio/Audio/Player/Player.editable = false
		$Audio/Audio/SFX/SFX.value = 0
		$Audio/Audio/Ambi/Ambi.value = 0
		$Audio/Audio/Music/Music.value = 0
		$Audio/Audio/Master/Master.value = 0
		$Audio/Audio/Player/Player.value = 0
		AudioServer.set_bus_mute(0, true)
		Globals.sett_mute = true
	else:
		$Audio/Audio/Strike.visible = false
		$Audio/Audio/SFX/SFX.editable = true
		$Audio/Audio/Ambi/Ambi.editable = true
		$Audio/Audio/Music/Music.editable = true
		$Audio/Audio/Master/Master.editable = true
		$Audio/Audio/Player/Player.editable = true
		$Audio/Audio/SFX/SFX.value = Globals.sett_sfx
		$Audio/Audio/Ambi/Ambi.value = Globals.sett_ambi
		$Audio/Audio/Music/Music.value = Globals.sett_music
		$Audio/Audio/Master/Master.value = Globals.sett_master
		$Audio/Audio/Player/Player.value = Globals.sett_player
		AudioServer.set_bus_mute(0, false)
		Globals.sett_mute = false

#endregion

#region KEYBINDS

## Remove old keybind and add new
func _set_keybind(action, key) -> void:
	var event = InputEventKey.new()
	event.keycode = OS.find_keycode_from_string(key)
	InputMap.action_erase_events(action)
	InputMap.action_add_event(action, event)
	
	match action:
		"up": 
			Globals.keys_up = key
			$Keys/Keys/Up/Up.text = key
		"down": 
			Globals.keys_down = key
			$Keys/Keys/Down/Down.text = key
		"left": 
			Globals.keys_left = key
			$Keys/Keys/Left/Left.text = key
		"right": 
			Globals.keys_right = key
			$Keys/Keys/Right/Right.text = key
		"inventory": 
			Globals.keys_inv = key
			$Keys/Keys/Menu/Menu.text = key
		"interact": 
			Globals.keys_int = key
			$Keys/Keys/Interact/Interact.text = key

## Up key
func _on_up() -> void:
	key_changing = "up"
	key_listening = true
	get_node("../Listen").visible = true

## Down key
func _on_down() -> void:
	key_changing = "down"
	key_listening = true
	get_node("../Listen").visible = true

## Left key
func _on_left() -> void:
	key_changing = "left"
	key_listening = true
	get_node("../Listen").visible = true

## Right key
func _on_right() -> void:
	key_changing = "right"
	key_listening = true
	get_node("../Listen").visible = true

## Menu change
func _on_menu() -> void:
	key_changing = "inventory"
	key_listening = true
	get_node("../Listen").visible = true

## Interact change
func _on_interact() -> void:
	key_changing = "interact"
	key_listening = true
	get_node("../Listen").visible = true

## Reset keybinds
func _on_default() -> void:
	_set_keybind("up", "W")
	_set_keybind("down", "S")
	_set_keybind("left", "A")
	_set_keybind("right", "D")
	_set_keybind("inventory", "E")
	_set_keybind("interact", "Space")

#endregion
