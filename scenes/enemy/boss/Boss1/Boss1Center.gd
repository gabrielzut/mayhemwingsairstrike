extends "res://classes/destructable.gd"

export var weapon = preload("res://scenes/props/EnemyShot3.tscn")
export var pausado = true
export var destroyed = false

func _ready():
	if pausado:
		collision_layer = 0
		collision_mask = 0
		$Timer.stop()
	else:
		start()

func start():
	pausado = false
	collision_layer = 1
	collision_mask = 8
	$Timer.start()
	
func _on_Timer_timeout():
	if pausado == false and destroyed == false:
		var shoot = weapon.instance()
		shoot.global_position = $Position2D.get_global_position()
		shoot.global_rotation_degrees = rand_range(140,250)
		shoot.seguir = false
		get_tree().get_root().get_child(1).add_child(shoot)

func damage(dmg):
	hp -= dmg
	get_node("AnimationPlayer").stop()
	get_node("AnimationPlayer").play("damage")
	$PlayerHit.play()

	if hp <= 0:
		singletons.addScore(score)
		var explosion = singletons.explosion.instance()
		explosion.position = position
		explosion.scale = Vector2(3,3)
		get_parent().add_child(explosion)
		explosion.explode()
		
		var fire = preload("res://scenes/particles/fire.tscn")
		var firedestroyed = fire.instance()
		firedestroyed.scale = Vector2(3,3)
		destroyed = true
		$Timer.stop()
		$CollisionPolygon2D.disabled = true
		firedestroyed.position = $Sprite.position
		add_child(firedestroyed)
		$Sprite.hide()
		$Sprite2.hide()