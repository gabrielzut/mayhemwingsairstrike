extends "res://classes/destructable.gd"

export var aceleracao = 10
export var maxVelocidade = 100

signal finished()

var starting = false
var finished = false
var velocidade = Vector2()
var cdbomb = false

func _ready():
	start()

func start():
	starting = true
	position = Vector2(144,530)
	collision_layer = 32
	collision_mask = 80
	$AnimationPlayer.play("Start")
	$TimerShoot.start()
	$TimerScore.start()
	$TimerIFrames.start()
	$AnimationPlayer2.play("IFrames")
	
func finish():
	finished = true
	$TimerScore.stop()
	$TimerShoot.stop()
	collision_layer = 32
	collision_mask = 64

func _physics_process(delta):
	if finished == false:
		if starting == false:
			if Input.is_action_pressed("ui_up"):
				if velocidade.y < -maxVelocidade:
					velocidade.y = -maxVelocidade 
				elif velocidade.y > 0:
					velocidade.y = 0
				else:
					velocidade.y -= aceleracao
			if Input.is_action_pressed("ui_down"):
				if velocidade.y > maxVelocidade:
					velocidade.y = maxVelocidade
				elif velocidade.y < 0:
					velocidade.y = 0
				else:
					velocidade.y += aceleracao
			if Input.is_action_pressed("ui_up") == Input.is_action_pressed("ui_down"):
				velocidade.y = 0
				
			if Input.is_action_pressed("ui_right"):
				if velocidade.x > maxVelocidade:
					velocidade.x = maxVelocidade 
				elif velocidade.x < 0:
					velocidade.x = 0
				else:
					velocidade.x += aceleracao
			if Input.is_action_pressed("ui_left"):
				if velocidade.x < -maxVelocidade:
					velocidade.x = -maxVelocidade 
				elif velocidade.x > 0:
					velocidade.x = 0
				else:
					velocidade.x -= aceleracao
			if Input.is_action_pressed("ui_left") == Input.is_action_pressed("ui_right"):
				velocidade.x = 0
				
			var colisao = move_and_collide(velocidade * delta)
				
			if colisao:
				if ("Enemy" in colisao.collider.name or "Hazard" in colisao.collider.name):
					damage(1)
					if colisao.collider.has_method("damage"):
						colisao.collider.damage(1)
					else:
						var parent = colisao.collider.get_parent()
						while !(parent.has_method("damage")) and parent != get_tree().get_root():
							parent = parent.get_parent()
						if parent.has_method("damage"):
							parent.damage(1)
				if "ENM" in colisao.collider.name:
					colisao.collider.queue_free()
					damage(1)
				
			if Input.is_action_just_pressed("player_shoot"):
				$PlayerShoot.play()
				var shoot = singletons.getPlayerWeapon().instance()
				$TimerShoot.wait_time = shoot.shootInterval
				shoot.position = $Position2D.get_global_position()
				get_parent().add_child(shoot)
				$TimerShoot.start()
				
			if Input.is_action_just_pressed("player_special"):
				if singletons.playerBomb >= 1 and cdbomb == false:
					singletons.playerBomb -= 1
					var bomb = singletons.playerSpecial.instance()
					bomb.position = $Position2D.get_global_position()
					get_parent().add_child(bomb)
					cdbomb = true
					$PlayerShoot.play()
					$TimerCDBomb.start()
	else:
		move_and_slide(Vector2(0,-200))
		
		if global_position.y < -30:
			emit_signal("finished")
			
	if Input.is_action_just_pressed("mute"):
		singletons.mute()

func _on_TimerShoot_timeout():
	if starting == false and finished == false:
		if Input.is_action_pressed("player_shoot"):
			var vol = $PlayerShoot.volume_db
			$PlayerShoot.play()
			var shoot = singletons.getPlayerWeapon().instance()
			$TimerShoot.wait_time = shoot.shootInterval
			shoot.position = $Position2D.get_global_position()
			get_parent().add_child(shoot)
		else:
			$TimerShoot.stop()

func damage(dmg):
	hp -= dmg

	if hp <= 0:
		singletons.addScore(score)
		var explosion = singletons.explosion.instance()
		if drop != false:
			var powerupDrop = powerup.instance()
			powerupDrop.global_position = global_position
			get_tree().get_root().get_child(1).add_child(powerupDrop)
		explosion.position = position
		get_parent().add_child(explosion)
		explosion.explode()
		singletons.playerLife -= 1
		collision_layer = 32
		collision_mask = 80
		respawn()

func respawn():
	if singletons.playerLife >= 0:
		visible = false
		position = Vector2(144,530)
		$TimerRespawn.start()
		starting = true
	else:
		$CollisionShape2D.disabled = true
		visible = false
		position = Vector2(144,530)
		$TimerGameOver.start()

func _on_TimerScore_timeout():
	singletons.addScore(10)

func _on_TimerIFrames_timeout():
	collision_layer = 34
	collision_mask = 92
	$AnimationPlayer2.stop()

func _on_TimerRespawn_timeout():
	visible = true
	start()

func _on_AnimationPlayer_animation_finished(anim_name):
	starting = false

func _on_TimerCDBomb_timeout():
	cdbomb = false

func _on_TimerGameOver_timeout():
	if get_tree().get_root().get_child(1).has_node("CanvasLayer/Fade"):
		get_tree().get_root().get_child(1).get_node("CanvasLayer/Fade").fadein("GameOver")
	get_tree().change_scene("res://scenes/stages/GameOver.tscn")