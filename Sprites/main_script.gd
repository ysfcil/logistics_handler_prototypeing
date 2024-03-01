extends Node2D
var rd_points_plastics : float = 10
var rd_points_electronics : float = 10
var rd_points_software : float = 10
var rd_points_hardware : float = 10
var budget : Dictionary = {"RandD": 10, "Logistics": 10, "Marketing": 10, "Military": 10}
# Called when the node enters the scene tree for the first time.
func _ready():
	$Logistics_handler.log_budget = budget["Logistics"]
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Money_label.text = str($Logistics_handler.Money)
	pass


func _on_timer_timeout():
	rd_points_electronics += 1 * budget["RandD"]
	rd_points_hardware += 1 * budget["RandD"]
	rd_points_plastics += 1 * budget["RandD"]
	rd_points_software += 1 * budget["RandD"]
	pass # Replace with function body.
