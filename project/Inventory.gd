extends Control

onready var inventory_container := $Inventory/HBoxContainer/Feed

var inv = {
	"Pellets": 100
}

func _ready() -> void:
	for i in inv.keys():
		var row := Label.new()
		row.text = i

			
			
		
