extends Control

@onready var home = get_node("../..")

#region SETUP

## Check for valid equiptment
func equiped() -> bool:
	if home.selected == "Bait":
		if Globals.current_bait == "": return false
		else: return true
	elif home.selected == "Lure":
		if Globals.current_lure == "": return false
		else: return true
	elif home.selected == "Rods":
		if Globals.current_rod == "": return false
		else: return true
	return false

#endregion

#region BUTTONS

## Button press rod
func _on_rod_button_up() -> void:
	$Panel/Rod/Press.play("up")
	var node = get_node_or_null("Panel/Rod/Icon/Icon/Inform/Press")
	if node != null: node.play("up")
func _on_rod_button_down() -> void:
	$Panel/Rod/Press.play("down")
	var node = get_node_or_null("Panel/Rod/Icon/Icon/Inform/Press")
	if node != null: node.play("down")

## Button press lure
func _on_lure_button_up() -> void:
	$Panel/Lure/Press.play("up")
	var node = get_node_or_null("Panel/Lure/Icon/Icon/Inform/Press")
	if node != null: node.play("up")
func _on_lure_button_down() -> void:
	$Panel/Lure/Press.play("down")
	var node = get_node_or_null("Panel/Lure/Icon/Icon/Inform/Press")
	if node != null: node.play("down")

## Button animations
func _on_bait_button_up() -> void:
	$Panel/Bait/Press.play("up")
func _on_bait_button_down() -> void:
	$Panel/Bait/Press.play("down")


## Information pressed
func _on_info_pressed() -> void:
	
	## Disable information
	if Globals.equip_info:
		if equiped(): $Panel/Info/Info.play("disabled")
		Globals.equip_info = false
	
	## Enable information
	elif !Globals.equip_info:
		if equiped(): $Panel/Info/Info.play("enabled")
		Globals.equip_info = true

#endregion
