extends Timer


# Called when the node enters the scene tree for the first time.
func _ready():
	$ProgressBar.max_value = wait_time
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$ProgressBar.value = wait_time-time_left
	pass
