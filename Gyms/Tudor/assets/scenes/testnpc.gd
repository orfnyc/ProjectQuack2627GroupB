extends Area2D

@onready var label_test = $Label
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var bodies = get_overlapping_bodies()
	for body in bodies:
		if body is CharacterBody2D:
			if body.mult >= 50:
				if Input.is_action_just_pressed("ui_text_newline"):
					label_test.text = "thanks for the mult"
					body.mult -= 50
	pass

func _on_body_entered(body: Node2D) -> void:
	print("hi")
	label_test.text = "hello gradient man"
	
	pass # Replace with function body.

func _on_body_exited(body: Node2D) -> void:
	print("bye")
	label_test.text = ""
	pass # Replace with function body.
