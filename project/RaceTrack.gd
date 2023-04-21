extends Node2D

export var number_of_racers: int

var chicken_scene = preload("res://Chicken.tscn")

onready var lane_x = $Position2D.position.x
onready var lane_y = $Position2D.position.y

var chickens = []

# Called when the node enters the scene tree for the first time.
func _ready():
	var all_chickens = Util.load_game()
	$CanvasLayer/MoneyLabel.text = str(Util.money)
	for i in min(all_chickens.size(), number_of_racers):
		add_chicken(all_chickens[i])


func add_chicken(c:Node):
	add_child(c)
	chickens.append(c)
	c.position = Vector2(lane_x, lane_y*chickens.size())
	c.connect("finished", self, "_on_Chicken_finished")
	
	
func _on_Chicken_finished(winner):
	$WiinerGold.position = winner.position
	for c in chickens: c.state = c.states.NOTHING
	Util.money += 5
	$CanvasLayer/MoneyLabel.text = str(Util.money)


func _on_CoopButton_pressed() -> void:
	Util.save_game()
	get_tree().change_scene("res://Coop.tscn")
