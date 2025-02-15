extends Slider

@export var snap_point = 5.0
@export var snap_size = 5.0

func _process(_delta):
	if abs(value - snap_point) <= snap_size:
		value = snap_point
