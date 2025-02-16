extends Button

@export var type = ""
@export var item_price = 5000

#region SETUP

func _ready() -> void:
	
	## Disable owned rods
	if type == "One" and Globals.has_rod_one:
		disabled = true
		$Max.visible = true
		$Able.play("disabled")
	if type == "Two" and Globals.has_rod_two:
		disabled = true
		$Max.visible = true
		$Able.play("disabled")
	if type == "Three" and Globals.has_rod_the:
		disabled = true
		$Max.visible = true
		$Able.play("disabled")
	place_name()
	
func _on_up(): $Press.play("up")
func _on_down(): $Press.play("down")

func _process(_delta: float) -> void:
	if item_price > Globals.money:
		disabled = true
		$Able.play("disabled")

## Redraw buttons
func place_name() -> void:
	match type:
		"Area Size": area_size()
		"Reel Speed": reel_speed()
		"Cast Speed": cast_speed()
		"Loss Speed": loss_speed()
		"Back Packs": back_pack()

## Increment and redraw
func _on_pressed():
	match type:
		"Area Size": Globals.upgrade_bar += 1
		"Reel Speed": Globals.upgrade_prog += 1
		"Cast Speed": Globals.upgrade_cast += 1
		"Loss Speed": Globals.upgrade_loss += 1
		"Back Packs": Globals.upgrade_pack += 1
	Globals.money = Globals.money - item_price
	
	## Rod one setup
	if type == "One":
		disabled = true
		$Max.visible = true
		$Able.play("disabled")
		Globals.has_rod_one = true
	
	## Rod two setup
	elif type == "Two":
		disabled = true
		$Max.visible = true
		$Able.play("disabled")
		Globals.has_rod_two= true
	
	## Rod three setup
	elif type == "Three":
		disabled = true
		$Max.visible = true
		$Able.play("disabled")
		Globals.has_rod_the= true
		
	else: place_name()

#endregion

#region PROGRESS

## Increase reel speed
func reel_speed():
	if Globals.upgrade_prog > 3:
		disabled = true
		$Able.play("disabled")
		$Max.visible = true
		$Price/Level.visible = false
		$Price.text = ""
	$Price/Level.text = str("LV ",Globals.upgrade_prog + 1)
	if Globals.upgrade_prog == 0:
		$Price.text = "5,000"
		item_price = 5000
	elif Globals.upgrade_prog == 1:
		$Price.text = "10,000"
		item_price = 10000
	elif Globals.upgrade_prog == 2:
		$Price.text = "20,000"
		item_price = 20000
	elif Globals.upgrade_prog == 3:
		$Price.text = "50,000"
		item_price = 50000

## Increase area sizes
func area_size():
	if Globals.upgrade_bar > 2:
		disabled = true
		$Able.play("disabled")
		$Max.visible = true
		$Price/Level.visible = false
		$Price.text = ""
	$Price/Level.text = str("LV ",Globals.upgrade_bar + 1)
	if Globals.upgrade_bar == 0:
		$Price.text = "8,000"
		item_price = 8000
	elif Globals.upgrade_bar == 1:
		$Price.text = "15,000"
		item_price = 35000
	elif Globals.upgrade_bar == 2:
		$Price.text = "40,000"
		item_price = 80000

## Increase cast speed
func cast_speed():
	if Globals.upgrade_cast > 4:
		disabled = true
		$Able.play("disabled")
		$Max.visible = true
		$Price/Level.visible = false
		$Price.text = ""
	$Price/Level.text = str("LV ",Globals.upgrade_cast + 1)
	if Globals.upgrade_cast == 0:
		$Price.text = "1,000"
		item_price = 1000
		Globals.cast_speed = 440
	elif Globals.upgrade_cast == 1:
		$Price.text = "3,000"
		item_price = 3000
		Globals.cast_speed = 490
	elif Globals.upgrade_cast == 2:
		$Price.text = "5,000"
		item_price = 5000
		Globals.cast_speed = 550
	elif Globals.upgrade_cast == 3:
		$Price.text = "6,500"
		item_price = 6500
		Globals.cast_speed = 600
	elif Globals.upgrade_cast == 4:
		$Price.text = "10,000"
		item_price = 10000
		Globals.cast_speed = 700

## Decrease escape speed
func loss_speed():
	if Globals.upgrade_loss > 3:
		disabled = true
		$Able.play("disabled")
		$Max.visible = true
		$Price/Level.visible = false
		$Price.text = ""
	$Price/Level.text = str("LV ",Globals.upgrade_loss + 1)
	if Globals.upgrade_loss == 0:
		$Price.text = "5,000"
		item_price = 5000
	elif Globals.upgrade_loss == 1:
		$Price.text = "10,000"
		item_price = 10000
	elif Globals.upgrade_loss == 2:
		$Price.text = "20,000"
		item_price = 20000
	elif Globals.upgrade_loss == 3:
		$Price.text = "50,000"
		item_price = 50000

## Increase backpack size
func back_pack():
	if Globals.upgrade_pack > 4:
		disabled = true
		$Able.play("disabled")
		$Max.visible = true
		$Price/Level.visible = false
		$Price.text = ""
	$Price/Level.text = str("LV ",Globals.upgrade_pack + 1)
	if Globals.upgrade_pack == 1:
		Globals.inv_space = 20
		$Price.text = "2,000"
		item_price = 2000
	elif Globals.upgrade_pack == 2:
		Globals.inv_space = 40
		$Price.text = "3,500"
		item_price = 3500
	elif Globals.upgrade_pack == 3:
		Globals.inv_space = 60
		$Price.text = "5,000"
		item_price = 5000
	elif Globals.upgrade_pack == 4:
		Globals.inv_space = 80
		$Price.text = "6,500"
		item_price = 6500
	elif Globals.upgrade_pack == 5:
		Globals.inv_space = 100
		$Price.text = "8,000"
		item_price = 8000

#endregion
