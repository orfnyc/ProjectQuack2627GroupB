extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var GRAVITY = ProjectSettings.get_setting("physics/2d/default_gravity")
var CURRENT_GRAVITY = GRAVITY

var mult = 0
var ACCELERATION = 1
var ACCELERATIVE_CONSTANT = 0.05
var FLOOR_DECCELERATIVE_CONSTANT = 0.1

@onready var mult_label = $Label
@onready var right_raycast: RayCast2D = $RightRayCast # Gets the RightRayCast node as a variable
@onready var left_raycast: RayCast2D = $LeftRayCast # Same w/ LeftRayCast

func touching_wall() -> bool:
	return (right_raycast.is_colliding() or left_raycast.is_colliding()) # checks if any raycast is touching a wall

func _physics_process(delta: float) -> void:
	
	if touching_wall() and velocity.y > 0: # if a raycast is touching a wall & 
		CURRENT_GRAVITY *= 0.1
	else:
		CURRENT_GRAVITY = GRAVITY
		
	# Add the gravity.
	if not is_on_floor():
		mult += 10 * delta
		velocity.y += CURRENT_GRAVITY * delta

	if is_on_floor():
		mult = int(mult)
	# Handle jump.
	if Input.is_action_just_pressed("ui_select") and (is_on_floor() or touching_wall()):
		velocity.y = JUMP_VELOCITY
		if touching_wall():
			#ACCELERATION = min(1.5, ACCELERATION + ACCELERATIVE_CONSTANT)
			if right_raycast.is_colliding():
				velocity.x = -1 * SPEED * ACCELERATION * 10
			if left_raycast.is_colliding():
				velocity.x = 1 * SPEED * ACCELERATION * 10
			print(velocity.x)

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction == 0:
		if is_on_floor():
			ACCELERATION -= max(0, ACCELERATION - FLOOR_DECCELERATIVE_CONSTANT)
		else:
			ACCELERATION -= max(0, ACCELERATION - ACCELERATIVE_CONSTANT)

	else:
		ACCELERATION = min(1.5, ACCELERATION + ACCELERATIVE_CONSTANT)
	if direction:
		if (direction == -1 and not left_raycast.is_colliding()) or (direction == 1 and not right_raycast.is_colliding()):
			#velocity.x = direction * SPEED * ACCELERATION
			print(velocity.x)
			velocity.x = move_toward(velocity.x, direction * SPEED * ACCELERATION, SPEED * ACCELERATION)
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED * ACCELERATION)

	mult_label.text = str(int(mult))
	move_and_slide()
