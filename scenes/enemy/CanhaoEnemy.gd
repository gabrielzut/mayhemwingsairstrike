extends "res://classes/destructable.gd"

export var weapon = preload("res://scenes/props/EnemyShot1.tscn")
export var destroyed = false
export var scrollDown = 20
export var pausado = true
export var tipo = 0
export var shootInterval = 2.0
export var shootSpeed = 0

func _ready():
	if tipo == 0:
		$AnimatedSprite.play("normal")
	elif tipo == 1:
		$AnimatedSprite.play("tank")
	
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

func _physics_process(delta):
	if get_tree().get_root().get_child(1).has_node("Player") and destroyed == false:
		var pos = get_tree().get_root().get_child(1).get_node("Player").position
		look_at(pos)
	move_and_slide(Vector2(0,scrollDown))
	
func _on_Timer_timeout():
	if $VisibilityNotifier2D.is_on_screen() and destroyed == false and pausado == false:
		var shoot = weapon.instance()
		
		if shootSpeed > 0:
			shoot.maxVelocidade = shootSpeed
		
		shoot.position = $Position2D.get_global_position()
		shoot.rotation_degrees = global_rotation_degrees + 90
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
		firedestroyed.global_rotation_degrees = -90
		firedestroyed.position = $AnimatedSprite.position
		add_child(firedestroyed)
		$AnimatedSprite.hide()

func _on_VisibilityNotifier2D_screen_exited():
	if pausado == false:
		queue_free()
