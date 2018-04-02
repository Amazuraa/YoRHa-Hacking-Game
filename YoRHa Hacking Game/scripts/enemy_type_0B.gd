# enemy type 0B
# shoot three types of bullet, pointing at player, and got some shield :D
extends KinematicBody2D

var motion = Vector2()
export var MOTION_SPEED = 70
var timer_rot = 0.0
var delay_rot = 0.1

var player_node

### bullets
export (PackedScene) var bullet1_tscn
export (PackedScene) var bullet2_tscn
export (PackedScene) var bullet3_tscn

var bullet_inst

onready var bullet_container = utils.main_node().get_node("bullet_container")
onready var muzzle = get_node("muzzle")
var timer = 0.0
export var delay = 1.0
var type_bullet  = 1
var count_bullet = -1
export var switch_bullet = 5

### health
export var total_health = 1

### shield
onready var shield1 = get_node("shield1")
onready var shield2 = get_node("shield2")
onready var shield3 = get_node("shield3")
onready var shield4 = get_node("shield4")

var angel_in_degree = 0
var new_pos_shield1 = Vector2()
var new_pos_shield2 = Vector2()
var new_pos_shield3 = Vector2()
var new_pos_shield4 = Vector2()
var deg = 0.0
export var shielding_speed = 50.0
var shielding_speed_max = 950.0
var shielding_speed_min = 50.0
var speed_state = 0

### active-state
var active_state = true
var active_state_prev = true
var active_state_next = true

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
	
	shield(delta)
	
	if deg > 359.0:
		if shielding_speed == shielding_speed_max:
			speed_state = 0
			speed_state += 1
		elif shielding_speed == shielding_speed_min:
			speed_state = 1
			speed_state -= 1
		
		if speed_state == 0 :
			shielding_speed += 50.0
			delay -= 0.01
		elif speed_state == 1 :
			shielding_speed -= 50.0
			delay += 0.01
	
	timer -= delta
	shooting()
	
	pass

###===================================================================

func shield(delta):
	
	deg = fmod(deg + shielding_speed * delta, 360.0)
	
	### ============================================ shield 1 control
	new_pos_shield1.x = cos(deg2rad(deg) - (PI/2)) # direction to clockwise
	new_pos_shield1.y = sin(deg2rad(deg) - (PI/2)) # direction to clockwise
	new_pos_shield1 = new_pos_shield1 * 140        # start at 0 degree 
	
	shield1.set_rot(deg2rad(-deg))
	shield1.set_pos(new_pos_shield1)
	
	### ============================================ shield 2 control
	new_pos_shield2.x = cos(deg2rad(deg) - (PI/2)) # direction to clockwise
	new_pos_shield2.y = sin(deg2rad(deg) - (PI/2)) # direction to clockwise
	new_pos_shield2 = new_pos_shield2 * -140       # start at 180 degree
	
	shield2.set_rot(deg2rad(-deg) - (PI/1))        
	shield2.set_pos(new_pos_shield2)
	
	### ============================================ shield 3 control
	new_pos_shield3.x = cos(deg2rad(deg) - (PI/1)) # direction to clockwise
	new_pos_shield3.y = sin(deg2rad(deg) - (PI/1)) # direction to clockwise
	new_pos_shield3 = new_pos_shield3 * 140        # start at 90 degree
	
	shield3.set_rot(deg2rad(-deg) - (3*PI/2))
	shield3.set_pos(new_pos_shield3)
	
	### ============================================ shield 4 control
	new_pos_shield4.x = cos(deg2rad(deg) - (PI/1)) # direction to clockwise
	new_pos_shield4.y = sin(deg2rad(deg) - (PI/1)) # direction to clockwise
	new_pos_shield4 = new_pos_shield4 * -140       # start at 270 degree
	
	shield4.set_rot(deg2rad(-deg) - (PI/2))
	shield4.set_pos(new_pos_shield4)
	
	pass

###===================================================================

func shooting():
	if timer <= 0 :
		timer = delay
		count_bullet += 1
		
		if count_bullet == switch_bullet:
			type_bullet += 1
			if type_bullet > 3:
				type_bullet = 1
			
			count_bullet = 0
		
		bullet_type()
		bullet_container.add_child(bullet_inst)
		bullet_inst.start_at( get_rot(), muzzle.get_global_pos() )
		return
	pass

###===================================================================

func bullet_type():
	if type_bullet == 1:
		bullet_inst = bullet1_tscn.instance()
	elif type_bullet == 2:
		bullet_inst = bullet2_tscn.instance()
	elif type_bullet == 3:
		bullet_inst = bullet3_tscn.instance()
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
	
	var slide_attempts = 10
	while(is_colliding() and slide_attempts > 0):
		motion = get_collision_normal().slide(motion)
		motion = move(motion)
		slide_attempts -= 1
	pass

###===================================================================

func hit():
	total_health -= 1
	if total_health == 0:
		explode()
	pass

###===================================================================

func explode():
	queue_free()
	pass

