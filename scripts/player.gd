extends CharacterBody3D

@onready var give_head = $give_head
@onready var standing_collision_shape: CollisionShape3D = $standing_collision_shape
@onready var crouching_collision_shape: CollisionShape3D = $crouching_collision_shape
@onready var ray_cast_3d: RayCast3D = $RayCast3D

@export var walking_speed = 5.0
@export var sprinting_speed = 10.0
@export var crouching_speed = 3.0
var current_speed = 5.0
var lerp_speed = 10.0
var direction = Vector3.ZERO
var crouching_depth = -0.5

const jump_velocity = 9.0
const mouse_sens = 0.3


func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event):
	if (event is InputEventMouseMotion) && !$Inventory.visible:
		rotate_y(deg_to_rad(-event.relative.x * mouse_sens))
		give_head.rotate_x(deg_to_rad(-event.relative.y * mouse_sens))
		give_head.rotation.x = clamp(give_head.rotation.x, deg_to_rad(-89), deg_to_rad(89))

func _physics_process(delta: float) -> void:
	
	if Input.is_action_just_pressed("Inventory"):
		$Inventory.visible = !$Inventory.visible
		if $Inventory.visible:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
	if Input.is_action_pressed("crouch"):
		current_speed = crouching_speed
		give_head.position.y = lerp(give_head.position.y, 1.8 + crouching_depth, delta*lerp_speed)
		standing_collision_shape.disabled = true
		crouching_collision_shape.disabled = false
	elif !ray_cast_3d.is_colliding():
		give_head.position.y = lerp(give_head.position.y, 1.8, delta*lerp_speed)
		standing_collision_shape.disabled = false
		crouching_collision_shape.disabled = true
		if Input.is_action_pressed("sprint"):
			current_speed = sprinting_speed
		else:
			current_speed = walking_speed
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = jump_velocity

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("left", "right", "forward", "backward")
	direction = lerp(direction, (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized(), delta*lerp_speed)
	
	
	if direction:
		velocity.x = direction.x * current_speed
		velocity.z = direction.z * current_speed
	else:
		velocity.x = move_toward(velocity.x, 0, current_speed)
		velocity.z = move_toward(velocity.z, 0, current_speed)

	move_and_slide()
