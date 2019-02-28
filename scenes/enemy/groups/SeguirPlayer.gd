extends KinematicBody2D

export var scrollDown = 20.2

export var drop = false
export var powerup = preload("res://scenes/powerups/BombPowerup.tscn")
export var pausado = true

onready var singletons = get_node("/root/Singletons")

func start():
	pausado = false
	for child in get_children():
		child.start()
		if drop == true and child.drop == true:
			child.powerup = powerup
		elif drop == false:
			child.drop = false
	
func _ready():
	if pausado == false:
		start()
	
func _physics_process(delta):
	if pausado == true and get_tree().get_root().get_child(1).has_node("Player"):
		for child in get_children():
			var pos = get_tree().get_root().get_child(1).get_node("Player").position
			child.look_at(pos)
			child.global_rotation_degrees += 90
	
	move_and_slide(Vector2(0,scrollDown))
	
	if get_child_count() == 0:
		queue_free()