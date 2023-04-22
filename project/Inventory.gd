extends Control

onready var feed_list := $Inventory/HBox/FeedContainer
onready var store_list := $Inventory/HBox/StoreContainer/HBox/StoreList

var items := {}

func _ready() -> void:
	for node in store_list.get_children():
		node.connect("bought", self, "_on_StoreItem_bought")

func add_to_inventory(title, quantity):
	var row := Label.new()
	row.text = title + " - " + str(quantity) + " units"
	feed_list.add_child(row)	
	
func _on_StoreItem_bought(title, price, quantity):
	#Deduct price
	if items.has(title):
		items[title] = items[title] + quantity
		for l in feed_list.get_children():
			l = l as Label
			if l.text.begins_with(title):
				l.text = title + " - " + str(items[title]) + " units"
	else:
		items[title] = quantity
		add_to_inventory(title, quantity)


