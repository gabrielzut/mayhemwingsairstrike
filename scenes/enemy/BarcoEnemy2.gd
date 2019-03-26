extends "res://classes/destructable.gd"

export var weapon = preload("res://scenes/props/EnemyShot4.tscn")
export var shootInterval = 0.2
export var shootSpeed = 100
export var maxVelocidade = 30
export var scrollDown = 20
export var tempoMov = 30
export var pausado = true
var velocidade = Vector2(0,0)
var posShoot = 0

func start():
	visible = true
	pausado = false
	collision_layer = 1
	collision_mask = 8
	$Timer.wait_time = shootInterval
	velocidade = Vector2(0,maxVelocidade).rotated(rotation)
	$Timer.start()

func _ready():
	if pausado:
		collision_layer = 0
		collision_mask = 0
		visible = false
	else:
		start()

func _physics_process(delta):
	move_and_slide(Vector2(0,scrollDown))
	
	var colisao = move_and_collide(velocidade * delta)
	
func _on_VisibilityNotifier2D_screen_exited():
	if !pausado:
		queue_free()

func damage(dmg):
	hp -= dmg
	get_node("AnimationPlayer").stop()
	get_node("AnimationPlayer").play("damage")
	$PlayerHit.play()
	
	if hp <= 0:
		if drop != false:
			var powerupDrop = powerup.instance()
			powerupDrop.global_position = global_position
			get_tree().get_root().get_child(1).add_child(powerupDrop)
			
		$CollisionPolygon2D.disabled = true
		$Timer.stop()
		
		for child in $Sprite.get_children():
			if child.has_method("explode"):
				child.explode()
				
		$AnimationPlayer.play("explode")
		
		singletons.addScore(score)

func _on_Timer_timeout():
	if pausado == false:
		var shoot = weapon.instance()
		
		if shootSpeed > 0:
			shoot.maxVelocidade = shootSpeed
		
		if posShoot == 0:
			shoot.global_position = $Position2D.get_global_position()
		elif posShoot == 1:
			shoot.global_position = $Position2D2.get_global_position()
		elif posShoot == 2:
			shoot.global_position = $Position2D3.get_global_position()
		elif posShoot == 3:
			shoot.global_position = $Position2D4.get_global_position()
		elif posShoot == 4:
			shoot.global_position = $Position2D5.get_global_position()
			posShoot = -1
			
		posShoot += 1
			
		shoot.global_rotation_degrees = rand_range(100,250)
		shoot.seguir = false
		get_tree().get_root().get_child(1).add_child(shoot)

func _on_Explosion_exploded(confirmation):
	queue_free()