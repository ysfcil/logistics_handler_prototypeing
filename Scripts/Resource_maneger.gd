extends Node
signal resource_is_working(name_of_resource,influence, price)
signal resource_to_logistics(resource_)
var resource_Type = ["Oil", "Lithium", "Gold"]
var resource_price = [10, 100, 1000]
var resource_info = {"Oil1":[false,1, 1.2], "Lithium1":[false,1,1.5], "Gold1":[false,1,10],"Oil2":[false,1,1.6], "Lithium2":[false,1,2.1], "Gold2":[false,1,11.3]}
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	for resource in resource_info:
		resource_is_working.emit(resource,resource_info[resource][1], resource_info[resource][2])
		resource_to_logistics.emit(resource_info)
	
	


func resource_on(name_):
	resource_info[name_][0] = !resource_info[name_][0]
	pass # Replace with function body.
