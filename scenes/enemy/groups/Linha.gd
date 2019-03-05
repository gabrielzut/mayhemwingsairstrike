extends KinematicBody2D

export var scrollDown = 20

export var drop = false
export var powerup = preload("res://scenes/powerups/BombPowerup.tscn")

onready var singletons = get_node("/root/Singletons")

func start():
	for child in get_children():
		child.start()
		if drop == true and child.drop == true:
			child.powerup = powerup
		elif drop == false:
			child.drop = false
	
func _physics_process(delta):
	move_and_slide(Vector2(0,scrollDown))
	
	if get_child_count() == 0:
		queue_free()