extends HBoxContainer
var factories_by_city_ = {"Bangladesh":[1,0,0], "London": [0,0,0], "New_York": [0,0,0]}
# Called when the node enters the scene tree for the first time.
func _ready():
	for i in factories_by_city_.keys():
		$city_giving.get_popup().add_item(i)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_logistics_handler_to_connection(factories_by_city):
	factories_by_city = factories_by_city_
	pass # Replace with function body.

