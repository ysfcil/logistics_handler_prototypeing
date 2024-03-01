extends Area2D


# Called when the node enters the scene tree for the first time.

func _ready() -> void:
	input_pickable = true

func _on_input_event(viewport, event, shape_idx):
	print("click")
	pass # Replace with function body.


func _on_mouse_entered():
	print("works")
	pass # Replace with function body.
