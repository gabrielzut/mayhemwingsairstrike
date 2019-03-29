extends Node2D

var bossDestroyed = false

func _ready():
	$CanvasLayer/Fade.fadein("self")

func _on_Spawner_collision(confirmation):
	$HelicopteroEnemy.start()
	$HelicopteroEnemy2.start()
	$HelicopteroEnemy3.start()

func _on_Spawner2_collision(confirmation):
	$BarcoEnemy2.start()

func _on_Spawner3_collision(confirmation):
	$LancaMisselEnemy.start()

func _on_Spawner4_collision(confirmation):
	$HeliEnemy.start()
	$HeliEnemy2.start()
	$HeliEnemy3.start()

func _on_Spawner5_collision(confirmation):
	$Linha.start()
	$Linha2.start()
	$Linha3.start()
	$Linha4.start()

func _on_Spawner6_collision(confirmation):
	$HelicopteroEnemy4.start()
	$HelicopteroEnemy5.start()

func _on_Spawner7_collision(confirmation):
	$V.start()

func _on_Spawner8_collision(confirmation):
	$TruckEnemy.start()

func _on_Spawner9_collision(confirmation):
	$TruckEnemy2.start()

func _on_Spawner10_collision(confirmation):
	$TankEnemy.start()
	$TankEnemy2.start()

func _on_Spawner11_collision(confirmation):
	$HelicopteroEnemy6.start()
	$HelicopteroEnemy7.start()

func _on_Spawner12_collision(confirmation):
	$BarcoEnemy3.start()
	$BarcoEnemy4.start()

func _on_Spawner13_collision(confirmation):
	$LancaMisselEnemy2.start()
	$LancaMisselEnemy3.start()
	$LancaMisselEnemy4.start()
	$LancaMisselEnemy5.start()

func _on_Spawner14_collision(confirmation):
	$Linha5.start()
	$Linha6.start()
	$Boss2.start()

func _on_Boss2_destroyed():
	$Player.finish()
	$CanvasLayer/Fade.fadeout("stage3")

func _on_Boss2_finished():
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
	#if source == "stage3":
		#get_tree().change_scene("res://scenes/stages/stage3.tscn")
	pass

func _on_Spawner15_collision(confirmation):
	$PlayerMusic/Tween.interpolate_property($PlayerMusic,"volume_db",-25,-80,3,Tween.TRANS_SINE,Tween.EASE_IN)
	$PlayerMusic/Tween.start()
