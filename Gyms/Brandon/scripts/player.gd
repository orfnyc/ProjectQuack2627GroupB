extends CharacterBody2D


const SPEED : float = 450.0
const JUMP_VELOCITY : float = -400.0
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var current_gravity = gravity


const ACCELERATION : float = SPEED * 0.9
const AIR_DECCELERATIVE_CONSTANT : float = SPEED * 0.01
const FLOOR_DECCELERATIVE_CONSTANT : float = SPEED * 0.05
const MAX_SPEED : float = SPEED * 1.5
const WALL_JUMP_STRENGTH := Vector2(0.75, 0.9)

var mult = 0
@onready var mult_label : Label = $Label

func _physics_process(delta: float) -> void:
	
	if is_on_wall() and velocity.y > 0: # when on a wall, fall slower (wall sliding)
		current_gravity *= 0.1
	else:
		current_gravity = gravity
		
	# Add the gravity.
	if not is_on_floor():
		if not is_on_wall(): 
			mult += 10 * delta # if not on a wall, increase multiplier
		velocity.y += current_gravity * delta # if not on floor, fall down according to gravity
#
	if is_on_floor():
		if mult != int(mult): # only happens if they're not equal so it doesn't set a value to itself and spend processing power
			mult = int(mult) # when landing, round multiplier
#
	var direction := Input.get_axis("move_left", "move_right") # -1 if pressing left, 1 if pressing right, 0 if neither
	if direction == 0: # not pressing directional inputs
		if is_on_floor(): # if player is on the floor
			if velocity.x > 0:
				velocity.x = max(0, velocity.x - (FLOOR_DECCELERATIVE_CONSTANT)) # decreases velocity by floor deccelerative constant, takes 0 if the result is negative
			elif velocity.x < 0:
				velocity.x = min(0, velocity.x + (FLOOR_DECCELERATIVE_CONSTANT)) # decreases velocity by floor decelerative constant, opposite signs because moving left is signed negative
		else: # if player not on floor
			if velocity.x > 0:
				velocity.x = max(0, velocity.x - (AIR_DECCELERATIVE_CONSTANT)) # same for air deccelerative constant
			elif velocity.x < 0:
				velocity.x = min(0, velocity.x + (AIR_DECCELERATIVE_CONSTANT)) # same for air deccelerative constant

	if Input.is_action_just_pressed("jump") and (is_on_floor() or is_on_wall()): # if player presses the jump button
		velocity.y = JUMP_VELOCITY # increases y velocity by jump velocity
		if is_on_wall():
			velocity.y *= WALL_JUMP_STRENGTH.y
		if is_on_wall_only(): # if player is on wall and not on floor
			var wall_jump_direction = get_wall_normal().x # gets the direction that the wall face is facing (1 if wall is on left, -1 if wall is on right)
			velocity.x += SPEED * wall_jump_direction * WALL_JUMP_STRENGTH.x # increases velocity in direction of the wall
		#
			#
	if direction != 0: # if player is holding a directional key
		print(velocity.x)
		if ((is_on_wall() and direction == get_wall_normal().x) or not is_on_wall()): # if the player is moving off of a wall or not on a wall
			var friction = 0
			
			if direction == -1 * sign(velocity.x):
				if is_on_floor():
					friction = FLOOR_DECCELERATIVE_CONSTANT # adds friction if player is on floor and holding a directional input opposite to their movement direction
				if not is_on_floor():
					friction = AIR_DECCELERATIVE_CONSTANT # same but for if player is in air
					
			if direction == 1: # if player is holding right
				velocity.x = min(MAX_SPEED, velocity.x + (ACCELERATION * delta) + friction) # increases player speed by acceleration up to max speed
			elif direction == -1: # if player is holding left
				velocity.x = max(-1 * MAX_SPEED, velocity.x - (ACCELERATION * delta) - friction) # increases player speed by acceleration up to max speed; using min and subtraction because moving left is signed negative
			
	
	mult_label.text = str(int(mult))
	move_and_slide()
