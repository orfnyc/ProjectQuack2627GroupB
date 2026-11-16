extends Area2D

@onready var dialogue = $Dialogue
@export var hello_dialogue: String = ""
@export var sell_dialogue: String = ""
@export var reject_dialogue: String = ""
@export var sell_cost: int = 0
@export var quests: Array[Array] = [[[0, 0, 0, 0]]]

signal quest_released(quest)
var quests_completed : int = 0
var initial_quests : int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	dialogue.text = ""
	for quest in quests:
		quest.append(get_instance_id())
		initial_quests += 1
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var bodies = get_overlapping_bodies()
	for body in bodies:
		if body is CharacterBody2D:
			if quests.size() == initial_quests - quests_completed:
				quest_released.emit(quests[0])
				quests.pop_front()
			if Input.is_action_just_pressed("ui_text_newline"):
				if body.mult >= sell_cost:
					dialogue.text = sell_dialogue
					body.mult -= sell_cost
				else:
					dialogue.text = reject_dialogue

func quest_completed():
	quests_completed += 1
	if quests_completed == initial_quests:
		hello_dialogue = "you finished my quests!"
	

func _on_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		print("hi")
		dialogue.text = hello_dialogue

func _on_body_exited(body: Node2D) -> void:
	if body is CharacterBody2D:
		print("bye")
		dialogue.text = ""
