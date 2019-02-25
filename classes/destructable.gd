extends KinematicBody2D

export var hp = 1
onready var singletons = get_node("/root/Singletons")
export var score = 0

func damage(dmg):
	hp -= dmg

	if hp <= 0:
		singletons.addScore(score)
		var explosion = singletons.explosion.instance()
		explosion.position = position
		get_parent().add_child(explosion)
		explosion.explode()
		queue_free()