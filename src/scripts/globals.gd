extends Node

const bass = preload("res://res/fishes/bass/bass_inv.tscn")
const ruby = preload("res://res/fishes/ruby/ruby_inv.tscn")
const sapp = preload("res://res/fishes/sapp/sapp_inv.tscn")
const chub = preload("res://res/fishes/chub/chub_inv.tscn")
const neon = preload("res://res/fishes/neon/neon_inv.tscn")
const pike = preload("res://res/fishes/pike/pike_inv.tscn")
const drum = preload("res://res/fishes/drum/drum_inv.tscn")
const musk = preload("res://res/fishes/musk/musk_inv.tscn")
const perch = preload("res://res/fishes/perch/perch_inv.tscn")
const bgill = preload("res://res/fishes/bgill/bgill_inv.tscn")
const zebra = preload("res://res/fishes/zebra/zebra_inv.tscn")
const guppy = preload("res://res/fishes/guppy/guppy_inv.tscn")
const wcrap = preload("res://res/fishes/wcrap/wcrap_inv.tscn")
const bullh = preload("res://res/fishes/bullh/bullh_inv.tscn")
const bream = preload("res://res/fishes/bream/bream_inv.tscn")
const brook = preload("res://res/fishes/brook/brook_inv.tscn")
const bcrap = preload("res://res/fishes/bcrap/bcrap_inv.tscn")
const belly = preload("res://res/fishes/belly/belly_inv.tscn")
const minnow = preload("res://res/fishes/minnow/minnow_inv.tscn")
const walleye = preload("res://res/fishes/walleye/walleye_inv.tscn")
const sturgeon = preload("res://res/fishes/sturgeon/sturgeon_inv.tscn")

const bass_sell = preload("res://res/fishes/bass/bass_sell.tscn")
const ruby_sell = preload("res://res/fishes/ruby/ruby_sell.tscn")
const sapp_sell = preload("res://res/fishes/sapp/sapp_sell.tscn")
const chub_sell = preload("res://res/fishes/chub/chub_sell.tscn")
const neon_sell = preload("res://res/fishes/neon/neon_sell.tscn")
const pike_sell = preload("res://res/fishes/pike/pike_sell.tscn")
const drum_sell = preload("res://res/fishes/drum/drum_sell.tscn")
const musk_sell = preload("res://res/fishes/musk/musk_sell.tscn")
const bream_sell = preload("res://res/fishes/bream/bream_sell.tscn")
const belly_sell = preload("res://res/fishes/belly/belly_sell.tscn")
const wcrap_sell = preload("res://res/fishes/wcrap/wcrap_sell.tscn")
const brook_sell = preload("res://res/fishes/brook/brook_sell.tscn")
const bcrap_sell = preload("res://res/fishes/bcrap/bcrap_sell.tscn")
const bullh_sell = preload("res://res/fishes/bullh/bullh_sell.tscn")
const bgill_sell = preload("res://res/fishes/bgill/bgill_sell.tscn")
const perch_sell = preload("res://res/fishes/perch/perch_sell.tscn")
const zebra_sell = preload("res://res/fishes/zebra/zebra_sell.tscn")
const guppy_sell = preload("res://res/fishes/guppy/guppy_sell.tscn")
const minnow_sell = preload("res://res/fishes/minnow/minnow_sell.tscn")
const walleye_sell = preload("res://res/fishes/walleye/walleye_sell.tscn")
const sturgeon_sell = preload("res://res/fishes/sturgeon/sturgeon_sell.tscn")


const grub_inv = preload("res://res/equip/bait/grub/grub_inv.tscn")
const grub_icon = preload("res://res/equip/bait/grub/grub_icon.tscn")
const grub_sell = preload("res://res/equip/bait/grub/grub_sell.tscn")

const worm_inv = preload("res://res/equip/bait/worm/worm_inv.tscn")
const worm_icon = preload("res://res/equip/bait/worm/worm_icon.tscn")
const worm_sell = preload("res://res/equip/bait/worm/worm_sell.tscn")

const blue_inv = preload("res://res/equip/lure/blue/blue_inv.tscn")
const blue_icon = preload("res://res/equip/lure/blue/blue_icon.tscn")
const blue_sell = preload("res://res/equip/lure/blue/blue_sell.tscn")


const empty_inv = preload("res://src/scenes/empty.tscn")

const rod_one_inv = preload("res://res/equip/rods/rod_1/rod_1_inv.tscn")
const rod_one_icon = preload("res://res/equip/rods/rod_1/rod_1_icon.tscn")
const rod_two_inv = preload("res://res/equip/rods/rod_2/rod_2_inv.tscn")
const rod_two_icon = preload("res://res/equip/rods/rod_2/rod_2_icon.tscn")
const rod_three_inv = preload("res://res/equip/rods/rod_3/rod_3_inv.tscn")
const rod_three_icon = preload("res://res/equip/rods/rod_3/rod_3_icon.tscn")


var money = 500000
var speed = 450
var stop_cast = false
var time_of_day = 900
var cast_speed = 400
var inv_space = 100

var sett_scale = 2
var sett_zoom = 1
var sett_master = 0.7
var sett_music = 0.7
var sett_sfx = 0.7
var sett_ambi = 0.7
var sett_player= 0.7
var sett_vsync = true
var sett_mute = true
var sett_window = "Windowed"

var keys_up = "W"
var keys_down = "S"
var keys_left = "A"
var keys_right = "D"
var keys_inv = "E"
var keys_int = "Space"

var current_rod = ""
var current_bait = ""
var current_lure = ""

var has_rod_one = true
var has_rod_two = false
var has_rod_the = false

var equip_info = true
var shops_info = true
var mechs_info = true

var shop_type = "Fish"
var equip_page = "Bait"

var upgrade_bar = 0
var upgrade_prog = 0
var upgrade_cast = 0
var upgrade_loss = 0
var upgrade_pack = 5

var pond_caught = []

var lure = []
var bait = []
var fish = []


#region SETUP

func _ready() -> void:
	add_test_fish()
	set_settings()

func set_settings() -> void:
	AudioServer.set_bus_volume_db(0, log(sett_master)*20)
	AudioServer.set_bus_volume_db(1, log(sett_player)*20)
	AudioServer.set_bus_volume_db(2, log(sett_music)*20)
	AudioServer.set_bus_volume_db(3, log(sett_sfx)*20)
	AudioServer.set_bus_volume_db(4, log(sett_ambi)*20)

func add_test_fish():
	Spawn.sturgeon()
	Spawn.walleye()
	Spawn.minnow()
	Spawn.zebra()
	Spawn.bream()
	Spawn.bcrap()
	Spawn.perch()
	Spawn.guppy()
	Spawn.belly()
	Spawn.wcrap()
	Spawn.bgill()
	Spawn.bullh()
	Spawn.brook()
	Spawn.bass()
	Spawn.neon()
	Spawn.drum()
	Spawn.pike()
	Spawn.chub()
	Spawn.sapp()
	Spawn.ruby()
	Spawn.musk()


#endregion
