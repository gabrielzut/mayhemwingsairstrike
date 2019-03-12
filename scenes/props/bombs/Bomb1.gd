extends KinematicBody2D

export var aceleracao = 50
export var maxVelocidade = 200
var explosion = preload("res://scenes/props/bombs/Bomb1Explosion.tscn")

var velocidade = Vector2()

func _ready():
	add_collision_exception_with(get_tree().get_root().get_child(1).get_node("Player"))

func _physics_process(delta):
	if velocidade.y > -maxVelocidade:
		velocidade.y -= aceleracao
	else:
		velocidade.y = -maxVelocidade
		
	var colisao = move_and_collide(velocidade * delta)
	
	if global_position.y <= 100:
		explode()
	
	if colisao:
		explode()

func explode():
	var exploded = explosion.instance()
	exploded.global_position = global_position
	get_tree().get_root().get_child(1).add_child(exploded)
	queue_free()

func _on_Timer_timeout():
	explode()
