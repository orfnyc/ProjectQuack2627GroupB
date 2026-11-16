extends Node2D

var quests : Array = []
# QUESTS ARE EACH AN ARRAY OF ARRAYS OF 3 ITEMS
# [[X, Y, Z, A], ID]
# X = THE TASK ID; IE: 0 IS PICKING UP AN ITEM, 1 IS DOING AN ACTION, 2 IS TRAVELLING DISTANCE
# Y = THE ID OF THE THING DONE; IE: IF APPLE HAS ID 1, AND YOU COLLECT AN APPLE, Y = 1; IF TREE HAS ID 2 AND YOU CHOP DOWN TREE, Y = 2, ETC
# Z = THE AMOUNT OF THING DONE; IF YOU NEED 7 APPLES, Z = 7
# A = 0 or 1, REPRESENTS IF IT'S A "GAIN" TASK (0) OR A "HAVE" TASK (1)
# ID = THE ID OF THE NPC THAT GAVE THE QUEST
# EACH ARRAY OF [X, Y, Z] IS A "TASK"
# "GAIN" TASKS ARE HANDLED IN MAIN
# "HAVE" TASKS ARE HANDLED IN THE NPCS

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#if Engine.get_frames_drawn() % 144 > 142 or Engine.get_frames_drawn() % 144 < 2: <- test print statement
		#print(quests)
	pass


func _on_npc_quest_released(quest: Variant) -> void:
	if quest not in  quests:
		quests.append(quest)
	print("QUEST RELEASED: ", quest)


func _on_player_action_completed(action: Variant) -> void:
	for quest in quests:
		var tasks_finished = 0
		var taskmaster_id : int = quest[quest.size() - 1]
		
		for task in quest:
			if typeof(task) != TYPE_INT:
				if task[0] == action[0]: # if same type of task
					if task[1] == action[1]: # if same type of requirement
						task[2] -= action[2] # subtracts amount of action from amount of task (NOTE: COULD BE A BAD WAY OF DOING THINGS BY DEFAULT; MORE OR LESS MAKES EACH TASK "GAIN X Y" AND NOT "HAVE X Y". MIGHT NEED TO WORK ON A TASK BY TASK BASIS)
					if task[2] <= 0: # if task finished
						tasks_finished += 1
						
		if tasks_finished == quest.size() - 1: # if all tasks in quest are finished
			var taskmaster = instance_from_id(taskmaster_id) # gets id of the npc that sent the task
			taskmaster.quest_completed() # task completed
		
	pass # Replace with function body.
