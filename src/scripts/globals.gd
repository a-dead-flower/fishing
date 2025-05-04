extends Node

const eel_inv = preload("res://res/fishes/eel/eel_inv.tscn")
const bass_inv = preload("res://res/fishes/bass/bass_inv.tscn")
const ruby_inv = preload("res://res/fishes/ruby/ruby_inv.tscn")
const sapp_inv = preload("res://res/fishes/sapp/sapp_inv.tscn")
const chub_inv = preload("res://res/fishes/chub/chub_inv.tscn")
const neon_inv = preload("res://res/fishes/neon/neon_inv.tscn")
const pike_inv = preload("res://res/fishes/pike/pike_inv.tscn")
const drum_inv = preload("res://res/fishes/drum/drum_inv.tscn")
const musk_inv = preload("res://res/fishes/musk/musk_inv.tscn")
const carp_inv = preload("res://res/fishes/carp/carp_inv.tscn")
const lgar_inv = preload("res://res/fishes/lgar/lgar_inv.tscn")
const ssun_inv = preload("res://res/fishes/ssun/ssun_inv.tscn")
const catf_inv = preload("res://res/fishes/catf/catf_inv.tscn")
const bfin_inv = preload("res://res/fishes/bfin/bfin_inv.tscn")
const rhop_inv = preload("res://res/fishes/rhop/rhop_inv.tscn")
const saug_inv = preload("res://res/fishes/saug/saug_inv.tscn")
const moon_inv = preload("res://res/fishes/moon/moon_inv.tscn")
const bjaw_inv = preload("res://res/fishes/bjaw/bjaw_inv.tscn")
const moss_inv = preload("res://res/fishes/moss/moss_inv.tscn")
const agar_inv = preload("res://res/fishes/agar/agar_inv.tscn")
const sock_inv = preload("res://res/fishes/sock/sock_inv.tscn")
const gala_inv = preload("res://res/fishes/gala/gala_inv.tscn")
const redc_inv = preload("res://res/fishes/redc/redc_inv.tscn")
const bulb_inv = preload("res://res/fishes/bulb/bulb_inv.tscn")
const snap_inv = preload("res://res/fishes/snap/snap_inv.tscn")
const glow_inv = preload("res://res/fishes/glow/glow_inv.tscn")
const knife_inv = preload("res://res/fishes/knife/knife_inv.tscn")
const afish_inv = preload("res://res/fishes/afish/afish_inv.tscn")
const cpick_inv = preload("res://res/fishes/cpick/cpick_inv.tscn")
const perch_inv = preload("res://res/fishes/perch/perch_inv.tscn")
const bgill_inv = preload("res://res/fishes/bgill/bgill_inv.tscn")
const zebra_inv = preload("res://res/fishes/zebra/zebra_inv.tscn")
const guppy_inv = preload("res://res/fishes/guppy/guppy_inv.tscn")
const wcrap_inv = preload("res://res/fishes/wcrap/wcrap_inv.tscn")
const bullh_inv = preload("res://res/fishes/bullh/bullh_inv.tscn")
const bream_inv = preload("res://res/fishes/bream/bream_inv.tscn")
const brook_inv = preload("res://res/fishes/brook/brook_inv.tscn")
const bcrap_inv = preload("res://res/fishes/bcrap/bcrap_inv.tscn")
const belly_inv = preload("res://res/fishes/belly/belly_inv.tscn")
const asnap_inv = preload("res://res/fishes/asnap/asnap_inv.tscn")
const sturg_inv = preload("res://res/fishes/sturg/sturg_inv.tscn")
const atlan_inv = preload("res://res/fishes/atlan/atlan_inv.tscn")
const minnow_inv = preload("res://res/fishes/minnow/minnow_inv.tscn")
const aperch_inv = preload("res://res/fishes/aperch/aperch_inv.tscn")
const btrout_inv = preload("res://res/fishes/btrout/btrout_inv.tscn")
const rtrout_inv = preload("res://res/fishes/rtrout/rtrout_inv.tscn")
const walleye_inv = preload("res://res/fishes/walleye/walleye_inv.tscn")

const eel_sell = preload("res://res/fishes/eel/eel_sell.tscn")
const ssun_sell = preload("res://res/fishes/ssun/ssun_sell.tscn")
const bass_sell = preload("res://res/fishes/bass/bass_sell.tscn")
const ruby_sell = preload("res://res/fishes/ruby/ruby_sell.tscn")
const sapp_sell = preload("res://res/fishes/sapp/sapp_sell.tscn")
const chub_sell = preload("res://res/fishes/chub/chub_sell.tscn")
const neon_sell = preload("res://res/fishes/neon/neon_sell.tscn")
const pike_sell = preload("res://res/fishes/pike/pike_sell.tscn")
const drum_sell = preload("res://res/fishes/drum/drum_sell.tscn")
const musk_sell = preload("res://res/fishes/musk/musk_sell.tscn")
const carp_sell = preload("res://res/fishes/carp/carp_sell.tscn")
const lgar_sell = preload("res://res/fishes/lgar/lgar_sell.tscn")
const catf_sell = preload("res://res/fishes/catf/catf_sell.tscn")
const rhop_sell = preload("res://res/fishes/rhop/rhop_sell.tscn")
const saug_sell = preload("res://res/fishes/saug/saug_sell.tscn")
const bfin_sell = preload("res://res/fishes/bfin/bfin_sell.tscn")
const moon_sell = preload("res://res/fishes/moon/moon_sell.tscn")
const bjaw_sell = preload("res://res/fishes/moon/moon_sell.tscn")
const moss_sell = preload("res://res/fishes/moss/moss_sell.tscn")
const agar_sell = preload("res://res/fishes/agar/agar_sell.tscn")
const sock_sell = preload("res://res/fishes/sock/sock_sell.tscn")
const gala_sell = preload("res://res/fishes/gala/gala_sell.tscn")
const redc_sell = preload("res://res/fishes/redc/redc_sell.tscn")
const bulb_sell = preload("res://res/fishes/bulb/bulb_sell.tscn")
const snap_sell = preload("res://res/fishes/snap/snap_sell.tscn")
const glow_sell = preload("res://res/fishes/glow/glow_sell.tscn")
const knife_sell = preload("res://res/fishes/knife/knife_sell.tscn")
const afish_sell = preload("res://res/fishes/afish/afish_sell.tscn")
const cpick_sell = preload("res://res/fishes/cpick/cpick_sell.tscn")
const bream_sell = preload("res://res/fishes/bream/bream_sell.tscn")
const belly_sell = preload("res://res/fishes/belly/belly_sell.tscn")
const wcrap_sell = preload("res://res/fishes/wcrap/wcrap_sell.tscn")
const brook_sell = preload("res://res/fishes/brook/brook_sell.tscn")
const bcrap_sell = preload("res://res/fishes/bcrap/bcrap_sell.tscn")
const bullh_sell = preload("res://res/fishes/bullh/bullh_sell.tscn")
const bgill_sell = preload("res://res/fishes/bgill/bgill_sell.tscn")
const perch_sell = preload("res://res/fishes/perch/perch_sell.tscn")
const asnap_sell = preload("res://res/fishes/asnap/asnap_sell.tscn")
const zebra_sell = preload("res://res/fishes/zebra/zebra_sell.tscn")
const guppy_sell = preload("res://res/fishes/guppy/guppy_sell.tscn")
const sturg_sell = preload("res://res/fishes/sturg/sturg_sell.tscn")
const atlan_sell = preload("res://res/fishes/atlan/atlan_sell.tscn")
const btrout_sell = preload("res://res/fishes/btrout/btrout_sell.tscn")
const rtrout_sell = preload("res://res/fishes/rtrout/rtrout_sell.tscn")
const aperch_sell = preload("res://res/fishes/aperch/aperch_sell.tscn")
const minnow_sell = preload("res://res/fishes/minnow/minnow_sell.tscn")
const walleye_sell = preload("res://res/fishes/walleye/walleye_sell.tscn")

const eel_entity = preload("res://res/fishes/eel/eel_entity.tscn")
const bass_entity = preload("res://res/fishes/bass/bass_entity.tscn")
const ruby_entity = preload("res://res/fishes/ruby/ruby_entity.tscn")
const sapp_entity = preload("res://res/fishes/sapp/sapp_entity.tscn")
const bfin_entity = preload("res://res/fishes/bfin/bfin_entity.tscn")
const chub_entity = preload("res://res/fishes/chub/chub_entity.tscn")
const neon_entity = preload("res://res/fishes/neon/neon_entity.tscn")
const pike_entity = preload("res://res/fishes/pike/pike_entity.tscn")
const drum_entity = preload("res://res/fishes/drum/drum_entity.tscn")
const musk_entity = preload("res://res/fishes/musk/musk_entity.tscn")
const carp_entity = preload("res://res/fishes/carp/carp_entity.tscn")
const lgar_entity = preload("res://res/fishes/lgar/lgar_entity.tscn")
const ssun_entity = preload("res://res/fishes/ssun/ssun_entity.tscn")
const catf_entity = preload("res://res/fishes/catf/catf_entity.tscn")
const rhop_entity = preload("res://res/fishes/rhop/rhop_entity.tscn")
const saug_entity = preload("res://res/fishes/saug/saug_entity.tscn")
const moon_entity = preload("res://res/fishes/moon/moon_entity.tscn")
const bjaw_entity = preload("res://res/fishes/bjaw/bjaw_entity.tscn")
const moss_entity = preload("res://res/fishes/moss/moss_entity.tscn")
const agar_entity = preload("res://res/fishes/agar/agar_entity.tscn")
const sock_entity = preload("res://res/fishes/sock/sock_entity.tscn")
const gala_entity = preload("res://res/fishes/gala/gala_entity.tscn")
const redc_entity = preload("res://res/fishes/redc/redc_entity.tscn")
const bulb_entity = preload("res://res/fishes/bulb/bulb_entity.tscn")
const snap_entity = preload("res://res/fishes/snap/snap_entity.tscn")
const glow_entity = preload("res://res/fishes/glow/glow_entity.tscn")
const knife_entity = preload("res://res/fishes/knife/knife_entity.tscn")
const atlan_entity = preload("res://res/fishes/atlan/atlan_entity.tscn")
const afish_entity = preload("res://res/fishes/afish/afish_entity.tscn")
const cpick_entity = preload("res://res/fishes/cpick/cpick_entity.tscn")
const belly_entity = preload("res://res/fishes/belly/belly_entity.tscn")
const wcrap_entity = preload("res://res/fishes/wcrap/wcrap_entity.tscn")
const bgill_entity = preload("res://res/fishes/bgill/bgill_entity.tscn")
const bullh_entity = preload("res://res/fishes/bullh/bullh_entity.tscn")
const brook_entity = preload("res://res/fishes/brook/brook_entity.tscn")
const asnap_entity = preload("res://res/fishes/asnap/asnap_entity.tscn")
const bcrap_entity = preload("res://res/fishes/bcrap/bcrap_entity.tscn")
const guppy_entity = preload("res://res/fishes/guppy/guppy_entity.tscn")
const bream_entity = preload("res://res/fishes/bream/bream_entity.tscn")
const zebra_entity = preload("res://res/fishes/zebra/zebra_entity.tscn")
const perch_entity = preload("res://res/fishes/perch/perch_entity.tscn")
const sturg_entity = preload("res://res/fishes/sturg/sturg_entity.tscn")
const minnow_entity = preload("res://res/fishes/minnow/minnow_entity.tscn")
const aperch_entity = preload("res://res/fishes/aperch/aperch_entity.tscn")
const btrout_entity = preload("res://res/fishes/btrout/btrout_entity.tscn")
const rtrout_entity = preload("res://res/fishes/rtrout/rtrout_entity.tscn")
const walleye_entity = preload("res://res/fishes/walleye/walleye_entity.tscn")

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
var bonus_rng = 0

var sett_scale = 2
var sett_zoom = 1
var sett_master = 0.7
var sett_music = 0.7
var sett_sfx = 0.7
var sett_ambi = 0.7
var sett_player= 0.7
var sett_vsync = true
var sett_mute = false
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
	Spawn.walleye()
	Spawn.minnow()
	Spawn.aperch()
	Spawn.btrout()
	Spawn.rtrout()
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
	Spawn.asnap()
	Spawn.cpick()
	Spawn.sturg()
	Spawn.afish()
	Spawn.atlan()
	Spawn.knife()
	Spawn.glow()
	Spawn.snap()
	Spawn.bulb()
	Spawn.redc()
	Spawn.gala()
	Spawn.sock()
	Spawn.agar()
	Spawn.moss()
	Spawn.bjaw()
	Spawn.moon()
	Spawn.rhop()
	Spawn.saug()
	Spawn.bfin()
	Spawn.catf()
	Spawn.bass()
	Spawn.ssun()
	Spawn.neon()
	Spawn.drum()
	Spawn.pike()
	Spawn.chub()
	Spawn.sapp()
	Spawn.ruby()
	Spawn.musk()
	Spawn.carp()
	Spawn.lgar()
	Spawn.eel()


#endregion
