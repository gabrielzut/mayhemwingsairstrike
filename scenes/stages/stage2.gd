extends Node2D

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