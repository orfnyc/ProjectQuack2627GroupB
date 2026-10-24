extends Area2D

@onready var dialogue = $Dialogue
@export var hello_dialogue: String = ""
@export var sell_dialogue: String = ""
@export var sell_cost: int = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var bodies = get_overlapping_bodies()
	for body in bodies:
		if body is CharacterBody2D:
			if body.mult >= sell_cost:
				if Input.is_action_just_pressed("ui_text_newline"):
					dialogue.text = sell_dialogue
					body.mult -= sell_cost
	pass

func _on_body_entered(body: Node2D) -> void:
	print("hi")
	dialogue.text = hello_dialogue
	
	pass # Replace with function body.

func _on_body_exited(body: Node2D) -> void:
	print("bye")
	dialogue.text = ""
	pass # Replace with function body.
