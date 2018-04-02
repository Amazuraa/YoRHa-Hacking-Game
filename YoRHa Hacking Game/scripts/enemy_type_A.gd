# enemy type A
# shoot one type of bullet only and pointing player
extends KinematicBody2D

var motion = Vector2()
export var MOTION_SPEED = 70
var timer_rot = 0.0
var delay_rot = 0.1

var player_node

### bullets
export (PackedScene) var bullet_tscn
var bullet_inst
onready var bullet_container = utils.main_node().get_node("bullet_container")
onready var muzzle = get_node("muzzle")
var timer = 0.0
export var delay = 1.0

### health
export var total_health = 1
onready var hitted_sprite = get_node("sprite")

### explosion
var explosion_tscn
var explosion_inst
onready var explosion_container = utils.main_node().get_node("explosion_container")

### active-state
var active_state = true
var active_state_prev = true
var active_state_next = true

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
	
	look_at_player(delta)
	moving(delta)
	
	timer -= delta
	if timer <= 0 :
		timer = delay
		bullet_inst = bullet_tscn.instance()
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

func moving(delta):
	motion += Vector2(MOTION_SPEED , 0).rotated(get_rot() + PI/2)
	motion = motion.normalized()
	motion = motion.normalized()*MOTION_SPEED*delta
	motion = move(motion)
	
	#this will fix the glitch collision
	#available on lastest version only
	set_collision_margin(5.0)
	
	var slide_attempts = 5
	while(is_colliding() and slide_attempts > 0):
		motion = get_collision_normal().slide(motion)
		motion = move(motion)
		slide_attempts -= 1
	pass

###===================================================================

func hit():
	hitted_sprite.set_frame(0)
	hitted_sprite.play("hit")
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
	self.queue_free()
	pass

###===================================================================

func sfx_explode():
	sfx_inst_e = sfx_tscn_e.instance()
	sfx_container.add_child(sfx_inst_e)
	sfx_inst_e.play("enemy_explode")
	pass

###===================================================================

func _on_notifier_enter_screen():
	volume_state = "up"
	pass

func _on_notifier_exit_screen():
	volume_state = "down"
	pass
