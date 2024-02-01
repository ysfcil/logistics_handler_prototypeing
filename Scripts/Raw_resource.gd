extends Panel
var resource_Type = ["Oil", "Lithium", "Gold"]
@export var is_oil =false
@export var is_Lithium=false
@export var is_Gold=false
var this_resource_is = []

# Called when the node enters the scene tree for the first time.
func _ready():
	if is_Lithium:
		this_resource_is.append(resource_Type[1])
		$Resource_name.text = resource_Type[1]
	elif is_oil:
		this_resource_is.append(resource_Type[0])
		$Resource_name.text = resource_Type[0]
	elif is_Gold:
		this_resource_is.append(resource_Type[2])
		$Resource_name.text = resource_Type[2]
		
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
