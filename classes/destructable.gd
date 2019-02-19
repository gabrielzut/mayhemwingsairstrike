extends KinematicBody2D

export var hp = 1

func damage(dmg):
	hp -= dmg

	if hp <= 0:
		queue_free()