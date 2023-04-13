extends Node2D


var Chicken := preload("res://Chicken.tscn")
var Float := preload("res://Float.tscn")
onready var remove_chicken := $"CanvasLayer/Remove Chicken"

const left_boundary = 70
const right_boundary = 720

const names := ["Aimeé","Belle","Bijou","Chérie","Coquette","Fleur","Lyonette","Mignon"]

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Add_Chicken_button_down():
	var c = Chicken.instance()
	add_child(c)
	c.set_skills(70, 70, names[randi() % names.size()])
	c.state = c.states.CHILLING
	c.position.x = randi() % (right_boundary-left_boundary) + left_boundary
	c.connect("was_clicked", self, "_on_Chicken_was_clicked")

func _on_Chicken_was_clicked(chicken:Node):
	if remove_chicken.pressed:
		chicken.queue_free()
		var float_text := Float.instance()
		float_text.position = chicken.position
		add_child(float_text)

func _on_Remove_Chicken_toggled(button_pressed: bool) -> void:
	if button_pressed:
		remove_chicken.modulate = Color.red
	else:
		remove_chicken.modulate = Color.white
