extends Node2D

var bossDestroyed = false

func _ready():
	$CanvasLayer/Fade.fadein("self")

func _on_Boss3_destroyed():
	$bgLauncher.start()

func _on_Boss3_finished():
	bossDestroyed = true
	$PlayerMusic/Tween.interpolate_property($PlayerMusic,"volume_db",-25,-80,2,Tween.TRANS_SINE,Tween.EASE_IN)
	$PlayerMusic/Tween.start()

func _on_Tween_tween_completed(object, key):
	$PlayerMusic.volume_db = -25
	if bossDestroyed == true:
		$PlayerMusic.stream = preload("res://sound/music/Alexander Ehlers - Flags.ogg")
		$PlayerMusic.play(34.20)
	else:
		$PlayerMusic.stream = preload("res://sound/music/Alexander Ehlers - Doomed.ogg")
		$PlayerMusic.play()

func _on_Fade_animation(source):
	if source == "youWin":
		get_tree().change_scene("res://scenes/stages/YouWin.tscn")
	pass

func _on_Spawner_collision(confirmation):
	$V.start()
	$TankEnemy.start()
	$TankEnemy2.start()

func _on_Spawner2_collision(confirmation):
	$TruckEnemy.start()
	$TruckEnemy2.start()

func _on_Spawner3_collision(confirmation):
	$AviaoGrandeEnemy.start()
	$AviaoGrandeEnemy2.start()

func _on_Spawner4_collision(confirmation):
	$TankEnemy3.start()
	$TankEnemy4.start()
	$TankEnemy5.start()
	$TankEnemy6.start()
	$TankEnemy7.start()
	$TankEnemy8.start()

func _on_Spawner5_collision(confirmation):
	$Linha.start()
	$Linha2.start()
	$Linha3.start()
	$Linha4.start()
	$Linha5.start()

func _on_Spawner6_collision(confirmation):
	$MissileEnemy.start()
	$MissileEnemy2.start()
	$MissileEnemy3.start()
	$MissileEnemy4.start()
	$MissileEnemy5.start()
	$MissileEnemy6.start()
	$MissileEnemy7.start()
	$MissileEnemy8.start()
	$MissileEnemy9.start()
	$MissileEnemy10.start()
	$MissileEnemy11.start()
	$MissileEnemy12.start()
	$MissileEnemy13.start()
	$MissileEnemy20.start()
	$MissileEnemy21.start()
	$MissileEnemy22.start()
	$MissileEnemy23.start()
	$MissileEnemy24.start()
	$MissileEnemy25.start()
	$MissileEnemy26.start()
	$MissileEnemy27.start()

func _on_Spawner7_collision(confirmation):
	$TankEnemy9.start()
	$TruckEnemy3.start()

func _on_Spawner8_collision(confirmation):
	$HelicopteroEnemy.start()
	$HelicopteroEnemy2.start()

func _on_Spawner9_collision(confirmation):
	$HeliEnemy.start()
	$HeliEnemy2.start()
	$HeliEnemy3.start()

func _on_Spawner10_collision(confirmation):
	$V2.start()
	$V3.start()

func _on_Spawner11_collision(confirmation):
	$MissileEnemy14.start()
	$MissileEnemy15.start()
	$MissileEnemy16.start()
	$MissileEnemy17.start()
	$MissileEnemy18.start()
	$MissileEnemy19.start()

func _on_Spawner12_collision(confirmation):
	$V4.start()

func _on_Spawner13_collision(confirmation):
	$V5.start()
	$V6.start()

func _on_Spawner14_collision(confirmation):
	$Linha7.start()
	$Linha8.start()
	$Linha9.start()
	$Linha10.start()
	$Linha11.start()

func _on_Spawner15_collision(confirmation):
	$Linha12.start()
	$Linha13.start()

func _on_Spawner16_collision(confirmation):
	$ParallaxBackground.pausado = true
	$Boss3.scrollDown = 0
	$TankEnemy9.scrollDown = 0
	$TruckEnemy3.scrollDown = 0
	$bgLauncher.scrollDown = 0
	$Boss3.start()

func _on_bgLauncher_finished():
	$Player.finish()
	$CanvasLayer/Fade.fadeout("youWin")

func _on_Spawner17_collision(confirmation):
	$PlayerMusic/Tween.interpolate_property($PlayerMusic,"volume_db",-25,-80,3,Tween.TRANS_SINE,Tween.EASE_IN)
	$PlayerMusic/Tween.start()
