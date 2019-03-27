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
