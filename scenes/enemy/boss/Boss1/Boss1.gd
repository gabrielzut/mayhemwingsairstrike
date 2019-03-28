extends KinematicBody2D

export var scrollDown = 20
export var pausado = true
signal finished()
signal destroyed()
var destroyed = false

func _ready():
	if pausado:
		$CanhaoEnemy.visible = true
		$CanhaoEnemy2.visible = true
		$CanhaoEnemy3.visible = true
		$CanhaoEnemy4.visible = true
		$CanhaoEnemy5.visible = true
	else:
		start()

func start():
	pausado = false
	scrollDown = 0
	
	for child in get_children():
		if child.has_method("start") and child.name != "Boss1Center" and child.name != "TimerDestroyed":
			child.start()
	
func _physics_process(delta):
	move_and_slide(Vector2(0,scrollDown))
	
	if $Boss1Center.pausado == true and !has_node("Boss1Gun") and !has_node("Boss1Gun2") and $Boss1Launcher.destroyed == true and $CanhaoEnemy.destroyed == true and $CanhaoEnemy2.destroyed == true and $CanhaoEnemy3.destroyed == true and $CanhaoEnemy4.destroyed == true and $CanhaoEnemy5.destroyed == true:
		$Boss1Center.start()
		
	if $Boss1Center.destroyed == true and destroyed == false:
		$TimerDestroyed.start()
		destroyed = true
		emit_signal("finished")
		for child in get_tree().get_root().get_child(1).get_children():
			if "Shot" in child.name:
				child.queue_free()

func _on_TimerDestroyed_timeout():
	emit_signal("destroyed")
