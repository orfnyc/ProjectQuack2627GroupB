extends CharacterBody2D

signal last_direction_signal(ld: int)

const GRAVITY: float = 500.0
const JUMP_IMPULSE: float = 300.0
const WALK_ACCELERATION: float = 1000.0
const WALK_DECCELERATION: float = 1500.0
const MAX_SPEED: float = 250.0
const WALL_SLIDE: float = 50.0

@onready var camera: Camera2D = $Camera2D

func _physics_process(delta: float) -> void:
	# Apply Gravity
	velocity.y += GRAVITY * delta
	if is_on_wall(): 
		if Input.is_action_pressed("left_test") or Input.is_action_pressed("right_test"):
			velocity.y = min(velocity.y, WALL_SLIDE)
	
	if Input.is_action_pressed("left_test"):
		velocity.x -= WALK_ACCELERATION * delta
	if Input.is_action_pressed("right_test"):
		velocity.x += WALK_ACCELERATION * delta
	if is_on_floor() and not (Input.is_action_pressed("left_test") or Input.is_action_pressed("right_test")):
		if velocity.x > 0:
			velocity.x -= WALK_DECCELERATION * delta
			velocity.x = max(0, velocity.x)
		if velocity.x < 0: 
			velocity.x += WALK_DECCELERATION * delta
			velocity.x = min(0, velocity.x)
			
	# Jump
	if is_on_floor() and Input.is_action_just_pressed("up_test"):
		velocity.y -= JUMP_IMPULSE
		
	# Wall Jump
	if is_on_wall_only() and Input.is_action_just_pressed("up_test"):
		velocity.x += get_wall_normal().x * JUMP_IMPULSE
		velocity.y = -JUMP_IMPULSE
	
	velocity.x = clampf(velocity.x, -MAX_SPEED, MAX_SPEED)
	move_and_slide()

func set_camera_bounds(top_right: Vector2i, bottom_left: Vector2i) -> void:
	camera.limit_top = top_right.y
	camera.limit_bottom = bottom_left.y
	camera.limit_left = bottom_left.x
	camera.limit_right = top_right.x
