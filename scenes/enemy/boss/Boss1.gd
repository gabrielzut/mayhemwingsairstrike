extends KinematicBody2D

export var scrollDown = 20.2
export var pausado = true

func _ready():
	if pausado:
		$CanhaoEnemy.visible = true
		$CanhaoEnemy2.visible = true
		$CanhaoEnemy3.visible = true
		$CanhaoEnemy4.visible = true
		$CanhaoEnemy5.visible = true
	else:
		start()

func start():
	pausado = false
	scrollDown = 0
	
	$CanhaoEnemy.get_node("Timer").wait_time = 1.2
	$CanhaoEnemy2.get_node("Timer").wait_time = 1.5
	$CanhaoEnemy3.get_node("Timer").wait_time = 1.2
	$CanhaoEnemy4.get_node("Timer").wait_time = 1.5
	$CanhaoEnemy5.get_node("Timer").wait_time = 1.2
	
	for child in get_children():
		if child.has_method("start"):
			child.start()
	
func _physics_process(delta):
	move_and_slide(Vector2(0,scrollDown))