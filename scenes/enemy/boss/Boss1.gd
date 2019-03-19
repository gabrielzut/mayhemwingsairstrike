extends KinematicBody2D

export var scrollDown = 20
export var pausado = true
signal destroyed()
var destroyed = false

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
	
	for child in get_children():
		if child.has_method("start") and child.name != "Boss1Center":
			child.start()
	
func _physics_process(delta):
	move_and_slide(Vector2(0,scrollDown))
	
	if $Boss1Center.pausado == true and !has_node("Boss1Gun") and !has_node("Boss1Gun2") and $Boss1Launcher.destroyed == true and $CanhaoEnemy.destroyed == true and $CanhaoEnemy2.destroyed == true and $CanhaoEnemy3.destroyed == true and $CanhaoEnemy4.destroyed == true and $CanhaoEnemy5.destroyed == true:
		$Boss1Center.start()
		
	if $Boss1Center.destroyed == true and destroyed == false:
		emit_signal("destroyed")
		destroyed = true