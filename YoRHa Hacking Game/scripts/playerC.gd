#playerC
extends KinematicBody2D

### bullets
export (PackedScene) var bullet_tscn
var bullet_inst
onready var bullet_container = utils.main_node().get_node("bullet_container")
onready var gun_timer = get_node("gun_timer")

### create input states classes
var btn_l_up    = null
var btn_l_down  = null
var btn_l_left  = null
var btn_l_right = null

var btn_up    = null 
var btn_down  = null
var btn_left  = null
var btn_right = null

### directions
var direction = "up"
var direction_prev = "up"
var direction_next = "up"

onready var muzzle = get_node("muzzle")

var rot
var angle_in_degree = 0

var motion = Vector2()
export var MOTION_SPEED = 190

var shooting

var active_state = true
var active_state_prev = true
var active_state_next = true

### hit and explosion
var animation_tscn
var animation_inst
onready var animation_container = get_node("hit_explode_container")
var explode_count = 0

### health
var health_count_state = true
var health_count_max = 0
export var total_health = 1
onready var health3 = get_node("health3")
onready var health2 = get_node("health2")
onready var health1 = get_node("health1")

###sfx
onready var sample_player = get_node("sample_player")
onready var sample_player_stat = get_node("sample_player_stat")

###command
export var command_active = false

###===================================================================

func _ready():
	add_to_group("player")
	set_process(true)
	set_process_input(true)
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
	command()
	direction_prev = direction
	direction = direction_next
	
	btn_l_up    = Input.is_action_pressed("ui_up")
	btn_l_down  = Input.is_action_pressed("ui_down")
	btn_l_left  = Input.is_action_pressed("ui_left")
	btn_l_right = Input.is_action_pressed("ui_right")
	
	btn_up    = Input.is_action_pressed("move_up")
	btn_down  = Input.is_action_pressed("move_down")
	btn_left  = Input.is_action_pressed("move_left")
	btn_right = Input.is_action_pressed("move_right")
	
	shooting = Input.is_action_pressed("shoot")
	
	moving(delta)
	direction_statement()
	rotation_count()
	rotation()
	shooting()
	pass

###===================================================================

func shooting():
	if shooting :
		if gun_timer.get_time_left() == 0:
			sample_player.play("player_shoot")
			gun_timer.start()
			bullet_inst = bullet_tscn.instance()
			bullet_container.add_child(bullet_inst)
			bullet_inst.start_at( get_rot(), muzzle.get_global_pos() )
	pass

###===================================================================

func direction_statement():
	if direction == "up":
		angle_in_degree = 0
	elif direction == "left":
		angle_in_degree = 90
	elif direction == "down":
		angle_in_degree = 180
	elif direction == "right":
		angle_in_degree = 270
	
	elif direction == "up-left":
		angle_in_degree = 0 + 45
	elif direction == "left-down":
		angle_in_degree = 90 + 45
	elif direction == "down-right":
		angle_in_degree = 180 + 45
	elif direction == "right-up":
		angle_in_degree = 270 + 45
	pass 

###===================================================================

func moving(delta):
	### Moving direction
	if btn_up :
		motion += Vector2(0, -1)
	elif btn_down :
		motion += Vector2(0, 1)
	elif btn_left :
		motion += Vector2(-1, 0)
	elif btn_right :
		motion += Vector2(1, 0)
	
	motion = motion.normalized()*MOTION_SPEED*delta
	motion = move(motion)
	
	#this will fix the glitch collision
	#available on lastest version only
	set_collision_margin(1.0)
	
	var slide_attempts = 10
	while(is_colliding() and slide_attempts > 0):
		motion = get_collision_normal().slide(motion)
		motion = move(motion)
		slide_attempts -= 1
	pass

###===================================================================

func rotation_count():
	rot = atan2((sin(deg2rad(angle_in_degree))), (cos(deg2rad(angle_in_degree))))
	pass

###===================================================================

func rotation():
	
	### Look at directions
	if btn_l_up and btn_l_left:
		direction_next = "up-left"
	elif btn_l_left and btn_l_down:
		direction_next = "left-down"
	elif btn_l_down and btn_l_right:
		direction_next = "down-right"
	elif btn_l_right and btn_l_up:
		direction_next = "right-up"
		
	elif btn_l_up:
		direction_next = "up"
	elif btn_l_down:
		direction_next = "down"
	elif btn_l_left:
		direction_next = "left"
	elif btn_l_right:
		direction_next = "right"
	
	angle_in_degree
	set_rot(rot)
	pass

###===================================================================

func hit():
	if health_count_state == true:
		total_health -= 1
	elif health_count_state == false:
		total_health = 0
	
	if total_health == 0:
		explode()
	elif total_health > 0:
		if total_health == 2:
			sample_player_stat.play("player_hit2")
			health3.hide()
			health2.show()
			health1.hide()
			
			health2.set_frame(0)
			health2.play("health2")
		
		elif total_health == 1:
			sample_player_stat.play("player_hit2")
			health3.hide()
			health2.hide()
			health1.show()
			
			health1.set_frame(0)
			health1.play("health1")
		
		animation_tscn = preload("res://scenes/player_hit.tscn")
		animation_inst = animation_tscn.instance()
		animation_container.add_child(animation_inst)
		animation_inst.set_pos(get_global_pos())
		animation_inst.set_frame(0)
		animation_inst.play("player_hit")
	pass

###===================================================================

func explode():
	#health_count_state = true
	sample_player_stat.play("player_explode")
	self.hide()
	active_state_next = false
	animation_tscn = preload("res://scenes/player_explosionC.tscn")
	animation_inst = animation_tscn.instance()
	animation_container.add_child(animation_inst)
	animation_inst.set_pos(get_global_pos())
	animation_inst.set_frame(0)
	animation_inst.play("player_explosion")
	pass

###===================================================================

func command():
	if utils.command_player == true:
		command_active = true
	elif utils.command_player == false:
		command_active = false
	pass