extends Node2D

signal exploded(confirmation)

func explode():
	$AnimatedSprite.play("explode")

func _on_AnimatedSprite_animation_finished():
	emit_signal("exploded",true)
	queue_free()
