class_name ObjectFactory
extends Node

enum ObjectTypes {RED, GREEN}

const OBJECTS: Dictionary[ObjectTypes, PackedScene] = {
	ObjectTypes.RED: preload("uid://d27tr3fwlq1se")
}


static func test():
	print("static function")

func create_object(type: ObjectTypes, position: Vector2):
	var new_object: Item = OBJECTS[type].instantiate()
	new_object.position = position
	add_child(new_object)
