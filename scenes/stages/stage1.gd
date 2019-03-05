extends Node2D

func _on_Spawner_collision(confirmation):
	$Linha.start()
	$Linha2.start()

func _on_Spawner2_collision(confirmation):
	$BarcoEnemy.start()
	$BarcoEnemy2.start()

func _on_Spawner3_collision(confirmation):
	$V.start()

func _on_Spawner4_collision(confirmation):
	$Linha3.start()
	$Linha4.start()
	$Linha5.start()
	$Linha6.start()

func _on_Spawner5_collision(confirmation):
	$BarcoEnemy3.start()
	$BarcoEnemy4.start()

func _on_Spawner6_collision(confirmation):
	$Linha7.start()
	$Linha8.start()

func _on_Spawner7_collision(confirmation):
	$Linha9.start()
	$Linha10.start()
	$BarcoEnemy5.start()

func _on_Spawner8_collision(confirmation):
	$Boss1.start()
	$ParallaxBackground.pausado = true
	$ParallaxBackground2.pausado = true

func _on_Spawner9_collision(confirmation):
	$TankEnemy.start()
	$TankEnemy2.start()
	$CanhaoEnemy3.start()
	$CanhaoEnemy4.start()

func _on_Spawner10_collision(confirmation):
	$AviaoEnemy.start()
	$AviaoEnemy2.start()
	$AviaoEnemy3.start()

func _on_Spawner11_collision(confirmation):
	$V2.start()
	$V3.start()
