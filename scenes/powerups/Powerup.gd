extends KinematicBody2D

const VELOCIDADE = 50

onready var singletons = get_node("/root/Singletons")

enum Type{
	SCORE,BOMB,LIFE,POWER
}

export(Type) var type = Type.BOMB

var velocidade = Vector2(0,0)

func _ready():
	velocidade = Vector2(0,VELOCIDADE)
	global_rotation = 0

func _physics_process(delta):
	var colisao = move_and_slide(velocidade)
	
	var player = null
	
	if get_tree().get_root().get_child(1).has_node("Player"):
		player = get_tree().get_root().get_child(1).get_node("Player")
	if $Area2D.get_overlapping_bodies().has(player):
		pick()

func pick():
	if type == Type.SCORE:
		singletons.addScore(100)
	elif type == Type.BOMB:
		singletons.addBomb(1)
	elif type == Type.POWER:
		singletons.addPower(1)
	elif type == Type.LIFE:
		singletons.addLife(1)
	queue_free()

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()