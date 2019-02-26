extends KinematicBody2D

export var aceleracao = 50
export var maxVelocidade = 600
export var shootInterval = 0.13
export var dmg = 1
var nextLevel = preload("res://scenes/props/WLaser2.tscn")

var velocidade = Vector2()

func _process(delta):
	if velocidade.y > -maxVelocidade:
		velocidade.y -= aceleracao
	else:
		velocidade.y = -maxVelocidade
		
	var colisao = move_and_collide(velocidade * delta)
	
	if colisao:
		if 'Enemy' in colisao.collider.name:
			colisao.collider.damage(dmg)
			queue_free()
	
	if !$VisibilityNotifier2D.is_on_screen():
		queue_free()