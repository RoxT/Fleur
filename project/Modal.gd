extends Node2D

onready var panel := $PanelContainer/Panel/VBoxContainer

var labels:Array

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if !labels.empty():
		for l in labels:
			panel.add_child(l)

func _set_stats(stats:Array):
	assert(!stats.empty(), "Why modal if no stats??")
	for m in stats:
		var label := Label.new()
		label.text = m
		if panel: 
			panel.add_child(label)
		else:
			labels.append(label)
		
