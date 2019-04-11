extends "res://classes/destructable.gd"

export var weapon = preload("res://scenes/props/EnemyShot2.tscn")
export var destroyed = false
export var scrollDown = 20
export var pausado = true
export var shootInterval = 2.0
export var shootSpeed = 70

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

func _physics_process(delta):
	move_and_slide(Vector2(0,scrollDown))
	
func _on_Timer_timeout():
	if destroyed == false and pausado == false:
		var shoot = weapon.instance()
		
		if shootSpeed > 0:
			shoot.maxVelocidade = shootSpeed
		
		shoot.position = $Position2D.get_global_position()
		shoot.rotation_degrees = global_rotation_degrees
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
		get_parent().add_child(explosion)
		explosion.explode()
		
		var fire = preload("res://scenes/particles/fire.tscn")
		var firedestroyed = fire.instance()
		destroyed = true
		$Timer.stop()
		$CollisionShape2D.disabled = true
		firedestroyed.position = $Sprite.position
		firedestroyed.scale = Vector2(1.3,1.3)
		firedestroyed.global_rotation_degrees = 0
		add_child(firedestroyed)
		$Sprite.hide()

func _on_VisibilityNotifier2D_screen_exited():
	if pausado == false:
		queue_free()
