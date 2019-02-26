extends KinematicBody2D

export var hp = 1
onready var singletons = get_node("/root/Singletons")
export var score = 0

export var drop = false
export var powerup = preload("res://scenes/powerups/BombPowerup.tscn")

func damage(dmg):
	hp -= dmg

	if hp <= 0:
		singletons.addScore(score)
		var explosion = singletons.explosion.instance()
		if drop != false:
			var powerupDrop = powerup.instance()
			powerupDrop.position = position
			get_parent().add_child(powerupDrop)
		explosion.position = position
		get_parent().add_child(explosion)
		explosion.explode()
		queue_free()