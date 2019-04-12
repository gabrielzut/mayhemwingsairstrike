extends KinematicBody2D

export var scrollDown = 20
signal finished()

func start():
	$AnimatedSprite.play("launch")

func _physics_process(delta):
	move_and_slide(Vector2(0,scrollDown))

func _on_AnimatedSprite_animation_finished():
	if $AnimatedSprite.animation == "launch":
		$Timer.start()

func _on_Timer_timeout():
	$AnimationPlayer.play("start")

func _on_AnimationPlayer_animation_finished(anim_name):
	emit_signal("finished")
