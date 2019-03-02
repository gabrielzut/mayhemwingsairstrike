extends KinematicBody2D

export var aceleracao = 20
export var maxVelocidade = 40
export var dmg = 1
export var seguir = true

var velocidade = Vector2()

func _ready():
	velocidade = Vector2(0,-maxVelocidade).rotated(global_rotation)
	$Timer.start()

func _process(delta):
	if seguir == true and get_tree().get_root().get_child(1).has_node("Player"):
		var pos = get_tree().get_root().get_child(1).get_node("Player").position
		look_at(pos)
		global_rotation_degrees += 90
		velocidade = Vector2(0,-maxVelocidade).rotated(global_rotation)

	var colisao = move_and_collide(velocidade * delta)
	
	if colisao:
		if 'Player' in colisao.collider.name:
			colisao.collider.damage(dmg)
			queue_free()

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func _on_Timer_timeout():
	seguir = false
