extends KinematicBody2D

export var scrollDown = 20

func _physics_process(delta):
	move_and_slide(Vector2(0,20))

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()