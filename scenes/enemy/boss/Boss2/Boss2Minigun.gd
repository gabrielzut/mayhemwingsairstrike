extends "res://classes/destructable.gd"

export var weapon = preload("res://scenes/props/EnemyShot4.tscn")
export var destroyed = false
export var pausado = true
export var shootInterval = 0.3
export var shootSpeed = 100
var state = "stopped"

func _ready():
	
	$Timer.wait_time = shootInterval
	
	if pausado:
		collision_layer = 0
		collision_mask = 0
		visible = false
	else:
		start()

func start():
	visible = true
	pausado = false
	collision_layer = 1
	collision_mask = 8
	$Timer.start()
	$AnimationTimer.start()
	
func _on_Timer_timeout():
	if destroyed == false and pausado == false and state == "shooting":
		var shoot = weapon.instance()
		
		if shootSpeed > 0:
			shoot.maxVelocidade = shootSpeed
		
		shoot.position = $Position2D.get_global_position()
		shoot.seguir = false
		shoot.rotation_degrees = global_rotation_degrees + 180
		get_tree().get_root().get_child(1).add_child(shoot)
		
func damage(dmg):
	hp -= dmg
	
	get_node("AnimationPlayer").stop()
	get_node("AnimationPlayer").play("damage")
	$PlayerHit.play()

	if hp <= 0 and destroyed == false:
		singletons.addScore(score)
		var explosion = singletons.explosion.instance()
		explosion.position = position
		explosion.scale = Vector2(1.5,1.5)
		get_parent().add_child(explosion)
		explosion.z_index = 2
		explosion.explode()
		queue_free()

func _on_AnimationPlayer2_animation_started(anim_name):
	$AnimationTimer.wait_time = 1.5
	$AnimationTimer.start()

func _on_AnimationTimer_timeout():
	if state == "stopped":
		$AnimationTimer.stop()
		$AnimationTimer.wait_time = 1.5
		$AnimationTimer.start()
		$AnimationPlayer2.play("shooting")
		state = "preparing"
	elif state == "preparing":
		state = "shooting"
		$AnimationTimer.stop()
		$AnimationTimer.wait_time = 2.5
		$AnimationTimer.start()
	elif state == "shooting":
		state = "stopped"
		$AnimationTimer.stop()
		$AnimationTimer.wait_time = 0.5
		$AnimationTimer.start()

func _on_AnimationPlayer2_animation_finished(anim_name):
	$AnimationPlayer2.stop()
