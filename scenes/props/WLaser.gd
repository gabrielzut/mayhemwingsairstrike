extends KinematicBody2D

export var aceleracao = 50
export var maxVelocidade = 600
export var shootInterval = 0.13
export var dmg = 1
var nextLevel = preload("res://scenes/props/WLaser2.tscn")

var velocidade = Vector2()

func _ready():
	add_collision_exception_with(get_tree().get_root().get_child(1).get_node("Player"))

func _physics_process(delta):
	if velocidade.y > -maxVelocidade:
		velocidade.y -= aceleracao
	else:
		velocidade.y = -maxVelocidade
		
	var colisao = move_and_collide(velocidade * delta)
	
	if colisao:
		if 'Enemy' in colisao.collider.name or 'Boss' in colisao.collider.name:
			if colisao.collider.has_method("damage"):
				colisao.collider.damage(dmg)
			else:
				var parent = colisao.collider.get_parent()
				while !(parent.has_method("damage")) and parent != get_tree().get_root():
					parent = parent.get_parent()
				if parent.has_method("damage"):
					parent.damage(dmg)
			queue_free()

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
