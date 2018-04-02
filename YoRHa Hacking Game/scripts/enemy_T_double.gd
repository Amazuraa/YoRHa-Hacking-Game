# enemy type T (tower)
# not moving, not poiting player, only shooting (on type of bullet)
extends KinematicBody2D

var player_node

### bullets
export (PackedScene) var bullet_tscn
var bullet_inst
export (PackedScene) var bullet_tscn1
var bullet_inst1
onready var bullet_container = utils.main_node().get_node("bullet_container")
onready var muzzle = get_node("muzzle")
onready var muzzle1 = get_node("muzzle1")
var timer = 0.0
export var delay = 1.0

### health
export var total_health = 1

### explosion
var explosion_tscn
var explosion_inst
onready var explosion_container = utils.main_node().get_node("explosion_container")

### active-state
var active_state = true
var active_state_prev = true
var active_state_next = true

### rotating
var angel_in_degree = 0
var new_pos_rotation = Vector2()
var new_pos_rotation1 = Vector2()
export var degree = 0.0
export var degree1 = 0.0
export var rotating_speed = 50.0

export var rotating = false
export var rotating_clockwise = false

### sfx
export (PackedScene) var sfx_tscn_e
var sfx_inst_e
export (PackedScene) var sfx_tscn_s
var sfx_inst_s
onready var sfx_container = utils.main_node().get_node("sfx_container")

var volume_state = null

func _ready():
	timer = delay
	add_to_group("enemy")
	set_process(true)
	pass

func _process(delta):
	active_state_prev = active_state
	active_state = active_state_next
	
	if active_state == true:
		set_fixed_process(true)
	elif active_state == false:
		set_fixed_process(false)
	pass

func _fixed_process(delta):
	
	rotating_muzzle(delta)
	timer -= delta
	shooting()
	
	pass

###===================================================================

func shooting():
	if timer <= 0 :
		timer = delay
		
		bullet_inst = bullet_tscn.instance()
		bullet_inst1 = bullet_tscn1.instance()
		bullet_container.add_child(bullet_inst)
		bullet_container.add_child(bullet_inst1)
		bullet_inst.start_at( muzzle.get_rot(), muzzle.get_global_pos() )
		bullet_inst1.start_at( muzzle1.get_rot(), muzzle1.get_global_pos() )
		sfx_shoot()
		return
	pass

###===================================================================

func sfx_shoot():
	sfx_inst_s = sfx_tscn_s.instance()
	sfx_container.add_child(sfx_inst_s)
	
	if volume_state == "up":
		sfx_inst_s.set_default_volume_db(0)
	elif volume_state == "down":
		sfx_inst_s.set_default_volume_db(-30)
	
	sfx_inst_s.play("enemy_shoot")
	pass

###===================================================================

func rotating_muzzle(delta):
	
	if rotating == true:
		degree = fmod(degree + rotating_speed * delta, 360.0)
		degree1 = fmod(degree1 + rotating_speed * delta, 360.0)
	elif rotating == false:
		degree
		degree1
	
	### rotation control
	new_pos_rotation.x = cos(deg2rad(degree) - (PI/2))
	new_pos_rotation.y = sin(deg2rad(degree) - (PI/2))
	new_pos_rotation   = new_pos_rotation * 70          
	
	### rotation control2
	new_pos_rotation1.x = cos(deg2rad(degree1) - (PI/2))
	new_pos_rotation1.y = sin(deg2rad(degree1) - (PI/2))
	new_pos_rotation1   = new_pos_rotation1 * 70 
	
	
	if rotating_clockwise == true:
		muzzle.set_rot(deg2rad(-degree))
		muzzle.set_pos(new_pos_rotation)
		muzzle1.set_rot(deg2rad(-degree1))
		muzzle1.set_pos(new_pos_rotation1)
		
	elif rotating_clockwise == false:
		muzzle.set_rot(deg2rad(-degree))
		muzzle.set_pos(new_pos_rotation)
		muzzle1.set_rot(deg2rad(-degree1))
		muzzle1.set_pos(new_pos_rotation1)
		
	pass

###===================================================================

func hit():
	total_health -= 1
	if total_health == 0:
		explode()
	pass

###===================================================================

func explode():
	sfx_explode()
	explosion_tscn = preload("res://scenes/enemy_explosion_type1.tscn")
	explosion_inst = explosion_tscn.instance()
	explosion_container.add_child(explosion_inst)
	explosion_inst.set_pos(get_global_pos())
	explosion_inst.play("explode")
	queue_free()
	pass

###===================================================================

func sfx_explode():
	sfx_inst_e = sfx_tscn_e.instance()
	sfx_container.add_child(sfx_inst_e)
	sfx_inst_e.play("enemy_explode")
	pass

func _on_notifier_enter_screen():
	volume_state = "up"
	pass

func _on_notifier_exit_screen():
	volume_state = "down"
	pass
