extends "res://classes/destructable.gd"

export var maxVelocidade = 30
export var scrollDown = 20
export var tempoMov = 30
var velocidade = Vector2(0,0)
export var pausado = true

func start():
	visible = true
	pausado = false
	collision_layer = 1
	collision_mask = 0
	velocidade = Vector2(0,maxVelocidade).rotated(rotation)
	$LancaMisselEnemy.start()
	$Timer.wait_time = tempoMov
	$Timer.one_shot = true
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
	
	if has_node("LancaMisselEnemy"):
		if $LancaMisselEnemy.destroyed == true:
				collision_mask = 8
	
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
		$AnimatedSprite/Explosion.explode()
		$AnimatedSprite/Explosion2.explode()
		$AnimationPlayer.play("explode")
		
		singletons.addScore(score)

func _on_Explosion_exploded(confirmation):
	if(confirmation):
		$AnimationPlayer.stop()
		$CollisionPolygon2D.disabled = true
		modulate = "ffffff"
		$LancaMisselEnemy.visible = false
		velocidade = Vector2(0,0)
		
		var destroyedFloor = preload("res://scenes/particles/DestroyedFloor.tscn").instance()
		destroyedFloor.position = $AnimatedSprite.position
		destroyedFloor.scale = Vector2(1.2,1.2)
		add_child(destroyedFloor)
		$AnimatedSprite.hide()
		
func _on_Timer_timeout():
	velocidade = Vector2(0,0)
