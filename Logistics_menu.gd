extends Window
var index_ = {0 : "Bangladesh", 1 : "New_York",2 :  "London"}
var cities = ["Bangladesh", "New_York", "London"]
# Called when the node enters the scene tree for the first time.
func _ready():
	
	for i in cities:
		$connection_create/PopupMenu.add_check_item(i)
			
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	pass

func _on_popup_menu_index_pressed(index):
	$connection_create/sender_name.text = str(index_[index])
	var dummycity = cities
	cities.remove_at(index)
	for i in cities:
		$connection_create/PopupMenu2.add_check_item(i)
	cities = dummycity
	$connection_create/PopupMenu2.visible = true
	
	
	pass # Replace with function body.
