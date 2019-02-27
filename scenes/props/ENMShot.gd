extends KinematicBody2D

export var aceleracao = 50
export var maxVelocidade = 100
export var dmg = 1

var velocidade = Vector2()

func _ready():
	velocidade = Vector2(0,-maxVelocidade).rotated(rotation)

func _process(delta):
	var colisao = move_and_collide(velocidade * delta)
	
	if colisao:
		if 'Player' in colisao.collider.name:
			colisao.collider.damage(dmg)
			queue_free()
	
	#if !$VisibilityNotifier2D.is_on_screen():
	#	queue_free()
