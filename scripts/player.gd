extends CharacterBody3D
class_name Character

@onready var head: Node3D = %give_head
@onready var standing_collision: CollisionShape3D = $standing_collision_shape
@onready var crouching_collision: CollisionShape3D = $crouching_collision_shape
@onready var crouch_raycast = %crouch_raycast
@onready var interaction_raycast = %InteractionSight
@onready var camera = $give_head/Camera3D
@onready var dialog = %InventoryDialog
@onready var inventory : Inventory = Inventory.new()

const walk_speed = 5.0
const sprint_speed = 8.0
var speed = 5.0

# The frequency here is responsible for how much player's head will bob, 
# while the amplitude defines how deep the head will go down
const head_bob_freq = 2.4
const head_bob_amp = 0.06
var head_bob = 0.0

const crouching_speed = 3.0
const crouching_depth = -0.5

const jump_velocity = 4.0
const lerp_speed = 10.0
const mouse_sensivity = 0.3

# Base fov is just as its defined is camera, maybe I had to set it's value FROM the camera. Le fov_change can be used to
# adjust how the picture will stretch while moving
const base_fov = 75.0
const fov_change = 1.1

var direction = Vector3.ZERO

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event: InputEvent) -> void:
	if (event is InputEventMouseMotion) and !dialog.visible:
		rotate_y(deg_to_rad(-event.relative.x * mouse_sensivity))
		head.rotate_x(deg_to_rad(-event.relative.y * mouse_sensivity))
		head.rotation.x = clamp(head.rotation.x, deg_to_rad(-89), deg_to_rad(89))


func _physics_process(delta: float) -> void:
	
	# Deleted "ui_accept - Space" and "ui_next - Tab" and added new bind, works just the same as before
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_velocity
		
	# This works pretty much the same as before, but sprint was moved out of if-statement
	if Input.is_action_pressed("crouch"):
		speed = crouching_depth
		head.position.y = lerp(head.position.y, 1.8 + crouching_depth, delta*lerp_speed)
		standing_collision.disabled = true
		crouching_collision.disabled = false
	elif !crouch_raycast.is_colliding():
		head.position.y = lerp(head.position.y, 1.8, delta*lerp_speed)
		standing_collision.disabled = false
		crouching_collision.disabled = true
		
	# Changed sprint to set slower speed while crouching, the other works pretty much the same
	if Input.is_action_pressed("sprint") and !Input.is_action_pressed("crouch"):
		speed = sprint_speed
	elif Input.is_action_pressed("sprint") and Input.is_action_pressed("crouch"):
		speed = sprint_speed - 1
	else:
		speed = walk_speed
			
	# Gravity works just like it did before
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	# Direction works just like it did before
	var input_direction = Input.get_vector("left", "right", "forward", "backward")
	direction = lerp(direction, (transform.basis * Vector3(input_direction.x, 0, input_direction.y)).normalized(), delta*lerp_speed)
	
	
	# An additional layer of this statement was added to allow some control and inertia while the player is falling
	if is_on_floor():
		if direction:
			velocity.x = direction.x * speed
			velocity.z = direction.z * speed
		else:
			velocity.x = move_toward(velocity.x, 0, speed)
			velocity.z = move_toward(velocity.z, 0, speed)
	else:
		velocity.x = lerp(velocity.x, direction.x * speed, delta * 2.0)
		velocity.z = lerp(velocity.z, direction.z * speed, delta * 2.0)
		
	# This calls _head_bob() function to use some smart maths to change a position of player's head while moving.
	head_bob += delta * velocity.length() * float(is_on_floor())
	camera.transform.origin = _head_bob(head_bob)
	
	# FOV changes as the player moves around based on their speed. You can modify a delta multiplier or fov_change parameter
	var velocity_clamped = clamp(velocity.length(), 0.5, sprint_speed * 2)
	var target_fov = base_fov + fov_change * velocity_clamped
	camera.fov = lerp(camera.fov, target_fov, delta*2.0)
		
	move_and_slide()

# There are some smort maths that were stolen from yt video about movement system. If "bobbing" looks weird - edit parameters
func _head_bob(time) -> Vector3:
	var position = Vector3.ZERO
	position.y = sin(time * head_bob_freq) * head_bob_amp
	position.x = cos(time * head_bob_freq / 2) * head_bob_amp 
	return position
