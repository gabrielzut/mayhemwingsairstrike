extends "res://classes/destructable.gd"

export var weapon = preload("res://scenes/props/EnemyShot5.tscn")
export var destroyed = false
export var pausado = true
export var shootInterval = 2.0
export var shootSpeed = 0

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
	$Timer.start()
	
func setTargetable():
	collision_layer = 1
	collision_mask = 8

func _physics_process(delta):
	if get_tree().get_root().get_child(1).has_node("Player") and destroyed == false:
		var pos = get_tree().get_root().get_child(1).get_node("Player").position
		look_at(pos)
	
func _on_Timer_timeout():
	if destroyed == false and pausado == false:
		var shoot1 = weapon.instance()
		var shoot2 = weapon.instance()
		$AnimatedSprite.play("shoot")
		
		if shootSpeed > 0:
			shoot1.maxVelocidade = shootSpeed
			shoot2.maxVelocidade = shootSpeed
		
		shoot1.position = $Position2D.get_global_position()
		shoot2.position = $Position2D2.get_global_position()
		shoot1.seguir = false
		shoot2.seguir = false
		shoot1.rotation_degrees = global_rotation_degrees + 90
		shoot2.rotation_degrees = global_rotation_degrees + 90
		get_tree().get_root().get_child(1).add_child(shoot1)
		get_tree().get_root().get_child(1).add_child(shoot2)
		
func damage(dmg):
	hp -= dmg
	
	get_node("AnimationPlayer").stop()
	get_node("AnimationPlayer").play("damage")
	$PlayerHit.play()

	if hp <= 0 and destroyed == false:
		singletons.addScore(score)
		var explosion = singletons.explosion.instance()
		explosion.position = position
		explosion.scale = Vector2(3,3)
		explosion.z_index = 3
		get_parent().add_child(explosion)
		explosion.explode()
		
		var fire = preload("res://scenes/particles/fire.tscn")
		var firedestroyed = fire.instance()
		destroyed = true
		$Timer.stop()
		$CollisionPolygon2D.disabled = true
		firedestroyed.global_rotation_degrees = -90
		firedestroyed.scale = Vector2(3.5,3.5)
		firedestroyed.position = $AnimatedSprite.position
		add_child(firedestroyed)
		$AnimatedSprite.hide()

func _on_AnimatedSprite_animation_finished():
	$AnimatedSprite.play("normal")
