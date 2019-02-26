extends KinematicBody2D

export var scrollDown = 20.2
signal collision(confirmation)

func _physics_process(delta):
	move_and_slide(Vector2(0,scrollDown))
	
	if $Position2D.global_position.y >= 370:
		emit_signal("collision",true)
		queue_free()