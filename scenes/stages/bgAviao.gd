extends KinematicBody2D

export var aceleracao = 50
export var maxVelocidade = 50
export var scrollDown = 20

var velocidade = Vector2()
var visivel = false

func _ready():
	velocidade = Vector2(0,scrollDown)

func _on_Timer_timeout():
	velocidade = Vector2(scrollDown,-maxVelocidade).rotated(rotation)
	visivel = true

func _process(delta):
	move_and_collide(velocidade * delta)

func _on_VisibilityNotifier2D_viewport_entered(viewport):
	$Timer.start()
