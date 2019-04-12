extends KinematicBody2D

export var scrollDown = 20
export var pausado = true
signal finished()
signal destroyed()
var destroyed = false

func _ready():
	if !pausado:
		start()

func start():
	pausado = false
	$TimerMove.start()
	$TimerTrail.start()
	$Boss2Cannon.visible = true
	$Boss2Minigun.visible = true
	
func _physics_process(delta):
	move_and_slide(Vector2(0,scrollDown))
	
	if $Boss2Flak.pausado == true and !has_node("Boss2Minigun"):
		$Boss2Flak.start()
		$Boss2Flak2.start()
		$Boss2Flak3.start()
		$Boss2Flak4.start()
		$Boss2Cannon.setTargetable()
		
	if $Boss2Cannon.destroyed == true and destroyed == false:
		$Boss2Cannon.z_index = 1
		scrollDown = 20
		
		if !$Boss2Flak.destroyed:
			$Boss2Flak.damage(300)
		if !$Boss2Flak2.destroyed:
			$Boss2Flak2.damage(300)
		if !$Boss2Flak3.destroyed:
			$Boss2Flak3.damage(300)
		if !$Boss2Flak4.destroyed:
			$Boss2Flak4.damage(300)
		$TimerDestroyed.start()
		destroyed = true
		emit_signal("finished")
		for child in get_tree().get_root().get_child(1).get_children():
			if "Shot" in child.name:
				child.queue_free()

func _on_TimerDestroyed_timeout():
	emit_signal("destroyed")

func _on_TimerTrail_timeout():
	var trail = preload("res://scenes/enemy/boss/Boss2/Boss2Trail.tscn").instance()
	trail.global_position = $Position2D.global_position
	trail.z_index = -2
	get_tree().get_root().get_child(1).add_child(trail)

func _on_TimerMove_timeout():
	scrollDown = 0
	$Boss2Cannon.start()
	$Boss2Minigun.start()