extends HBoxContainer

export var title:String setget set_title
export var price:int setget set_price

onready var label := $Label
onready var spinbox := $SpinBox
onready var buy_button := $BuyButton

signal bought(title, price, quantity)

func _ready() -> void:
	update_label()
	
func set_title(value):
	title = value
	update_label()

func set_price(value):
	price = value
	update_label()

func _on_BuyButton_pressed() -> void:
	emit_signal("bought", title, price, spinbox.value)
	spinbox.value = 0

func update_label():
	if label:
		label.text = title + " - $" + str(price)
