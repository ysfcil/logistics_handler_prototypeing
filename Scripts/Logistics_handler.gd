extends Node
signal to_connection(factories_by_city)
var log_budget: float = 10
var goods_by_city = {"Bangladesh":[107,1,2], "London": [10,1,3], "New_York": [500,1,4]}
var factories_by_city = {"Bangladesh":[1,0,0], "London": [0,0,0], "New_York": [0,0,0]}
var wages_by_city = {"Bangladesh":[100,230,350], "London": [500,670,890], "New_York": [689,890,1000]}
var goods_by_city_for_Sale = {"Bangladesh":[0,0,0], "London": [0,0,0], "New_York": [0,0,0]}
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
	Money = 10000000
	send_info_to_city()
	to_connection.emit(factories_by_city)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	pass


func _on_timer_timeout():
	for i in len (connections):
		if connections[i][0] == connections[i][2]:
			if connections[i][1] == "Vehicle":
				if goods_by_city[connections[i][2]][2] > 0:
					goods_by_city_for_Sale[connections[i][2]][2] += goods_by_city[connections[i][0]][2]
					goods_by_city[connections[i][0]][2] = 0
				
			if connections[i][1] == "Plastics":
				if goods_by_city[connections[i][2]][0] > 0:
					goods_by_city_for_Sale[connections[i][2]][0] += goods_by_city[connections[i][0]][0]
					goods_by_city[connections[i][0]][0] = 0
			if connections[i][1] == "Electronics":
				if goods_by_city[connections[i][2]][1] > 0:
					goods_by_city_for_Sale[connections[i][2]][1] += goods_by_city[connections[i][0]][1]
					goods_by_city[connections[i][0]][1] = 0	
		else:
			if connections[i][1] == "Vehicle":
				if goods_by_city[connections[i][0]][2] > transferred_amount:
					goods_by_city[connections[i][0]][2] -= transferred_amount
					goods_by_city_for_Sale[connections[i][2]][2] += transferred_amount
				else:
					goods_by_city_for_Sale[connections[i][2]][2] += goods_by_city[connections[i][0]][2]
					goods_by_city[connections[i][0]][2] = 0
			if connections[i][1] == "Plastics":
				if goods_by_city[connections[i][0]][0] > transferred_amount:
					goods_by_city[connections[i][0]][0] -= transferred_amount
					goods_by_city_for_Sale[connections[i][2]][0] += transferred_amount
				else:
					goods_by_city_for_Sale[connections[i][2]][0] += goods_by_city[connections[i][0]][2]
					goods_by_city[connections[i][0]][0] = 0
			if connections[i][1] == "Electronics":
				if goods_by_city[connections[i][0]][1] > transferred_amount:
					goods_by_city[connections[i][0]][1] -= transferred_amount
					goods_by_city_for_Sale[connections[i][2]][1] += transferred_amount
				else:
					goods_by_city_for_Sale[connections[i][2]][1] += goods_by_city[connections[i][0]][2]
					goods_by_city[connections[i][0]][1] = 0		
	
	
	
	
	
	
	
	
	#delivery of connected lines
	#for i in len(connections):
	#	for j in len(goods_by_city["Bangladesh"]):
	#		transferred_amount = 10
	#		if goods_by_city[connections[i][0]][j] > transferred_amount:
	#			goods_by_city[connections[i][0]][j] -= transferred_amount
	#			goods_by_city[connections[i][1]][j] += transferred_amount
	#		else:
	#			transferred_amount = goods_by_city[connections[i][0]][j]
	#			goods_by_city[connections[i][0]][j] = 0
	#			goods_by_city[connections[i][1]][j] += transferred_amount
	#produciton and payement
	for i in len(goods_by_city):
		for j in len(goods_by_city.values()):
			if resources["Oil1"][0]:
				goods_by_city.values()[i][0] += factories_by_city.values()[i][0]*100
				Money -= resources["Oil1"][2]*100
			if resources["Oil2"][0]:
				goods_by_city.values()[i][0] += factories_by_city.values()[i][0]*100
				Money -= resources["Oil2"][2]*100
			if resources["Lithium1"][0]:
				goods_by_city.values()[i][1] += factories_by_city.values()[i][1]*50
				Money -= resources["Lithium1"][2]*100
			if resources["Lithium2"][0]:
				goods_by_city.values()[i][1] += factories_by_city.values()[i][1]*50
				Money -= resources["Lithium2"][2]*100
			if resources["Gold1"][0]:
				goods_by_city.values()[i][2] += factories_by_city.values()[i][2]*10
				Money -= resources["Gold1"][2]*100
			if resources["Gold2"][0]:
				goods_by_city.values()[i][2] += factories_by_city.values()[i][2]*10
				Money -= resources["Gold2"][2]*100
			#Money -= wages_by_city.values()[i][j] * factories_by_city.values()[i][j]
			
	#payment
	
	#SELLING
	for _city in goods_by_city_for_Sale:
		for i in len(goods_by_city_for_Sale[_city]):
			var potential_sell = 100
			if  goods_by_city_for_Sale[_city][i] > potential_sell:
				goods_by_city_for_Sale[_city][i] -= potential_sell
				Money += 100*potential_sell
			else:
				Money += 100*goods_by_city_for_Sale[_city][i]
				goods_by_city_for_Sale[_city][i] = 0
	send_info_to_city()
	
	
	pass # Replace with function body.
func send_info_to_city():
	for i in len(goods_by_city):
		city_has_goods.emit(goods_by_city.keys()[i], goods_by_city.values()[i], Money, wages_by_city, goods_by_city_for_Sale)
	to_connection.emit(factories_by_city)

func factory_info(name_of_the_city, factories_it_has, money_):
	set_deferred("Money", money_)
	factories_by_city[name_of_the_city] = factories_it_has
	to_connection.emit(factories_by_city)
	pass # Replace with function body.


func resource_to_logistics(resource_):
	resources = resource_
	pass # Replace with function body.


func new_connection_connenction_created(connection_info):
	connections.append(connection_info)
	pass # Replace with function body.


func connection_destroyed(connection_info):
	connections.erase(connection_info)
	pass # Replace with function body.

