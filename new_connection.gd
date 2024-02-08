extends HBoxContainer
var factories_by_city_ = {"Bangladesh":[1,1,1], "London": [2,1,0], "New_York": [0,0,1]}
var Connection_ = []
signal connenction_created(connection_info)
signal connection_destroyed(connection_info)
var logistics

# Called when the node enters the scene tree for the first time.
func _ready():
	logistics = get_tree().get_nodes_in_group("logistics")
	connenction_created.connect(Callable(logistics[0], "new_connection_connenction_created"))
	connection_destroyed.connect(Callable(logistics[0], "connection_destroyed"))
	$factory_type.disabled = true
	$to_city.disabled = true
	for i in factories_by_city_.keys():
		$from_city.add_item(i)
		$from_city.select(-1)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_logistics_handler_to_connection(factories_by_city):
	factories_by_city = factories_by_city_
	pass # Replace with function body.



func from_city_item_selected(index):
	$to_city.disabled = true
	Connection_.clear()
	Connection_.append($from_city.get_item_text(index))
	$factory_type.disabled = false
	$factory_type.clear()
	if factories_by_city_[$from_city.get_item_text(index)][0] != 0:
		$factory_type.add_item("Plastics")
	if factories_by_city_[$from_city.get_item_text(index)][1] != 0:
		$factory_type.add_item("Electronics")
	if factories_by_city_[$from_city.get_item_text(index)][2] != 0:
		$factory_type.add_item("Vehicle")
	$factory_type.select(-1)
	print(Connection_)
	pass # Replace with function body.


func factory_type_item_selected(index):
	if len(Connection_) == 2:
		Connection_.pop_back()
	var selected_facto = $factory_type.get_item_text(index)
	$to_city.disabled = false
	$to_city.clear()
	for i in factories_by_city_.keys():
		$to_city.add_item(i)
	$to_city.select(-1)
	Connection_.append(selected_facto)
	print(Connection_)
	pass # Replace with function body.


func to_city_item_selected(index):
	var send_this_city = $to_city.get_item_text(index)
	Connection_.append(send_this_city)
	print(Connection_)
	$from_city.disabled = true
	$factory_type.disabled = true
	$to_city.disabled = true
	$cancel_button.disabled = false
	$cancel_button.visible = true
	connenction_created.emit(Connection_)
	#send the connection info to the logistics handler
	pass # Replace with function body.


func _on_cancel_button_pressed():
	connection_destroyed.emit(Connection_)
	#send info to the logistics handler to stop the transfer of goods
	#destroy the line
	queue_free()
	pass # Replace with function body.
