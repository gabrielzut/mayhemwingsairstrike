extends Node

var playerSprite = preload("res://graphics/plane/aviao1.png")
var playerWeapon1 = preload("res://scenes/props/WLaser.tscn")
var playerWeapon2 = preload("res://scenes/props/WLaser2.tscn")
var playerWeapon3 = preload("res://scenes/props/WLaser3.tscn")
var playerSpecial = preload("res://scenes/props/bombs/Bomb1.tscn")
var explosion = preload("res://scenes/particles/explosion.tscn")
var bombPowerup = preload("res://scenes/powerups/BombPowerup.tscn")
var powerPowerup = preload("res://scenes/powerups/PowerPowerup.tscn")
var lifePowerup = preload("res://scenes/powerups/LifePowerup.tscn")
var scorePowerup = preload("res://scenes/powerups/ScorePowerup.tscn")

var playerPowerup = 1
var playerLife = 3
var playerBomb = 2
var playerScore = 0

func addPower(var power):
	if playerPowerup + power <= 3:
		playerPowerup += power
	else:
		playerPowerup = 3
		addScore(100)
		
func addLife(var life):
	playerLife += life
	
func addBomb(var bomb):
	if playerBomb + bomb <= 3:
		playerBomb += bomb
	else:
		playerBomb = 3
		addScore(100)

func addScore(var score):
	playerScore += score

func getPlayerWeapon():
	if playerPowerup == 1:
		return playerWeapon1
	elif playerPowerup == 2:
		return playerWeapon2
	elif playerPowerup == 3:
		return playerWeapon3

# Para adicionar o singleton nos códigos usar
# onready var singletons = get_node("/root/Singletons")