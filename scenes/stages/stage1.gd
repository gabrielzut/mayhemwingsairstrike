extends Node2D

func _on_Spawner_collision(confirmation):
	$Linha.start()
	$Linha2.start()

func _on_Spawner2_collision(confirmation):
	$BarcoEnemy.start()
	$BarcoEnemy2.start()
	

func _on_Spawner3_collision(confirmation):
	$V.start()
