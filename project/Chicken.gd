extends KinematicBody2D


var speed := 10;
var stamina := 10;
var chkn_name:String
var wins := 0
var farm := "Me"

const HIGH = 20
const MED = 15
const LOW = 10

enum skills {
	HIGH = 20
	MED = 15
	LOW = 10
}

enum states {
	RACING
	CHILLING,
	NOTHING
}

onready var saunter_timer:Timer = $Saunter
onready var animatied_sprite := $AnimatedSprite2
onready var Modal := preload("res://Modal.tscn")
onready var debounce := $Debounce
var modal

var state:int
var saunter_dir

var rng = RandomNumberGenerator.new()

var boost:int

signal finished(chicken)
signal was_clicked(chicken)

func _ready():
	pass # Replace with function body.

func set_skills(skill_sp:int, skill_st:int, new_name:String="Agnes"):
	rng.randomize()
	self.speed = rng.randfn(skill_sp, 10)
	self.stamina = rng.randfn(skill_st, 10)
	self.chkn_name = new_name
	self.boost = stamina
	print("New chicken speed: " + str(speed) + ", stamina: " + str(stamina))
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if state == states.NOTHING:
		animatied_sprite.playing = false
		return
	elif state == states.RACING:
		boost = boost - 1
		var velocity = Vector2(speed* (2 if boost > 0 else 1), 0)
		var collision = move_and_collide(velocity * delta)
		if collision && collision.collider.name == "FinishLine":
			print("chicken finished")
			wins += 1
			emit_signal("finished", self)
	elif state == states.CHILLING:
		if saunter_dir == null:
			saunter_dir = Vector2(rng.randf_range(-0.5, 0.5), rng.randf_range(-0.5, 0.5))
			saunter_timer.start(randi() % 6 + 1)
		else:
			var linear_velocity := move_and_slide(saunter_dir * speed * (2 if boost > 0 else 1))
			animatied_sprite.flip_h = saunter_dir.x < 0
			animatied_sprite.playing = linear_velocity.length() > 0.2

func _on_Saunter_timeout():
	saunter_dir = null

func _on_Chicken_mouse_entered() -> void:
	if modal:return
	modal = Modal.instance()
	modal._set_stats([chkn_name,
		"Stamina: " + str(stamina), 
		"Speed: " + str(speed),
		"Wins: " + str(wins),
		"Owner: " + farm
		])
	add_child(modal)

func _on_Chicken_mouse_exited() -> void:
	if modal: 
		debounce.start()

func _on_Debounce_timeout() -> void:
		modal.queue_free()
		modal = null

func _on_Chicken_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventScreenTouch && event.pressed:
		emit_signal("was_clicked", self)

func save():
	var save_dict = {
		"filename" : get_filename(),
		"parent" : get_parent().get_path(),
		"pos_x" : position.x,
		"pos_y" : position.y,
		"chkn_name" : chkn_name,
		"stamina" : stamina,
		"speed" : speed,
		"wins" : wins,
		"farm:" : farm
	}
	return save_dict
