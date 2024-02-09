extends Panel
signal sending_goods(sender, cities_connected_to)
signal  logistics_handler_info(goods_out, goods_in)
signal logistics_handler_factory_info(name_of_the_city, factories_it_has, money)
var name_city
var connection_process_on_going
var connection_estabilished = 0
var max_connection = 1
var goods_ = [1,2,3]
var goods_for_sale = [0,0,0]
@export var factroies = [1,0,0]
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
	pass
			
func info_update():
	$Goods_label.text = "Plastics: %d" % [goods_[0]]
	$Factory_label.text = "| %d" % [factroies[0]]
	$Goods_label2.text = "Electronics: %d" % [goods_[1]]
	$Factory_label2.text = "| %d" % [factroies[1]]
	$Goods_label3.text = "Vehicles: %d" % [goods_[2]]
	$Factory_label3.text = "| %d" % [factroies[2]]
	logistics_handler_factory_info.emit(name_city, factroies, money_)
	


func _on_logistics_handler_city_has_goods(name_name, name_goods, Money, wages, sale_goods):
	money_ = Money
	if name_name == name_city:
			goods_ = name_goods
			wages = wages_
			sale_goods[name_city] = goods_for_sale
			print(goods_for_sale)
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
