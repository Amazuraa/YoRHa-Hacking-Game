# enemy type 1C
# shoot two type of bullet, not pointing at player, and not moving
extends KinematicBody2D

var motion = Vector2()
export var MOTION_SPEED = 70
var timer_rot = 0.0

var player_node

### bullets
export (PackedScene) var bullet1_tscn
export (PackedScene) var bullet2_tscn

var bullet_inst

onready var bullet_container = utils.main_node().get_node("bullet_container")
onready var muzzle = get_node("muzzle")
var timer = 0.0
export var delay = 1.0
var type_bullet  = 1
var count_bullet = -1
export var switch_bullet = 5

### rotating
var angel_in_degree = 0
var new_pos_rotation = Vector2()
var deg = 0.0
export var rotating_speed = 50.0

### health
export var total_health = 1

### active-state
var active_state = true
var active_state_prev = true
var active_state_next = true

### explosion
var explosion_tscn
var explosion_inst
onready var explosion_container = utils.main_node().get_node("explosion_container")

### hit
export (PackedScene) var hit_tscn
var hit_inst

### shield
export var is_the_core_shielding = false
var shield_tscn
var shield_inst
var shield_container 

### rotating
export var rotating = true

### sfx
export (PackedScene) var sfx_tscn_e
var sfx_inst_e
export (PackedScene) var sfx_tscn_h
var sfx_inst_h
export (PackedScene) var sfx_tscn_s
var sfx_inst_s
onready var sfx_container = utils.main_node().get_node("sfx_container")

var volume_state = null

func _ready():
	timer = delay
	add_to_group("enemy")
	set_process(true)
	shielding()
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
	
	if rotating == true:
		rotating_muzzle(delta)
	elif rotating == false:
		look_at_player(delta)
	
	timer -= delta
	shooting()
	pass

###===================================================================

func look_at_player(delta):
	# this script has same method to 'look_at()'
	# or maybe the 'look_at()' in manual way :v
	
	var target_x
	var target_y
	var angel
	
	player_node = utils.main_node().get_node("player_container/player")
	
	if player_node == null :
		target_x = get_global_mouse_pos().x
		target_y = get_global_mouse_pos().y
		
	elif player_node != null : 
		target_x = player_node.get_global_pos().x
		target_y = player_node.get_global_pos().y
	
	angel = atan2((target_x - get_global_pos().x) , (target_y - get_global_pos().y ))
	angel = angel + (PI/1)
	
	set_rot(angel)
	pass

###===================================================================

func rotating_muzzle(delta):
	deg = fmod(deg + rotating_speed * delta, 360.0)
	
	### rotation control
	new_pos_rotation.x = cos(deg2rad(deg) - (PI/2)) # direction to clockwise
	new_pos_rotation.y = sin(deg2rad(deg) - (PI/2)) # direction to clockwise
	new_pos_rotation   = new_pos_rotation           # start at 0 degree 
	
	set_rot(deg2rad(deg))
	pass

###===================================================================

func shooting():
	if timer <= 0 :
		timer = delay
		count_bullet += 1
		
		if count_bullet == switch_bullet:
			type_bullet += 1
			if type_bullet > 2:
				type_bullet = 1
			
			count_bullet = 0
		
		bullet_type()
		bullet_container.add_child(bullet_inst)
		bullet_inst.start_at( get_rot(), muzzle.get_global_pos() )
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

func bullet_type():
	if type_bullet == 1:
		bullet_inst = bullet1_tscn.instance()
	elif type_bullet == 2:
		bullet_inst = bullet2_tscn.instance()
	pass

###===================================================================

func hit():
	sfx_hit()
	hit_inst = hit_tscn.instance()
	utils.main_node().get_node("hit_container").add_child(hit_inst)
	hit_inst.set_pos(get_global_pos())
	hit_inst.play("core_hit")
	
	total_health -= 1
	if total_health == 0:
		explode()
	pass

###===================================================================

func sfx_hit():
	sfx_inst_h = sfx_tscn_h.instance()
	sfx_container.add_child(sfx_inst_h)
	sfx_inst_h.play("core_hit")
	pass

###===================================================================

func explode():
	sfx_explode()
	explosion_tscn = preload("res://scenes/core_explosion.tscn")
	explosion_inst = explosion_tscn.instance()
	explosion_container.add_child(explosion_inst)
	explosion_inst.set_pos(get_global_pos())
	explosion_inst.play("core_explosion")
	queue_free()
	pass

###===================================================================

func sfx_explode():
	sfx_inst_e = sfx_tscn_e.instance()
	sfx_container.add_child(sfx_inst_e)
	sfx_inst_e.play("core_explode")
	pass

###===================================================================

func shielding():
	if is_the_core_shielding == true:
		shield_tscn = preload("res://scenes/core_shield.tscn")
		shield_inst = shield_tscn.instance()
		shield_container = get_node("shield")
		shield_container.add_child(shield_inst)
		shield_inst.play("core_shield")
	elif is_the_core_shielding == false:
		return
	pass

###===================================================================

func _on_notifier_enter_screen():
	volume_state = "up"
	pass

func _on_notifier_exit_screen():
	volume_state = "down"
	pass
