extends "res://classes/destructable.gd"

export var maxVelocidade = 150
export var weapon = "none"
export var pausado = true

var velocidade = Vector2(0,0)

func start():
	visible = true
	pausado = false
	collision_layer = 4
	collision_mask = 10
	velocidade = Vector2(0,-maxVelocidade).rotated(get_global_transform().get_rotation())

func _ready():
	if pausado:
		collision_layer = 0
		collision_mask = 0
		visible = false

func _physics_process(delta):
	var colisao = move_and_collide(velocidade * delta)
	
	if colisao != null and 'Player' in colisao.collider.name:
		damage(1)
		colisao.collider.damage(1)

func _on_VisibilityNotifier2D_screen_exited():
	if !pausado:
		queue_free()