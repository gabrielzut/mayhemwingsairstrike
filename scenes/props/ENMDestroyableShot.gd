extends "res://classes/destructable.gd"

export var aceleracao = 50
export var maxVelocidade = 100
export var dmg = 1

var velocidade = Vector2()

func _ready():
	if get_tree().get_root().get_child(1).has_node("Player"):
		var pos = get_tree().get_root().get_child(1).get_node("Player").position
		look_at(pos)
		global_rotation_degrees += 90
	velocidade = Vector2(0,-maxVelocidade).rotated(rotation)

func _physics_process(delta):
	var colisao = move_and_collide(velocidade * delta)
	rotation = rotation + 3 * delta
	
	if colisao:
		if 'Player' in colisao.collider.name:
			colisao.collider.damage(dmg)
			queue_free()
		if 'W' in colisao.collider.name:
			queue_free()

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func damage(dmg):
	hp -= dmg

	if hp <= 0:
		singletons.addScore(score)
		var explosion = singletons.explosion.instance()
		explosion.position = position
		explosion.scale = Vector2(0.5,0.5)
		get_parent().add_child(explosion)
		explosion.explode()
		queue_free()