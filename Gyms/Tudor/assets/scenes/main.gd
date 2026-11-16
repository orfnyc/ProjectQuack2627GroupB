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
	#if Engine.get_frames_drawn() % 144 > 142 or Engine.get_frames_drawn() % 144 < 2:
		#print(quests)
	pass


func _on_npc_quest_released(quest: Variant) -> void:
	if quest not in  quests:
		quests.append(quest)
	print(quests)
	#pass # Replace with function body.


func _on_player_action_completed(action: Variant) -> void:
	for quest in quests:
		for task in quest:
			var tasks_finished = 0
			var taskmaster_id : int = quest[quest.size() - 1]
			
			if typeof(task) != TYPE_INT:
				if task[0] == action[0]: # if same type of task
					if task[1] == action[1]: # if same type of requirement
						task[2] -= action[2]
					if task[2] <= 0:
						tasks_finished += 1
			if tasks_finished == quest.size() - 1:
				var taskmaster = instance_from_id(taskmaster_id)
				taskmaster.quest_completed()
		
	pass # Replace with function body.
