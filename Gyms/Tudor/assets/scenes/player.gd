extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var mult = 0
@onready var mult_label = $Label

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		mult += 10 * delta
		velocity += get_gravity() * delta

	if is_on_floor():
		mult = int(mult)
	# Handle jump.
	if Input.is_action_just_pressed("ui_select") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	mult_label.text = str(int(mult))
	move_and_slide()
