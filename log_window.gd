extends Window
var Distant_position = Vector2i(-300, -300) 
var main_position = Vector2i(300, 200)
# Called when the node enters the scene tree for the first time.
func _ready():
	#position = Distant_position
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_close_requested():
	position = Distant_position
	pass # Replace with function body.


func _on_call():
	position = main_position
	pass # Replace with function body.
func _created():
	pass
