extends Node
var goods_by_city = {"Bangladesh":[107,1,2], "London": [10,1,3], "New_York": [500,1,4]}
var factories_by_city = {"Bangladesh":[0,0,0], "London": [0,0,0], "New_York": [0,0,0]}
var wages_by_city = {"Bangladesh":[100,230,350], "London": [500,670,890], "New_York": [689,890,1000]}
@onready var positions_cities = {"Bangladesh":$Bangladesh.global_position, "London": $London.position, "New_York": $New_York.position}
signal connection_created(out_, in_)
signal linePositions(first, second)
signal city_has_goods(name_name, name_goods, money, wages)
var connections = []
var Money
@export var line_scene : PackedScene
@export var transferred_amount = 10
var resources = {}
# Called when the node enters the scene tree for the first time.
func _ready():
	Money = 10000
	send_info_to_city()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	print(goods_by_city)
	pass


func logistics_handler_info(goods_out, goods_in):
	if ![goods_in, goods_out] in connections:
		connections.append([goods_out, goods_in])
		connection_created.emit(goods_out, goods_in)
		draw_line(goods_out, goods_in)
	pass # Replace with function body.
func draw_line(out_, in_):
	var l = line_scene.instantiate()
	l.out_point_name = out_
	l.in_point_name = in_
	l.first_point = positions_cities[out_]
	l.second_point = positions_cities[in_]
	call_deferred("add_child", l)
	pass

func _on_timer_timeout():
	#delivery of connected lines
	for i in len(connections):
		for j in len(goods_by_city["Bangladesh"]):
			transferred_amount = 10
			if goods_by_city[connections[i][0]][j] > transferred_amount:
				goods_by_city[connections[i][0]][j] -= transferred_amount
				goods_by_city[connections[i][1]][j] += transferred_amount
			else:
				transferred_amount = goods_by_city[connections[i][0]][j]
				goods_by_city[connections[i][0]][j] = 0
				goods_by_city[connections[i][1]][j] += transferred_amount
	#produciton and payement
	for i in len(goods_by_city):
		for j in len(goods_by_city.values()):
			if resources["Oil1"][0] or resources["Oil2"][0]:
				goods_by_city.values()[i][j] += factories_by_city.values()[i][j]*100
			Money -= wages_by_city.values()[i][j] * factories_by_city.values()[i][j]
			
	#payment
	send_info_to_city()
	
	pass # Replace with function body.
func send_info_to_city():
	for i in len(goods_by_city):
		city_has_goods.emit(goods_by_city.keys()[i], goods_by_city.values()[i], Money, wages_by_city)
	pass

func factory_info(name_of_the_city, factories_it_has, money_):
	set_deferred("Money", money_)
	factories_by_city[name_of_the_city] = factories_it_has
	pass # Replace with function body.


func resource_to_logistics(resource_):
	resources = resource_
	pass # Replace with function body.
