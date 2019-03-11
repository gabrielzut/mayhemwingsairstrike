extends KinematicBody2D

export var pausado = true
export var scrollDown = 20

func start():
	pausado = false
	scrollDown = 0

func _physics_process(delta):
	move_and_slide(Vector2(0,scrollDown))
	
	if pausado == false:
		$Cloud1.move_and_slide(Vector2(50,0))
		$Cloud2.move_and_slide(Vector2(-70,0))
		$Cloud3.move_and_slide(Vector2(60,0))
		$Cloud4.move_and_slide(Vector2(-50,0))
		$Cloud5.move_and_slide(Vector2(60,0))
		$Cloud6.move_and_slide(Vector2(-70,0))

func _on_VisibilityNotifier2D_screen_exited():
	if pausado == false:
		queue_free()
