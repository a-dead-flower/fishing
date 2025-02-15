extends Button

@export var item_name = ""
@export var item_price = 0
@export var item_size = ""
@export var item_info: PackedScene
@export var item_index = 0

## Setup node
func _enter_tree(): $Price.text = str(item_price)
func _on_up(): $Press.play("up")
func _on_down(): $Press.play("down")
func _ready(): Setup.connect_self(self.get_path())

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
