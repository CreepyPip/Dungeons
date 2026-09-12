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
	print("1. Начать игру")
	print("2. Продолжить")
	print("3. Закрыть игру")
	print("4. Открыть свой сундук")
	
	let answer = readLine()!
	
	// Работа при новой игре
	if (answer == "1") {
		freeFile() // Очистка файла
		game2 = true
	}
	
	// Работа при продолжении игры
	if (answer == "2") {
		inv.freeChest() // Очестка сундука, чтобы не было повторений
		let arrFromFile = fromFile() // Запись из файла в переменную
		
		// Запись в сундук
		for i in 0..<arrFromFile.count {
			inv.inChest(arrFromFile[i])
		}
		game2 = true
	}
	
	// Проверка того, что есть в сундуке
	if (answer == "4") {
		let arrFromFile = fromFile() // Проверяем из файла

		print("У вас в сундуке:")
		for i in 0..<arrFromFile.count {
			print(arrFromFile[i])
		}
	}
	
	// Закрытие игры (чтобы работало не только на 3)
	if (answer != "1" && answer != "2" && answer != "4") {
		game = false
		break
	}
	
	if (game2) {
		// Генерируем подземелье
		let dungeon = generateMaze(Int32(width), Int32(height), 30)
		
		// Массив для удобного хранения подземелья
		var A: [[String]] = []
		// Координаты игрока
		var x = height - 2
		var y = (width/2)-1
		
		// Перезаписываем
		for i in 0..<height {
			var microArr: [String] = []
			for j in 0..<width {
				let pretrans = dungeon![j + i * width]
				if Int(exactly: pretrans)! == 35 {
					microArr.append("#")
				}
				if Int(exactly: pretrans)! == 32 {
					microArr.append(" ")
				}
				if Int(exactly: pretrans)! == 83 {
					microArr.append("S")
					y = j;
				}
				if Int(exactly: pretrans)! == 69 {
					microArr.append("E")
				}
				if Int(exactly: pretrans)! == 63 {
					microArr.append("?")
				}
			}
			
			A.append(microArr)
		}
		
		// Местонахождение игрока
		A[x][y] = "@"
		enableRawMode() // Ввод "без подтверждения"
		var inGame = true // булевая для отображения поля
		var outputItems: [String] = [] // Массив для отображения собранного
		var itemsCount = 0 // переменная для цикла отображения собранного
		
		while(inGame){
			clearScreen() // Чистим экран при каждой иттерации
			
			// Переменные для границ экрана
			var xh = x-10
			var xl = x+10
			var yl = y-10
			var yr = y+10
			
			// Проверка границ
			while (xh < 0) {
				xh += 1
			}
			while (xl > height) {
				xl -= 1
			}
			while (yl < 0) {
				yl += 1
			}
			while (yr > width) {
				yr -= 1
			}
			
			// Вывод на экран вида игрока
			for i in xh..<xl {
				for j in yl..<yr {
					print(A[i][j], terminator: " ")
				}
				print()
			}
			
			// Отображение собранного из сунуков
			if !outputItems.isEmpty {
				for i in 0..<outputItems.count {
					print(outputItems[i])
				}
				itemsCount += 1
			}
			
			// Склаываем в сумку и чистим экран
			if (itemsCount == 3) {
				for i in 0..<outputItems.count {
					if (outputItems[i] != "Пустой") {
						inv.inBag(outputItems[i])
					}
				}
				itemsCount = 0
				outputItems.removeAll()
			}
			
			
			// Ввод пользователя
			var input: Int32
			
			repeat {
				input = getchar()
			} while (input != 119 && input != 97 && input != 115 && input != 100 && input != 101)
			
			if (input == 119) && (A[x-1][y] == "E") {
				inGame = false
			}
			
			if (input == 119) && (A[x-1][y] != "#" && A[x-1][y] != "?") {
				A[x][y] = " "
				x = x - 1
				A[x][y] = "@"
			}
			
			if (input == 97) && (A[x][y-1] != "#" && A[x][y-1] != "?") {
				A[x][y] = " "
				y = y - 1
				A[x][y] = "@"
			}
			
			if (input == 115) && (A[x+1][y] != "#" && A[x+1][y] != "?") && (A[x+1][y] != "S") {
				A[x][y] = " "
				x = x + 1
				A[x][y] = "@"
			}
			
			if (input == 100) && (A[x][y+1] != "#" && A[x][y+1] != "?") {
				A[x][y] = " "
				y = y + 1
				A[x][y] = "@"
			}
			
			// Сундуки
			if (input == 101) && (A[x][y+1] == "?" || A[x][y-1] == "?" || A[x+1][y] == "?" || A[x-1][y] == "?") {
				if A[x][y+1] == "?" {
					A[x][y+1] = " "
					outputItems.append(randomItems())
				}
				if A[x][y-1] == "?" {
					A[x][y-1] = " "
					outputItems.append(randomItems())
				}
				if A[x+1][y] == "?" {
					A[x+1][y] = " "
					outputItems.append(randomItems())
				}
				if A[x-1][y] == "?" {
					A[x-1][y] = " "
					outputItems.append(randomItems())
				}
				itemsCount = 0
			}
			
		}
		
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
		inv.freeBag()
		
		
		// Отключение режима "без проверки"
		disableRawMode()
		// Очистка памяти
		freeMaze(dungeon)
		game2 = false
	}
}
