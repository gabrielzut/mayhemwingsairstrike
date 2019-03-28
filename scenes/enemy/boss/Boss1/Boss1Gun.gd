extends "res://classes/destructable.gd"

export var weapon = preload("res://scenes/props/EnemyShot3.tscn")
export var pausado = true
var shots = 0

func _ready():
	if pausado:
		collision_layer = 0
		collision_mask = 0
	else:
		start()

func start():
	pausado = false
	collision_layer = 1
	collision_mask = 8
	
func _on_Timer_timeout():
	if pausado == false:
		$Timer2.start()
	
func _on_Timer2_timeout():
	if shots < 3:
		var shoot = weapon.instance()
		shoot.global_position = $Position2D.get_global_position()
		get_tree().get_root().get_child(1).add_child(shoot)
		shots += 1
	else:
		shots = 0
		$Timer2.stop()

func damage(dmg):
	hp -= dmg
	get_node("AnimationPlayer").stop()
	get_node("AnimationPlayer").play("damage")
	$PlayerHit.play()

	if hp <= 0:
		singletons.addScore(score)
		var explosion = singletons.explosion.instance()
		explosion.position = position
		get_parent().add_child(explosion)
		explosion.explode()
		queue_free()
