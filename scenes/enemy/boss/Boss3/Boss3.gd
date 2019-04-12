extends KinematicBody2D

export var scrollDown = 20
export var pausado = true
signal finished()
signal destroyed()
var destroyed = false
var phase = 0

func _ready():
	if !pausado:
		start()

func start():
	pausado = false
	phase = 1
	$AnimationPlayer.play("move1")
	
func _physics_process(delta):
	move_and_slide(Vector2(0,scrollDown))
	
	if phase == 1 and $TremBoss/Boss3Flak.destroyed == true and $TremBoss/Boss3Flak2.destroyed == true and !($TremBoss.has_node("Boss3MG")) and !($TremBoss.has_node("Boss3MG2")) and !($TremBoss.has_node("Boss3MG3")):
		phase = 2
		$AnimationPlayer.play("move2")
	elif phase == 3 and $TremBoss/Boss3Cannon.destroyed == true and !($TremBoss.has_node("Boss3MG4")) and !($TremBoss.has_node("Boss3MG5")) and !($TremBoss.has_node("Boss3MG6")):
		phase = 3
		$AnimationPlayer.play("move4")
		
	if $TremBoss.destroyed == true and destroyed == false:
		emit_signal("finished")
		$TimerDestroyed.start()
		for child in get_tree().get_root().get_child(1).get_children():
			if "Shot" in child.name:
				child.queue_free()
		destroyed = true
		$AnimationPlayer.play("move6")

func _on_TimerDestroyed_timeout():
	emit_signal("destroyed")

func _on_AnimationPlayer_animation_finished(anim_name):
	if "move1" in anim_name:
		$TremBoss/Boss3Flak.start()
		$TremBoss/Boss3Flak/Timer.start()
		$TremBoss/Boss3Flak2.start()
		$TremBoss/Boss3Flak2/Timer.start()
		$TremBoss/Boss3MG.start()
		$TremBoss/Boss3MG/Timer.start()
		$TremBoss/Boss3MG2.start()
		$TremBoss/Boss3MG2/Timer.start()
		$TremBoss/Boss3MG3.start()
		$TremBoss/Boss3MG3/Timer.start()
	elif "move2" in anim_name:
		$AnimationPlayer.play("move3")
		phase = 3
	elif "move3" in anim_name:
		$TremBoss/Boss3MG4.start()
		$TremBoss/Boss3MG4/Timer.start()
		$TremBoss/Boss3MG5.start()
		$TremBoss/Boss3MG5/Timer.start()
		$TremBoss/Boss3MG6.start()
		$TremBoss/Boss3MG6/Timer.start()
		$TremBoss/Boss3Cannon.start()
	elif "move4" in anim_name:
		$AnimationPlayer.play("move5")
		phase = 5
	elif "move5" in anim_name:
		$TremBoss.start()