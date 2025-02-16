extends Node

const sturgeon = preload("res://res/fishes/sturgeon/sturgeon_inv.tscn")
const minnow = preload("res://res/fishes/minnow/minnow_inv.tscn")
const zebra = preload("res://res/fishes/zebra/zebra_inv.tscn")
const bass = preload("res://res/fishes/bass/bass_inv.tscn")

const bass_sell = preload("res://res/fishes/bass/bass_sell.tscn")
const minnow_sell = preload("res://res/fishes/minnow/minnow_sell.tscn")
const sturgeon_sell = preload("res://res/fishes/sturgeon/sturgeon_sell.tscn")
const zebra_sell = preload("res://res/fishes/zebra/zebra_sell.tscn")

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

const rod_one_inv = preload("res://res/equip/rods/rod_one/rod_one_inv.tscn")
const rod_one_icon = preload("res://res/equip/rods/rod_one/rod_one_icon.tscn")


var money = 500000
var speed = 450
var stop_cast = false
var time_of_day = 900
var cast_speed = 400
var inv_space = 10

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
var has_rod_thr = false

var equip_info = true
var shops_info = true
var mechs_info = true

var shop_type = "Fish"
var equip_page = "Bait"

var upgrade_bar = 0
var upgrade_prog = 0
var upgrade_cast = 0
var upgrade_loss = 0
var upgrade_pack = 0

var pond_caught = []

var lure = []
var bait = []
var fish = []


#region SETUP

func _ready() -> void:
	set_settings()

func set_settings() -> void:
	AudioServer.set_bus_volume_db(0, log(sett_master)*20)
	AudioServer.set_bus_volume_db(1, log(sett_player)*20)
	AudioServer.set_bus_volume_db(2, log(sett_music)*20)
	AudioServer.set_bus_volume_db(3, log(sett_sfx)*20)
	AudioServer.set_bus_volume_db(4, log(sett_ambi)*20)

#endregion
