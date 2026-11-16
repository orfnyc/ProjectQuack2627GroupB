extends CharacterBody2D

var path: Line2D

@export var direction: Vector2 = Vector2(0,0)

const SPEED = 350.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	
func _physics_process(_delta: float) -> void:
	velocity = direction * SPEED
	if move_and_slide():
		# change direction
		var angle: float = randf_range(0, 360)
		direction.x = cos(deg_to_rad(angle))
		direction.y = sin(deg_to_rad(angle))
