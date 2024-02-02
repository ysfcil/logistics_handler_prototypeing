extends Panel
signal resource_on(name_)
var resource_Type = ["Oil", "Lithium", "Gold"]
@export var is_oil =false
@export var is_Lithium=false
@export var is_Gold=false
var this_resource_is = []
var my_price = 100.0
var my_influence = 1.0
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
	$Price_per_unit.text = str(my_price, "$")
	$influence.text = str(my_influence)
	pass


func resource_is_working(resource,influence, price):
	if resource == name:
		my_influence = influence
		my_price = price
	
	pass # Replace with function body.


func _on_check_button_toggled(toggled_on):
	resource_on.emit(name)
	pass # Replace with function body.
