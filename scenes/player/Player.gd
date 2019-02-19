extends "res://classes/destructable.gd"

onready var singletons = get_node("/root/Singletons")

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
	$Timer.start()

func _process(delta):
	if Input.is_action_pressed("ui_up"):
		if velocidade.y < -maxVelocidade:
			velocidade.y = -maxVelocidade 
		else:
			velocidade.y -= aceleracao
	if Input.is_action_pressed("ui_down"):
		if velocidade.y > maxVelocidade:
			velocidade.y = maxVelocidade 
		else:
			velocidade.y += aceleracao
	if Input.is_action_pressed("ui_up") == Input.is_action_pressed("ui_down"):
		velocidade.y = 0
		
	if Input.is_action_pressed("ui_right"):
		if velocidade.x > maxVelocidade:
			velocidade.x = maxVelocidade 
		else:
			velocidade.x += aceleracao
	if Input.is_action_pressed("ui_left"):
		if velocidade.x < -maxVelocidade:
			velocidade.x = -maxVelocidade 
		else:
			velocidade.x -= aceleracao
	if Input.is_action_pressed("ui_left") == Input.is_action_pressed("ui_right"):
		velocidade.x = 0
		
	var colisao = move_and_collide(velocidade * delta)
	
	if colisao:
		if ("Enemy" in colisao.collider.name or "Hazard" in colisao.collider.name) and singletons.gameStatus == 2:
			damage(1)
			colisao.collider.damage(1)
		if "Powerup" in colisao.collider.name and singletons.gameStatus == 2:
			colisao.collider.pick()
	
	if $".".position.x > get_viewport().size.x - padding:
		$".".position.x = get_viewport().size.x - padding
	if $".".position.x < padding:
		$".".position.x = padding
	if $".".position.y > get_viewport().size.y - padding:
		$".".position.y = get_viewport().size.y - padding
	if $".".position.y < padding:
		$".".position.y = padding
		
	if Input.is_action_just_pressed("player_shoot"):
		var shoot = singletons.playerWeapon.instance()
		$Timer.wait_time = shoot.shootInterval
		shoot.position = $Position2D.get_global_position()
		get_parent().add_child(shoot)
		$Timer.start()
	
func _on_Timer_timeout():
	if Input.is_action_pressed("player_shoot"):
		var shoot = singletons.playerWeapon.instance()
		$Timer.wait_time = shoot.shootInterval
		shoot.position = $Position2D.get_global_position()
		get_parent().add_child(shoot)
	else:
		$Timer.stop()
