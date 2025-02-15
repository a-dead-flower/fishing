extends Button

@export var item_name = ""
@export var item_price = 0
@export var item_type = ""
@export var player_has = true
@export var ammount = 1
@export var lure_id = 0
@export var lure_mod = 1

@onready var menu = get_node("/root/Scene/Player/Canvas")
@onready var shop_box = get_node("/root/Scene/Player/Canvas/Menu/Shop/List/VBox")
@onready var player_box = get_node("/root/Scene/Player/Canvas/Menu/Player/List/VBox")
@onready var money_label = get_node("/root/Scene/Player/Canvas/Menu/Panel1/Price")

var index = 0
var object = []
var shift = false

#region SETUP

## Set price on label
func _ready() -> void:
	Setup.connect_self(self.get_path())
	
	## Hide durability in shop
	if !player_has and item_type == "Lure":
		$Price/Durab.visible = false
		$Price.text = str(item_price * ammount)
	
	## Set price of object
	if item_type == "Bait":
		$Price.text = str(item_price * ammount)
	if item_type == "Bait" and player_has:
		$Price.text = str(item_price * object[1])
		
	if item_type == "Lure":
		item_price = ammount * lure_mod
		$Price.text = str(item_price)


## Process function
func _process(_delta: float) -> void:
	## Check for shift and close
	if Input.is_action_pressed("shift"): shift = true
	if Input.is_action_just_released("shift"): shift = false
	
	## Count Money
	if player_has: return
	if item_type == "Bait":
		if Globals.money < item_price * ammount:
			$Able.play("disabled")
			disabled = true
		else: ## Insufficient funds
			$Able.play("enabled")
			disabled = false
	if item_type == "Lure":
		if Globals.money < item_price:
			$Able.play("disabled")
			disabled = true
		else: ## Insufficient funds
			$Able.play("enabled")
			disabled = false


## Setup label
func _enter_tree(): $Price.text = str(item_price)
func _on_up(): $Press.play("up")
func _on_down(): $Press.play("down")

#endregion

#region PRESSED

## Change item list
func _on_pressed() -> void:
	
	## Buy and sell bait logic
	if item_type == "Bait": ## Item stacks multiple
		if player_has: ## Player has item
			
			## Player holds shift
			if !shift or object[1] == 1:
				Globals.money += item_price
				money_label.text = str(Setup.get_money(Globals.money))
				menu.change_bait(false, ammount, item_name)
				
			else: ## Shift is pressed and more than one
				Globals.money += item_price * (object[1]/2)
				money_label.text = str(Setup.get_money(Globals.money))
				menu.change_bait(false, object[1]/2, item_name)
			
			## Redraw list
			menu.draw_bait()
			
		if not player_has: ## On shop side
			Globals.money -= item_price * ammount
			money_label.text = str(Setup.get_money(Globals.money))
			menu.change_bait(true, ammount, item_name)
			menu.draw_bait()
			
			
	## Buy and sell lure logic
	elif item_type == "Lure":
		if player_has: ## Sell lure
			Globals.money += item_price
			money_label.text = str(Setup.get_money(Globals.money))
			menu.change_lure(false, ammount, item_name, lure_id)
			menu.draw_lure()
			
		elif !player_has: ## Buy lure
			Globals.money -= item_price
			money_label.text = str(Setup.get_money(Globals.money))
			menu.change_lure(true, ammount, item_name, lure_id)
			menu.draw_lure()
			
			
	## Buy and sell fish logic
	elif item_type == "Fish":
		if player_has: ## Sell fish
			Globals.money += item_price
			money_label.text = str(Setup.get_money(Globals.money))
			self.reparent(shop_box)
			menu.change_fish(false, object)
			player_has = false
			
		elif !player_has: ## Buy fish
			Globals.money -= item_price
			money_label.text = str(Setup.get_money(Globals.money))
			self.reparent(player_box)
			get_parent().move_child(self, 0)
			menu.change_fish(true, object)
			player_has = true
				
#endregion
