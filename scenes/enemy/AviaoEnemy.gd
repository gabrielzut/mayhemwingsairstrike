extends "res://classes/destructable.gd"

export var maxVelocidade = 150
export var weapon = "none"

var velocidade = Vector2(0,0)

func _ready():
	velocidade = Vector2(0,-maxVelocidade).rotated(rotation)

func _physics_process(delta):
	var colisao = move_and_collide(velocidade * delta)
	
	if colisao != null and 'Player' in colisao.collider.name:
		damage(1)
		colisao.collider.damage(1)

#func _on_VisibilityNotifier2D_screen_exited():
#	queue_free()