extends Button

## Name used for sorting
@export var item_name = ""
## Packed scene connects to info
@export var item_info: PackedScene

var item_index = 0
var item_price = 0
var item_size = ""

## Setup node
func _enter_tree(): $Price.text = str(item_price)
func _on_up(): $Press.play("up")
func _on_down(): $Press.play("down")
func _ready():
	Setup.connect_self(self.get_path())
	$Price/Panel.mouse_filter = MOUSE_FILTER_PASS

## Open Info panel
func _on_pressed() -> void:
	if get_node_or_null("../../../../Info") != null:
		get_node("../../../../Info").name = "DELETE"
		get_node("../../../../DELETE").queue_free()
	
	var info = item_info.instantiate()
	get_node("../../../../").add_child(info)
	info.get_node("Size/Size").text = item_size
	info.get_node("Value/Value").text = str("$",item_price)
	info.fish_index = item_index
	info.name = "Info"
