extends "res://classes/destructable.gd"

export var weapon = preload("res://scenes/props/EnemyShot5.tscn")
export var destroyed = false
export var pausado = true
export var shootInterval = 1.5
export var shootSpeed = 0

func _ready():
	$Timer.wait_time = shootInterval
	
	if pausado:
		collision_layer = 0
		collision_mask = 0
	else:
		start()

func start():
	pausado = false
	collision_layer = 1
	collision_mask = 8
	$Timer.start()

func _physics_process(delta):
	if get_tree().get_root().get_child(1).has_node("Player") and destroyed == false:
		var pos = get_tree().get_root().get_child(1).get_node("Player").position
		look_at(pos)
	
func _on_Timer_timeout():
	if destroyed == false and pausado == false:
		var shoot = weapon.instance()
		
		if shootSpeed > 0:
			shoot.maxVelocidade = shootSpeed
		
		shoot.position = $Position2D.get_global_position()
		shoot.seguir = true
		shoot.scale = Vector2(0.5,0.5)
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
		explosion.scale = Vector2(1.3,1.3)
		explosion.z_index = 3
		get_parent().add_child(explosion)
		explosion.explode()
		
		var fire = preload("res://scenes/particles/fire.tscn")
		var firedestroyed = fire.instance()
		destroyed = true
		$Timer.stop()
		$CollisionPolygon2D.disabled = true
		firedestroyed.global_rotation_degrees = -90
		firedestroyed.scale = Vector2(1.3,1.3)
		firedestroyed.position = $Sprite.position
		add_child(firedestroyed)
		$Sprite.hide()