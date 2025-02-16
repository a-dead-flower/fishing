extends CanvasLayer

var rng = RandomNumberGenerator.new()
var bar = false

#region SETUP

## Ready function
func _ready():
	$Menu/Panel1/Price.text = str(Setup.get_money(Globals.money))
	if Globals.shop_type == "Fish": draw_fish()
	if Globals.shop_type == "Bait": draw_bait()
	$Variation.play(Globals.shop_type)
	Setup.connect_buttons()
	Setup.dim_ambient()
	disable_info()


## Process function
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("menu"):
		$Animate.play("close")
		Setup.undim_ambient()
	if Input.is_action_just_pressed("interact"):
		$Animate.play("close")
		Setup.undim_ambient()
	if Input.is_action_just_pressed("inventory"):
		$Animate.play("close")
		Setup.undim_ambient()

## Disable info on open
func disable_info():
	if Globals.shop_type == "Fish": return
	var list = $Menu/Shop/List/VBox.get_children()
	for i in list:
		i.get_node("Inform").force = true
		i.get_node("Inform").visible = false

## Enable info on open
func enable_info():
	if Globals.shop_type == "Fish": return
	var list = $Menu/Shop/List/VBox.get_children()
	for i in list:
		i.get_node("Inform").force = false


## Render bait list
func draw_bait():
	var parent = $Menu/Player/List/VBox
	var children = parent.get_children()
	for child in children: child.queue_free()
	
	## Draw bait list
	for i in Globals.bait:
		var index = 0
		var item = i[4].instantiate()
		item.text = str(item.text, " x", i[1])
		item.player_has = true
		item.index = index
		item.object = i
		index += 1
		$Menu/Player/List/VBox.add_child(item)


## Render lure list
func draw_lure():
	var parent = $Menu/Player/List/VBox
	var children = parent.get_children()
	for child in children: child.queue_free()
	
	## Draw lure list
	for i in Globals.lure:
		var item = i[4].instantiate()
		item.player_has = true
		item.lure_id = i[0]
		item.ammount = i[1]
		item.get_node("Price").text = str(item.item_price)
		item.get_node("Price/Durab").value = i[1]
		$Menu/Player/List/VBox.add_child(item)


## Render fish list
func draw_fish():
	var index = 0 ## Fish index
	var parent = $Menu/Player/List/VBox
	var children = parent.get_children()
	for child in children: child.queue_free()
	
	## Draw fish list
	Globals.fish.reverse()
	for i in Globals.fish:
		var item = i[3].instantiate()
		item.item_price = i[1]
		item.index = index
		item.object = i
		index += 1
		$Menu/Player/List/VBox.add_child(item)
	Globals.fish.reverse()


## Open info pages
func _on_info() -> void:
	if Globals.shops_info: Globals.shops_info = false
	else: Globals.shops_info = true

#endregion

#region INVENTORY

## Animation finished
func _on_animate(anim_name: StringName) -> void:
	if anim_name == "close":
		queue_free()
		get_tree().paused = false


## Change sort type name player
func _on_sort_name_player():
	if $Menu/Player/Name/Label/Arrow.scale.x == 1:
		$Menu/Player/Name/Label/Arrow.scale.x = -1
		_sort_nodes("alpha-lh", true)
	elif $Menu/Player/Name/Label/Arrow.scale.x == -1:
		$Menu/Player/Name/Label/Arrow.scale.x = 1
		_sort_nodes("alpha-hl", true)


## Change sort type price player
func _on_sort_price_player():
	if $Menu/Player/Price/Label/Arrow.scale.x == 1:
		$Menu/Player/Price/Label/Arrow.scale.x = -1
		_sort_nodes("price-lh", true)
	elif $Menu/Player/Price/Label/Arrow.scale.x == -1:
		$Menu/Player/Price/Label/Arrow.scale.x = 1
		_sort_nodes("price-hl", true)


## Change sort type name shop
func _on_sort_name_shop():
	if $Menu/Shop/Name/Label/Arrow.scale.x == 1:
		$Menu/Shop/Name/Label/Arrow.scale.x = -1
		_sort_nodes("alpha-lh", false)
	elif $Menu/Shop/Name/Label/Arrow.scale.x == -1:
		$Menu/Shop/Name/Label/Arrow.scale.x = 1
		_sort_nodes("alpha-hl", false)

## Change sort type price shop
func _on_sort_price_shop():
	if $Menu/Shop/Price/Label/Arrow.scale.x == 1:
		$Menu/Shop/Price/Label/Arrow.scale.x = -1
		_sort_nodes("price-lh", false)
	elif $Menu/Shop/Price/Label/Arrow.scale.x == -1:
		$Menu/Shop/Price/Label/Arrow.scale.x = 1
		_sort_nodes("price-hl", false)



## Sort nodes by type
func _sort_nodes(type, player):
	var sorted_nodes
	var item_list
	
	if player: ## Sort player
		sorted_nodes = []
		for child in $Menu/Player/List/VBox.get_children():
			if child.item_type == Globals.shop_type: sorted_nodes.append(child)
		item_list = $Menu/Player/List/VBox
		
	else: ## Sort shop
		sorted_nodes = []
		for child in $Menu/Shop/List/VBox.get_children():
			if child.item_type == Globals.shop_type: sorted_nodes.append(child)
		item_list = $Menu/Shop/List/VBox
	
	if type == "alpha-hl":
		sorted_nodes.sort_custom(func(a: Node, b: Node): 
			return a.item_name.naturalnocasecmp_to(b.item_name) < 0 )
			
	elif type == "alpha-lh":
		sorted_nodes.sort_custom(func(a: Node, b: Node): 
			return a.item_name.naturalnocasecmp_to(b.item_name) > 0 )
			
	elif type == "price-hl":
		sorted_nodes.sort_custom(func(a: Node, b: Node): 
			if Globals.shop_type == "Bait":
				return int(a.text.split("x")[-1]) * \
				a.item_price > int(b.text.split("x")[-1]) * b.item_price
			elif Globals.shop_type == "Fish":
				return a.item_price > b.item_price)
			
	elif type == "price-lh":
		sorted_nodes.sort_custom(func(a: Node, b: Node): 
			if Globals.shop_type == "Bait":
				return int(a.text.split("x")[-1]) * \
				a.item_price < int(b.text.split("x")[-1]) * b.item_price
			elif Globals.shop_type == "Fish":
				return a.item_price < b.item_price)
	
	## Sort nodes but not rect
	for node in item_list.get_children():
		if node.item_type == Globals.shop_type:
			item_list.remove_child(node)
	for node in sorted_nodes:
		item_list.add_child(node)
		if node.item_type == "Bait":
			node.get_node("Price").text = str(
			int(node.text.split("x")[-1]) * node.item_price)


## Rotate shop pages
func _on_next() -> void:
	
	## Fish page
	if Globals.shop_type == "Lure":
		Globals.shop_type = "Fish"
		draw_fish()
		
	## Bait page
	elif Globals.shop_type == "Fish":
		Globals.shop_type = "Bait"
		remove_fish()
		draw_bait()
	
	## Lure page
	elif Globals.shop_type == "Bait":
		Globals.shop_type = "Lure"
		draw_lure()
	
	## Shop variation type
	$Variation.play(Globals.shop_type)


## Remove fish from shop
func remove_fish():
	var list = $Menu/Shop/List/VBox.get_children()
	for i in list: if i.item_type == "Fish": i.queue_free()


## Button clicks
func _on_name_button_up_shop(): $Menu/Shop/Name/Label/Press.play("up")
func _on_price_button_up_shop(): $Menu/Shop/Price/Label/Press.play("up")
func _on_name_button_down_shop(): $Menu/Shop/Name/Label/Press.play("down")
func _on_name_button_up_player(): $Menu/Player/Name/Label/Press.play("up")
func _on_price_button_up_player(): $Menu/Player/Price/Label/Press.play("up")
func _on_price_button_down_shop(): $Menu/Shop/Price/Label/Press.play("down")
func _on_name_button_down_player(): $Menu/Player/Name/Label/Press.play("down")
func _on_price_button_down_player(): $Menu/Player/Price/Label/Press.play("down")

#endregion

#region ARRAYS

## Edit fish array
func change_fish(add, object):
	if add: Globals.fish.append(object)
	else: ## Remove fish at index
		for i in Globals.fish:
			if i == object:
				Globals.fish.erase(i)


## Edit bait array
func change_bait(add, ammount, item_name):
	if not add: for i in Globals.bait:
		if i[0] == item_name:
			if i[1] - ammount == 0:
				Globals.bait.erase(i)
			else: i[1] -= ammount
			
	if add: ## Add element to array
		var found = false
		for i in Globals.bait:
			## Check if exists
			if i[0] == item_name:
				i[1] += ammount
				found = true
		
		## Not have already
		if not found: match item_name:
			"Grub":
				Globals.bait.append([
				item_name, ammount,
				Globals.grub_inv, 
				Globals.grub_icon, 
				Globals.grub_sell])
				
			"Worm":
				Globals.bait.append([
				item_name, ammount,
				Globals.worm_inv, 
				Globals.worm_icon, 
				Globals.worm_sell])



## Edit lure array
func change_lure(add, ammount, item_name, lure_id):
	## Add to lure array
	var found = false
	
	## Remove from array
	if !add: for i in Globals.lure:
		if i[0] == lure_id:
			Globals.lure.erase(i)
		
	elif add: ## Check if ID exists
		var random = rng.randi_range(0, 999)
		if Globals.lure.size() != 0:
			while !found: for i in Globals.lure:
				if i[0] == str(random): 
					random = rng.randi_range(0, 999)
				else: found = true
			
		## Add to array
		match item_name:
			"Blue":
				Globals.lure.append(
				[str(random), ammount,
				Globals.blue_inv, 
				Globals.blue_icon, 
				Globals.blue_sell])
#endregion
