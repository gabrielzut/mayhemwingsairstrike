extends "res://classes/destructable.gd"

export var aceleracao = 10
export var maxVelocidade = 100
export var padding = 15

var velocidade = Vector2()

func _ready():
	resetPos()
	start()

func resetPos():
	$".".position.x = 144
	$".".position.y = 450

func start():
	$TimerShoot.start()
	$TimerScore.start()

func _process(delta):
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
		if ("Enemy" in colisao.collider.name or "Hazard" in colisao.collider.name) and singletons.gameStatus == 2:
			damage(1)
			if colisao.collider.has_method("damage"):
				colisao.collider.damage(1)
			else:
				var parent = colisao.collider.get_parent()
				while !(parent.has_method("damage")) and parent != get_tree().get_root():
					parent = parent.get_parent()
				if parent.has_method("damage"):
					parent.damage(1)
		if "Powerup" in colisao.collider.name and singletons.gameStatus == 2:
			colisao.collider.pick()
		if "ENM" in colisao.collider.name and singletons.gameStatus == 2:
			colisao.collider.queue_free()
			damage(1)
	
	if $".".position.x > get_viewport().size.x - padding:
		$".".position.x = get_viewport().size.x - padding
	if $".".position.x < padding:
		$".".position.x = padding
	if $".".position.y > get_viewport().size.y - padding:
		$".".position.y = get_viewport().size.y - padding
	if $".".position.y < padding:
		$".".position.y = padding
		
	if Input.is_action_just_pressed("player_shoot"):
		var shoot = singletons.getPlayerWeapon().instance()
		$TimerShoot.wait_time = shoot.shootInterval
		shoot.position = $Position2D.get_global_position()
		get_parent().add_child(shoot)
		$TimerShoot.start()
		
	if Input.is_action_just_pressed("player_special"):
		if singletons.playerBomb >= 1:
			singletons.playerBomb -= 1
			var bomb = singletons.playerSpecial.instance()
			bomb.position = $Position2D.get_global_position()
			get_parent().add_child(bomb)

func _on_TimerShoot_timeout():
	if Input.is_action_pressed("player_shoot"):
		var shoot = singletons.getPlayerWeapon().instance()
		$TimerShoot.wait_time = shoot.shootInterval
		shoot.position = $Position2D.get_global_position()
		get_parent().add_child(shoot)
	else:
		$TimerShoot.stop()

func _on_TimerScore_timeout():
	singletons.addScore(10)
