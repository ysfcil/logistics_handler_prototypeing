extends VBoxContainer
@export var containerScene : PackedScene
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_pressed():
	var l = containerScene.instantiate()
	call_deferred("add_child", l)
	pass # Replace with function body.
