extends Node2D

signal exploded(confirmation)

func _ready():
	if scale.x < 1:
		$PlayerExplode.volume_db = -25
	elif scale.x > 1:
		$PlayerExplode.volume_db = -15

func explode():
	$AnimatedSprite.play("explode")
	$PlayerExplode.play()

func _on_AnimatedSprite_animation_finished():
	emit_signal("exploded",true)
	queue_free()