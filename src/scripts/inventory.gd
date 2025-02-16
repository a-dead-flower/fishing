extends CanvasLayer

var selected = ""
@export var info_open = false

#region SETUP

## Ready function
func _ready():
	_redraw_fish()
	_redraw_rods()
	_redraw_lure()
	_redraw_bait()
	Setup.connect_buttons()
	$Menu/Panel/Price.text = Setup.get_money(Globals.money)
	Setup.dim_ambient()
	match Globals.equip_page:
		"Bait": _on_bait_pressed()
		"Rods": _on_rods_pressed()
		"Lure": _on_lure_pressed()


## Process function
func _process(_delta):
	if Input.is_action_just_pressed("menu"):
		$Blur/Animate.play("close")
		Setup.undim_ambient()
	if Input.is_action_just_pressed("inventory"):
		$Blur/Animate.play("close")
		Setup.undim_ambient()

	## Add empty label
	if $Menu/Equip/Panel/List/VBox.get_child_count() == 0:
		$Menu/Equip/Panel/List/VBox.add_child(Globals.empty_inv.instantiate())
	if $Menu/Fish/List/VBox.get_child_count() == 0:
		$Menu/Fish/List/VBox.add_child(Globals.empty_inv.instantiate())
	
	## Set space indicator
	$Menu/Panel/Title/Arrs.text = str(
		Globals.fish.size(), "/", Globals.inv_space)


## Animation finished
func _on_animate(anim_name: StringName) -> void:
	if anim_name == "close":
		queue_free()
		get_tree().paused = false

## Remove from fish array
func remove_fish(fish_index):
	Globals.fish.reverse()
	Globals.fish.remove_at(fish_index)
	Globals.fish.reverse()

#endregion

#region SORTING

## Button animations
func _on_name_button_up(): $Menu/Fish/Name/Label/Press.play("up")
func _on_name_button_down(): $Menu/Fish/Name/Label/Press.play("down")
func _on_price_button_up(): $Menu/Fish/Price/Label/Press.play("up")
func _on_price_button_down(): $Menu/Fish/Price/Label/Press.play("down")

## Sort nodes by type
func _sort_nodes(type):
	var sorted_nodes := $Menu/Fish/List/VBox.get_children()
	
	if type == "alpha-hl":
		sorted_nodes.sort_custom( func(a: Node, b: Node): 
			return a.item_name.naturalnocasecmp_to(b.item_name) < 0 )
			
	elif type == "alpha-lh":
		sorted_nodes.sort_custom( func(a: Node, b: Node): 
			return a.item_name.naturalnocasecmp_to(b.item_name) > 0 )
			
	elif type == "price-hl":
		sorted_nodes.sort_custom( func(a: Node, b: Node): 
			return a.item_price > b.item_price)
			
	elif type == "price-lh":
		sorted_nodes.sort_custom( func(a: Node, b: Node): 
			return a.item_price < b.item_price)
			
	for node in $Menu/Fish/List/VBox.get_children():
		$Menu/Fish/List/VBox.remove_child(node)
	for node in sorted_nodes:
		$Menu/Fish/List/VBox.add_child(node)


## Change sort type name
func _on_sort_name():
	if $Menu/Fish/Name/Label/Arrow.scale.x == 1:
		$Menu/Fish/Name/Label/Arrow.scale.x = -1
		_sort_nodes("alpha-lh")
	elif $Menu/Fish/Name/Label/Arrow.scale.x == -1:
		$Menu/Fish/Name/Label/Arrow.scale.x = 1
		_sort_nodes("alpha-hl")
		
## Change sort type price
func _on_sort_price():
	if $Menu/Fish/Price/Label/Arrow.scale.x == 1:
		$Menu/Fish/Price/Label/Arrow.scale.x = -1
		_sort_nodes("price-lh")
	elif $Menu/Fish/Price/Label/Arrow.scale.x == -1:
		$Menu/Fish/Price/Label/Arrow.scale.x = 1
		_sort_nodes("price-hl")

#endregion

#region BUTTONS

## Bait button
func _on_bait_pressed() -> void:
	Globals.equip_page = "Bait"
	
	## Reversal logic
	if selected == "Bait":
		Globals.current_bait = ""
		_redraw_bait()
		
	else: ## Not previous
		_redraw_bait()
		selected = "Bait"
		$Menu/Equip/Panel/Title.text = "BAITS"


## Rod button
func _on_rods_pressed() -> void:
	Globals.equip_page = "Rods"
	
	## Reversal logic
	if selected == "Rods":
		Globals.current_rod = ""
		_redraw_rods()
		
	else: ## Not preious
		_redraw_rods()
		selected = "Rods"
		$Menu/Equip/Panel/Title.text = "RODS"


## Tackle button
func _on_lure_pressed() -> void:
	Globals.equip_page = "Lure"
	
	## Reversal logic
	if selected == "Lure":
		Globals.current_lure = ""
		_redraw_lure()
		
	else: ## Not previous
		_redraw_lure()
		selected = "Lure"
	$Menu/Equip/Panel/Title.text = "LURES"

#endregion

#region DRAWING

## Redraw fish list
func _redraw_fish():
	
	## Remove children
	var parent = $Menu/Fish/List/VBox
	var children = parent.get_children()
	for child in children:child.queue_free()

	Globals.fish.reverse()
	for i in Globals.fish:
		var item = i[0].instantiate()
		item.item_index = Globals.fish.find(i)
		item.item_price = i[1]
		item.item_size = i[2]
		$Menu/Fish/List/VBox.add_child(item)
	Globals.fish.reverse()


## Redraw bait list
func _redraw_bait():
	
	## Remove children
	var parent = $Menu/Equip/Panel/List/VBox
	var frame = $Menu/Equip/Panel/Bait/Icon
	var prev = frame.get_children()
	var children = parent.get_children()
	for child in prev: child.free()
	for child in children: child.queue_free()
	
	## Itterate bait
	for i in Globals.bait:
		if i[1] != 0:
			var item = i[2].instantiate()
			item.ammount = i[1]
			if item.item_name != Globals.current_bait:
				parent.add_child(item)
			else:
				var picture = i[3].instantiate()
				frame.add_child(picture)
				picture.get_node("Icon/Label").text = str(i[1])
				item.queue_free()
				
	## Set information position
	if Globals.equip_info: ## Make sure info selected
		if Globals.current_bait == "": ## Not active
			if info_open: $Menu/Equip/Panel/Info/Info.play("disabled")
			if !info_open: ## Set if already closed
				$Menu/Equip/Panel/Info/Info.play("disabled")
				$Menu/Equip/Panel/Info/Info.seek(1.0)
		else: if !info_open: $Menu/Equip/Panel/Info/Info.play("enabled")



## Redraw lure list
func _redraw_lure():
	
	## Remove children
	var parent = $Menu/Equip/Panel/List/VBox
	var frame = $Menu/Equip/Panel/Lure/Icon
	var prev = frame.get_children()
	var children = parent.get_children()
	for child in prev: child.free()
	for child in children: child.queue_free()
	
	## Itterate lure
	for i in Globals.lure:
		var item = i[2].instantiate()
		item.ammount = i[1]
		item.item_name = i[0]
		if i[0] != Globals.current_lure:
			item.get_node("Down/Durab").value = i[1]
			parent.add_child(item)
		else:
			item.queue_free()
			var picture = i[3].instantiate()
			frame.add_child(picture)
			picture.get_node("Durab").value = i[1]
			
	## Set information position
	if Globals.equip_info: ## Make sure info selected
		if Globals.current_lure == "": ## Not active
			if info_open: $Menu/Equip/Panel/Info/Info.play("disabled")
			if !info_open: ## Set if already closed
				$Menu/Equip/Panel/Info/Info.play("disabled")
				$Menu/Equip/Panel/Info/Info.seek(1.0)
		else: if !info_open: $Menu/Equip/Panel/Info/Info.play("enabled")


## Redraw rod list
func _redraw_rods():
	
	## Remove children
	var parent = $Menu/Equip/Panel/List/VBox
	var frame = $Menu/Equip/Panel/Rod/Icon
	var prev = frame.get_children()
	var children = parent.get_children()
	for child in prev: child.free()
	for child in children: child.queue_free()
	
	## Add rod one
	if Globals.current_rod == "One":
		frame.add_child(Globals.rod_one_icon.instantiate())
	elif Globals.current_rod != "One" and Globals.has_rod_one:
		var item = Globals.rod_one_inv.instantiate()
		parent.add_child(item)
		
	## Add rod two
	if Globals.current_rod == "Two":
		frame.add_child(Globals.rod_two_icon.instantiate())
	elif Globals.current_rod != "Two" and Globals.has_rod_two:
		var item = Globals.rod_two_inv.instantiate()
		parent.add_child(item)
		
	## Add rod two
	if Globals.current_rod == "Three":
		frame.add_child(Globals.rod_three_icon.instantiate())
	elif Globals.current_rod != "Three" and Globals.has_rod_the:
		var item = Globals.rod_three_inv.instantiate()
		parent.add_child(item)
	
	
	## Set information position
	if Globals.equip_info: ## Make sure info selected
		if Globals.current_rod == "": ## Not active
			if info_open: $Menu/Equip/Panel/Info/Info.play("disabled")
			if !info_open: ## Set if already closed
				$Menu/Equip/Panel/Info/Info.play("disabled")
				$Menu/Equip/Panel/Info/Info.seek(1.0)
		else: if !info_open: $Menu/Equip/Panel/Info/Info.play("enabled")
		


#endregion
