//
//  main.swift
//  Dungeons
//
//  Created by Семён Зайцев on 08.09.2026.
//

import Foundation
import Darwin

// Задаётся возможность использовать rand()
randomActive()
// Переменные размеров карты(возможно добавлю сложность)
let height = 200
let width = 100
// булевые для работы игры
var game = true
var game2 = false

// Цикл работы UX
while(game) {
	// Создаётся объект
	let inv = InventoryBridge()
	
	// Действия пользователей
	print("1. Продолжить")
	print("2. Начать игру")
	print("3. Бесконечный режим")
	print("4. Открыть свой сундук")
	print("5. Закрыть игру")
	
	let answer = readLine()!
	let continueGame = "1"
	let newGame = "2"
	let noEndGame = "3"
	let openChest = "4"
	var typeGame = true
	let inf = infinityMode()
	
	
	switch answer {
		case continueGame:
			inv.freeChest() // Очистка сундука, чтобы не было повторений
			let arrFromFile = fromFile() // Запись из файла в переменную
			
			// Запись в сундук
			for i in 0..<arrFromFile.count {
				inv.inChest(arrFromFile[i])
			}
			game2 = true
		case newGame:
			freeFile() // Очистка файла
			game2 = true
		case openChest:
			let arrFromFile = fromFile() // Проверяем из файла
			
			print("У вас в сундуке:")
			for i in 0..<arrFromFile.count {
				print(arrFromFile[i])
			}
		case noEndGame:
			typeGame = false
			game2 = true
			
		default:
			game = false
			break
	}
	
	var exit = false 
	
	if (game2) {
		let fight = inFight()
		exit = playingField(width, height, typeGame, inv, fight, inf)
		clearScreen()
		
		if !typeGame {
			print("Вы прошли \(inf.level) этажей")
			print("И получили \(inf.score(inv.outBag())) очков")
		}
		if(exit){
			print("Вы дошли до конца")
			// Вывод собранного на экран, запись в сундук игрока и очистка сумки
			print("Вы собрали за забег:")
			let arrBag = inv.outBag()!
			inFile(arrBag)
			if !arrBag.isEmpty {
				for i in 0..<arrBag.count {
					inv.inChest(arrBag[i])
					print(arrBag[i])
				}
			}
		}
		
		inv.freeBag()
		// Отключение режима "без проверки"
		disableRawMode()
		// Очистка памяти
		//freeMaze(dungeon)
		game2 = false
			
	}
}
