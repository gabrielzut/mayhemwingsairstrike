extends KinematicBody2D

export var hp = 1
onready var singletons = get_node("/root/Singletons")
export var score = 0

func damage(dmg):
	hp -= dmg

	if hp <= 0:
		singletons.addScore(score)
		queue_free()