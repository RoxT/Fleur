extends Node2D

export var number_of_racers: int

var chicken_scene = preload("res://Chicken.tscn")

onready var lane_x = $Position2D.position.x
onready var lane_y = $Position2D.position.y

var chickens = []

# Called when the node enters the scene tree for the first time.
func _ready():
	for i in number_of_racers:
		add_chicken()


func add_chicken():
	var c = chicken_scene.instance()
	c.set_skills(70, 70)
	add_child(c)
	chickens.append(c)
	c.position = Vector2(lane_x, lane_y*chickens.size())
	c.connect("finished", self, "_on_Chicken_finished")
	
	
func _on_Chicken_finished(winner):
	$WiinerGold.position = winner.position
	get_tree().paused = true
