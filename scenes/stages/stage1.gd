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
	$Boss1Clouds.start()
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

func _on_Spawner12_collision(confirmation):
	$AviaoEnemy4.start()
	$AviaoEnemy5.start()
	$AviaoEnemy6.start()

func _on_Spawner13_collision(confirmation):
	$AviaoGrandeEnemy.start()

func _on_Spawner14_collision(confirmation):
	$Linha11.start()
	$Linha12.start()
	$Linha13.start()

func _on_Spawner15_collision(confirmation):
	$AviaoGrandeEnemy2.start()
	$AviaoEnemy7.start()
	$AviaoEnemy8.start()
	$AviaoEnemy9.start()

func _on_Spawner16_collision(confirmation):
	$V4.start()
	$V5.start()
	$V6.start()
	$V7.start()

func _on_Spawner17_collision(confirmation):
	$BarcoEnemy6.start()
	$BarcoEnemy7.start()
	$BarcoEnemy8.start()
	$BarcoEnemy9.start()

func _on_Spawner18_collision(confirmation):
	$Linha14.start()
	$Linha15.start()
	$ParallaxBackground2/ParallaxLayer2/Sprite/Tween.interpolate_property($ParallaxBackground2/ParallaxLayer2/Sprite,"modulate",Color("3cffffff"), Color(1, 1, 1, 0),5.0,Tween.TRANS_SINE,Tween.EASE_IN)
	$ParallaxBackground2/ParallaxLayer2/Sprite/Tween.start()