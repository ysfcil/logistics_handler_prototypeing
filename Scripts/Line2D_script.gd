extends Line2D
var out_point_name = ""
var in_point_name = ""
@export var first_point = Vector2.ZERO
@export var second_point = Vector2.ZERO
# Called when the node enters the scene tree for the first time.
func _ready():
	points[0] = first_point
	points[1] = second_point
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	pass
