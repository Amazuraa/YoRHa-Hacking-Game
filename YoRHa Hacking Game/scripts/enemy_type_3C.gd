# enemy type 3C
# shoot two type of bullet, not pointing at player, and moving to player
extends KinematicBody2D

var motion = Vector2()
export var MOTION_SPEED = 70
var timer_rot = 0.0

var player_node

### bullets
export (PackedScene) var bullet1_tscn
export (PackedScene) var bullet2_tscn

var bullet_inst
var bullet_inst2
var bullet_inst3
var bullet_inst4

onready var bullet_container = utils.main_node().get_node("bullet_container")
onready var muzzle1 = get_node("muzzle1")
onready var muzzle2 = get_node("muzzle2")
onready var muzzle3 = get_node("muzzle3")
onready var muzzle4 = get_node("muzzle4")

var timer = 0.0
export var delay = 1.0
var type_bullet  = 1
var count_bullet = -1
export var switch_bullet = 5

### rotating
var angel_in_degree = 0
var pos_rotation       = Vector2()
var pos_rotation2      = Vector2()
var new_pos_rotation   = Vector2()
var new_pos_rotation2  = Vector2()
var new_pos_rotation3  = Vector2()
var new_pos_rotation4  = Vector2()
export var deg = 0.0
export var rotating_speed = 50.0
export var is_it_rotating = true

### health
export var total_health = 1

var target_x
var target_y
var target_pos = Vector2()

### active-state
var active_state = true
var active_state_prev = true
var active_state_next = true

### moving-state
export var is_it_moving = true

### explosion
export (PackedScene) var explosion_tscn
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
	
	if is_it_moving == true:
		follow_player()
		moving(delta)
	elif is_it_moving == false:
		pass
	
	rotating_muzzle(delta)
	timer -= delta
	shooting()
	pass

###===================================================================

func follow_player():
	# find player or mouse position and follow them 
	
	player_node = utils.main_node().get_node("player_container/player")
	
	if player_node == null :
		target_x = get_global_mouse_pos().x
		target_y = get_global_mouse_pos().y
		
	elif player_node != null : 
		target_x = player_node.get_global_pos().x
		target_y = player_node.get_global_pos().y
	
	target_pos = Vector2((target_x - get_global_pos().x) , (target_y - get_global_pos().y ))
	pass

###===================================================================

func moving(delta):
	motion += target_pos
	motion = motion.normalized()
	motion = motion.normalized()*MOTION_SPEED*delta
	motion = move(motion)
	
	var slide_attempts = 10
	while(is_colliding() and slide_attempts > 0):
		motion = get_collision_normal().slide(motion)
		motion = move(motion)
		slide_attempts -= 1
	pass

###===================================================================

func rotating_muzzle(delta):
	
	if is_it_rotating == true:
		deg = fmod(deg + rotating_speed * delta, 360.0)
	elif is_it_rotating == false:
		deg = deg
	
	pos_rotation.x = cos(deg2rad(deg) - (PI/2)) # direction to clockwise
	pos_rotation.y = sin(deg2rad(deg) - (PI/2)) # direction to clockwise
	
	pos_rotation2.x = cos(deg2rad(deg) - (PI/1)) # direction to clockwise
	pos_rotation2.y = sin(deg2rad(deg) - (PI/1)) # direction to clockwise
	
	### ========================================= rotation1 control
	new_pos_rotation = pos_rotation * 70
	muzzle1.set_rot(deg2rad(-deg))
	muzzle1.set_pos(new_pos_rotation)
	
	### ========================================= rotation2 control
	new_pos_rotation2 = pos_rotation * -70
	muzzle2.set_rot(deg2rad(-deg) - (PI/1))
	muzzle2.set_pos(new_pos_rotation2)
	
	### ========================================= rotation3 control
	new_pos_rotation3  = pos_rotation2 * 70
	muzzle3.set_rot(deg2rad(-deg) - (3*PI/2))
	muzzle3.set_pos(new_pos_rotation3)
	
	### ========================================= rotation4 control
	new_pos_rotation4  = pos_rotation2 * -70
	muzzle4.set_rot(deg2rad(-deg) - (PI/2))
	muzzle4.set_pos(new_pos_rotation4)
	
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
		bullet_container.add_child(bullet_inst2)
		bullet_container.add_child(bullet_inst3)
		bullet_container.add_child(bullet_inst4)
		
		bullet_inst.start_at( muzzle1.get_rot(), muzzle1.get_global_pos() )
		bullet_inst2.start_at( muzzle2.get_rot(), muzzle2.get_global_pos() )
		bullet_inst3.start_at( muzzle3.get_rot(), muzzle3.get_global_pos() )
		bullet_inst4.start_at( muzzle4.get_rot(), muzzle4.get_global_pos() )
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
		bullet_inst  = bullet1_tscn.instance()
		bullet_inst2 = bullet1_tscn.instance()
		bullet_inst3 = bullet2_tscn.instance()
		bullet_inst4 = bullet2_tscn.instance()
	elif type_bullet == 2:
		bullet_inst  = bullet2_tscn.instance()
		bullet_inst2 = bullet2_tscn.instance()
		bullet_inst3 = bullet1_tscn.instance()
		bullet_inst4 = bullet1_tscn.instance()
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
