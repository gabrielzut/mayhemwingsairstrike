extends KinematicBody2D

export var scrollDown = 20.2

export var drop = false
export var powerup = preload("res://scenes/powerups/BombPowerup.tscn")

onready var singletons = get_node("/root/Singletons")

func _ready():
	$AviaoEnemy5.drop = drop
	$AviaoEnemy5.powerup = powerup

func start():
	$AviaoEnemy.start()
	$AviaoEnemy2.start()
	$AviaoEnemy3.start()
	$AviaoEnemy4.start()
	$AviaoEnemy5.start()
	
func _process(delta):
	move_and_slide(Vector2(0,scrollDown))
	
	if get_child_count() == 0:
		queue_free()