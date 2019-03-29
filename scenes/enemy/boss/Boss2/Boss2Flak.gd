extends "res://classes/destructable.gd"

export var weapon = preload("res://scenes/props/EnemyShot3.tscn")
export var pausado = true
export var destroyed = false

func _ready():
	if pausado:
		$AnimatedSprite.play("hidden")
		collision_layer = 0
		collision_mask = 0
		$Timer.stop()
	else:
		start()

func start():
	$AnimatedSprite.play("start")
	pausado = false
	collision_layer = 1
	collision_mask = 8
	$Timer.start()
	
func _on_Timer_timeout():
	if pausado == false and destroyed == false:
		var shoot = weapon.instance()
		shoot.global_position = $Position2D.get_global_position()
		shoot.seguir = true
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
		explosion.scale = Vector2(1,1)
		get_parent().add_child(explosion)
		explosion.explode()
		
		var fire = preload("res://scenes/particles/fire.tscn")
		var firedestroyed = fire.instance()
		firedestroyed.scale = Vector2(0.5,0.5)
		firedestroyed.z_index = 1
		destroyed = true
		$Timer.stop()
		$CollisionShape2D.disabled = true
		firedestroyed.position = $AnimatedSprite.position
		add_child(firedestroyed)
		$AnimatedSprite.play("destroyed")

func _on_AnimatedSprite_animation_finished():
	if "start" in $AnimatedSprite.animation:
		$AnimatedSprite.play("normal")
