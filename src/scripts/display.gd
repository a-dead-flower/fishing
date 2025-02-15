extends CanvasLayer


func _ready():
	$Control/Time/Clock/Time.play("cycle")
	$Control/Time/Clock/Time.advance(Globals.time_of_day)

func _process(_delta):
	var seconds = int(get_node("/root/Setup/Cycle").current_animation_position)
	$Control/Time/Label.text = get_time((seconds * 10))

func get_time(time_in_sec):
	var seconds = time_in_sec%60
	var minutes = (time_in_sec/60)%60
	return "%02d:%02d" % [minutes, seconds]
