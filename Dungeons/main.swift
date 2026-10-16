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
var height = 200
var width = 100
// булевые для работы игры
var game = true
var game2 = false
var floor = 1.0

// Цикл работы UX
while(game) {
	//clearScreen()
	// Создаётся объект
	let inv = InventoryBridge()
	
	// Действия пользователей
	print("1. Продолжить")
	print("2. Начать игру")
	print("3. Бесконечный режим")
	print("4. Открыть свой сундук")
	print("5. Торговец")
	print("6. Посмотреть рекорды в бесконечном режиме")
	//print("7. Кастомизация")
	print("7. Закрыть игру")
	
	let answer = readLine()!
	let continueGame = "1"
	let newGame = "2"
	let noEndGame = "3"
	let openChest = "4"
	let dealerInput = "5"
	let records = "6"
	let customisation = "777777qweqweuuiuui"
	var typeGame = true
	let inf = infinityMode()
	
	
	switch answer {
		case continueGame:
			inv.freeChest() // Очистка сундука, чтобы не было повторений
			let arrFromFile = fromFile() // Запись из файла в переменную
			let itemsInBelt = fromFileBelt()
			inv.addMoney(moneyFromFile())
			floor = floorFromFile()
			if floor > 7 {floor = 1}
			for i in 0..<itemsInBelt.count {inv.inBelt(itemsInBelt[i])}
			
			// Запись в сундук
			for i in 0..<arrFromFile.count {
				inv.inChest(arrFromFile[i])
			}
			game2 = true
		case newGame:
			freeFile() // Очистка файла
			inFileBelt([], 0.0)
			floorInFile(1)
			// как же я насрал в работе с файлами
			// надо будет это переписать
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
		case dealerInput:
			dealer(inv)
			continue
		case records:
			let records = fromFileRecord()
			print("")
			for i in 0..<records.count {print(records[i])}
			print("")
		case customisation:
			break
		default:
			game = false
			break
	}
	
	var exit = false 
	
	let invIG = InventoryBridge()
	
	if (game2) {
		let fight = inFight()
		if typeGame {
			let dHeight = Double(height)
			let dWidth = Double(width)
			height = Int(0.25 * (floor - 1) * dHeight) + height
			width = Int(0.25 * (floor - 1) * dWidth) + width
			clearScreen()
			print("Этаж \(Int(floor))")
			Thread.sleep(forTimeInterval: 1.5)
			exit = playingField(width, height, inv, fight, inf, typeGame)
		} else {
			var infExit = true
			
			while(infExit) {
				clearScreen()
				let infModeItems = randomItemInfMode()
				print("Вы получили:")
				for i in 0..<infModeItems.count {
					print(infModeItems[i])
					invIG.inBelt(infModeItems[i])
				}
				Thread.sleep(forTimeInterval: 1.5)
				infExit = playingField(width, height, invIG, fight, inf, typeGame)
				disableRawMode()
				inf.levelPlus()
			}
		}
		
		clearScreen()
		
		if !typeGame {
			let sc = inf.score(invIG.outBag())
			let ls = inf.level
			print("Вы получили \(sc) очков")
			print("И прошли \(ls) этажей: +\(ls*10) очков")
			print("В целом \(Double(ls*10) + sc) очков")
			print("\nВведите имя")
			let name = readLine() ?? "noname"
			inFileRecord((Double(ls*10) + sc), name)
		}
		if(exit){
			print("Вы дошли до конца")
			// Вывод собранного на экран, запись в сундук игрока и очистка сумки
			print("Вы собрали за забег:")
			let arrBag = inv.outBag()!
			inFile(arrBag, inv.getMoney())
			if !arrBag.isEmpty {
				for i in 0..<arrBag.count {
					inv.inChest(arrBag[i])
					print(arrBag[i])
				}
			}
			Thread.sleep(forTimeInterval: 1.5)
			clearScreen()
			if floor == 7 {
				print("Вы прошли подземелье")
				Thread.sleep(forTimeInterval: 2.5)
				floor = 0
			}
			floor += 1
		} else {floor = 1}
		
		floorInFile(floor)
		inv.freeBag()
		// Отключение режима "без проверки"
		disableRawMode()
		game2 = false
			
	}
}
