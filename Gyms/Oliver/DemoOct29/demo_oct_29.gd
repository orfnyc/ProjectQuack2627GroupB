extends Node2D

@onready var player_last_direction: Label = $TestUI/PlayerLastDirection
@onready var player: CharacterBody2D = $PlayerOct29
@onready var top_right: Node2D = $LevelBounds/TopRight
@onready var bottom_left: Node2D = $LevelBounds/BottomLeft
@onready var object_factory: ObjectFactory = $ObjectFactory

func _ready() -> void:
	set_level_bounds()
	object_factory.create_object(ObjectFactory.ObjectTypes.RED, Vector2(150, 600))

func set_level_bounds():
	player.set_camera_bounds(Vector2i(top_right.position), Vector2i(bottom_left.position))

func _on_player_oct_29_last_direction_signal(ld: int) -> void:
	player_last_direction.text = "Left" if ld == -1 else "Right"
