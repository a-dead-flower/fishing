extends Node

const game = preload("res://src/scenes/game.tscn")



var rng = RandomNumberGenerator.new()
var new_best = false
var new_fish = false
var current_fish
var entity_fish

var fish_name
var fish_size
var fish_token
var fish_array

var rarities = {
	"Common"     : 4000,
	"Uncommon"   : 2000,
	"Rare"       : 800,
	"Epic"       : 300,
	"Legendary"  : 50,
	"Mythic"     : 10,
	}

#region LOGIC

## Function called to start minigame
func start_game():
	current_fish = moss()
	entity_fish = current_fish.instantiate()
	var child = game.instantiate()
	child.fish_name = entity_fish.name
	add_child(child)


## Function to create the fish after game
func create_fish():
	Globals.stop_cast = true
	entity_fish.position = get_node("/root/Scene/Player/Sprite/Cursor").position
	add_child(entity_fish)
	check_bestiary()
	if new_best: entity_fish.get_node("Box/Control/Panel/Best").visible = true
	if new_fish: entity_fish.get_node("Box/Control/Panel/Best/Label").text = "New Fish!"

## Weighted rarity finder
func get_rarity():
	rng.randomize()
	var weighted = 0
	for n in rarities: weighted += rarities[n]
	var item = rng.randi_range(0,weighted)
	for n in rarities:
		if item <= rarities[n]:
			return n
		item -= rarities[n]

#endregion

#region GENERATE

## Generate new fish
func generate():
	var type = get_rarity()
	
	## Common fish
	if type == "Common":
		var fish = rng.randi_range(1, 18)
		match fish:
			1: return minnow()
			2: return ruby()
			3: return sapp()
			4: return chub()
			5: return perch()
			6: return belly()
			7: return walleye()
			8: return neon()
			9: return guppy()
			10: return wcrap()
			11: return bcrap()
			12: return bream()
			13: return bullh()
			14: return brook()
			15: return pike()
			16: return musk()
			17: return drum()
			18: return bgill()

	## Uncommon fish
	if type == "Uncommon":
		var fish = rng.randi_range(1, 13)
		match fish:
			1: return bass()
			2: return carp()
			3: return eel()
			4: return lgar()
			5: return asnap()
			6: return ssun()
			7: return aperch()
			8: return catf()
			9: return btrout()
			10: return bfin()
			11: return rhop()
			12: return saug()
			13: return cpick()
		
	## Rare fish
	if type == "Rare":
		var fish = rng.randi_range(1, 1)
		if fish == 1: return sturg()
		
	## Epic fish
	if type == "Epic":
		var fish = rng.randi_range(1, 1)
		if fish == 1: return zebra()
		
	## Legendary fish
	if type == "Legendary":
		var _fish = rng.randi_range(1, 1)
		return bass()
		
	## Mythic fish
	if type == "Mythic":
		var _fish = rng.randi_range(1, 1)
		return bass()


## Check if caught fish
func check_bestiary():
	new_best = false
	new_fish = false
	for i in fish_array:
		if i [0] == fish_name:
			i[2] = i[2] + 1
			var bsize = str(i[1]).split(fish_token)
			if float(bsize[0]) < snapped(fish_size,0.1):
				i[1] = str(snapped(fish_size,0.1),fish_token)
				new_best = true
			return
	fish_array.append([fish_name,str(snapped(fish_size,0.1),fish_token),1])
	new_fish = true
	new_best = true

#endregion

#region FISH

#region COMMONS

#################################################################################
##                                 COMMON                                      ##
#################################################################################

## Add minnow
func minnow():
	var base = 30
	fish_size = rng.randf_range(2.0, 8.0)
	var value = base + (fish_size/2)
	fish_array = Globals.pond_caught
	fish_name = "Minnow"; fish_token = "cm"
	Globals.fish.append([
		Globals.minnow_inv,
		snapped(value,1),
		str(snapped(fish_size,0.1),"cm"),
		Globals.minnow_sell
	]); return Globals.minnow_entity

## Add ruby crayfish
func ruby():
	var base = 35
	fish_size = rng.randf_range(5.0, 12.0)
	var value = base + (fish_size/2)
	fish_array = Globals.pond_caught
	fish_name = "Ruby"; fish_token = "cm"
	Globals.fish.append([
		Globals.ruby_inv,
		snapped(value,1),
		str(snapped(fish_size,0.1),"cm"),
		Globals.ruby_sell
	]); return Globals.ruby_entity

## Add sapphire crayfish
func sapp():
	var base = 35
	fish_size = rng.randf_range(5.0, 14.0)
	var value = base + (fish_size/2)
	fish_array = Globals.pond_caught
	fish_name = "Sapp"; fish_token = "cm"
	Globals.fish.append([
		Globals.sapp_inv,
		snapped(value,1),
		str(snapped(fish_size,0.1),"cm"),
		Globals.sapp_sell
	]); return Globals.sapp_entity

## Add chub
func chub():
	var base = 35
	fish_size = rng.randf_range(30.0, 50.0)
	var value = base + (fish_size/2)
	fish_array = Globals.pond_caught
	fish_name = "Chub"; fish_token = "cm"
	Globals.fish.append([
		Globals.chub_inv,
		snapped(value,1),
		str(snapped(fish_size,0.1),"cm"),
		Globals.chub_sell
	]); return Globals.chub_entity

## Add perch
func perch():
	var base = 40
	fish_size = rng.randf_range(30.0, 45.0)
	var value = base + (fish_size/2)
	fish_array = Globals.pond_caught
	fish_name = "Perch"; fish_token = "cm"
	Globals.fish.append([
		Globals.perch_inv,
		snapped(value,1),
		str(snapped(fish_size,0.1),"cm"),
		Globals.perch_sell
	]); return Globals.perch_entity

## Add belly
func belly():
	var base = 40
	fish_size = rng.randf_range(20.0, 50.0)
	var value = base + (fish_size)
	fish_array = Globals.pond_caught
	fish_name = "Belly"; fish_token = "cm"
	Globals.fish.append([
		Globals.belly_inv,
		snapped(value,1),
		str(snapped(fish_size,0.1),"cm"),
		Globals.belly_sell
	]); return Globals.belly_entity

## Add walleye
func walleye():
	var base = 37
	fish_size = rng.randf_range(50.0, 100.0)
	var value = base + (fish_size/2)
	fish_array = Globals.pond_caught
	fish_name = "Walleye"; fish_token = "cm"
	Globals.fish.append([
		Globals.walleye_inv,
		snapped(value,1),
		str(snapped(fish_size,0.1),"cm"),
		Globals.walleye_sell
	]); return Globals.walleye_entity

## Add neon
func neon():
	var base = 50
	fish_size = rng.randf_range(2.0, 6.0)
	var value = base + (fish_size/2)
	fish_array = Globals.pond_caught
	fish_name = "Neon"; fish_token = "cm"
	Globals.fish.append([
		Globals.neon_inv,
		snapped(value,1),
		str(snapped(fish_size,0.1),"cm"),
		Globals.neon_sell
	]); return Globals.neon_entity

## Add guppy
func guppy():
	var base = 30
	fish_size = rng.randf_range(2.0, 6.0)
	var value = base + (fish_size/2)
	fish_array = Globals.pond_caught
	fish_name = "Guppy"; fish_token = "cm"
	Globals.fish.append([
		Globals.guppy_inv,
		snapped(value,1),
		str(snapped(fish_size,0.1),"cm"),
		Globals.guppy_sell
	]); return Globals.guppy_entity

## Add white crappie
func wcrap():
	var base = 50
	fish_size = rng.randf_range(17.0, 53.0)
	var value = base + (fish_size/2)
	fish_array = Globals.pond_caught
	fish_name = "Wcrap"; fish_token = "cm"
	Globals.fish.append([
		Globals.wcrap_inv,
		snapped(value,1),
		str(snapped(fish_size,0.1),"cm"),
		Globals.wcrap_sell
	]); return Globals.wcrap_entity

## Add black crappie
func bcrap():
	var base = 50
	fish_size = rng.randf_range(17.0, 53.0)
	var value = base + (fish_size/2)
	fish_array = Globals.pond_caught
	fish_name = "Bcrap"; fish_token = "cm"
	Globals.fish.append([
		Globals.bcrap_inv,
		snapped(value,1),
		str(snapped(fish_size,0.1),"cm"),
		Globals.bcrap_sell
	]); return Globals.bcrap_entity

## Add perch
func bream():
	var base = 30
	fish_size = rng.randf_range(30.0, 55.0)
	var value = base + (fish_size)
	fish_array = Globals.pond_caught
	fish_name = "Bream"; fish_token = "cm"
	Globals.fish.append([
		Globals.bream_inv,
		snapped(value,1),
		str(snapped(fish_size,0.1),"cm"),
		Globals.bream_sell
	]); return Globals.bream_entity

## Add perch
func bullh():
	var base = 30
	fish_size = rng.randf_range(15.0, 30.0)
	var value = base + (fish_size)
	fish_array = Globals.pond_caught
	fish_name = "Bullh"; fish_token = "cm"
	Globals.fish.append([
		Globals.bullh_inv,
		snapped(value,1),
		str(snapped(fish_size,0.1),"cm"),
		Globals.bullh_sell
	]); return Globals.bullh_entity

## Add perch
func brook():
	var base = 30
	fish_size = rng.randf_range(25.0, 65.0)
	var value = base + (fish_size)
	fish_array = Globals.pond_caught
	fish_name = "Brook"; fish_token = "cm"
	Globals.fish.append([
		Globals.brook_inv,
		snapped(value,1),
		str(snapped(fish_size,0.1),"cm"),
		Globals.brook_sell
	]); return Globals.brook_entity

## Add pike
func pike():
	var base = 60
	fish_size = rng.randf_range(50.0, 150.0)
	var value = base + (fish_size)
	fish_array = Globals.pond_caught
	fish_name = "Pike"; fish_token = "cm"
	Globals.fish.append([
		Globals.pike_inv,
		snapped(value,1),
		str(snapped(fish_size,0.1),"cm"),
		Globals.pike_sell
	]); return Globals.pike_entity

## Add musk
func musk():
	var base = 65
	fish_size = rng.randf_range(50.0, 150.0)
	var value = base + (fish_size)
	fish_array = Globals.pond_caught
	fish_name = "Musk"; fish_token = "cm"
	Globals.fish.append([
		Globals.musk_inv,
		snapped(value,1),
		str(snapped(fish_size,0.1),"cm"),
		Globals.musk_sell
	]); return Globals.musk_entity

## Add drum
func drum():
	var base = 30
	fish_size = rng.randf_range(30.0, 75.0)
	var value = base + (fish_size/2)
	fish_array = Globals.pond_caught
	fish_name = "Drum"; fish_token = "cm"
	Globals.fish.append([
		Globals.drum_inv,
		snapped(value,1),
		str(snapped(fish_size,0.1),"cm"),
		Globals.drum_sell
	]); return Globals.drum_entity

## Add blue gill
func bgill():
	var base = 60
	fish_size = rng.randf_range(7.0, 22.0)
	var value = base + (fish_size/2)
	fish_array = Globals.pond_caught
	fish_name = "Bgill"; fish_token = "cm"
	Globals.fish.append([
		Globals.bgill_inv,
		snapped(value,1),
		str(snapped(fish_size,0.1),"cm"),
		Globals.bgill_sell
	]); return Globals.bgill_entity

## Add sturgeon
func sturg():
	var base = 200
	fish_size = rng.randf_range(0.5, 4.0)
	var value = base + (fish_size * 100)/2
	fish_array = Globals.pond_caught
	fish_name = "Sturgeon"; fish_token = "m"
	Globals.fish.append([
		Globals.sturg_inv,
		snapped(value,1),
		str(snapped(fish_size,0.01),"m"),
		Globals.sturg_sell
	]); return Globals.sturg_entity

## Add zebra pleco
func zebra():
	var base = 400
	fish_size = rng.randf_range(2.0, 8.0)
	var value = base + (fish_size * 5)
	fish_array = Globals.pond_caught
	fish_name = "Zebra"; fish_token = "cm"
	Globals.fish.append([
		Globals.zebra_inv,
		snapped(value,1),
		str(snapped(fish_size,0.1),"cm"),
		Globals.zebra_sell
	]); return Globals.zebra_entity
#endregion

#region UNCOMMON

#################################################################################
##                                UNCOMMON                                     ##
#################################################################################

## Add bass
func bass():
	var base = 100
	fish_size = rng.randi_range(30, 100)
	var value = base + (fish_size/2)
	fish_array = Globals.pond_caught
	fish_name = "Bass"; fish_token = "cm"
	Globals.fish.append([
		Globals.bass_inv,
		snapped(value,1),
		str(snapped(fish_size,1),"cm"),
		Globals.bass_sell
	]); return Globals.bass_entity

## Add carp
func carp():
	var base = 80
	fish_size = rng.randf_range(18.0, 45.0)
	var value = base + (fish_size)
	fish_array = Globals.pond_caught
	fish_name = "Carp"; fish_token = "cm"
	Globals.fish.append([
		Globals.carp_inv,
		snapped(value,1),
		str(snapped(fish_size,0.1),"cm"),
		Globals.carp_sell
	]); return Globals.carp_entity

## Add eel
func eel():
	var base = 90
	fish_size = rng.randf_range(0.2, 4.0)
	var value = base + (fish_size*10)
	fish_array = Globals.pond_caught
	fish_name = "Eel"; fish_token = "m"
	Globals.fish.append([
		Globals.eel_inv,
		snapped(value,1),
		str(snapped(fish_size,0.1),"m"),
		Globals.eel_sell
	]); return Globals.eel_entity

## Add longnose gar
func lgar():
	var base = 90
	fish_size = rng.randf_range(70, 120)
	var value = base + (fish_size)
	fish_array = Globals.pond_caught
	fish_name = "Lgar"; fish_token = "cm"
	Globals.fish.append([
		Globals.lgar_inv,
		snapped(value,1),
		str(snapped(fish_size,0.1),"cm"),
		Globals.lgar_sell
	]); return Globals.lgar_entity


#################################################################################
##  TODO:STATS
#################################################################################

## Add albino snapper
func asnap():
	var base = 90
	fish_size = rng.randf_range(70, 120)
	var value = base + (fish_size)
	fish_array = Globals.pond_caught
	fish_name = "Asnap"; fish_token = "cm"
	Globals.fish.append([
		Globals.asnap_inv,
		snapped(value,1),
		str(snapped(fish_size,0.1),"cm"),
		Globals.asnap_sell
	]); return Globals.asnap_entity

## Add spotted sunfish
func ssun():
	var base = 90
	fish_size = rng.randf_range(70, 120)
	var value = base + (fish_size)
	fish_array = Globals.pond_caught
	fish_name = "Ssun"; fish_token = "cm"
	Globals.fish.append([
		Globals.ssun_inv,
		snapped(value,1),
		str(snapped(fish_size,0.1),"cm"),
		Globals.ssun_sell
	]); return Globals.ssun_entity
	
## Add albino perch
func aperch():
	var base = 90
	fish_size = rng.randf_range(70, 120)
	var value = base + (fish_size)
	fish_array = Globals.pond_caught
	fish_name = "Aperch"; fish_token = "cm"
	Globals.fish.append([
		Globals.aperch_inv,
		snapped(value,1),
		str(snapped(fish_size,0.1),"cm"),
		Globals.aperch_sell
	]); return Globals.aperch_entity

## Add catfisn
func catf():
	var base = 90
	fish_size = rng.randf_range(70, 120)
	var value = base + (fish_size)
	fish_array = Globals.pond_caught
	fish_name = "Catf"; fish_token = "cm"
	Globals.fish.append([
		Globals.catf_inv,
		snapped(value,1),
		str(snapped(fish_size,0.1),"cm"),
		Globals.catf_sell
	]); return Globals.catf_entity

## Add brown trout
func btrout():
	var base = 90
	fish_size = rng.randf_range(70, 120)
	var value = base + (fish_size)
	fish_array = Globals.pond_caught
	fish_name = "Btrout"; fish_token = "cm"
	Globals.fish.append([
		Globals.btrout_inv,
		snapped(value,1),
		str(snapped(fish_size,0.1),"cm"),
		Globals.btrout_sell
	]); return Globals.btrout_entity

## Add bowfin
func bfin():
	var base = 90
	fish_size = rng.randf_range(70, 120)
	var value = base + (fish_size)
	fish_array = Globals.pond_caught
	fish_name = "Bfin"; fish_token = "cm"
	Globals.fish.append([
		Globals.bfin_inv,
		snapped(value,1),
		str(snapped(fish_size,0.1),"cm"),
		Globals.bfin_sell
	]); return Globals.bfin_entity

## Add rock hopper
func rhop():
	var base = 90
	fish_size = rng.randf_range(70, 120)
	var value = base + (fish_size)
	fish_array = Globals.pond_caught
	fish_name = "Rhop"; fish_token = "cm"
	Globals.fish.append([
		Globals.rhop_inv,
		snapped(value,1),
		str(snapped(fish_size,0.1),"cm"),
		Globals.rhop_sell
	]); return Globals.rhop_entity

## Add sauger
func saug():
	var base = 90
	fish_size = rng.randf_range(70, 120)
	var value = base + (fish_size)
	fish_array = Globals.pond_caught
	fish_name = "Saug"; fish_token = "cm"
	Globals.fish.append([
		Globals.saug_inv,
		snapped(value,1),
		str(snapped(fish_size,0.1),"cm"),
		Globals.saug_sell
	]); return Globals.saug_entity

## Add chain pickrel
func cpick():
	var base = 90
	fish_size = rng.randf_range(70, 120)
	var value = base + (fish_size)
	fish_array = Globals.pond_caught
	fish_name = "Cpick"; fish_token = "cm"
	Globals.fish.append([
		Globals.cpick_inv,
		snapped(value,1),
		str(snapped(fish_size,0.1),"cm"),
		Globals.cpick_sell
	]); return Globals.cpick_entity

## Add mooneye
func moon():
	var base = 90
	fish_size = rng.randf_range(70, 120)
	var value = base + (fish_size)
	fish_array = Globals.pond_caught
	fish_name = "Moon"; fish_token = "cm"
	Globals.fish.append([
		Globals.moon_inv,
		snapped(value,1),
		str(snapped(fish_size,0.1),"cm"),
		Globals.moon_sell
	]); return Globals.moon_entity

## Add blackjaw
func bjaw():
	var base = 90
	fish_size = rng.randf_range(70, 120)
	var value = base + (fish_size)
	fish_array = Globals.pond_caught
	fish_name = "Bjaw"; fish_token = "cm"
	Globals.fish.append([
		Globals.bjaw_inv,
		snapped(value,1),
		str(snapped(fish_size,0.1),"cm"),
		Globals.bjaw_sell
	]); return Globals.bjaw_entity

## Add mossy arrowhead
func moss():
	var base = 90
	fish_size = rng.randf_range(70, 120)
	var value = base + (fish_size)
	fish_array = Globals.pond_caught
	fish_name = "Moss"; fish_token = "cm"
	Globals.fish.append([
		Globals.moss_inv,
		snapped(value,1),
		str(snapped(fish_size,0.1),"cm"),
		Globals.moss_sell
	]); return Globals.moss_entity

#endregion

#endregion
