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

func _physics_process(delta: float) -> void:
	
	
	ACCELERATION = abs(ACCELERATION)
	if is_on_wall() and velocity.y > 0: # if a raycast is touching a wall & 
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
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction == 0:
		if is_on_floor():
			ACCELERATION = max(0, ACCELERATION - FLOOR_DECCELERATIVE_CONSTANT)
		else:
			ACCELERATION = max(0, ACCELERATION - ACCELERATIVE_CONSTANT)
	elif not is_on_wall():
		ACCELERATION = min(1.5, ACCELERATION + ACCELERATIVE_CONSTANT)
	elif is_on_wall():
		ACCELERATION = min(0.2, ACCELERATION + ACCELERATIVE_CONSTANT)
	
	if Input.is_action_just_pressed("ui_select") and (is_on_floor() or is_on_wall()):
		velocity.y = JUMP_VELOCITY
		if is_on_wall() and not is_on_floor():
			ACCELERATION = 0.75
			var wall_jump_direction = get_wall_normal().x
			
			#velocity.x += SPEED * wall_jump_direction * 4
			velocity.x = move_toward(0, wall_jump_direction * SPEED * ACCELERATION * 6, SPEED * ACCELERATION * 6)
			print(velocity.x, " and ", is_on_wall())
		
			
	if direction:
		if(is_on_wall() and direction != get_wall_normal().x):
			print("moving towards wall")
		if ((is_on_wall() and direction == get_wall_normal().x) or not is_on_wall()):
			#velocity.x = direction * SPEED * ACCELERATION
			print("not moving towards wall")
			velocity.x = move_toward(velocity.x, direction * SPEED * ACCELERATION, SPEED * ACCELERATION)
	elif not is_on_wall():
		velocity.x = move_toward(velocity.x, 0, SPEED * ACCELERATION)

	mult_label.text = str(int(mult))
	move_and_slide()
