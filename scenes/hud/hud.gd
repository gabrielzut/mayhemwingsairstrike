extends CanvasLayer

onready var singletons = get_node("/root/Singletons")

func _process(delta):
	
	if singletons.playerBomb >= 1:
		$Bomb1.show()
	else:
		$Bomb1.hide()
	if singletons.playerBomb >= 2:
		$Bomb2.show()
	else:
		$Bomb2.hide()
	if singletons.playerBomb >= 3:
		$Bomb3.show()
	else:
		$Bomb3.hide()
	if singletons.playerBomb >= 4:
		$Bomb4.show()
	else:
		$Bomb4.hide()
	if singletons.playerBomb >= 5:
		$Bomb5.show()
	else:
		$Bomb5.hide()
	
	if singletons.playerLife >= 1:
		$Life1.show()
	else:
		$Life1.hide()
	if singletons.playerLife >= 2:
		$Life2.show()
	else:
		$Life2.hide()
	if singletons.playerLife >= 3:
		$Life3.show()
	else:
		$Life3.hide()
		
	$Score.text = "Score: %06d" % singletons.playerScore