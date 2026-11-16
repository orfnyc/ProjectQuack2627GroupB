class_name Item
extends Node2D

signal picked_up

func _on_area_2d_body_entered(body: Node2D) -> void:
	picked_up.emit()
	queue_free()
