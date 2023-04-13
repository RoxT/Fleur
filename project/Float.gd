extends Node2D

const food_words := ["Delicious", "Yummm", "That wasn't even dry", "Crispy!", "Mmmmmm", ]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Label.text = food_words[randi() % food_words.size()]

