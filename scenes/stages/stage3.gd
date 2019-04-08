extends Node2D

var bossDestroyed = false

func _ready():
	$CanvasLayer/Fade.fadein("self")

#func _on_Boss3_destroyed():
#	$Player.finish()
#	$CanvasLayer/Fade.fadeout("stage3")

#func _on_Boss3_finished():
#	bossDestroyed = true
#	$PlayerMusic/Tween.interpolate_property($PlayerMusic,"volume_db",-25,-80,2,Tween.TRANS_SINE,Tween.EASE_IN)
#	$PlayerMusic/Tween.start()

func _on_Tween_tween_completed(object, key):
	$PlayerMusic.volume_db = -25
	if bossDestroyed == true:
		$PlayerMusic.stream = preload("res://sound/music/Alexander Ehlers - Flags.ogg")
		$PlayerMusic.play(34.20)
	else:
		$PlayerMusic.stream = preload("res://sound/music/Alexander Ehlers - Doomed.ogg")
		$PlayerMusic.play()

func _on_Fade_animation(source):
	#if source == "stage4":
		#get_tree().change_scene("res://scenes/stages/stage4.tscn")
	pass
	
#func _on_Spawner_collision(confirmation):
#	$PlayerMusic/Tween.interpolate_property($PlayerMusic,"volume_db",-25,-80,3,Tween.TRANS_SINE,Tween.EASE_IN)
#	$PlayerMusic/Tween.start()