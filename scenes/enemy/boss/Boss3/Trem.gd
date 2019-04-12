extends "res://classes/destructable.gd"

export var weapon = preload("res://scenes/props/EnemyShot4.tscn")
export var pausado = true
export var destroyed = false
export var shootSpeed = 0

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
		var shoot1 = weapon.instance()
		var shoot2 = weapon.instance()
		var shoot3 = weapon.instance()
		shoot1.seguir = false
		shoot2.seguir = false
		shoot3.seguir = false
		
		if shootSpeed > 0:
			shoot1.maxVelocidade = shootSpeed
			shoot2.maxVelocidade = shootSpeed
			shoot3.maxVelocidade = shootSpeed
		
		shoot1.position = $Position2D.get_global_position()
		shoot2.position = $Position2D.get_global_position()
		shoot3.position = $Position2D.get_global_position()
		var pos = Vector2(0,0)
		if get_tree().get_root().get_child(1).has_node("Player"):
			pos = get_tree().get_root().get_child(1).get_node("Player").position
		shoot1.look_at(pos)
		shoot2.look_at(pos)
		shoot3.look_at(pos)
		shoot1.global_rotation_degrees += 90
		shoot2.global_rotation_degrees += 75
		shoot3.global_rotation_degrees += 105
		get_tree().get_root().get_child(1).add_child(shoot1)
		get_tree().get_root().get_child(1).add_child(shoot2)
		get_tree().get_root().get_child(1).add_child(shoot3)

func damage(dmg):
	hp -= dmg
	get_node("AnimationPlayer").stop()
	get_node("AnimationPlayer").play("damage")
	$PlayerHit.play()

	if hp <= 0:
		singletons.addScore(score)
		var explosion = singletons.explosion.instance()
		explosion.position = Vector2($Position2D.position.x - 25,$Position2D.position.y)
		explosion.scale = Vector2(4,4)
		explosion.z_index = 4
		get_parent().add_child(explosion)
		explosion.explode()
		
		var fire = preload("res://scenes/particles/fire.tscn")
		var firedestroyed = fire.instance()
		firedestroyed.scale = Vector2(4,4)
		destroyed = true
		$Timer.stop()
		$CollisionPolygon2D.disabled = true
		firedestroyed.position = Vector2($Position2D.position.x - 25,$Position2D.position.y)
		firedestroyed.z_index = 4
		add_child(firedestroyed)