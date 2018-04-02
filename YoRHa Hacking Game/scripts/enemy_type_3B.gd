# enemy type 3B
# shoot one type of bullet only, pointing at player, and got some shield :D
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

### shield
onready var shield1 = get_node("shield1")
onready var shield2 = get_node("shield2")

var angel_in_degree = 90
var new_pos_shield1 = Vector2()
var new_pos_shield2 = Vector2()
var deg = 0.0
export var shielding_speed = 50.0
var degree_state = 0

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
	
	timer -= delta
	shooting()
	
	shield(delta)
	pass

###===================================================================

func shield(delta):
	
	if deg > 90.0 :
		degree_state = 0
		degree_state += 1
	elif deg < 0.0 :
		degree_state = 1
		degree_state -= 1
	
	if degree_state == 0:
		deg = fmod(deg + shielding_speed * delta, 100.0)
	elif degree_state == 1:
		deg = fmod(deg + (-1*shielding_speed) * delta, 100.0)
	
	### shield 1 control
	new_pos_shield1.x = cos(deg2rad(deg) - (PI/2)) # direction to clockwise
	new_pos_shield1.y = sin(deg2rad(deg) - (PI/2)) # direction to clockwise
	new_pos_shield1 = new_pos_shield1 * 100        # start at 0 degree 
	
	shield1.set_rot(deg2rad(-deg))
	shield1.set_pos(new_pos_shield1)
	
	### shield 2 control
	new_pos_shield2.x = cos(deg2rad(-deg) - (PI/2)) # direction to clockwise
	new_pos_shield2.y = sin(deg2rad(-deg) - (PI/2)) # direction to clockwise
	new_pos_shield2 = new_pos_shield2 * 100         # start at 0 degree reverse
	
	shield2.set_rot(deg2rad(deg))        # flip vertical and follow rotation
	shield2.set_pos(new_pos_shield2)
	pass

###===================================================================

func shooting():
	if timer <= 0 :
		timer = delay
		bullet_inst = bullet_tscn.instance()
		bullet_container.add_child(bullet_inst)
		bullet_inst.start_at( get_rot(), muzzle.get_global_pos() )
		return
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

