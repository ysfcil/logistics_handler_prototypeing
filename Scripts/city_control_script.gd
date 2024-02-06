extends Panel
signal sending_goods(sender, cities_connected_to)
signal  logistics_handler_info(goods_out, goods_in)
signal logistics_handler_factory_info(name_of_the_city, factories_it_has, money)
var name_city
var sender_city
var connection_process_on_going
var connection_estabilished = 0
var max_connection = 1
var cities_connected_to_as_in = []
var cities_connected_to_as_out = []
var goods_ = [1,2,3]
var factroies = [0,0,0]
var wages_ = [0,0,0]
var money_
@export var factory_cost = 100
# Called when the node enters the scene tree for the first time.
func _ready():
	name_city = name
	info_update()
	$Name_label.text = name_city
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if $in_button.button_pressed:
			logistics_handler_info.emit(sender_city, name_city)
			print(sender_city, name_city)
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and connection_process_on_going:
			$in_button.set_deferred("visible",false)
			$in_button.set_deferred("disabled", true)
			set_deferred("connection_process_on_going", false)
			set_deferred("sender_city", "")
			
func info_update():
	$Goods_label.text = "Plastics: %d" % [goods_[0]]
	$Factory_label.text = "| %d" % [factroies[0]]
	$Goods_label2.text = "Electronics: %d" % [goods_[1]]
	$Factory_label2.text = "| %d" % [factroies[1]]
	$Goods_label3.text = "Vehicles: %d" % [goods_[2]]
	$Factory_label3.text = "| %d" % [factroies[2]]
	logistics_handler_factory_info.emit(name_city, factroies, money_)
	

func out_button_pressed():
	var sender = ""
	sender = name_city
	sending_goods.emit(sender, cities_connected_to_as_in)
	pass # Replace with function body.


func other_city_sending_goods(sender, cities_connected_to):
	sender_city = sender
	if name_city != sender_city and !sender_city in cities_connected_to and !name_city in cities_connected_to and !sender in cities_connected_to_as_in:
		$in_button.visible=true
		$in_button.disabled = false
		set_deferred("connection_process_on_going", true)


func connection_created(out_, in_):
	if name_city == in_:
		cities_connected_to_as_in.append(out_)
	if  name_city == out_:
		cities_connected_to_as_out.append(in_)
	pass # Replace with function body.


func _on_logistics_handler_city_has_goods(name_name, name_goods, Money, wages):
	money_ = Money
	if name_name == name_city:
			goods_ = name_goods
			wages = wages_
	info_update()
	pass # Replace with function body.


func _on_facto_buy_pressed():
	#moneycheck
	if money_ >= factory_cost:
		print(name_city)
		money_ -= factory_cost
		factroies[0] += 1
		logistics_handler_factory_info.emit(name_city, factroies, money_)
		info_update()
	pass # Replace with function body.
