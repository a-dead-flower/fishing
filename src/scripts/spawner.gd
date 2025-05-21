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
	current_fish = generate()
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
	entity_fish.get_node("Box/Control/Panel/Best").visible = false
	if new_best: entity_fish.get_node("Box/Control/Panel/Best").visible = true
	if new_fish: entity_fish.get_node("Box/Control/Panel/Best/Label").text = "New Fish!"

## Weighted rarity finder
func get_rarity():
	rng.randomize()
	var weighted = 0
	for n in rarities: weighted += rarities[n]
	var item = rng.randi_range(Globals.bonus_rng,weighted)
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
		var fish = rng.randi_range(1, 16)
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
			14: return moon()
			15: return bjaw()
			16: return moss()
		
	## Rare fish
	if type == "Rare":
		var fish = rng.randi_range(1, 11)
		match fish:
			1: return agar()
			2: return afish()
			3: return sock()
			4: return rtrout()
			5: return atlan()
			6: return gala()
			7: return redc()
			8: return bulb()
			9: return snap()
			10: return knife()
			11: return glow()
		
	## Epic fish
	if type == "Epic":
		var fish = rng.randi_range(1, 9)
		match fish:
			1: return zebra()
			2: return padd()
			3: return home()
			4: return cloud()
			5: return swirl()
			6: return night()
			7: return violet()
			8: return dart()
			9: return gold()
		
	## Legendary fish
	if type == "Legendary":
		var fish = rng.randi_range(1, 5)
		match fish:
			1: return dream()
			2: return barb()
			3: return dragon()
			4: return cosmic()
			5: return jack()
		
	## Mythic fish
	if type == "Mythic":
		var _fish = rng.randi_range(1, 1)
		return zebra()


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
	fish_array.append([fish_name,str(snapped(fish_size,0.1),fish_token),1,true])
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

## Add muskellunge
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
	var base = 110
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
	var base = 120
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
	var base = 120
	fish_size = rng.randf_range(70, 120)
	var value = base + (fish_size/2)
	fish_array = Globals.pond_caught
	fish_name = "Lgar"; fish_token = "cm"
	Globals.fish.append([
		Globals.lgar_inv,
		snapped(value,1),
		str(snapped(fish_size,0.1),"cm"),
		Globals.lgar_sell
	]); return Globals.lgar_entity

## Add albino snapper
func asnap():
	var base = 100
	fish_size = rng.randf_range(30, 70)
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
	var base = 100
	fish_size = rng.randf_range(10, 20)
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
	var base = 110
	fish_size = rng.randf_range(15, 30)
	var value = base + (fish_size)
	fish_array = Globals.pond_caught
	fish_name = "Aperch"; fish_token = "cm"
	Globals.fish.append([
		Globals.aperch_inv,
		snapped(value,1),
		str(snapped(fish_size,0.1),"cm"),
		Globals.aperch_sell
	]); return Globals.aperch_entity

## Add catfish
func catf():
	var base = 120
	fish_size = rng.randf_range(1, 2)
	var value = base + (fish_size*10)
	fish_array = Globals.pond_caught
	fish_name = "Catf"; fish_token = "m"
	Globals.fish.append([
		Globals.catf_inv,
		snapped(value,1),
		str(snapped(fish_size,0.1),"m"),
		Globals.catf_sell
	]); return Globals.catf_entity

## Add brown trout
func btrout():
	var base = 100
	fish_size = rng.randf_range(40, 80)
	var value = base + (fish_size*1.5)
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
	var base = 110
	fish_size = rng.randf_range(45, 60)
	var value = base + (fish_size*1.2)
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
	var base = 110
	fish_size = rng.randf_range(8, 17)
	var value = base + (fish_size*2)
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
	var base = 100
	fish_size = rng.randf_range(25, 40)
	var value = base + (fish_size*2)
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
	var base = 120
	fish_size = rng.randf_range(60, 80)
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
	var base = 130
	fish_size = rng.randf_range(30, 40)
	var value = base + (fish_size*1.4)
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
	var base = 140
	fish_size = rng.randf_range(20, 40)
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
	var base = 145
	fish_size = rng.randf_range(10, 20)
	var value = base + (fish_size*2)
	fish_array = Globals.pond_caught
	fish_name = "Moss"; fish_token = "cm"
	Globals.fish.append([
		Globals.moss_inv,
		snapped(value,1),
		str(snapped(fish_size,0.1),"cm"),
		Globals.moss_sell
	]); return Globals.moss_entity

#endregion

#region RARE

#################################################################################
##                                  RARE                                       ##
#################################################################################

## Add alligator gar
func agar():
	var base = 220
	fish_size = rng.randf_range(1.5, 3)
	var value = base + (fish_size*15)
	fish_array = Globals.pond_caught
	fish_name = "Agar"; fish_token = "m"
	Globals.fish.append([
		Globals.agar_inv,
		snapped(value,1),
		str(snapped(fish_size,0.1),"m"),
		Globals.agar_sell
	]); return Globals.agar_entity

## Add angel fish
func afish():
	var base = 210
	fish_size = rng.randf_range(10, 20)
	var value = base + (fish_size*2)
	fish_array = Globals.pond_caught
	fish_name = "Afish"; fish_token = "cm"
	Globals.fish.append([
		Globals.afish_inv,
		snapped(value,1),
		str(snapped(fish_size,0.1),"cm"),
		Globals.afish_sell
	]); return Globals.afish_entity

## Add sockeye salmon
func sock():
	var base = 220
	fish_size = rng.randf_range(60, 90)
	var value = base + (fish_size*1.4)
	fish_array = Globals.pond_caught
	fish_name = "Sock"; fish_token = "cm"
	Globals.fish.append([
		Globals.sock_inv,
		snapped(value,1),
		str(snapped(fish_size,0.1),"cm"),
		Globals.sock_sell
	]); return Globals.sock_entity

## Add rainbow trout
func rtrout():
	var base = 240
	fish_size = rng.randf_range(50, 70)
	var value = base + (fish_size)
	fish_array = Globals.pond_caught
	fish_name = "Rtrout"; fish_token = "cm"
	Globals.fish.append([
		Globals.rtrout_inv,
		snapped(value,1),
		str(snapped(fish_size,0.1),"cm"),
		Globals.rtrout_sell
	]); return Globals.rtrout_entity

## Add atlantic salmon
func atlan():
	var base = 230
	fish_size = rng.randf_range(1, 2)
	var value = base + (fish_size)
	fish_array = Globals.pond_caught
	fish_name = "Atlan"; fish_token = "cm"
	Globals.fish.append([
		Globals.atlan_inv,
		snapped(value,1),
		str(snapped(fish_size,0.1),"cm"),
		Globals.atlan_sell
	]); return Globals.atlan_entity

## Add galaxy rasbora
func gala():
	var base = 250
	fish_size = rng.randf_range(1.5, 4)
	var value = base + (fish_size*15)
	fish_array = Globals.pond_caught
	fish_name = "Gala"; fish_token = "cm"
	Globals.fish.append([
		Globals.gala_inv,
		snapped(value,1),
		str(snapped(fish_size,0.1),"cm"),
		Globals.gala_sell
	]); return Globals.gala_entity

## Add redtail catfish
func redc():
	var base = 230
	fish_size = rng.randf_range(1, 2)
	var value = base + (fish_size*20)
	fish_array = Globals.pond_caught
	fish_name = "Redc"; fish_token = "m"
	Globals.fish.append([
		Globals.redc_inv,
		snapped(value,1),
		str(snapped(fish_size,0.1),"m"),
		Globals.redc_sell
	]); return Globals.redc_entity

## Add sparkling bulbfin
func bulb():
	var base = 210
	fish_size = rng.randf_range(8, 10)
	var value = base + (fish_size*10)
	fish_array = Globals.pond_caught
	fish_name = "Bulb"; fish_token = "cm"
	Globals.fish.append([
		Globals.bulb_inv,
		snapped(value,1),
		str(snapped(fish_size,0.1),"cm"),
		Globals.bulb_sell
	]); return Globals.bulb_entity

## Add alligator snapping turtle
func snap():
	var base = 230
	fish_size = rng.randf_range(35, 80)
	var value = base + (fish_size)
	fish_array = Globals.pond_caught
	fish_name = "Snap"; fish_token = "cm"
	Globals.fish.append([
		Globals.snap_inv,
		snapped(value,1),
		str(snapped(fish_size,0.1),"cm"),
		Globals.snap_sell
	]); return Globals.snap_entity

## Add black ghost knifefish
func knife():
	var base = 210
	fish_size = rng.randf_range(30, 50)
	var value = base + (fish_size)
	fish_array = Globals.pond_caught
	fish_name = "Knife"; fish_token = "cm"
	Globals.fish.append([
		Globals.knife_inv,
		snapped(value,1),
		str(snapped(fish_size,0.1),"cm"),
		Globals.knife_sell
	]); return Globals.knife_entity

## Add glowing night winder
func glow():
	var base = 240
	fish_size = rng.randf_range(1.5, 3)
	var value = base + (fish_size*15)
	fish_array = Globals.pond_caught
	fish_name = "Glow"; fish_token = "m"
	Globals.fish.append([
		Globals.glow_inv,
		snapped(value,1),
		str(snapped(fish_size,0.1),"m"),
		Globals.glow_sell
	]); return Globals.glow_entity

#endregion

#region EPIC

#################################################################################
##                                  EPIC                                       ##
#################################################################################

## Add zebra pleco
func zebra():
	var base = 380
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

## Add paddlefish
func padd():
	var base = 370
	fish_size = rng.randf_range(1.5, 2)
	var value = base + (fish_size*15)
	fish_array = Globals.pond_caught
	fish_name = "Padd"; fish_token = "m"
	Globals.fish.append([
		Globals.padd_inv,
		snapped(value,1),
		str(snapped(fish_size,0.1),"m"),
		Globals.padd_sell
	]); return Globals.padd_entity

## Add home runner
func home():
	var base = 390
	fish_size = rng.randf_range(5, 10)
	var value = base + (fish_size)
	fish_array = Globals.pond_caught
	fish_name = "Home"; fish_token = "cm"
	Globals.fish.append([
		Globals.home_inv,
		snapped(value,1),
		str(snapped(fish_size,0.1),"cm"),
		Globals.home_sell
	]); return Globals.home_entity

## Add cloud dancer
func cloud():
	var base = 385
	fish_size = rng.randf_range(40, 80)
	var value = base + (fish_size)
	fish_array = Globals.pond_caught
	fish_name = "Cloud"; fish_token = "cm"
	Globals.fish.append([
		Globals.cloud_inv,
		snapped(value,1),
		str(snapped(fish_size,0.1),"cm"),
		Globals.cloud_sell
	]); return Globals.cloud_entity

## Add swirlback turtle
func swirl():
	var base = 360
	fish_size = rng.randf_range(15, 30)
	var value = base + (fish_size*2)
	fish_array = Globals.pond_caught
	fish_name = "Swirl"; fish_token = "cm"
	Globals.fish.append([
		Globals.swirl_inv,
		snapped(value,1),
		str(snapped(fish_size,0.1),"cm"),
		Globals.swirl_sell
	]); return Globals.swirl_entity

## Add glowing nighteye
func night():
	var base = 390
	fish_size = rng.randf_range(70, 120)
	var value = base + (fish_size)
	fish_array = Globals.pond_caught
	fish_name = "Night"; fish_token = "cm"
	Globals.fish.append([
		Globals.night_inv,
		snapped(value,1),
		str(snapped(fish_size,0.1),"cm"),
		Globals.night_sell
	]); return Globals.night_entity

## Add violet goby
func violet():
	var base = 380
	fish_size = rng.randf_range(30, 60)
	var value = base + (fish_size)
	fish_array = Globals.pond_caught
	fish_name = "Violet"; fish_token = "cm"
	Globals.fish.append([
		Globals.violet_inv,
		snapped(value,1),
		str(snapped(fish_size,0.1),"cm"),
		Globals.violet_sell
	]); return Globals.violet_entity

## add diamond darter
func dart():
	var base = 385
	fish_size = rng.randf_range(10, 15)
	var value = base + (fish_size*5)
	fish_array = Globals.pond_caught
	fish_name = "Dart"; fish_token = "cm"
	Globals.fish.append([
		Globals.dart_inv,
		snapped(value,1),
		str(snapped(fish_size,0.1),"cm"),
		Globals.dart_sell
	]); return Globals.dart_entity

## add golden mahseer
func gold():
	var base = 390
	fish_size = rng.randf_range(1.5, 3)
	var value = base + (fish_size*15)
	fish_array = Globals.pond_caught
	fish_name = "Gold"; fish_token = "m"
	Globals.fish.append([
		Globals.gold_inv,
		snapped(value,1),
		str(snapped(fish_size,0.1),"m"),
		Globals.gold_sell
	]); return Globals.gold_entity

#endregion

#region LEGENDARY

#################################################################################
##                                LEGENDARY                                    ##
#################################################################################

## add dreamcatcher
func dream():
	var base = 750
	fish_size = rng.randf_range(50, 80)
	var value = base + (fish_size)
	fish_array = Globals.pond_caught
	fish_name = "Dream"; fish_token = "cm"
	Globals.fish.append([
		Globals.dream_inv,
		snapped(value,1),
		str(snapped(fish_size,0.1),"cm"),
		Globals.dream_sell
	]); return Globals.dream_entity

## add giant barb
func barb():
	var base = 780
	fish_size = rng.randf_range(2, 3)
	var value = base + (fish_size*30)
	fish_array = Globals.pond_caught
	fish_name = "Barb"; fish_token = "m"
	Globals.fish.append([
		Globals.barb_inv,
		snapped(value,1),
		str(snapped(fish_size,0.1),"m"),
		Globals.barb_sell
	]); return Globals.barb_entity

## add dragonfish
func dragon():
	var base = 800
	fish_size = rng.randf_range(5, 8)
	var value = base + (fish_size)
	fish_array = Globals.pond_caught
	fish_name = "Dragon"; fish_token = "m"
	Globals.fish.append([
		Globals.dragon_inv,
		snapped(value,1),
		str(snapped(fish_size,0.1),"m"),
		Globals.dragon_sell
	]); return Globals.dragon_entity

## add cosmic
func cosmic():
	var base = 780
	fish_size = rng.randf_range(60, 90)
	var value = base + (fish_size)
	fish_array = Globals.pond_caught
	fish_name = "Cosmic"; fish_token = "cm"
	Globals.fish.append([
		Globals.cosmic_inv,
		snapped(value,1),
		str(snapped(fish_size,0.1),"cm"),
		Globals.cosmic_sell
	]); return Globals.cosmic_entity

## add jackson pollock
func jack():
	var base = 760
	fish_size = rng.randf_range(30, 50)
	var value = base + (fish_size)
	fish_array = Globals.pond_caught
	fish_name = "Jack"; fish_token = "cm"
	Globals.fish.append([
		Globals.jack_inv,
		snapped(value,1),
		str(snapped(fish_size,0.1),"cm"),
		Globals.jack_sell
	]); return Globals.jack_entity

#endregion
