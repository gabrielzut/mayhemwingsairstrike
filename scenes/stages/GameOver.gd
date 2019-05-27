extends Control

func _ready():
	$Fade.fadein("self")
	$Timer.start()

func _on_Timer_timeout():
	get_tree().change_scene("res://scenes/stages/TitleScreen.tscn")