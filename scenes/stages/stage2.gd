extends Node2D

func _ready():
	$CanvasLayer/Fade.fadein("self")

func _on_Spawner_collision(confirmation):
	$HelicopteroEnemy.start()
