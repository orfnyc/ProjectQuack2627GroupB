extends Node2D

var quests : Array = []
# QUESTS ARE EACH AN ARRAY OF 3 ITEMS
# [X, Y, Z]
# X = THE TASK ID; IE: 0 IS PICKING UP AN ITEM, 1 IS DOING AN ACTION, 2 IS TRAVELLING DISTANCE
# Y IS THE ID OF THE THING DONE; IE: IF APPLE HAS ID 1, AND YOU COLLECT AN APPLE, Y = 1; IF TREE HAS ID 2 AND YOU CHOP DOWN TREE, Y = 2, ETC
# Z IS THE AMOUNT OF THING DONE; IF YOU NEED 7 APPLES, Z = 7

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_npc_quest_released(quest: Variant) -> void:
	if quest not in  quests:
		quests.append(quest)
	print(quests)
	#pass # Replace with function body.
