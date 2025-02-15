extends Control

@export var item_type = ""

func _process(_delta: float) -> void:
	
	## Show info for lure 
	if Globals.equip_page == "Lure":
		if item_type == "Lure": $Inform.visible = true
		else: $Inform.visible = false
		
	## Show info for bait
	elif Globals.equip_page == "Bait":
		if item_type == "Bait": $Inform.visible = true
		else: $Inform.visible = false
		
	## Show info for Rods
	elif Globals.equip_page == "Rods":
		if item_type == "Rods": $Inform.visible = true
		else: $Inform.visible = false
