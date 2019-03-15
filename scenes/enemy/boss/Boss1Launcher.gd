extends "res://classes/destructable.gd"

export var weapon = preload("res://scenes/props/EnemyShot2.tscn")
export var destroyed = false
export var pausado = true

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
	if destroyed == false and pausado == false:
		var shoot = weapon.instance()
		shoot.global_position = $Position2D.get_global_position()
		shoot.rotation_degrees = rotation_degrees - 90
		get_tree().get_root().get_child(1).add_child(shoot)
		
func damage(dmg):
	hp -= dmg
	get_node("AnimationPlayer").stop()
	get_node("AnimationPlayer").play("damage")

	if hp <= 0 and destroyed == false:
		singletons.addScore(score)
		var explosion = singletons.explosion.instance()
		explosion.position = position
		explosion.scale = Vector2(1.4,1.4)
		get_parent().add_child(explosion)
		explosion.explode()
		
		var fire = preload("res://scenes/particles/fire.tscn")
		var firedestroyed = fire.instance()
		firedestroyed.scale = Vector2(2,2)
		destroyed = true
		$Timer.stop()
		$CollisionPolygon2D.disabled = true
		firedestroyed.position = $Sprite.position
		add_child(firedestroyed)
		$Sprite.hide()