extends CharacterBody2D

const SPEED: float = 250.0

var dash_timer_max: float = 0.1
var dash_timer: float = 0.0
var reset_position: Vector2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	reset_position = position

## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#pass

func _physics_process(delta: float) -> void:
	velocity = Vector2.ZERO # (x = 0, y = 0)
	if Input.is_action_pressed('left_test'):
		# BAD position.x += 10 * delta # 10 pixel / frames * second / frame = pixel / second ??
		velocity.x = -1
	if Input.is_action_pressed('right_test'):
		velocity.x = 1
	if Input.is_action_pressed('up_test'):
		velocity.y = -1
	if Input.is_action_pressed('down_test'):
		velocity.y = 1
	velocity = velocity.normalized() * SPEED
	if Input.is_action_just_pressed('dash_test') and dash_timer <= 0:
		dash_timer = dash_timer_max
	if dash_timer > 0.0:
		velocity *= 10
		dash_timer -= delta
	move_and_slide()

func _on_hitbox_body_entered(body: Node2D) -> void:
	position = reset_position
